// 📁 lib/features/work_order_list/widgets/work_order_card.dart

import 'package:easy_localization/easy_localization.dart'; // <--- Import easy_localization
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quiqflow_maintenance_app/features/shared_models/work_order_model.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrderModel order;
  final double cardRadius = 28.r;

  WorkOrderCard({super.key, required this.order});

  /// Returns a color for the status tag and its glow.
  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'open':
        return colorScheme.tertiary;
      case 'in progress':
        return colorScheme.secondary;
      case 'closed':
        return colorScheme.primary;
      default:
        return colorScheme.outline;
    }
  }

  /// Returns a dynamic icon based on the work order status.
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Icons.hourglass_empty_rounded;
      case 'in progress':
        return Icons.work_history_rounded;
      case 'closed':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  /// Builds a reusable row for displaying a detail with an icon.
  Widget _buildDetailRow(
    IconData icon,
    String text,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      children: [
        // --- DECREASED ICON SIZE ---
        Icon(
          icon,
          size: 18.sp,
          color: colorScheme.onSurfaceVariant,
        ), // Decreased
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            // --- DECREASED FONT SIZE ---
            style: textTheme.bodySmall!.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp, // Decreased
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  /// Builds a custom tag with border and subtle glow.
  Widget _buildStatusTag(
    String label,
    Color tagColor,
    ColorScheme colorScheme,
    TextTheme textTheme, {
    IconData? icon,
  }) {
    return Container(
      // --- DECREASED PADDING ---
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ), // Decreased
      decoration: BoxDecoration(
        color: tagColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: tagColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tagColor.withOpacity(0.3),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            // --- DECREASED ICON SIZE ---
            Icon(icon, size: 16.sp, color: tagColor), // Decreased
            SizedBox(width: 6.w), // Decreased
          ],
          Text(
            label.toUpperCase(),
            // --- DECREASED FONT SIZE ---
            style: textTheme.labelSmall!.copyWith(
              // Used a smaller style
              color: tagColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 10.sp, // Decreased
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final statusColor = _getStatusColor(order.status, colorScheme);

    // --- TRANSLATE STATUS AND PROGRESS TEXTS ---
    final String translatedStatus =
        'work_order_card.status.${order.status.toLowerCase().replaceAll(' ', '_')}'
            .tr();

    final progressValue =
        order.status.toLowerCase() == 'closed'
            ? 1.0
            : (order.status.toLowerCase() == 'in progress' ? 0.75 : 0.0);
    final progressText =
        order.status.toLowerCase() == 'closed'
            ? 'work_order_card.progress.completed'.tr(
              namedArgs: {'percentage': '100'},
            )
            : (order.status.toLowerCase() == 'in progress'
                ? 'work_order_card.progress.in_progress'.tr(
                  namedArgs: {'percentage': '75'},
                )
                : 'work_order_card.progress.not_started'.tr(
                  namedArgs: {'percentage': '0'},
                ));

    final statusIcon = _getStatusIcon(order.status);
    final isHighPriority = order.priority.toLowerCase() == 'high';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      decoration: BoxDecoration(
        // --- This has been changed to a solid white color ---
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            offset: const Offset(6, 12),
            blurRadius: 30,
            spreadRadius: -5,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            offset: const Offset(-2, -2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // --- TRANSLATE SNACKBAR MESSAGE ---
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'work_order_card.snack_bar.tapped_on'.tr(
                  namedArgs: {'title': order.title},
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(cardRadius),
        child: Padding(
          padding: EdgeInsets.all(24.w), // Decreased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER SECTION (TITLE + GLOWING STATUS) ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- DECREASED ICON SIZE ---
                  Icon(
                    Icons.receipt_long_rounded,
                    color: colorScheme.onSurface,
                    size: 32.sp, // Decreased
                  ),
                  SizedBox(width: 20.w), // Decreased
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- DECREASED FONT SIZE ---
                        Text(
                          order.title,
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            fontSize: 18.sp, // Decreased
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatusTag(
                        translatedStatus, // --- USE TRANSLATED STATUS ---
                        statusColor,
                        colorScheme,
                        textTheme,
                        icon: statusIcon,
                      ),
                      if (isHighPriority) ...[
                        SizedBox(height: 8.h), // Decreased
                        _buildStatusTag(
                          'work_order_card.priority.high'
                              .tr(), // --- TRANSLATED PRIORITY ---
                          colorScheme.error,
                          colorScheme,
                          textTheme,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Decreased
              // --- DESCRIPTION ---
              Text(
                order.description,
                // --- DECREASED FONT SIZE ---
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.4,
                  fontSize: 12.sp, // Decreased
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 24.h), // Decreased
              // --- DETAILS SECTION (DATE & TECHNICIAN) ---
              _buildDetailRow(
                Icons.calendar_month_outlined,
                // --- TRANSLATE AND USE LOCALE-AWARE DATE FORMAT ---
                'work_order_card.details.created_at'.tr(
                  namedArgs: {
                    'date': DateFormat(
                      'MMM d, yyyy',
                      context.locale.languageCode,
                    ).format(order.date),
                  },
                ),
                colorScheme,
                textTheme,
              ),
              SizedBox(height: 12.h), // Decreased
              _buildDetailRow(
                Icons.person_outline,
                // --- TRANSLATE WITH TECHNICIAN NAME ---
                'work_order_card.details.assigned_to'.tr(
                  namedArgs: {'technician': order.technicianId},
                ),
                colorScheme,
                textTheme,
              ),
              SizedBox(height: 24.h), // Decreased
              // --- PROGRESS INDICATOR ---
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 12.h, // Decreased
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    progressText, // --- USE TRANSLATED PROGRESS TEXT ---
                    // --- DECREASED FONT SIZE ---
                    style: textTheme.labelSmall!.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp, // Decreased
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Decreased
              // --- POLISHED ACTION BUTTONS ---
              Divider(color: colorScheme.outline.withOpacity(0.4), height: 1.h),
              SizedBox(height: 16.h), // Decreased
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<WorkOrderListCubit>().deleteWorkOrder(
                      order.id,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          // --- TRANSLATE SNACKBAR MESSAGE WITH ID ---
                          'work_order_card.snack_bar.removed_successfully'.tr(
                            namedArgs: {'id': order.id},
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  // --- DECREASED ICON SIZE ---
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20.sp,
                  ), // Decreased
                  label: Text(
                    'work_order_card.remove_button'
                        .tr(), // --- TRANSLATED BUTTON TEXT ---
                    // --- DECREASED FONT SIZE ---
                    style: textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp, // Decreased
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(
                      color: colorScheme.error.withOpacity(0.6),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    // --- DECREASED PADDING ---
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h, // Decreased
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
