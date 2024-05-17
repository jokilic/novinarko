// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novinarko_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovinarkoSettingsAdapter extends TypeAdapter<NovinarkoSettings> {
  @override
  final int typeId = 2;

  @override
  NovinarkoSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovinarkoSettings(
      novinarkoThemeEnum: fields[0] as NovinarkoThemeEnum,
      useInAppBrowser: fields[1] as bool,
      useImagesInArticles: fields[2] as bool,
      useAdBlocker: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NovinarkoSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.novinarkoThemeEnum)
      ..writeByte(1)
      ..write(obj.useInAppBrowser)
      ..writeByte(2)
      ..write(obj.useImagesInArticles)
      ..writeByte(3)
      ..write(obj.useAdBlocker);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovinarkoSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
