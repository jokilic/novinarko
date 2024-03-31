import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../models/novinarko_rss_item.dart';
import '../../util/dependencies.dart';
import 'read_controller.dart';
import 'widgets/read_close_button.dart';
import 'widgets/read_next_button.dart';
import 'widgets/read_previous_button.dart';
import 'widgets/read_widget.dart';

class ReadScreen extends StatelessWidget {
  final List<NovinarkoRssItem> items;

  const ReadScreen(
    this.items,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: PressableDough(
                child: ReadPreviousButton(
                  onPressed: getIt.get<ReadController>().openPrevious,
                ),
              ),
            ),
            PressableDough(
              child: ReadNextButton(
                onPressed: getIt.get<ReadController>().openNext,
              ),
            ),
          ],
        ),
        body: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 450),
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

                    return ReadWidget(
                      url: item.link ?? item.guid,
                    );
                  },
                ),

                ///
                /// CLOSE
                ///
                Positioned(
                  left: 12,
                  top: 16,
                  child: PressableDough(
                    child: ReadCloseButton(
                      onPressed: () {
                        getIt.get<ReadController>().clearItemsForReading();
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => Navigator.of(context).pop(),
                        );
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
