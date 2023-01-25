// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_switch_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadioSwitchAdapter extends TypeAdapter<RadioSwitch> {
  @override
  final int typeId = 1;

  @override
  RadioSwitch read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RadioSwitch.radio1;
      case 1:
        return RadioSwitch.radio2;
      default:
        return RadioSwitch.radio1;
    }
  }

  @override
  void write(BinaryWriter writer, RadioSwitch obj) {
    switch (obj) {
      case RadioSwitch.radio1:
        writer.writeByte(0);
        break;
      case RadioSwitch.radio2:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadioSwitchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
