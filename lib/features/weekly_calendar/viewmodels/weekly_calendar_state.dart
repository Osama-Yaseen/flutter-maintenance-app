import 'package:equatable/equatable.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/models/calendar_event.dart';

abstract class WeeklyCalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeeklyCalendarLoading extends WeeklyCalendarState {}

class WeeklyCalendarError extends WeeklyCalendarState {
  final String message;
  WeeklyCalendarError(this.message);

  @override
  List<Object?> get props => [message];
}

class WeeklyCalendarLoaded extends WeeklyCalendarState {
  final List<CalendarEvent> events;
  WeeklyCalendarLoaded(this.events);

  @override
  List<Object?> get props => [events];
}
