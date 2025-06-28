import 'package:quiqflow_maintenance_app/core/services/hive_service.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/models/calendar_event.dart';

class CalendarService {
  final HiveService _hiveService;

  CalendarService(this._hiveService);

  List<CalendarEvent> getEventsForWeek(DateTime weekStart) {
    final monday = weekStart.subtract(Duration(days: weekStart.weekday - 1));
    final weekDays = List.generate(7, (i) {
      final d = monday.add(Duration(days: i));
      return DateTime(d.year, d.month, d.day);
    });

    final all = _hiveService.getAll();

    final events = <CalendarEvent>[];
    for (final order in all) {
      final date = order.assignSlot.dateTime;
      final slotDate = DateTime(date.year, date.month, date.day);
      if (!weekDays.contains(slotDate)) continue;

      events.add(
        CalendarEvent(
          id: order.id,
          technicianId: order.technicianId,
          title: order.title,
          start: order.assignSlot.dateTime,
          end: order.assignSlot.dateTime.add(const Duration(hours: 1)),
        ),
      );
    }
    return events;
  }
}
