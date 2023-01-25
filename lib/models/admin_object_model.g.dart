// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_object_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminObjectAdapter extends TypeAdapter<AdminObject> {
  @override
  final int typeId = 0;

  @override
  AdminObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminObject(
      fields[0] as int,
      fields[1] as String,
      fields[2] as bool,
      fields[3] as RadioSwitch,
      fields[4] as bool,
      fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.switch1)
      ..writeByte(3)
      ..write(obj.switch2)
      ..writeByte(4)
      ..write(obj.switch3)
      ..writeByte(5)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
