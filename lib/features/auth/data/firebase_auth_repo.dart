import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';
import 'package:safe_scan/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo extends AuthRepo {
  final FirebaseAuth auth;

  FirebaseAuthRepo(this.auth);

  // Mappers
  AppUserModel _mapUser(User user) {
    return AppUserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }

  // Get current user
  @override
  Future<AppUserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;
    return _mapUser(user);
  }

  // Logout
  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  // Login
  @override
  Future<AppUserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      return _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // Register
  @override
  Future<AppUserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      await user.updateDisplayName(name);

      return _mapUser(user);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // Centralized Firebase error mapper
  Exception _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found for this email.');
      case 'wrong-password':
        return Exception('Incorrect password.');
      case 'email-already-in-use':
        return Exception('This email is already registered.');
      case 'invalid-email':
        return Exception('Invalid email format.');
      case 'weak-password':
        return Exception('Password is too weak.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are disabled.');
      default:
        return Exception(e.message ?? 'Authentication failed.');
    }
  }
}
