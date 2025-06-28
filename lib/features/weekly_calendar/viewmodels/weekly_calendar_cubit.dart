import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/services/calendar_service.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/viewmodels/weekly_calendar_state.dart';

class WeeklyCalendarCubit extends Cubit<WeeklyCalendarState> {
  final CalendarService _service;

  WeeklyCalendarCubit(this._service) : super(WeeklyCalendarLoading());

  Future<void> loadEvents(DateTime weekStart) async {
    emit(WeeklyCalendarLoading());
    try {
      final events = _service.getEventsForWeek(weekStart);
      emit(WeeklyCalendarLoaded(events));
    } catch (e) {
      emit(WeeklyCalendarError(e.toString()));
    }
  }
}
