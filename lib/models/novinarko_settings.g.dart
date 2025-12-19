// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novinarko_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovinarkoSettingsAdapter extends TypeAdapter<NovinarkoSettings> {
  @override
  final typeId = 2;

  @override
  NovinarkoSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovinarkoSettings(
      novinarkoThemeEnum: fields[0] as NovinarkoThemeEnum?,
      useInAppBrowser: fields[1] == null ? true : fields[1] as bool,
      useImagesInArticles: fields[2] == null ? true : fields[2] as bool,
      useAdBlocker: fields[3] == null ? false : fields[3] as bool,
      useShimmerLoader: fields[4] == null ? true : fields[4] as bool,
      fontFamily: fields[5] == null ? 'Merriweather' : fields[5] as String,
      showSnowflakes: fields[6] == null ? false : fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NovinarkoSettings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.novinarkoThemeEnum)
      ..writeByte(1)
      ..write(obj.useInAppBrowser)
      ..writeByte(2)
      ..write(obj.useImagesInArticles)
      ..writeByte(3)
      ..write(obj.useAdBlocker)
      ..writeByte(4)
      ..write(obj.useShimmerLoader)
      ..writeByte(5)
      ..write(obj.fontFamily)
      ..writeByte(6)
      ..write(obj.showSnowflakes);
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
