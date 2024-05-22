import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../models/novinarko_rss_item.dart';
import '../../util/dependencies.dart';
import '../news/news_read_controller.dart';
import 'read_controller.dart';
import 'web_buttons_controller.dart';
import 'widgets/read_close_button.dart';
import 'widgets/read_item.dart';
import 'widgets/read_next_button.dart';
import 'widgets/read_previous_button.dart';

class ReadScreen extends StatefulWidget {
  final List<NovinarkoRssItem> items;

  const ReadScreen({
    required this.items,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  void initState() {
    getIt.get<ReadController>().setItemLength(widget.items.length);
    getIt.get<ReadController>().updateWebButtonVisibility(
          page: 0,
          itemLength: widget.items.length,
        );

    super.initState();
  }

  @override
  void dispose() {
    getIt
      ..resetLazySingleton<ReadController>()
      ..resetLazySingleton<WebButtonsController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReadWidget(
        items: widget.items,
      );
}

class ReadWidget extends WatchingWidget {
  final List<NovinarkoRssItem> items;

  const ReadWidget({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final webButtons = watchIt<WebButtonsController>().value;

    return Scaffold(
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
                    onPressed: getIt.get<ReadController>().openPrevious,
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
                  onPressed: getIt.get<ReadController>().openNext,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Animate(
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: NovinarkoConstants.animationDuration,
          ),
        ],
        child: SafeArea(
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
                    url: item.link ?? item.guid,
                    headlessWebView: index == 0 ? getIt.get<NewsReadController>().headlessWebView : null,
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
                    onPressed: () {
                      getIt.get<NewsReadController>().clearReadingState();
                      Navigator.of(context).pop();
                    },
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
