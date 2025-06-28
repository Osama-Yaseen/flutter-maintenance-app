import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiqflow_maintenance_app/core/di/di.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/viewmodels/schedule_picker_cubit.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/views/schedule_picker_screen.dart';
import 'package:quiqflow_maintenance_app/features/splash/views/splash_screen.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/services/calendar_service.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/viewmodels/weekly_calendar_cubit.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/views/weekly_calendar_screen.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/home/views/home_screen.dart';

import 'package:quiqflow_maintenance_app/features/create_work_order/viewmodels/create_work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/views/create_work_order_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/work-orders',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<WorkOrderListCubit>()..loadWorkOrders(),
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: '/create-work-order',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<CreateWorkOrderCubit>(),
          child: const CreateWorkOrderScreen(),
        );
      },
    ),
    GoRoute(
      path: '/schedule-picker/:technicianId',
      builder: (context, state) {
        final technicianId = state.pathParameters['technicianId']!;
        return BlocProvider(
          create:
              (_) =>
                  SchedulePickerCubit()..loadSlotsForTechnician(technicianId),
          child: SchedulePickerScreen(technicianId: technicianId),
        );
      },
    ),
    GoRoute(
      path: '/weekly-calendar',
      builder:
          (context, state) => BlocProvider(
            create: (_) => WeeklyCalendarCubit(getIt<CalendarService>()),
            child: const WeeklyCalendarScreen(),
          ),
    ),
  ],
);
