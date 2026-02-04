import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safe_scan/core/route/app_router.dart';
import 'package:safe_scan/features/auth/data/firebase_auth_repo.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/scan/data/virustotal_repo.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_domain_cubit/scan_domain_cubit.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_file_cubit/scan_file_cubit.dart';
import 'package:safe_scan/features/scan/domain/repos/api_repo.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance); // to call it use sl<FirebaseAuth>()
  sl.registerLazySingleton<Dio>(() => Dio()); // to call it use sl<Dio>()

  // Repositories
  sl.registerLazySingleton<FirebaseAuthRepo>(
    () => FirebaseAuthRepo(sl<FirebaseAuth>()),
  ); // to call it use sl<FirebaseAuthRepo>()

  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>())); // to call it use sl<AppRouter>()

  sl.registerLazySingleton<ApiRepo>(() => VirustotalRepo(dio: sl<Dio>())); // to call it use sl<ApiRepo>()

  // Cubits
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl<FirebaseAuthRepo>())); // to call it use sl<AuthCubit>()
  sl.registerFactory<ScanFileCubit>(() => ScanFileCubit(sl<ApiRepo>())); // to call it use sl<ScanFileCubit>()
  sl.registerFactory<ScanDomainCubit>(() => ScanDomainCubit(sl<ApiRepo>())); // to call it use sl<ScanDomainCubit>()
}
