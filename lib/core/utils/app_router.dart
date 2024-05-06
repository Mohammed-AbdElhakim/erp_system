import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/bottomNavigationBar/presentation/views/bottom_navigatiaon_bar_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/host/presentation/views/host_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
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
        path: kScreenView,
        builder: (context, state) {
          Pages page = state.extra as Pages;
          return ScreenView(
            pageData: page,
          );
        },
      ),
    ],
  );
}
