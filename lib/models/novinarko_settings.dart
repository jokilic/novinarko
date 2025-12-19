import 'package:hive_ce/hive.dart';

import 'novinarko_theme_enum.dart';

part 'novinarko_settings.g.dart';

@HiveType(typeId: 2)
class NovinarkoSettings {
  @HiveField(0)
  final NovinarkoThemeEnum? novinarkoThemeEnum;
  @HiveField(1, defaultValue: true)
  final bool useInAppBrowser;
  @HiveField(2, defaultValue: true)
  final bool useImagesInArticles;
  @HiveField(3, defaultValue: false)
  final bool useAdBlocker;
  @HiveField(4, defaultValue: true)
  final bool useShimmerLoader;
  @HiveField(5, defaultValue: 'Merriweather')
  final String fontFamily;
  @HiveField(6, defaultValue: false)
  final bool showSnowflakes;

  NovinarkoSettings({
    required this.novinarkoThemeEnum,
    required this.useInAppBrowser,
    required this.useImagesInArticles,
    required this.useAdBlocker,
    required this.useShimmerLoader,
    required this.fontFamily,
    required this.showSnowflakes,
  });

  NovinarkoSettings copyWith({
    NovinarkoThemeEnum? novinarkoThemeEnum,
    bool? useInAppBrowser,
    bool? useImagesInArticles,
    bool? useAdBlocker,
    bool? useShimmerLoader,
    String? fontFamily,
    bool? showSnowflakes,
  }) => NovinarkoSettings(
    novinarkoThemeEnum: novinarkoThemeEnum ?? this.novinarkoThemeEnum,
    useInAppBrowser: useInAppBrowser ?? this.useInAppBrowser,
    useImagesInArticles: useImagesInArticles ?? this.useImagesInArticles,
    useAdBlocker: useAdBlocker ?? this.useAdBlocker,
    useShimmerLoader: useShimmerLoader ?? this.useShimmerLoader,
    fontFamily: fontFamily ?? this.fontFamily,
    showSnowflakes: showSnowflakes ?? this.showSnowflakes,
  );

  @override
  String toString() =>
      'NovinarkoSettings(novinarkoThemeEnum: $novinarkoThemeEnum, useInAppBrowser: $useInAppBrowser, useImagesInArticles: $useImagesInArticles, useAdBlocker: $useAdBlocker, useShimmerLoader: $useShimmerLoader, fontFamily: $fontFamily, showSnowflakes: $showSnowflakes)';

  @override
  bool operator ==(covariant NovinarkoSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.novinarkoThemeEnum == novinarkoThemeEnum &&
        other.useInAppBrowser == useInAppBrowser &&
        other.useImagesInArticles == useImagesInArticles &&
        other.useAdBlocker == useAdBlocker &&
        other.useShimmerLoader == useShimmerLoader &&
        other.fontFamily == fontFamily &&
        other.showSnowflakes == showSnowflakes;
  }

  @override
  int get hashCode =>
      novinarkoThemeEnum.hashCode ^
      useInAppBrowser.hashCode ^
      useImagesInArticles.hashCode ^
      useAdBlocker.hashCode ^
      useShimmerLoader.hashCode ^
      fontFamily.hashCode ^
      showSnowflakes.hashCode;
}
