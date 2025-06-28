import 'package:equatable/equatable.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';

class CreateWorkOrderState extends Equatable {
  final String title;
  final String description;
  final String? category;
  final String? priority;
  final String? technicianId;
  final DateTime? date;

  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final ScheduleSlot? assignedSlot;

  const CreateWorkOrderState({
    this.title = '',
    this.description = '',
    this.category,
    this.priority,
    this.technicianId,
    this.date,
    this.assignedSlot,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  CreateWorkOrderState copyWith({
    String? title,
    String? description,
    String? category,
    String? priority,
    String? technicianId,
    DateTime? date,
    ScheduleSlot? assignedSlot,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreateWorkOrderState(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      technicianId: technicianId ?? this.technicianId,
      date: date ?? this.date,
      assignedSlot: assignedSlot ?? this.assignedSlot,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    category,
    priority,
    technicianId,
    date,
    assignedSlot,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}
