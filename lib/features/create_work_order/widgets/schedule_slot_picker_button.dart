// 📁 lib/features/create_work_order/widgets/schedule_slot_picker_button.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiqflow_maintenance_app/core/theme/app_theme.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';

class ScheduleSlotPickerButton extends StatelessWidget {
  final String? technicianId;
  final ScheduleSlot? assignedSlot;
  final VoidCallback onPressed;

  const ScheduleSlotPickerButton({
    super.key,
    required this.technicianId,
    required this.assignedSlot,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: Colors.white,
        ),
        icon: const Icon(Icons.schedule),
        label: Text(
          assignedSlot == null
              ? 'create_work_order.button_pick_slot'.tr()
              : 'create_work_order.button_slot_label'.tr(
                namedArgs: {
                  'slot_label': assignedSlot!.label,
                  'date': DateFormat.yMMMd(
                    context.locale.languageCode,
                  ).format(assignedSlot!.dateTime),
                },
              ),
        ),
        onPressed: technicianId != null ? onPressed : null,
      ),
    );
  }
}
