import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class WorkOrderFilters extends Equatable {
  final List<String> statusFilter;
  final String? technicianFilter;
  final DateTimeRange? dateRangeFilter;
  final String searchText;

  const WorkOrderFilters({
    this.statusFilter = const [],
    this.technicianFilter,
    this.dateRangeFilter,
    this.searchText = '',
  });

  // --- REFACTOR: Use direct assignment instead of `??` to allow clearing filters ---
  WorkOrderFilters copyWith({
    List<String>? statusFilter,
    String? technicianFilter, // Note: This is nullable
    DateTimeRange? dateRangeFilter, // Note: This is nullable
    String? searchText,
  }) {
    return WorkOrderFilters(
      statusFilter: statusFilter ?? this.statusFilter,
      // FIX: Use a direct assignment to allow null to overwrite the old value.
      technicianFilter: technicianFilter,
      // FIX: Use a direct assignment to allow null to overwrite the old value.
      dateRangeFilter: dateRangeFilter,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
    statusFilter,
    technicianFilter,
    dateRangeFilter,
    searchText,
  ];
}
