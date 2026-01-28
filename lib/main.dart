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
// import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // DevicePreview(
    //   enabled: true, // disable in production
    //   builder: (context) => 
      BlocProvider(
        create: (context) =>
            AuthCubit(FirebaseAuthRepo(FirebaseAuth.instance))
              ..checkAuthStatus(),
        child: const MyApp(),
      ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final appRouter = AppRouter(authCubit);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          routerConfig: appRouter.router,
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
