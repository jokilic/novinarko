// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedSearchModelAdapter extends TypeAdapter<FeedSearchModel> {
  @override
  final typeId = 0;

  @override
  FeedSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedSearchModel(
      uid: fields[0] as String,
      description: fields[1] as String?,
      favicon: fields[2] as String?,
      siteName: fields[3] as String?,
      siteUrl: fields[4] as String?,
      title: fields[5] as String?,
      url: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FeedSearchModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.favicon)
      ..writeByte(3)
      ..write(obj.siteName)
      ..writeByte(4)
      ..write(obj.siteUrl)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
