import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';

abstract class AuthRepo {
  Future<AppUserModel?> getCurrentUser();
  Future<AppUserModel?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<AppUserModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<void> logout();
}
