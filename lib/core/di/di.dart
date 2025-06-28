import 'package:get_it/get_it.dart';
import 'package:quiqflow_maintenance_app/core/services/hive_service.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/viewmodels/create_work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/services/calendar_service.dart';
import 'package:quiqflow_maintenance_app/features/weekly_calendar/viewmodels/weekly_calendar_cubit.dart';
import 'package:quiqflow_maintenance_app/features/home/viewModels/work_order_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await HiveService.init();

  getIt.registerLazySingleton<HiveService>(() => HiveService());

  getIt.registerFactory(() => WorkOrderListCubit(getIt<HiveService>()));

  getIt.registerFactory(() => CreateWorkOrderCubit(getIt<HiveService>()));

  getIt.registerLazySingleton(() => CalendarService(getIt<HiveService>()));

  getIt.registerFactory(() => WeeklyCalendarCubit(getIt<CalendarService>()));
}
