import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:safe_scan/firebase_options.dart';
import 'package:safe_scan/core/di/injection_container.dart' as di;
import 'package:safe_scan/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  try {
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      Gemini.init(apiKey: apiKey);
    }
  } catch (e) {
    debugPrint('Error loading .env or initializing Gemini: $e');
  }

  // Load persisted locale before the first frame
  await di.sl<LocaleCubit>().loadLocale();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..checkAuthStatus(),
        ),
        BlocProvider(
          create: (context) => di.sl<LocaleCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              routerConfig: di.sl<AppRouter>().router,
              debugShowCheckedModeBanner: false,
              title: 'SafeScan',
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFFFAFAFA),
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
