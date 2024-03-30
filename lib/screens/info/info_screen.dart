import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme.dart';
import 'widgets/info_app_bar.dart';

// TODO: Localize
class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: InfoAppBar(),
        body: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 450),
            ),
          ],
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: AnimateList(
              effects: const [
                FadeEffect(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 450),
                ),
              ],
              children: [
                const SizedBox(height: 24),

                // TODO: Finish this screen

                Container(
                  height: 100,
                  width: 100,
                  color: context.colors.primary,
                ),
              ],
            ),
          ),
        ),
      );
}
