import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/models/calendar_event.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/viewmodels/weekly_calendar_cubit.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/viewmodels/weekly_calendar_state.dart';
import 'package:easy_localization/easy_localization.dart'; // <--- Import easy_localization
import 'package:quiqflow_maintenance_app/features/weekly_calendar/widgets/calendar_card_widget.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/widgets/empty_state_widget.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/widgets/error_state_widget.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/widgets/event_list_widget.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/widgets/loading_indicator_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class WeeklyCalendarScreen extends StatefulWidget {
  const WeeklyCalendarScreen({super.key});

  @override
  State<WeeklyCalendarScreen> createState() => _WeeklyCalendarScreenState();
}

class _WeeklyCalendarScreenState extends State<WeeklyCalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // A map to store events keyed by date for easy lookup.
  Map<DateTime, List<CalendarEvent>> _eventsMap = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    _loadEventsForWeek(_focusedDay);
  }

  /// Loads events for the specified week using the cubit.
  void _loadEventsForWeek(DateTime focusedDay) {
    context.read<WeeklyCalendarCubit>().loadEvents(focusedDay);
  }

  /// Provides a color based on the technician's ID for visual distinction.
  Color _getTechnicianColor(String technicianId) {
    final hash = technicianId.hashCode;
    // Use the theme's colors for consistency, and expand the list if needed
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
      Colors.green.shade700,
      Colors.indigo.shade700,
      Colors.amber.shade700,
    ];
    return colors[hash % colors.length];
  }

  /// Displays a SnackBar with event details when an appointment is tapped.
  void _showEventDetails(CalendarEvent event) {
    // --- Use locale from context for date formatting ---
    final localeCode = context.locale.languageCode;
    final String startTime = DateFormat(
      'h:mm a',
      localeCode,
    ).format(event.start);
    final String endTime = DateFormat('h:mm a', localeCode).format(event.end);

    // --- TRANSLATE SNACKBAR CONTENT ---
    final taskLabel = 'weekly_calendar.event_details.task_label'.tr();
    final technicianLabel =
        'weekly_calendar.event_details.technician_label'.tr();
    final timeLabel = 'weekly_calendar.event_details.time_label'.tr();

    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          '$taskLabel ${event.title}\n'
          '$technicianLabel ${event.technicianId}\n'
          '$timeLabel $startTime - $endTime',
        ),
        backgroundColor: _getTechnicianColor(event.technicianId),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Helper function to get events for a specific day from the map
  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _eventsMap[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          // --- TRANSLATED APP BAR TITLE ---
          title: Text('weekly_calendar.schedule_title'.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.today),
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime.now();
                  _selectedDay = _focusedDay;
                  _loadEventsForWeek(_focusedDay);
                });
              },
              // --- TRANSLATED TOOLTIP ---
              tooltip: 'weekly_calendar.jump_to_today_tooltip'.tr(),
            ),
          ],
        ),
        body: BlocBuilder<WeeklyCalendarCubit, WeeklyCalendarState>(
          builder: (context, state) {
            if (state is WeeklyCalendarLoading) {
              return const LoadingIndicatorWidget();
            } else if (state is WeeklyCalendarLoaded) {
              // Rebuild the events map from the new list of events to prevent duplication.
              final newEventsMap = <DateTime, List<CalendarEvent>>{};
              for (final event in state.events) {
                final normalizedDate = DateTime.utc(
                  event.start.year,
                  event.start.month,
                  event.start.day,
                );
                newEventsMap.putIfAbsent(normalizedDate, () => []).add(event);
              }
              _eventsMap = newEventsMap;

              final selectedEvents = _getEventsForDay(_selectedDay);

              return Column(
                children: [
                  // Use the extracted CalendarCardWidget
                  CalendarCardWidget(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    eventLoader: _getEventsForDay,
                    // Pass the setState logic as a callback to the child widget
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    // Pass the load events logic as a callback
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      _loadEventsForWeek(_focusedDay);
                    },
                  ),
                  // Use the extracted EventListWidget or EmptyStateWidget based on data
                  if (selectedEvents.isEmpty)
                    // --- This widget needs to be translated internally ---
                    const EmptyStateWidget()
                  else
                    EventListWidget(
                      selectedEvents: selectedEvents,
                      onEventTap: _showEventDetails,
                      getTechnicianColor: _getTechnicianColor,
                    ),
                ],
              );
            } else if (state is WeeklyCalendarError) {
              // --- This widget needs to be translated internally ---
              return ErrorStateWidget(
                message: state.message,
                onRetry: () => _loadEventsForWeek(_focusedDay),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
