// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderModelAdapter extends TypeAdapter<WorkOrderModel> {
  @override
  final int typeId = 0;

  @override
  WorkOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      priority: fields[4] as String,
      date: fields[5] as DateTime,
      technicianId: fields[6] as String,
      status: fields[7] as String,
      assignSlot: fields[8] as ScheduleSlot,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.technicianId)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.assignSlot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
