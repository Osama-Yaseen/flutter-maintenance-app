// 📁 lib/features/work_order_list/widgets/work_order_list.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiqflow_maintenance_app/features/shared_models/work_order_model.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/components/work_order_card.dart';

class WorkOrderList extends StatelessWidget {
  final List<WorkOrderModel> orders;

  const WorkOrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    // Access theme for consistent styling
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (orders.isEmpty) {
      // --- DECREASED FONT SIZE for the empty state message ---
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 60.sp, color: colorScheme.outline),
            SizedBox(height: 16.h),
            Text(
              'no_work_orders_found'.tr(),
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.outline,
                fontSize: 16.sp, // Decreased font size
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero, // Remove default padding
        itemCount: orders.length,
        separatorBuilder:
            (_, __) =>
                SizedBox(height: 12.h), // Add vertical spacing between cards
        itemBuilder: (context, index) {
          final order = orders[index];
          return WorkOrderCard(order: order);
        },
      ),
    );
  }
}
