// lib/features/schedule_picker/models/schedule_slot.dart

import 'package:hive/hive.dart';

part 'schedule_slot.g.dart';

@HiveType(typeId: 1)
class ScheduleSlot {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final String label; // Optional: e.g., "10:00 AM"

  ScheduleSlot({required this.dateTime, required this.label});

  factory ScheduleSlot.fromJson(Map<String, dynamic> json) {
    return ScheduleSlot(
      dateTime: DateTime.parse(json['dateTime']),
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'dateTime': dateTime.toIso8601String(), 'label': label};
  }
}
