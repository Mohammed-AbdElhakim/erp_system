import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/Reports/data/repositories/reports_repo_impl.dart';
import '../../features/accountProf/data/repositories/account_prof_repo_impl.dart';
import '../../features/attendance/data/repositories/attendance_repo_impl.dart';
import '../../features/auth/data/repositories/login/login_repo_impl.dart';
import '../../features/cashier/data/repositories/cashier_repo_impl.dart';
import '../../features/chart/data/repositories/chart_repo_impl.dart';
import '../../features/customerAccount/data/repositories/customer_account_repo_impl.dart';
import '../../features/dashboard/data/repositories/dashboard_repo_impl.dart';
import '../../features/generalBalance/data/repositories/general_balance_repo_impl.dart';
import '../../features/inventoryProduct/data/repositories/trial_balance_repo_impl.dart';
import '../../features/notifications/data/repositories/notifications_repo_impl.dart';
import '../../features/productCard/data/repositories/product_card_repo_impl.dart';
import '../../features/profile/data/repositories/profile_repo_impl.dart';
import '../../features/profit/data/repositories/profit_repo_impl.dart';
import '../../features/projectProcess/data/repositories/project_process_repo_impl.dart';
import '../../features/screenTable/data/repositories/screen_repo_impl.dart';
import '../../features/storeShow/data/repositories/store_show_repo_impl.dart';
import '../../features/supplierProcess/data/repositories/supplier_process_repo_impl.dart';
import '../../features/tasks/data/repositories/task_repo_impl.dart';
import '../../features/trialBalance/data/repositories/trial_balance_repo_impl.dart';
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

  getIt.registerSingleton<TrialBalanceRepoImpl>(
    TrialBalanceRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ProfitRepoImpl>(
    ProfitRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<GeneralBalanceRepoImpl>(
    GeneralBalanceRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<CashierRepoImpl>(
    CashierRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<CustomerAccountRepoImpl>(
    CustomerAccountRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<AccountProfRepoImpl>(
    AccountProfRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<SupplierProcessRepoImpl>(
    SupplierProcessRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ReportsRepoImpl>(
    ReportsRepoImpl(
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

  getIt.registerSingleton<NotificationsRepoImpl>(
    NotificationsRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<DashboardRepoImpl>(
    DashboardRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ProductCardRepoImpl>(
    ProductCardRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<StoreShowRepoImpl>(
    StoreShowRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ProjectProcessRepoImpl>(
    ProjectProcessRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<InventoryProductRepoImpl>(
    InventoryProductRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
}
