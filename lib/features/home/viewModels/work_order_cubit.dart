// 📁 lib/features/work_order_list/viewmodels/work_order_list_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiqflow_maintenance_app/core/services/hive_service.dart';
import 'package:quiqflow_maintenance_app/features/home/models/work_order_filters.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_state.dart';

class WorkOrderListCubit extends Cubit<WorkOrderListState> {
  final HiveService _service;

  WorkOrderListCubit(this._service) : super(WorkOrderListInitial());

  void loadWorkOrders() {
    emit(WorkOrderListLoading());
    try {
      final allOrders = _service.getAll();
      emit(WorkOrderListLoaded(allOrders: allOrders));
    } catch (e) {
      emit(WorkOrderListError());
    }
  }

  void applyFilters({
    List<String>? statuses,
    String? technicianId,
    DateTimeRange? dateRange,
  }) {
    if (state is WorkOrderListLoaded) {
      final currentState = state as WorkOrderListLoaded;
      final newFilters = currentState.filters.copyWith(
        statusFilter: statuses,
        technicianFilter: technicianId,
        dateRangeFilter: dateRange,
      );
      emit(currentState.copyWith(filters: newFilters));
    }
  }

  void applySearchFilter(String query) {
    // Only proceed if the state is loaded
    if (state is WorkOrderListLoaded) {
      final currentState = state as WorkOrderListLoaded;
      final newFilters = currentState.filters.copyWith(
        searchText: query.trim().toLowerCase(),
      );
      // --- Emit the new state with the updated filters ---
      emit(currentState.copyWith(filters: newFilters));
    }
  }

  Future<void> deleteWorkOrder(String id) async {
    await _service.delete(id);
    loadWorkOrders(); // Re-load to refresh the list from the service
  }

  Future<void> clearAll() async {
    final defaultFilters = WorkOrderFilters();
    if (state is WorkOrderListLoaded) {
      final currentState = state as WorkOrderListLoaded;
      emit(currentState.copyWith(filters: defaultFilters));
    } else {
      loadWorkOrders();
    }
  }
}
