// lib/features/weekly_calendar/widgets/calendar_card_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar_event.dart';

// Define typedefs for clarity
typedef EventLoader = List<CalendarEvent> Function(DateTime day);
typedef OnDaySelected =
    void Function(DateTime selectedDay, DateTime focusedDay);
typedef OnPageChanged = void Function(DateTime focusedDay);

class CalendarCardWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final EventLoader eventLoader;
  final OnDaySelected onDaySelected;
  final OnPageChanged onPageChanged;

  const CalendarCardWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TableCalendar<CalendarEvent>(
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: CalendarFormat.week,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: onDaySelected,
          onPageChanged: onPageChanged,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: textTheme.titleLarge!.copyWith(
              color: colorScheme.primary,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: colorScheme.primary,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: colorScheme.primary,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            selectedBuilder:
                (context, date, events) => Container(
                  margin: const EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            todayBuilder:
                (context, date, events) => Container(
                  margin: const EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.primary, width: 1.5),
                  ),
                  child: Text(
                    '${date.day}',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.tertiary,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
            dowBuilder: (context, day) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: textTheme.labelSmall!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
          eventLoader: eventLoader,
        ),
      ),
    );
  }
}
