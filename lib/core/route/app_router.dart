import 'package:flutter/material.dart';
import 'package:safe_scan/core/route/app_routes.dart';
import 'package:safe_scan/features/auth/presentation/pages/login_screen.dart';
import 'package:safe_scan/features/auth/presentation/pages/register_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text('Page not found'))),
      );
  }
}
