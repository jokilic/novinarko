import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../services/settings_service.dart';
import '../../services/theme_service.dart';
import '../../theme/colors/colors.dart';
import '../../theme/theme.dart';
import '../../util/dependencies.dart';
import '../../widgets/novinarko_checkbox.dart';
import '../../widgets/novinarko_divider.dart';
import 'widgets/settings_app_bar.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/settings_theme_widget.dart';

class SettingsScreen extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final settings = watchIt<SettingsService>().value;

    return Scaffold(
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
                title: 'settingsThemeTitle'.tr(),
                description: 'settingsThemeDescription'.tr(),
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
              NovinarkoDivider(),

              /// In-app browser
              SettingsListTile(
                onPressed: getIt.get<SettingsService>().inAppBrowserPressed,
                title: 'settingsInAppBrowserTitle'.tr(),
                description: 'settingsInAppBrowserDescription'.tr(),
                rightWidget: NovinarkoCheckbox(
                  value: settings.useInAppBrowser,
                ),
              ),

              /// Divider
              NovinarkoDivider(),

              /// In-app browser
              SettingsListTile(
                onPressed: getIt.get<SettingsService>().imagesInArticlesPressed,
                title: 'settingsImagesInArticlesTitle'.tr(),
                description: 'settingsImagesInArticlesDescription'.tr(),
                rightWidget: NovinarkoCheckbox(
                  value: settings.useImagesInArticles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
