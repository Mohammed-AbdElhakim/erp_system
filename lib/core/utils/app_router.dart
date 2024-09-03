import 'package:erp_system/features/screenTable/presentation/views/edit_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/Reports/data/models/report_model.dart';
import '../../features/Reports/presentation/views/table_reports_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/bottomNavigationBar/presentation/views/bottom_navigatiaon_bar_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/host/presentation/views/host_view.dart';
import '../../features/screenTable/data/models/passData/add_pass_data_model.dart';
import '../../features/screenTable/data/models/passData/pass_data_details_row.dart';
import '../../features/screenTable/presentation/views/add_view.dart';
import '../../features/screenTable/presentation/views/details_row_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/tasks/presentation/views/sub_task_view.dart';
import '../models/menu_model/pages.dart';
import '../views/screen_view.dart';

abstract class AppRouter {
  // GoRouter configuration
  static const String kSplashView = "/";
  static const String kHostView = "/hostView";
  static const String kLoginView = "/loginView";
  static const String kHomeView = "/homeView";
  static const String kBottomNavigationBarView = "/bottomNavigationBarView";
  static const String kScreenView = "/screenView";
  static const String kSubTaskView = "/subTaskView";
  static const String kDetailsRowView = "/detailsRowView";
  static const String kAddView = "/addView";
  static const String kEditView = "/editView";
  static const String kTableReportsView = "/tableReportsView";
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHostView,
        builder: (context, state) => const HostView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kBottomNavigationBarView,
        builder: (context, state) => const BottomNavigationBarView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSubTaskView,
        builder: (context, state) {
          TaskModel taskData = state.extra as TaskModel;
          return SubTaskView(
            taskData: taskData,
          );
        },
      ),
      GoRoute(
        path: kScreenView,
        builder: (context, state) {
          Pages page = state.extra as Pages;
          return ScreenView(
            pageData: page,
          );
        },
      ),
      GoRoute(
        path: kDetailsRowView,
        builder: (context, state) {
          PassDataDetailsRow data = state.extra as PassDataDetailsRow;
          return DetailsRowView(
            pageData: data.pageData,
            rowData: data.rowData,
          );
        },
      ),
      GoRoute(
        path: kAddView,
        builder: (context, state) {
          AddPassDataModel data = state.extra as AddPassDataModel;
          return AddView(
            columnList: data.columnList,
            pageData: data.pageData,
            listKey: data.listKey,
          );
        },
      ),
      GoRoute(
        path: kEditView,
        builder: (context, state) {
          AddPassDataModel data = state.extra as AddPassDataModel;
          return EditView(
            columnList: data.columnList,
            pageData: data.pageData,
            listKey: data.listKey,
          );
        },
      ),
      GoRoute(
        path: kTableReportsView,
        builder: (context, state) {
          ReportModel data = state.extra as ReportModel;
          return TableReportsView(
            reportModel: data,
          );
        },
      ),
    ],
  );
}
