// 📁 lib/features/work_order_list/widgets/filter_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_state.dart';
import 'package:quiqflow_maintenance_app/core/constants/app_constants.dart';
import 'package:quiqflow_maintenance_app/core/theme/app_theme.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  // --- Internal state to hold temporary selections ---
  late List<String> _selectedStatuses;
  late String? _selectedTechnician;
  late DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    // Initialize the local state from the Cubit's current state.
    // This ensures the modal opens with the filters already applied.
    final currentState = context.read<WorkOrderListCubit>().state;
    if (currentState is WorkOrderListLoaded) {
      _selectedStatuses = List.from(currentState.filters.statusFilter);
      _selectedTechnician = currentState.filters.technicianFilter;
      _selectedDateRange = currentState.filters.dateRangeFilter;
    } else {
      // Default to empty state if the cubit is not yet loaded.
      _selectedStatuses = [];
      _selectedTechnician = null;
      _selectedDateRange = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<WorkOrderListCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Status Filter (Modern Chips) ---
          _buildFilterHeader(
            'filter_section.status_title'.tr(),
            'filter_section.status_subtitle'.tr(),
            textTheme,
            colorScheme,
          ),
          SizedBox(height: 16.h),
          _buildStatusFilterChips(context, _selectedStatuses, (newSelection) {
            // --- Update local state via setState ---
            setState(() {
              _selectedStatuses = newSelection;
            });
          }),
          SizedBox(height: 24.h),

          // --- Technician Filter (Clean Choice Chips) ---
          _buildFilterHeader(
            'filter_section.technician_title'.tr(),
            'filter_section.technician_subtitle'.tr(),
            textTheme,
            colorScheme,
          ),
          SizedBox(height: 16.h),
          _buildTechnicianFilterChips(context, _selectedTechnician, (selected) {
            // --- Update local state via setState ---
            setState(() {
              _selectedTechnician = selected;
            });
          }),
          SizedBox(height: 24.h),

          // --- Date Range Filter (Clean Button) ---
          _buildFilterHeader(
            'filter_section.date_range_title'.tr(),
            'filter_section.date_range_subtitle'.tr(),
            textTheme,
            colorScheme,
          ),
          SizedBox(height: 16.h),
          _buildDateRangeButton(
            context,
            _selectedDateRange,
            (pickedDateRange) {
              // --- Update local state via setState ---
              setState(() {
                _selectedDateRange = pickedDateRange;
              });
            },
            textTheme,
            colorScheme,
          ),
          SizedBox(height: 24.h),

          // --- Action Buttons: Clear and Apply ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // --- Clear local state and update UI ---
                  setState(() {
                    _selectedStatuses = [];
                    _selectedTechnician = null;
                    _selectedDateRange = null;
                  });
                },
                style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                child: Text('filter_section.clear_filters_button'.tr()),
              ),
              SizedBox(width: 16.w),
              ElevatedButton(
                onPressed: () {
                  // --- Apply filters to the cubit and close the sheet ---
                  cubit.applyFilters(
                    statuses: _selectedStatuses,
                    technicianId: _selectedTechnician,
                    dateRange: _selectedDateRange,
                  );
                  Navigator.pop(context); // Close the modal sheet
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 24.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 4,
                ),
                child: Text('apply_filters_button'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to build consistent filter headers.
  Widget _buildFilterHeader(
    String title,
    String subtitle,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: textTheme.bodySmall!.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Replaces the custom pills with clean Material 3 FilterChips.
  Widget _buildStatusFilterChips(
    BuildContext context,
    List<String> selectedStatuses,
    Function(List<String>) onSelectionChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children:
          kWorkOrderStatuses.map((status) {
            final isSelected = selectedStatuses.contains(status);
            final translatedStatus =
                'work_order_card.status.${status.toLowerCase().replaceAll(' ', '_')}'
                    .tr();
            return FilterChip(
              label: Text(translatedStatus),
              selected: isSelected,
              onSelected: (bool selected) {
                final newSelection = List<String>.from(selectedStatuses);
                if (selected) {
                  newSelection.add(status);
                } else {
                  newSelection.remove(status);
                }
                onSelectionChanged(newSelection);
              },
              labelStyle: TextStyle(
                color:
                    isSelected
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              selectedColor: colorScheme.secondaryContainer,
              checkmarkColor: colorScheme.onSecondaryContainer,
              backgroundColor: colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              side: BorderSide(
                color:
                    isSelected
                        ? Colors.transparent
                        : colorScheme.outlineVariant,
                width: 1.0,
              ),
            );
          }).toList(),
    );
  }

  /// Replaces the custom animated cards with simple ChoiceChips with avatars.
  Widget _buildTechnicianFilterChips(
    BuildContext context,
    String? selectedTechnician,
    Function(String?) onSelected,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children:
          kTechnicianNames.map((technician) {
            final isSelected = selectedTechnician == technician;
            return ChoiceChip(
              avatar: CircleAvatar(
                backgroundColor:
                    isSelected
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurfaceVariant.withOpacity(0.1),
                child: Icon(
                  Icons.person_rounded,
                  size: 18.sp,
                  color:
                      isSelected
                          ? colorScheme.secondaryContainer
                          : colorScheme.onSurfaceVariant,
                ),
              ),
              label: Text(technician),
              selected: isSelected,
              onSelected: (bool selected) {
                onSelected(selected ? technician : null);
              },
              selectedColor: colorScheme.secondaryContainer,
              checkmarkColor: colorScheme.onSecondaryContainer,
              backgroundColor: colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              side: BorderSide(
                color:
                    isSelected
                        ? Colors.transparent
                        : colorScheme.outlineVariant,
              ),
              labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color:
                    isSelected
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
    );
  }

  /// A clean, flat button for the date range picker.
  Widget _buildDateRangeButton(
    BuildContext context,
    DateTimeRange? selectedDateRange,
    Function(DateTimeRange?) applyFilters,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        // Using OutlinedButton for a flatter look
        onPressed: () async {
          final pickedDateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            initialDateRange: selectedDateRange,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: colorScheme.copyWith(
                    primary: AppTheme.secondaryColor,
                    onPrimary: Colors.white,
                    surface: colorScheme.surfaceContainerHighest,
                    onSurface: colorScheme.onSurface,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.secondaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDateRange != null) {
            applyFilters(pickedDateRange);
          }
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          side: BorderSide(color: colorScheme.outline, width: 1.5),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
        ),
        icon: Icon(Icons.calendar_month, color: AppTheme.secondaryColor),
        label: Text(
          selectedDateRange != null
              ? '${DateFormat('MMM d, y', context.locale.languageCode).format(selectedDateRange.start)} - ${DateFormat('MMM d, y', context.locale.languageCode).format(selectedDateRange.end)}'
              : 'filter_section.select_date_range_button'.tr(),
          style: textTheme.bodyLarge!.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
