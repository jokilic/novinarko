import 'dart:math';

import 'package:dough/dough.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/settings_service.dart';
import '../../services/theme_service.dart';
import '../../theme/colors/colors.dart';
import '../../theme/theme.dart';
import '../../util/app_version.dart';
import '../../util/dependencies.dart';
import '../../util/sounds.dart';
import '../../widgets/novinarko_checkbox.dart';
import '../../widgets/novinarko_divider.dart';
import '../news/controllers/news_read_controller.dart';
import 'widgets/settings_app_bar.dart';
import 'widgets/settings_font_widget.dart';
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
            duration: NovinarkoConstants.animationDuration,
          ),
        ],
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),

            /// Theme
            SettingsListTile(
              fontFamily: settings.fontFamily,
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
                  const SizedBox(width: 8),
                  SettingsThemeWidget(
                    onPressed: () => getIt.get<ThemeService>().updateTheme(
                      NovinarkoTheme.green,
                    ),
                    color: NovinarkoColors.green,
                  ),
                ],
              ),
            ),

            /// Divider
            NovinarkoDivider(),

            /// Font
            SettingsListTile(
              fontFamily: settings.fontFamily,
              onPressed: () {},
              title: 'settingsFontTitle'.tr(),
              description: 'settingsFontDescription'.tr(),
              rightWidget: Row(
                children: [
                  SettingsFontWidget(
                    onPressed: () => getIt.get<SettingsService>().fontPressed(
                      fontFamily: 'Merriweather',
                    ),
                    fontFamily: 'Merriweather',
                  ),
                  const SizedBox(width: 20),
                  SettingsFontWidget(
                    onPressed: () => getIt.get<SettingsService>().fontPressed(
                      fontFamily: 'Nunito',
                    ),
                    fontFamily: 'Nunito',
                  ),
                ],
              ),
            ),

            /// Divider
            NovinarkoDivider(),

            /// Images in articles
            SettingsListTile(
              fontFamily: settings.fontFamily,
              onPressed: getIt.get<SettingsService>().imagesInArticlesPressed,
              title: 'settingsImagesInArticlesTitle'.tr(),
              description: 'settingsImagesInArticlesDescription'.tr(),
              rightWidget: NovinarkoCheckbox(
                value: settings.useImagesInArticles,
              ),
            ),

            /// Divider
            NovinarkoDivider(),

            if (!kIsWeb) ...[
              /// In-app browser
              SettingsListTile(
                fontFamily: settings.fontFamily,
                onPressed: getIt.get<SettingsService>().inAppBrowserPressed,
                title: 'settingsInAppBrowserTitle'.tr(),
                description: 'settingsInAppBrowserDescription'.tr(),
                rightWidget: NovinarkoCheckbox(
                  value: settings.useInAppBrowser,
                ),
              ),

              /// Divider
              NovinarkoDivider(),

              /// Ad-blocker
              SettingsListTile(
                fontFamily: settings.fontFamily,
                onPressed: () async {
                  await getIt.get<SettingsService>().adBlockerPressed();
                  getIt.get<NewsReadController>().generateWebViewSettings();
                },
                title: 'settingsAdBlockerTitle'.tr(),
                description: 'settingsAdBlockerDescription'.tr(),
                rightWidget: NovinarkoCheckbox(
                  value: settings.useAdBlocker,
                ),
              ),

              /// Divider
              NovinarkoDivider(),
            ],

            /// Shimmer loader
            SettingsListTile(
              fontFamily: settings.fontFamily,
              onPressed: getIt.get<SettingsService>().shimmerLoaderPressed,
              title: 'settingsShimmerLoaderTitle'.tr(),
              description: 'settingsShimmerLoaderDescription'.tr(),
              rightWidget: NovinarkoCheckbox(
                value: settings.useShimmerLoader,
              ),
            ),

            /// Divider
            NovinarkoDivider(),

            /// Shimmer loader
            SettingsListTile(
              fontFamily: settings.fontFamily,
              onPressed: getIt.get<SettingsService>().showSnowflakesPressed,
              title: 'Snowflakes',
              description: 'Hello there',
              rightWidget: NovinarkoCheckbox(
                value: settings.showSnowflakes,
              ),
            ),

            /// Divider
            NovinarkoDivider(),

            /// Contact me
            SettingsListTile(
              fontFamily: settings.fontFamily,
              onPressed: getIt.get<SettingsService>().contactMePressed,
              title: 'settingsContactMeTitle'.tr(),
              description: 'settingsContactMeDescription'.tr(),
              rightWidget: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Transform.rotate(
                  angle: pi,
                  child: Image.asset(
                    NovinarkoIcons.back,
                    fit: BoxFit.cover,
                    color: context.colors.text,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),

            /// Novinarko info
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PressableDough(
                  child: GestureDetector(
                    onLongPress: playWelcomeToNovinarko,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colors.text,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          NovinarkoIcons.splashIcon,
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Novinarko',
                      style: context.textStyles.settingsNovinarkoTitle,
                    ),
                    FutureBuilder(
                      future: getAppVersion(),
                      builder: (_, snapshot) {
                        final version = snapshot.data;

                        if (version != null) {
                          return Text(
                            'v$version',
                            style: context.textStyles.settingsNovinarkoVersion,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
