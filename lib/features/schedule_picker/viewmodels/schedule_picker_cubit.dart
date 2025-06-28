// lib/features/schedule_picker/viewmodels/schedule_picker_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';

class SchedulePickerState {
  final List<ScheduleSlot> availableSlots;
  final ScheduleSlot? selectedSlot;
  // --- ADDED: Loading flag to track API calls ---
  final bool isLoading;

  SchedulePickerState({
    required this.availableSlots,
    this.selectedSlot,
    required this.isLoading,
  });

  SchedulePickerState copyWith({
    List<ScheduleSlot>? availableSlots,
    ScheduleSlot? selectedSlot,
    bool? isLoading,
  }) {
    return SchedulePickerState(
      availableSlots: availableSlots ?? this.availableSlots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      isLoading:
          isLoading ??
          this.isLoading, // --- UPDATED: copyWith now includes isLoading ---
    );
  }
}

class SchedulePickerCubit extends Cubit<SchedulePickerState> {
  // --- UPDATED: Initial state now includes isLoading: false ---
  SchedulePickerCubit()
    : super(SchedulePickerState(availableSlots: [], isLoading: false));

  void loadSlotsForTechnician(String technicianId) async {
    // --- ENHANCEMENT: Simulate a loading state before the data is fetched ---
    emit(state.copyWith(isLoading: true));

    // --- MOCK API CALL: Simulate a network delay ---
    await Future.delayed(const Duration(seconds: 2));

    // Mocked time slots - in a real app, this would be an API call
    final now = DateTime.now();
    // Helper to get the date of the next weekday (Mon-Fri)
    DateTime getNextWeekday(int weekday) {
      final today = now.weekday;
      // Calculate days to add, wrapping around to the next week if needed
      final daysToAdd = (weekday - today + 7) % 7;
      // Ensure we only look for weekdays in the future, not today if it's past
      return now
          .add(Duration(days: daysToAdd == 0 ? 7 : daysToAdd))
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    }

    // As per user's location and time (Amman, Jordan, June 28, 2025), today is Friday.
    // Monday is the next working day.
    final nextMonday = getNextWeekday(DateTime.monday);
    final nextTuesday = getNextWeekday(DateTime.tuesday);
    final nextWednesday = getNextWeekday(DateTime.wednesday);

    final mockSlots = [
      ScheduleSlot(
        dateTime: nextMonday.add(const Duration(hours: 10)),
        label: '10:00 AM',
      ),
      ScheduleSlot(
        dateTime: nextMonday.add(const Duration(hours: 14)),
        label: '02:00 PM',
      ),
      ScheduleSlot(
        dateTime: nextTuesday.add(const Duration(hours: 11)),
        label: '11:00 AM',
      ),
      ScheduleSlot(
        dateTime: nextWednesday.add(const Duration(hours: 9)),
        label: '09:00 AM',
      ),
      // --- ADDED: More slots for a better visual list ---
      ScheduleSlot(
        dateTime: nextWednesday.add(const Duration(hours: 15)),
        label: '03:00 PM',
      ),
      ScheduleSlot(
        dateTime: nextWednesday.add(const Duration(hours: 17)),
        label: '05:00 PM',
      ),
    ];

    // --- ENHANCEMENT: Emit the data and set loading to false ---
    emit(state.copyWith(availableSlots: mockSlots, isLoading: false));
  }

  void selectSlot(ScheduleSlot slot) {
    emit(state.copyWith(selectedSlot: slot));
  }
}
