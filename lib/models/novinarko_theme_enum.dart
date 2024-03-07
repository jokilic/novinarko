import 'package:hive/hive.dart';

part 'novinarko_theme_enum.g.dart';

@HiveType(typeId: 1)
enum NovinarkoThemeEnum {
  @HiveField(0)
  light,

  @HiveField(1)
  dark,

  @HiveField(2)
  sepia,
}
