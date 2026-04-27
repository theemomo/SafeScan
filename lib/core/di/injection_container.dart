import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:safe_scan/features/auth/data/firebase_auth_repo.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/reports/data/shared_pref_reports_db.dart';
import 'package:safe_scan/features/reports/data/sqflite_reports_db.dart';
import 'package:safe_scan/features/reports/presentation/cubits/saved_reports_cubit.dart';
import 'package:safe_scan/features/scan/data/virustotal_repo.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_domain_cubit/scan_domain_cubit.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_file_cubit/scan_file_cubit.dart';
import 'package:safe_scan/features/scan/domain/repos/api_repo.dart';
import 'package:dio/dio.dart';
import 'package:safe_scan/features/settings/data/locale_repository.dart';
import 'package:safe_scan/features/settings/presentation/cubits/locale_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // External
  getIt.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  ); // to call it use sl<FirebaseAuth>()
  getIt.registerLazySingleton<Dio>(() => Dio()); // to call it use sl<Dio>()

  // Repositories
  getIt.registerLazySingleton<FirebaseAuthRepo>(
    () => FirebaseAuthRepo(getIt<FirebaseAuth>()),
  ); // to call it use sl<FirebaseAuthRepo>()

  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<AuthCubit>()),
  ); // to call it use sl<AppRouter>()

  getIt.registerLazySingleton<ApiRepo>(
    () => VirustotalRepo(dio: getIt<Dio>()),
  ); // to call it use sl<ApiRepo>()

  // Cubits
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<FirebaseAuthRepo>()),
  ); // to call it use sl<AuthCubit>()
  getIt.registerFactory<ScanFileCubit>(
    () => ScanFileCubit(getIt<ApiRepo>()),
  ); // to call it use sl<ScanFileCubit>()
  getIt.registerFactory<ScanDomainCubit>(
    () => ScanDomainCubit(getIt<ApiRepo>()),
  ); // to call it use sl<ScanDomainCubit>()

  // =====================================================================
  // Local Database
  // =====================================================================
  // Reports (SQLite) use this or the shared preferences below
  // getIt.registerLazySingleton<SqfliteReportsDB>(
  //   () => SqfliteReportsDB(),
  // );
  // getIt.registerFactory<SavedReportsCubit>(
  //   () => SavedReportsCubit(getIt<SqfliteReportsDB>()),
  // );

  // Reports (Shared Preferences) use this or the sqflite above
  getIt.registerLazySingleton<SharedPreferencesReportsDB>(
    () => SharedPreferencesReportsDB(),
  );
  getIt.registerFactory<SavedReportsCubit>(
    () => SavedReportsCubit(getIt<SharedPreferencesReportsDB>()),
  );

  // =====================================================================
  // Locale / Settings
  // =====================================================================
  getIt.registerLazySingleton<LocaleRepository>(() => LocaleRepository());
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<LocaleRepository>()),
  );
}
