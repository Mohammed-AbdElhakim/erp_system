import 'package:erp_system/features/auth/presentation/views/login_view.dart';
import 'package:erp_system/features/home/presentation/views/home_view.dart';
import 'package:erp_system/features/host/presentation/views/host_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  // GoRouter configuration
  static const String kSplashView = "/";
  static const String kHostView = "/hostView";
  static const String kLoginView = "/loginView";
  static const String kHomeView = "/homeView";
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
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
