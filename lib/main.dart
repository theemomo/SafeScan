import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_scan/features/auth/data/firebase_auth_repo.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuthRepo(FirebaseAuth.instance))..checkAuthStatus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final appRouter = AppRouter(authCubit);

    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'SafeScan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
      ),
    );
  }
}
