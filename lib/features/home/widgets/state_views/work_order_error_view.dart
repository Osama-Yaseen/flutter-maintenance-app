// 📁 lib/features/work_order_list/widgets/work_order_error_view.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOrderErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const WorkOrderErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: colorScheme.error),
            SizedBox(height: 16.h),
            Text(
              'failed_to_load'.tr(),
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.error,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text('retry_button'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
