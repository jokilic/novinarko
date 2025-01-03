// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide Disposable;
import 'package:get_it/get_it.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';
import '../../util/clean_url.dart';
import 'active_url_controller.dart';
import 'web_buttons_controller.dart';

class ReadController extends ValueNotifier<Map<NovinarkoRssItem, InAppWebViewController?>> implements Disposable {
  final LoggerService logger;
  final WebButtonsController webButtons;
  final ActiveUrlController activeUrl;

  ReadController({
    required this.logger,
    required this.webButtons,
    required this.activeUrl,
  }) : super({}) {
    pageController = PreloadPageController();
  }

  ///
  /// VARIABLES
  ///

  late PreloadPageController pageController;

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    pageController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Updates `state` with `passedItems`
  void setItems(List<NovinarkoRssItem> passedItems) {
    value.clear();

    for (var i = 0; i < passedItems.length; i++) {
      value[passedItems[i]] = null;
    }
  }

  /// Initializes a [WebViewController] for passed `item`
  void initializeWebViewController({
    required InAppWebViewController controller,
    required NovinarkoRssItem item,
  }) =>
      value[item] = controller;

  /// Triggered when the user presses `refresh` button
  Future<void> refresh() async {
    final currentPage = pageController.page?.round() ?? 0;
    final activeController = value.entries.toList()[currentPage].value;

    if (activeController != null) {
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
        await activeController.loadUrl(
          urlRequest: URLRequest(
            url: await activeController.getUrl(),
          ),
        );
      } else {
        await activeController.reload();
      }

      await updateActiveUri();
    }
  }

  /// Triggered when the user presses `back` button
  Future<void> goBack() async {
    final currentPage = pageController.page?.round() ?? 0;
    final activeController = value.entries.toList()[currentPage].value;

    final canGoBack = await activeController?.canGoBack();

    if (canGoBack ?? false) {
      await activeController?.goBack();
      await updateActiveUri();
    }
  }

  /// Triggered when the user presses `forward` button
  Future<void> goForward() async {
    final currentPage = pageController.page?.round() ?? 0;
    final activeController = value.entries.toList()[currentPage].value;

    final canGoForward = await activeController?.canGoForward();

    if (canGoForward ?? false) {
      await activeController?.goForward();
      await updateActiveUri();
    }
  }

  /// Triggered when the user goes to a new `url`
  Future<void> loadUrl(String url) async {
    final currentPage = pageController.page?.round() ?? 0;
    final activeController = value.entries.toList()[currentPage].value;

    final webUri = WebUri(url);

    await activeController?.loadUrl(
      urlRequest: URLRequest(url: webUri),
    );

    await updateActiveUri();
  }

  /// Updates active `url` shown in UI
  Future<void> updateActiveUri({String? overriddenUrl}) async {
    if (overriddenUrl != null) {
      activeUrl.updateState(
        cleanUrl(overriddenUrl),
      );

      return;
    }

    final currentPage = pageController.page?.round() ?? 0;
    final activeController = value.entries.toList()[currentPage].value;

    final url = await activeController?.getUrl();

    if (url != null) {
      activeUrl.updateState(
        cleanUrl('$url'),
      );
    }
  }

  /// Decrements the `pageController` index
  Future<void> openPreviousArticle() async {
    await pageController.previousPage(
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
    );

    final newPage = pageController.page?.round() ?? 0;

    updateWebButtonVisibility(
      page: newPage,
      itemLength: value.length,
    );

    await updateActiveUri();
  }

  /// Increments the `pageController` index
  Future<void> openNextArticle() async {
    await pageController.nextPage(
      duration: NovinarkoConstants.animationDuration,
      curve: Curves.easeIn,
    );

    final newPage = pageController.page?.round() ?? 0;

    updateWebButtonVisibility(
      page: newPage,
      itemLength: value.length,
    );

    await updateActiveUri();
  }

  /// Updates visibility of web buttons (previous & next)
  void updateWebButtonVisibility({
    required int page,
    required int itemLength,
  }) =>
      webButtons.updateState(
        (showPrevious: page > 0, showNext: page != itemLength - 1),
      );
}
