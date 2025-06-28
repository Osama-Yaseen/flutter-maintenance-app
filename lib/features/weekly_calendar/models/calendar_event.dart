class CalendarEvent {
  final String id;
  final String technicianId;
  final String title;
  final DateTime start;
  final DateTime end;

  CalendarEvent({
    required this.id,
    required this.technicianId,
    required this.title,
    required this.start,
    required this.end,
  });
}
