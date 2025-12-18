import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/auth/presentation/screens/login_screen.dart';
import 'package:safe_scan/features/auth/presentation/screens/register_screen.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';
import 'package:safe_scan/features/scan/presentation/screens/domain_report_screen.dart';
import 'package:safe_scan/features/scan/presentation/screens/file_report_screen.dart';
import 'package:safe_scan/features/scan/presentation/screens/home_screen.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    onException: (context, state, router) => GoRoute(
      path: "/error",
      builder: (context, state) {
        return const Scaffold(body: Center(child: Text('Page not found')));
      },
    ),
    refreshListenable: authCubit,
    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = authCubit.state is Authenticated;
      final bool isLoggingIn = state.matchedLocation == '/login';
      final bool isRegistering = state.matchedLocation == '/register';

      // Unauthenticated user trying to access a protected route
      if (!isAuthenticated && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      // Authenticated user trying to access login or register page
      if (isAuthenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            name: RouteNames.domainReport,
            path: "domain-report",
            builder: (context, state) {
              return DomainReportScreen(
                reportData: state.extra as DomainResponseModel,
              );
            },
          ),
          GoRoute(
            name: RouteNames.fileReport,
            path: "file-report",
            builder: (context, state) {
              return FileReportScreen(
                reportData: state.extra as FileResponseModel,
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.login,
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: RouteNames.register,
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
    ],
  );
}
