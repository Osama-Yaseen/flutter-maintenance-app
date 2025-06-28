// lib/core/services/hive_service.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';
import 'package:quiqflow_maintenance_app/features/shared_models/work_order_model.dart';

/// A set of extensions to easily get the start and end of a day.
/// This makes date range filtering logic much more readable.
extension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
}

class HiveService {
  static const _workOrderBox = 'work_orders';

  /// Initialize Hive and register adapters
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(WorkOrderModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ScheduleSlotAdapter());
    }

    await Hive.openBox<WorkOrderModel>(_workOrderBox);
  }

  Box<WorkOrderModel> get _box => Hive.box<WorkOrderModel>(_workOrderBox);

  /// CRUD operations
  List<WorkOrderModel> getAll() => _box.values.toList();

  List<WorkOrderModel> filter({
    String? status,
    String? technicianId,
    DateTimeRange? dateRange,
  }) {
    final filteredOrders = <WorkOrderModel>[];

    for (final order in _box.values) {
      if (status != null && order.status != status) {
        continue;
      }
      if (technicianId != null && order.technicianId != technicianId) {
        continue;
      }
      if (dateRange != null) {
        final orderDate =
            order.date.startOfDay; // Normalize order date to start of day
        final rangeStart = dateRange.start.startOfDay;
        final rangeEnd = dateRange.end.startOfDay;

        if (orderDate.isBefore(rangeStart) || orderDate.isAfter(rangeEnd)) {
          continue;
        }
      }
      filteredOrders.add(order);
    }
    return filteredOrders;
  }

  Future<void> save(WorkOrderModel order) async =>
      await _box.put(order.id, order);

  Future<void> delete(String id) async => await _box.delete(id);

  Future<void> clearAll() async => await _box.clear();
}
