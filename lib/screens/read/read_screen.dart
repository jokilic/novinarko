// ignore_for_file: deprecated_member_use

import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../models/novinarko_rss_item.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../news/controllers/news_read_controller.dart';
import 'active_url_controller.dart';
import 'read_controller.dart';
import 'web_buttons_controller.dart';
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

    getIt.get<ReadController>()
      ..setItems(widget.items)
      ..updateWebButtonVisibility(
        page: 0,
        itemLength: widget.items.length,
      )
      ..updateActiveUri(
        overriddenUrl: widget.items.first.link ?? widget.items.first.guid,
      );
  }

  @override
  void dispose() {
    getIt
      ..resetLazySingleton<ReadController>()
      ..resetLazySingleton<WebButtonsController>()
      ..resetLazySingleton<ActiveUrlController>();

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
    final activeUrl = watchIt<ActiveUrlController>().value;

    return WillPopScope(
      onWillPop: () => popScreen(context),
      child: Scaffold(
        floatingActionButton: Row(
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
        body: SafeArea(
          child: Stack(
            children: [
              ///
              /// CONTENT
              ///
              PreloadPageView.builder(
                controller: getIt.get<ReadController>().pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];

                  return ReadItem(
                    initialUrl: item.link ?? item.guid,
                    headlessWebView: index == 0 ? getIt.get<NewsReadController>().headlessWebView : null,
                    onWebViewCreated: (controller) => getIt.get<ReadController>().initializeWebViewController(
                          controller: controller,
                          item: item,
                        ),
                    onProgressChanged: (_, progress) {
                      getIt.get<LoggerService>().f('Progress -> $progress');
                    },
                  );
                },
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
              /// BOTTOM MENU
              ///
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: PressableDough(
                  child: Center(
                    child: IconButton.filled(
                      onPressed: getIt.get<ReadController>().refresh,
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 80,
                child: PressableDough(
                  child: Center(
                    child: IconButton.filled(
                      onPressed: getIt.get<ReadController>().goBack,
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 160,
                child: PressableDough(
                  child: Center(
                    child: IconButton.filled(
                      onPressed: getIt.get<ReadController>().goForward,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 240,
                child: PressableDough(
                  child: Center(
                    child: Text(
                      activeUrl,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'EncodeSans',
                        height: 1.4,
                        color: Colors.yellow,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
