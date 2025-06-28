// 📁 lib/features/create_work_order/widgets/custom_date_picker_field.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiqflow_maintenance_app/core/theme/app_theme.dart';

class CustomDatePickerField extends StatelessWidget {
  final DateTime? date;
  final void Function(DateTime) onDateSelected;

  const CustomDatePickerField({
    super.key,
    required this.date,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) onDateSelected(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'create_work_order.label_date'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date != null
                    ? DateFormat.yMMMd(
                      context.locale.languageCode,
                    ).format(date!)
                    : 'create_work_order.date_picker_placeholder'.tr(),
                style: TextStyle(
                  color: date != null ? AppTheme.tertiaryColor : Colors.grey,
                ),
              ),
              const Icon(Icons.calendar_today, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
