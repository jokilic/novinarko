import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../models/novinarko_rss_item.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import 'read_controller.dart';
import 'widgets/read_floating_action_button.dart';
import 'widgets/read_widget.dart';

class ReadScreen extends StatelessWidget {
  final List<NovinarkoRssItem> items;

  const ReadScreen(
    this.items,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: ReadFloatingActionButton(
          onPressed: () {
            getIt.get<ReadController>().clearItemsForReading();
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pop(),
            );
          },
        ),
        body: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 450),
            ),
          ],
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.paddingOf(context).top,
              ),
              Expanded(
                child: PreloadPageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];

                    return ReadWidget(
                      url: item.link ?? item.guid,
                      backgroundColor: context.colors.background,
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.paddingOf(context).bottom,
              ),
            ],
          ),
        ),
      );
}
