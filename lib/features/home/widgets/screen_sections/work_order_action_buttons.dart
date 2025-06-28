// 📁 lib/features/work_order_list/widgets/work_order_action_buttons.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOrderActionButtons extends StatelessWidget {
  final VoidCallback onShowFilter;
  final VoidCallback onShowCalendar;

  const WorkOrderActionButtons({
    super.key,
    required this.onShowFilter,
    required this.onShowCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: onShowFilter,
            icon: Icon(
              Icons.filter_list,
              size: 18.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            label: Text(
              'filter_button'.tr(),
              style: textTheme.labelLarge!.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14.sp,
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: onShowCalendar,
            icon: Icon(
              Icons.calendar_view_week,
              size: 18.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            label: Text(
              'calendar_button'.tr(),
              style: textTheme.labelLarge!.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
