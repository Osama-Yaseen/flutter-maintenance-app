// 📁 lib/features/work_order_list/widgets/date_range_filter_field.dart

import 'package:easy_localization/easy_localization.dart'; // <--- Import easy_localization
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateRangeFilterField extends StatefulWidget {
  final DateTimeRange? initialValue;
  final void Function(DateTimeRange?) onChanged;

  const DateRangeFilterField({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<DateRangeFilterField> createState() => _DateRangeFilterFieldState();
}

class _DateRangeFilterFieldState extends State<DateRangeFilterField> {
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _updateControllerText(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant DateRangeFilterField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the text field if the parent's value changes (e.g., from clear filters)
    if (widget.initialValue != oldWidget.initialValue) {
      _updateControllerText(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _updateControllerText(DateTimeRange? dateRange) {
    if (dateRange != null) {
      // Use the current locale to format the dates
      final localeCode = context.locale.languageCode;
      _dateController.text =
          '${DateFormat.yMMMd(localeCode).format(dateRange.start)} → ${DateFormat.yMMMd(localeCode).format(dateRange.end)}';
    } else {
      _dateController.clear();
    }
  }

  // A reusable input decoration for consistency
  InputDecoration _inputDecoration({Widget? suffixIcon}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InputDecoration(
      hintText: 'select_date_range_hint'.tr(), // --- TRANSLATED ---
      hintStyle: textTheme.bodyLarge!.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      prefixIcon: Icon(
        Icons.calendar_today_outlined,
        color: colorScheme.onSurfaceVariant,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: colorScheme.surfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(16.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: _dateController,
      readOnly: true, // Prevents manual keyboard input
      onTap: () async {
        // Show the date picker dialog when the field is tapped
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2023),
          lastDate: DateTime(2100),
          builder: (context, child) {
            // Apply a comprehensive theme to the calendar dialog
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: colorScheme,
                textTheme: textTheme,
                dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  backgroundColor: colorScheme.surface,
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: colorScheme.surface,
                  headerBackgroundColor: colorScheme.primaryContainer,
                  headerForegroundColor: colorScheme.onPrimaryContainer,
                  dayForegroundColor: WidgetStateProperty.all(
                    colorScheme.onSurface,
                  ),
                  todayForegroundColor: WidgetStateProperty.all(
                    colorScheme.primary,
                  ),
                  rangeSelectionBackgroundColor: colorScheme.primary
                      .withOpacity(0.1),
                  rangeSelectionOverlayColor: WidgetStateProperty.all(
                    colorScheme.primary.withOpacity(0.1),
                  ),
                  rangePickerHeaderBackgroundColor: colorScheme.primary,
                  rangePickerHeaderForegroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    textStyle: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        widget.onChanged(picked); // Notify the parent widget of the selection
      },
      style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
      decoration: _inputDecoration(
        suffixIcon:
            widget.initialValue != null
                ? IconButton(
                  icon: Icon(Icons.clear, color: colorScheme.error),
                  onPressed: () => widget.onChanged(null), // Clear the filter
                )
                : Icon(
                  Icons.arrow_drop_down,
                  color: colorScheme.onSurfaceVariant,
                ),
      ),
    );
  }
}
