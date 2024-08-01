import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/attendance/data/repositories/attendance_repo_impl.dart';
import '../../features/auth/data/repositories/login/login_repo_impl.dart';
import '../../features/chart/data/repositories/chart_repo_impl.dart';
import '../../features/screenTable/data/repositories/screen_repo_impl.dart';
import '../../features/tasks/data/repositories/task_repo_impl.dart';
import '../repositories/menu/menu_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<MenuRepoImpl>(
    MenuRepoImpl(getIt.get<ApiService>()),
  );

  getIt.registerSingleton<ScreenRepoImpl>(
    ScreenRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ChartRepoImpl>(
    ChartRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<AttendanceRepoImpl>(
    AttendanceRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<TaskRepoImpl>(
    TaskRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
}
