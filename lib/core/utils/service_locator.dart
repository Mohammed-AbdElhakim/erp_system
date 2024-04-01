import 'package:dio/dio.dart';
import 'package:erp_system/features/auth/data/repositories/login/login_repo_impl.dart';
import 'package:erp_system/features/screensView/data/repositories/screen_repo_impl.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repositories/menu/menu_repo_impl.dart';
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
}
