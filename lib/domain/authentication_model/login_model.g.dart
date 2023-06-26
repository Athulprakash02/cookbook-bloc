// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginDataAdapter extends TypeAdapter<LoginData> {
  @override
  final int typeId = 1;

  @override
  LoginData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginData(
      id: fields[0] as int?,
      fullName: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      confirmPassword: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.confirmPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
