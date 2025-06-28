// lib/features/schedule_picker/views/schedule_picker_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart'; // <--- Import easy_localization
import 'package:quiqflow_maintenance_app/core/theme/app_theme.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/viewmodels/schedule_picker_cubit.dart';

class SchedulePickerScreen extends StatelessWidget {
  final String technicianId;

  const SchedulePickerScreen({super.key, required this.technicianId});

  // A static builder method for GoRouter
  static BlocProvider builder(BuildContext context, GoRouterState state) {
    final technicianId = state.pathParameters['technicianId']!;
    return BlocProvider(
      create:
          (_) => SchedulePickerCubit()..loadSlotsForTechnician(technicianId),
      child: SchedulePickerScreen(technicianId: technicianId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _SchedulePickerView();
  }
}

class _SchedulePickerView extends StatelessWidget {
  const _SchedulePickerView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<SchedulePickerCubit, SchedulePickerState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildHeader(context, textTheme, colorScheme),
              _buildBody(context, state, textTheme, colorScheme),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
                sliver: SliverToBoxAdapter(
                  child: _buildAssignButton(context, state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  SliverAppBar _buildHeader(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      backgroundColor: colorScheme.surface,
      expandedHeight: 120.h,
      pinned: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(24.w, 0, 12.w, 16.h),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // --- TRANSLATED HEADER TITLE ---
            Text(
              'schedule_picker.header_title'.tr(),
              style: textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontSize: 20.sp,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 24.sp,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    SchedulePickerState state,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    if (state.isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppTheme.secondaryColor),
              SizedBox(height: 16.h),
              // --- TRANSLATED LOADING MESSAGE ---
              Text(
                'schedule_picker.loading_message'.tr(),
                style: textTheme.titleMedium!.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    if (state.availableSlots.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy_rounded,
                  size: 48.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: 16.h),
                // --- TRANSLATED EMPTY STATE MESSAGE ---
                Text(
                  'schedule_picker.no_slots_available'.tr(),
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge!.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // --- ENHANCEMENT: Use context.locale.languageCode for locale-aware date formatting ---
    final groupedSlots = _groupSlotsByDate(
      state.availableSlots,
      context.locale.languageCode,
    );

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final date = groupedSlots.keys.elementAt(index);
        final slots = groupedSlots[date]!;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(date, textTheme, colorScheme),
              ...slots.map(
                (slot) =>
                    _buildSlotItem(context, slot, state.selectedSlot == slot),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      }, childCount: groupedSlots.keys.length),
    );
  }

  Widget _buildDateHeader(
    String date,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16.h, 0, 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        date,
        style: textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildSlotItem(
    BuildContext context,
    ScheduleSlot slot,
    bool isSelected,
  ) {
    final cubit = context.read<SchedulePickerCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: InkWell(
        onTap: () => cubit.selectSlot(slot),
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
          decoration: BoxDecoration(
            gradient:
                isSelected
                    ? LinearGradient(
                      colors: [
                        AppTheme.secondaryColor.withOpacity(0.2),
                        AppTheme.secondaryColor.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            color: isSelected ? null : colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color:
                  isSelected
                      ? AppTheme.secondaryColor
                      : colorScheme.surfaceContainer,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isSelected
                        ? AppTheme.secondaryColor.withOpacity(0.2)
                        : colorScheme.shadow.withOpacity(0.08),
                offset: const Offset(0, 6),
                blurRadius: 15,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slot.label,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontSize: 14.sp,
                      ),
                    ),
                    // --- TRANSLATED DURATION TEXT ---
                    Text(
                      'schedule_picker.slot_duration'.tr(),
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.8),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.secondaryColor,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssignButton(BuildContext context, SchedulePickerState state) {
    final selected = state.selectedSlot;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: selected == null ? null : () => context.pop(selected),
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: AppTheme.primaryColor,
          elevation: 8,
        ),
        child: Text(
          // --- TRANSLATED BUTTON TEXT ---
          'schedule_picker.assign_button'.tr(),
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  // --- MODIFIED: Pass locale to DateFormat for locale-aware formatting ---
  Map<String, List<ScheduleSlot>> _groupSlotsByDate(
    List<ScheduleSlot> slots,
    String locale,
  ) {
    final Map<String, List<ScheduleSlot>> grouped = {};
    for (var slot in slots) {
      final date = DateFormat(
        'EEEE, MMMM d,yyyy',
        locale,
      ).format(slot.dateTime);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(slot);
    }
    return grouped;
  }
}
