import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/firebase_options.dart';
import 'package:safe_scan/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(
    BlocProvider(
      // create: (context) => AuthCubit(FirebaseAuthRepo(FirebaseAuth.instance))..checkAuthStatus(),
      create: (context) => di.sl<AuthCubit>()..checkAuthStatus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: di.sl<AppRouter>().router,
          debugShowCheckedModeBanner: false,
          title: 'SafeScan',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFAFAFA),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
        );
      },
    );
  }
}
