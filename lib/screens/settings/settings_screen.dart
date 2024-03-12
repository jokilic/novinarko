import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../services/theme_service.dart';
import '../../theme/colors/colors.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import 'widgets/settings_app_bar.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/settings_theme_widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.background,
        extendBodyBehindAppBar: true,
        appBar: SettingsAppBar(),
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

                /// Theme
                SettingsListTile(
                  onPressed: () {},
                  title: 'Theme',
                  description: 'Choose a theme to use in your app',
                  rightWidget: Row(
                    children: [
                      SettingsThemeWidget(
                        onPressed: () => getIt.get<ThemeService>().updateTheme(
                              NovinarkoTheme.light,
                            ),
                        color: NovinarkoColors.white,
                      ),
                      const SizedBox(width: 8),
                      SettingsThemeWidget(
                        onPressed: () => getIt.get<ThemeService>().updateTheme(
                              NovinarkoTheme.dark,
                            ),
                        color: NovinarkoColors.dark,
                      ),
                      const SizedBox(width: 8),
                      SettingsThemeWidget(
                        onPressed: () => getIt.get<ThemeService>().updateTheme(
                              NovinarkoTheme.sepia,
                            ),
                        color: NovinarkoColors.sepia,
                      ),
                    ],
                  ),
                ),

                /// Divider
                Divider(
                  color: context.colors.text,
                  thickness: 1,
                  height: 8,
                  indent: 16,
                  endIndent: 16,
                ),

                /// In-app browser
                SettingsListTile(
                  onPressed: () {},
                  title: 'In-app browser',
                  description: 'When opening feeds, open them with an internal browser',
                  rightWidget: Checkbox.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
