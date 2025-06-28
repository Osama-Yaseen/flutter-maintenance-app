// 📁 lib/features/work_order_list/widgets/work_order_empty_view.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOrderEmptyView extends StatelessWidget {
  const WorkOrderEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 60.sp, color: colorScheme.outline),
            SizedBox(height: 16.h),
            Text(
              'no_work_orders_found'.tr(),
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.outline,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
