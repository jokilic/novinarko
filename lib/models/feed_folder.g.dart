// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_folder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedFolderAdapter extends TypeAdapter<FeedFolder> {
  @override
  final typeId = 3;

  @override
  FeedFolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedFolder(
      id: fields[0] as String,
      name: fields[1] as String,
      children: (fields[2] as List).cast<FeedItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, FeedFolder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedFolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
