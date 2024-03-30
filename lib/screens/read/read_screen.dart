import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../theme/theme.dart';
import 'widgets/read_app_bar.dart';
import 'widgets/read_widget/read_widget.dart';

class ReadScreen extends StatelessWidget {
  final websites = [
    'https://www.google.com',
    'https://www.24sata.hr',
    'https://www.index.hr',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: ReadAppBar(),
        body: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 450),
            ),
          ],
          child: PreloadPageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: websites.length,
            itemBuilder: (_, index) => ReadWidget(
              url: websites[index],
              backgroundColor: context.colors.background,
              index: index,
            ),
          ),
        ),
      );
}
