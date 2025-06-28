import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';

part 'work_order_model.g.dart';

@HiveType(typeId: 0)
class WorkOrderModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String priority;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String technicianId;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final ScheduleSlot assignSlot;

  const WorkOrderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.date,
    required this.technicianId,
    required this.status,
    required this.assignSlot,
  });

  WorkOrderModel copyWith({
    String? title,
    String? description,
    String? category,
    String? priority,
    DateTime? date,
    String? technicianId,
    String? status,
    ScheduleSlot? assignSlot,
  }) {
    return WorkOrderModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      technicianId: technicianId ?? this.technicianId,
      status: status ?? this.status,
      assignSlot: assignSlot ?? this.assignSlot,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    priority,
    date,
    technicianId,
    status,
    assignSlot,
  ];
}
