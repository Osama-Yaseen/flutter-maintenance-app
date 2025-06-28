// lib/features/weekly_calendar/widgets/event_list_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/calendar_event.dart';

// Define typedefs for clarity and type safety
typedef GetTechnicianColor = Color Function(String technicianId);
typedef OnEventTap = void Function(CalendarEvent event);

class EventListWidget extends StatelessWidget {
  final List<CalendarEvent> selectedEvents;
  final OnEventTap onEventTap;
  final GetTechnicianColor getTechnicianColor;

  const EventListWidget({
    super.key,
    required this.selectedEvents,
    required this.onEventTap,
    required this.getTechnicianColor,
  });

  // Helper function to format time (can be kept here or moved to a utils class)
  String _formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          final event = selectedEvents[index];
          final Color cardColor = getTechnicianColor(event.technicianId);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: cardColor,
            child: InkWell(
              onTap: () => onEventTap(event),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            event.title,
                            style: textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${_formatTime(event.start)} - ${_formatTime(event.end)}',
                          style: textTheme.labelSmall!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          event.technicianId,
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
