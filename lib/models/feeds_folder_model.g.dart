// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_folder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedsFolderModelAdapter extends TypeAdapter<FeedsFolderModel> {
  @override
  final typeId = 3;

  @override
  FeedsFolderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedsFolderModel(
      uid: fields[0] as String,
      name: fields[1] as String,
      feeds: fields[2] == null
          ? const []
          : (fields[2] as List).cast<FeedSearchModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FeedsFolderModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.feeds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedsFolderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
