import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';

abstract class AuthRepo{
  Future<AppUserModel?> getCurrentUser();
  Future<AppUserModel?> loginWithEmailAndPassword(String email, String password);
  Future<AppUserModel?> registerWithEmailAndPassword(String email, String password, String name);
  Future<void> logout();
}