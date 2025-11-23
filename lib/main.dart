import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:safe_scan/core/route/app_routes.dart';
  

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SafeScan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.loginRoute,
      ),
    );
  }
}
