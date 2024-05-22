import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide Disposable;
import 'package:get_it/get_it.dart';

import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';
import '../../services/settings_service.dart';
import '../../util/peter_lowe_ad_hosts.dart';

class NewsReadController extends ValueNotifier<List<NovinarkoRssItem>> implements Disposable {
  final LoggerService logger;
  final SettingsService settings;

  NewsReadController({
    required this.logger,
    required this.settings,
  }) : super([]) {
    generateWebViewSettings();
  }

  ///
  /// VARIABLES
  ///

  AnimationController? shakeFabController;
  HeadlessInAppWebView? headlessWebView;
  InAppWebViewSettings? webViewSettings;

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    shakeFabController?.dispose();
    headlessWebView?.dispose();
  }

  ///
  /// METHODS
  ///

  /// Adds or removes [NovinarkoRssItem] for reading in [ReadScreen]
  void itemPressed(NovinarkoRssItem item) {
    /// Check if article is already in the list
    final articleExists = value.any((article) => article == item);

    /// Article exists in the list, remove it
    if (articleExists) {
      value.remove(item);
    }

    /// Article doesn't exist in the list, add it
    else {
      value.add(item);
    }

    /// Assign new state value
    value = List.from(value);

    /// Animate FAB
    triggerFabAnimation();

    /// Preloads or disposes `headlessWebView`
    toggleHeadlessWebView();
  }

  /// Initializes or disposes `headlessWebView`, depending on value in `state`
  Future<void> toggleHeadlessWebView() async {
    final firstItem = value.firstOrNull;

    /// Item exists in the list, preload `headlessWebView`
    if (firstItem != null) {
      /// Generate article URL
      final url = firstItem.link ?? firstItem.guid;

      /// URL exists & `headlessWebView` isn't already initialized
      if (url != null && headlessWebView == null) {
        headlessWebView = HeadlessInAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(url),
          ),
          initialSettings: webViewSettings,
        );

        await headlessWebView?.run();
      }
    }

    /// List is empty, dispose `headlessWebView`
    else {
      await headlessWebView?.dispose();
      headlessWebView = null;
    }
  }

  /// Clears all [NovinarkoRssItem] from `state` and disposes `headlessWebView`
  void clearReadingState() {
    value = [];
    toggleHeadlessWebView();
  }

  /// Trigger FAB animation
  void triggerFabAnimation() {
    shakeFabController?.reset();
    shakeFabController?.forward();
  }

  /// Generates `webViewSettings`, used in in-app browser
  void generateWebViewSettings() {
    /// Generate if user is using in-app browser & `webViewSettings` is not already initialized
    if (settings.value.useInAppBrowser) {
      webViewSettings = InAppWebViewSettings(
        isInspectable: kDebugMode,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllowFullscreen: true,
        contentBlockers: generateContentBlockers(
          shouldUseContentBlockers: settings.value.useAdBlocker,
        ),
      );
    } else {
      webViewSettings = null;
    }
  }

  /// Logic to generate content blockers in order to have an ad-free experience
  List<ContentBlocker> generateContentBlockers({required bool shouldUseContentBlockers}) {
    final contentBlockers = <ContentBlocker>[];

    if (shouldUseContentBlockers) {
      /// For each `adHost`, add a [ContentBlocker] to block its loading
      for (final adHost in peterLoweAdHosts) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(
              urlFilter: adHost,
            ),
            action: ContentBlockerAction(
              type: ContentBlockerActionType.BLOCK,
            ),
          ),
        );
      }

      /// Apply the `display: none` style to some HTML elements
      contentBlockers.add(
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: '.*',
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: '.banner, .banners, .ads, .ad, .advert',
          ),
        ),
      );
    } else {
      contentBlockers.clear();
    }

    return contentBlockers;
  }
}
