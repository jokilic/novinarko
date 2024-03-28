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

  NovinarkoSettings({
    required this.novinarkoThemeEnum,
    required this.useInAppBrowser,
    required this.useImagesInArticles,
  });

  NovinarkoSettings copyWith({
    NovinarkoThemeEnum? novinarkoThemeEnum,
    bool? useInAppBrowser,
    bool? useImagesInArticles,
  }) =>
      NovinarkoSettings(
        novinarkoThemeEnum: novinarkoThemeEnum ?? this.novinarkoThemeEnum,
        useInAppBrowser: useInAppBrowser ?? this.useInAppBrowser,
        useImagesInArticles: useImagesInArticles ?? this.useImagesInArticles,
      );

  @override
  String toString() => 'NovinarkoSettings(novinarkoThemeEnum: $novinarkoThemeEnum, useInAppBrowser: $useInAppBrowser, useImagesInArticles: $useImagesInArticles)';

  @override
  bool operator ==(covariant NovinarkoSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.novinarkoThemeEnum == novinarkoThemeEnum && other.useInAppBrowser == useInAppBrowser && other.useImagesInArticles == useImagesInArticles;
  }

  @override
  int get hashCode => novinarkoThemeEnum.hashCode ^ useInAppBrowser.hashCode ^ useImagesInArticles.hashCode;
}
