// 📁 lib/features/work_order_list/views/work_order_list_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_state.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/filter_widgets/filter_section.dart'; // This is already a separate widget, good!
import 'package:quiqflow_maintenance_app/features/home/widgets/screen_sections/work_order_action_buttons.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/screen_sections/work_order_app_bar.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/components/work_order_card.dart'; // This is already a separate widget, good!
import 'package:quiqflow_maintenance_app/features/home/widgets/state_views/work_order_empty_view.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/state_views/work_order_error_view.dart';
import 'package:quiqflow_maintenance_app/features/home/widgets/state_views/work_order_loading_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<WorkOrderListCubit>().applySearchFilter(
      _searchController.text,
    );
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'greeting.morning'.tr();
    }
    if (hour < 17) {
      return 'greeting.afternoon'.tr();
    }
    return 'greeting.evening'.tr();
  }

  void _switchLanguage() {
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Use a BlocProvider.value to ensure the cubit is available in the bottom sheet
    final cubit = context.read<WorkOrderListCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (modalContext) {
        return BlocProvider.value(
          value: cubit,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                16.h,
                16.w,
                MediaQuery.of(modalContext).viewInsets.bottom,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Text(
                      'filter_sheet_title'.tr(),
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const FilterSection(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WorkOrderListCubit>().loadWorkOrders();
      },
      color: colorScheme.primary,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // --- EXTRACTED: The SliverAppBar is now its own widget ---
            WorkOrderAppBar(
              searchController: _searchController,
              greeting: _greeting,
              onLanguageSwitch: _switchLanguage,
            ),
            // --- EXTRACTED: The row of buttons is now its own widget ---
            SliverToBoxAdapter(
              child: WorkOrderActionButtons(
                onShowFilter: () => _showFilterBottomSheet(context),
                onShowCalendar: () => context.push('/weekly-calendar'),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(height: 1, color: colorScheme.outline),
            ),
            BlocBuilder<WorkOrderListCubit, WorkOrderListState>(
              builder: (context, state) {
                if (state is WorkOrderListLoading) {
                  // --- EXTRACTED: The loading state view ---
                  return const WorkOrderLoadingView();
                } else if (state is WorkOrderListLoaded) {
                  if (state.filteredOrders.isEmpty) {
                    // --- EXTRACTED: The empty state view ---
                    return const WorkOrderEmptyView();
                  }
                  return SliverList.separated(
                    itemCount: state.filteredOrders.length,
                    separatorBuilder:
                        (_, __) => Divider(
                          height: 1,
                          color: colorScheme.outlineVariant,
                        ),
                    itemBuilder: (context, index) {
                      final order = state.filteredOrders[index];
                      return WorkOrderCard(order: order);
                    },
                  );
                } else if (state is WorkOrderListError) {
                  // --- EXTRACTED: The error state view with a retry callback ---
                  return WorkOrderErrorView(
                    onRetry:
                        () =>
                            context.read<WorkOrderListCubit>().loadWorkOrders(),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await context.push<bool>('/create-work-order');
            if (result == true) {
              // ignore: use_build_context_synchronously
              context.read<WorkOrderListCubit>().loadWorkOrders();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
