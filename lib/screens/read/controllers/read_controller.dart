// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide Disposable;
import 'package:get_it/get_it.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants.dart';
import '../../../models/novinarko_rss_item.dart';
import '../../../services/logger_service.dart';
import '../../../util/url.dart';
import 'web_buttons_controller.dart';

class ReadController extends ValueNotifier<List<({int index, String? url, InAppWebViewController? controller})>> implements Disposable {
  final LoggerService logger;
  final WebButtonsController webButtons;

  ReadController({
    required this.logger,
    required this.webButtons,
  }) : super([]) {
    pageController = PreloadPageController();

    addressBarController = TextEditingController();

    addressBarFocusNode = FocusNode()
      ..addListener(
        () {
          if (addressBarFocusNode.hasFocus) {
            /// Select all text and move cursor to end when focused
            if (isFirstAddressBarPress) {
              addressBarController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: addressBarController.text.length,
                affinity: TextAffinity.upstream,
              );
            }

            /// Reset the press state when focus is lost
            else {
              isFirstAddressBarPress = true;
            }
          }
        },
      );
  }

  ///
  /// VARIABLES
  ///

  late PreloadPageController pageController;
  late TextEditingController addressBarController;
  late FocusNode addressBarFocusNode;

  var isFirstAddressBarPress = true;

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    pageController.dispose();
    addressBarController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Updates `state` with `passedItems`
  void setItems(List<NovinarkoRssItem> passedItems) {
    value.clear();

    value = List.generate(
      passedItems.length,
      (index) {
        final item = passedItems[index];
        return (index: index, url: item.link ?? item.guid, controller: null);
      },
    );
  }

  /// Initializes a [WebViewController] for passed `item`
  void initializeWebViewController({
    required int index,
    required NovinarkoRssItem item,
    required InAppWebViewController controller,
  }) =>
      value[index] = (
        index: value[index].index,
        url: value[index].url,
        controller: controller,
      );

  /// Triggered when the user presses address bar
  void onAddressBarPressed() {
    /// First press - select all and move cursor to end
    if (isFirstAddressBarPress) {
      addressBarController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: addressBarController.text.length,
        affinity: TextAffinity.upstream,
      );

      isFirstAddressBarPress = false;
    }

    /// Second press - do regular Flutter logic
    else {
      /// Get the current tap position from the controller
      final tapPosition = addressBarController.selection.base.offset;

      /// Create a new selection with both base and extent at tap position
      addressBarController.selection = TextSelection.collapsed(
        offset: tapPosition,
      );
    }
  }

  /// Triggered when the user presses `refresh` button
  Future<void> refresh() async {
    final activeController = getControllerFromPage();

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
    final activeController = getControllerFromPage();

    final canGoBack = await activeController?.canGoBack();

    if (canGoBack ?? false) {
      await activeController?.goBack();
      await updateActiveUri();
    }
  }

  /// Triggered when the user presses `forward` button
  Future<void> goForward() async {
    final activeController = getControllerFromPage();

    final canGoForward = await activeController?.canGoForward();

    if (canGoForward ?? false) {
      await activeController?.goForward();
      await updateActiveUri();
    }
  }

  /// Triggered when the user goes to a new `url`
  Future<void> loadUrl(String url) async {
    final activeController = getControllerFromPage();

    final newUrl = processUrl(url);

    final webUri = WebUri(newUrl);

    await activeController?.loadUrl(
      urlRequest: URLRequest(url: webUri),
    );

    await updateActiveUri();
  }

  /// Triggered when the user presses `Share` button
  Future<void> share() async {
    final currentPage = pageController.page?.round() ?? 0;
    final activeUrl = value[currentPage].url;

    if (activeUrl != null) {
      await Share.shareUri(Uri.parse(activeUrl));
      await updateActiveUri();
    }
  }

  /// Updates active `url` shown in UI
  Future<void> updateActiveUri({String? overrideUrl}) async {
    /// `overrideUrl` is passed
    if (overrideUrl != null) {
      final newUrl = cleanUrl(overrideUrl);
      addressBarController.text = newUrl;
      return;
    }

    final currentPage = pageController.page?.round() ?? 0;

    final url = await value[currentPage].controller?.getUrl();

    /// Found `URL` from `activeController`
    if (url != null) {
      /// Update the `addressBarController` with new clean `url`
      addressBarController.text = cleanUrl('$url');

      /// Update `state` with new `url`
      value[currentPage] = (
        index: value[currentPage].index,
        url: '$url',
        controller: value[currentPage].controller,
      );

      return;
    }

    addressBarController.text = 'readStateErrorSubtitle'.tr();
  }

  /// Returns proper `controller`, depending on the `page`
  InAppWebViewController? getControllerFromPage() {
    final currentPage = pageController.page?.round() ?? 0;
    return value[currentPage].controller;
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
