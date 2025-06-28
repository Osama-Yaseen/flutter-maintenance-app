// 📁 lib/features/home/viewModels/work_order_state.dart

import 'package:equatable/equatable.dart';
import 'package:quiqflow_maintenance_app/features/home/models/work_order_filters.dart';
import 'package:quiqflow_maintenance_app/features/shared_models/work_order_model.dart';

abstract class WorkOrderListState extends Equatable {
  const WorkOrderListState();

  @override
  List<Object?> get props => [];
}

class WorkOrderListInitial extends WorkOrderListState {}

class WorkOrderListLoading extends WorkOrderListState {}

class WorkOrderListLoaded extends WorkOrderListState {
  final List<WorkOrderModel> allOrders;
  final WorkOrderFilters filters;

  List<WorkOrderModel> get filteredOrders =>
      _applyFiltersOnList(allOrders, filters);

  const WorkOrderListLoaded({
    required this.allOrders,
    this.filters = const WorkOrderFilters(),
  });

  WorkOrderListLoaded copyWith({WorkOrderFilters? filters}) {
    return WorkOrderListLoaded(
      allOrders: allOrders,
      filters: filters ?? this.filters,
    );
  }

  // --- REFINED: Filtering logic for clarity and robustness ---
  static List<WorkOrderModel> _applyFiltersOnList(
    List<WorkOrderModel> allOrders,
    WorkOrderFilters filters,
  ) {
    Iterable<WorkOrderModel> filteredList = allOrders;

    // Filter 1: Status
    if (filters.statusFilter.isNotEmpty) {
      filteredList = filteredList.where(
        (order) => filters.statusFilter.contains(order.status),
      );
    }

    // --- Removed Priority and Category filters as they are not in the model ---

    // Filter 2: Technician
    if (filters.technicianFilter != null) {
      filteredList = filteredList.where(
        (order) => order.technicianId == filters.technicianFilter,
      );
    }

    // Filter 3: Date Range
    if (filters.dateRangeFilter != null) {
      // Normalize the date range to midnight for a robust comparison
      final start = filters.dateRangeFilter!.start;
      final end = filters.dateRangeFilter!.end;

      // Check if the order's date is within the inclusive date range
      filteredList = filteredList.where((order) {
        final orderDate = DateTime(
          order.date.year,
          order.date.month,
          order.date.day,
        );
        final startDate = DateTime(start.year, start.month, start.day);
        final endDate = DateTime(end.year, end.month, end.day);

        return (orderDate.isAtSameMomentAs(startDate) ||
                orderDate.isAfter(startDate)) &&
            (orderDate.isAtSameMomentAs(endDate) ||
                orderDate.isBefore(endDate));
      });
    }

    // Filter 4: Search Query
    if (filters.searchText.isNotEmpty) {
      final query = filters.searchText.toLowerCase();
      filteredList = filteredList.where((order) {
        return order.title.toLowerCase().contains(query) ||
            order.description.toLowerCase().contains(query);
      });
    }

    return filteredList.toList();
  }

  // --- Add the props list for Equatable ---
  @override
  List<Object?> get props => [allOrders, filters];
}

class WorkOrderListError extends WorkOrderListState {}
