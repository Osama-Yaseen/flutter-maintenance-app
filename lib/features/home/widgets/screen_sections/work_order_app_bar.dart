// 📁 lib/features/work_order_list/widgets/work_order_app_bar.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_state.dart';

class WorkOrderAppBar extends StatelessWidget {
  final TextEditingController searchController;
  final String greeting;
  final VoidCallback onLanguageSwitch;

  const WorkOrderAppBar({
    super.key,
    required this.searchController,
    required this.greeting,
    required this.onLanguageSwitch,
  });

  @override
  Widget build(BuildContext context) {
    // In your widget's build method or a helper function
    final currentLocale = context.locale;
    final supportedLocales = context.supportedLocales;

    // Find the locale that is NOT the current one.
    // This assumes you have exactly two supported locales.
    final localeToSwitchTo = supportedLocales.firstWhere(
      (locale) => locale.languageCode != currentLocale.languageCode,
      orElse:
          () =>
              currentLocale, // Fallback to current if only one locale is supported
    );

    // Helper function to get a human-readable language name
    String getLanguageName(String languageCode) {
      switch (languageCode) {
        case 'en':
          return 'English';
        case 'ar':
          return 'العربية'; // Arabic
        // Add more cases if you support more languages
        default:
          return languageCode.toUpperCase();
      }
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      floating: true,
      elevation: 4,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: OutlinedButton.icon(
            onPressed: onLanguageSwitch,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              side: BorderSide(
                color: colorScheme.onPrimaryContainer.withOpacity(0.5),
              ),
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
            ),
            icon: Icon(Icons.language, size: 18.sp, color: colorScheme.primary),
            label: Text(
              getLanguageName(localeToSwitchTo.languageCode).toUpperCase(),
              style: textTheme.labelLarge!.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSurface,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'search_hint'.tr(),
                hintStyle: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                  size: 20.sp,
                ),
                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: colorScheme.onSurfaceVariant,
                            size: 20.sp,
                          ),
                          onPressed: () => searchController.clear(),
                        )
                        : null,
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 16.w,
                ),
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primary,
                colorScheme.primaryContainer.withOpacity(0.8),
                colorScheme.surface,
              ],
              stops: const [0.1, 0.4, 1.0],
            ),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: textTheme.bodySmall!.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'work_orders_title'.tr(),
                        style: textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          fontSize: 28.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      BlocBuilder<WorkOrderListCubit, WorkOrderListState>(
                        builder: (context, state) {
                          if (state is WorkOrderListLoaded) {
                            return Text(
                              'work_orders_count'.tr(
                                namedArgs: {
                                  'count':
                                      state.filteredOrders.length.toString(),
                                },
                              ),
                              style: textTheme.bodySmall!.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 12.sp,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person,
                      size: 24.sp,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
