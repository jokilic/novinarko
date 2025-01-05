// ignore_for_file: deprecated_member_use

import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../models/novinarko_rss_item.dart';
import '../../util/dependencies.dart';
import '../news/controllers/news_read_controller.dart';
import 'controllers/read_controller.dart';
import 'controllers/read_loader_controller.dart';
import 'controllers/web_buttons_controller.dart';
import 'widgets/read_bottom_bar.dart';
import 'widgets/read_close_button.dart';
import 'widgets/read_item.dart';
import 'widgets/read_next_button.dart';
import 'widgets/read_previous_button.dart';

class ReadScreen extends StatefulWidget {
  final List<NovinarkoRssItem> items;
  final BuildContext previousContext;

  const ReadScreen({
    required this.items,
    required this.previousContext,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  void initState() {
    super.initState();

    final firstUrl = widget.items.firstOrNull?.link ?? widget.items.firstOrNull?.guid;

    getIt.get<ReadController>()
      ..setItems(widget.items)
      ..updateWebButtonVisibility(
        page: 0,
        itemLength: widget.items.length,
      )
      ..updateActiveUri(
        overrideUrl: firstUrl,
      );
  }

  @override
  void dispose() {
    getIt
      ..resetLazySingleton<ReadController>()
      ..resetLazySingleton<WebButtonsController>()
      ..resetLazySingleton<ReadLoaderController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReadWidget(
        items: widget.items,
        previousContext: widget.previousContext,
      );
}

class ReadWidget extends WatchingWidget {
  final List<NovinarkoRssItem> items;
  final BuildContext previousContext;

  const ReadWidget({
    required this.items,
    required this.previousContext,
  });

  Future<bool> popScreen(BuildContext context) async {
    Navigator.of(context).pop();
    getIt.get<NewsReadController>().showRestoreArticlesSnackbar(previousContext);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final webButtons = watchIt<WebButtonsController>().value;
    final loaderValue = watchIt<ReadLoaderController>().value;

    return WillPopScope(
      onWillPop: () => popScreen(context),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  ///
                  /// CONTENT
                  ///
                  Expanded(
                    child: PreloadPageView.builder(
                      controller: getIt.get<ReadController>().pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        final item = items[index];

                        return ReadItem(
                          initialUrl: item.link ?? item.guid,
                          headlessWebView: index == 0 ? getIt.get<NewsReadController>().headlessWebView : null,
                          onWebViewCreated: (controller) {
                            getIt.get<ReadController>().initializeWebViewController(
                                  index: index,
                                  controller: controller,
                                  item: item,
                                );
                            getIt.get<ReadLoaderController>().setLoader = 0;
                          },
                          updateUri: (_) => getIt.get<ReadController>().updateActiveUri(),
                          onProgressChanged: (progress) => getIt.get<ReadLoaderController>().setLoader = progress / 100,
                          onConsoleMessage: (_) {},
                        );
                      },
                    ),
                  ),

                  ///
                  /// BOTTOM MENU BAR
                  ///
                  ReadBottomBar(
                    progress: loaderValue,
                    controller: getIt.get<ReadController>().addressBarController,
                    focusNode: getIt.get<ReadController>().addressBarFocusNode,
                    onAddressBarPressed: getIt.get<ReadController>().onAddressBarPressed,
                    onAddressBarSubmitted: getIt.get<ReadController>().loadUrl,
                    onBackPressed: getIt.get<ReadController>().goBack,
                    onForwardPressed: getIt.get<ReadController>().goForward,
                    onSharePressed: getIt.get<ReadController>().share,
                    onRefreshPressed: getIt.get<ReadController>().refresh,
                  ),
                ],
              ),

              ///
              /// CLOSE
              ///
              Positioned(
                right: 12,
                top: 16,
                child: PressableDough(
                  child: ReadCloseButton(
                    onPressed: () => popScreen(context),
                  ),
                ),
              ),

              ///
              /// ARTICLE BUTTONS
              ///
              Positioned(
                bottom: 72,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///
                    /// PREVIOUS
                    ///
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: IgnorePointer(
                        ignoring: !webButtons.showPrevious,
                        child: AnimatedOpacity(
                          opacity: webButtons.showPrevious ? 1 : 0,
                          duration: NovinarkoConstants.animationDuration,
                          curve: Curves.easeIn,
                          child: PressableDough(
                            child: ReadPreviousButton(
                              onPressed: getIt.get<ReadController>().openPreviousArticle,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    ///
                    /// NEXT
                    ///
                    IgnorePointer(
                      ignoring: !webButtons.showNext,
                      child: AnimatedOpacity(
                        opacity: webButtons.showNext ? 1 : 0,
                        duration: NovinarkoConstants.animationDuration,
                        curve: Curves.easeIn,
                        child: PressableDough(
                          child: ReadNextButton(
                            onPressed: getIt.get<ReadController>().openNextArticle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
