// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novinarko_theme_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovinarkoThemeEnumAdapter extends TypeAdapter<NovinarkoThemeEnum> {
  @override
  final typeId = 1;

  @override
  NovinarkoThemeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NovinarkoThemeEnum.light;
      case 1:
        return NovinarkoThemeEnum.dark;
      case 2:
        return NovinarkoThemeEnum.sepia;
      case 3:
        return NovinarkoThemeEnum.green;
      default:
        return NovinarkoThemeEnum.light;
    }
  }

  @override
  void write(BinaryWriter writer, NovinarkoThemeEnum obj) {
    switch (obj) {
      case NovinarkoThemeEnum.light:
        writer.writeByte(0);
      case NovinarkoThemeEnum.dark:
        writer.writeByte(1);
      case NovinarkoThemeEnum.sepia:
        writer.writeByte(2);
      case NovinarkoThemeEnum.green:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovinarkoThemeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
