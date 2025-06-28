// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_slot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleSlotAdapter extends TypeAdapter<ScheduleSlot> {
  @override
  final int typeId = 1;

  @override
  ScheduleSlot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleSlot(
      dateTime: fields[0] as DateTime,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleSlot obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
