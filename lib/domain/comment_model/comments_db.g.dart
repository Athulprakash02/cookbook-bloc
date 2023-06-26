// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentsDataAdapter extends TypeAdapter<CommentsData> {
  @override
  final int typeId = 3;

  @override
  CommentsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentsData(
      id: fields[0] as int?,
      userName: fields[1] as String,
      recipeName: fields[2] as String,
      comment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommentsData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.recipeName)
      ..writeByte(3)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
