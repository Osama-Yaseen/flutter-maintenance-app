import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiqflow_maintenance_app/core/constants/app_constants.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';
import 'package:uuid/uuid.dart';
import 'package:quiqflow_maintenance_app/core/services/hive_service.dart';
import 'package:quiqflow_maintenance_app/features/shared_models/work_order_model.dart';
import '../models/create_work_order_state.dart';

class CreateWorkOrderCubit extends Cubit<CreateWorkOrderState> {
  final HiveService _hiveService;

  CreateWorkOrderCubit(this._hiveService) : super(const CreateWorkOrderState());

  Future<void> submit() async {
    if (state.title.isEmpty ||
        state.description.isEmpty ||
        state.category == null ||
        state.priority == null ||
        state.date == null ||
        state.technicianId == null) {
      emit(state.copyWith(errorMessage: 'Please complete all fields'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final newOrder = WorkOrderModel(
        id: const Uuid().v4(),
        title: state.title,
        description: state.description,
        category: state.category!,
        priority: state.priority!,
        date: state.date!,
        technicianId: state.technicianId!,
        status: kWorkOrderStatuses.first, // Default to first status
        assignSlot:
            state.assignedSlot ??
            ScheduleSlot(dateTime: DateTime.now(), label: 'No Slot Assigned'),
      );

      await _hiveService.save(newOrder);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  void updateTitle(String value) {
    emit(state.copyWith(title: value, clearError: true));
  }

  void updateAssignedSlot(ScheduleSlot slot) {
    emit(state.copyWith(assignedSlot: slot));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value, clearError: true));
  }

  void updateCategory(String? value) {
    emit(state.copyWith(category: value, clearError: true));
  }

  void updatePriority(String? value) {
    emit(state.copyWith(priority: value, clearError: true));
  }

  // In CreateWorkOrderCubit
  void updateTechnician(String? value) {
    emit(
      state.copyWith(technicianId: value, clearError: true, assignedSlot: null),
    );
  }

  void updateDate(DateTime value) {
    emit(state.copyWith(date: value, clearError: true));
  }

  void reset() {
    emit(const CreateWorkOrderState());
  }
}
