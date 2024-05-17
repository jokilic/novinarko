import 'package:hive/hive.dart';

import 'novinarko_theme_enum.dart';

part 'novinarko_settings.g.dart';

@HiveType(typeId: 2)
class NovinarkoSettings {
  @HiveField(0)
  final NovinarkoThemeEnum novinarkoThemeEnum;
  @HiveField(1)
  final bool useInAppBrowser;
  @HiveField(2)
  final bool useImagesInArticles;
  @HiveField(3)
  final bool useAdBlocker;

  NovinarkoSettings({
    required this.novinarkoThemeEnum,
    required this.useInAppBrowser,
    required this.useImagesInArticles,
    required this.useAdBlocker,
  });

  NovinarkoSettings copyWith({
    NovinarkoThemeEnum? novinarkoThemeEnum,
    bool? useInAppBrowser,
    bool? useImagesInArticles,
    bool? useAdBlocker,
  }) =>
      NovinarkoSettings(
        novinarkoThemeEnum: novinarkoThemeEnum ?? this.novinarkoThemeEnum,
        useInAppBrowser: useInAppBrowser ?? this.useInAppBrowser,
        useImagesInArticles: useImagesInArticles ?? this.useImagesInArticles,
        useAdBlocker: useAdBlocker ?? this.useAdBlocker,
      );

  @override
  String toString() =>
      'NovinarkoSettings(novinarkoThemeEnum: $novinarkoThemeEnum, useInAppBrowser: $useInAppBrowser, useImagesInArticles: $useImagesInArticles, useAdBlocker: $useAdBlocker)';

  @override
  bool operator ==(covariant NovinarkoSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.novinarkoThemeEnum == novinarkoThemeEnum &&
        other.useInAppBrowser == useInAppBrowser &&
        other.useImagesInArticles == useImagesInArticles &&
        other.useAdBlocker == useAdBlocker;
  }

  @override
  int get hashCode => novinarkoThemeEnum.hashCode ^ useInAppBrowser.hashCode ^ useImagesInArticles.hashCode ^ useAdBlocker.hashCode;
}
