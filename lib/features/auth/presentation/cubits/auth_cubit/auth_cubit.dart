import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';
import 'package:safe_scan/features/auth/domain/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with ChangeNotifier {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(AuthInitial());

  @override
  void emit(AuthState state) {
    super.emit(state);
    notifyListeners();
  }

  String _formatError(Object e) {
    final msg = e.toString();
    return msg.startsWith('Exception: ')
        ? msg.replaceFirst('Exception: ', '')
        : msg;
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      print("cubit-loading");
      final AppUserModel? user = await _authRepo.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(Authenticated(user: user));
      print("cubit-authenticated");
    } catch (e) {
      print("cubit-error");
      emit(AuthFailure(_formatError(e)));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(AuthInitial());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUserModel? user = await _authRepo.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthFailure(_formatError(e)));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _authRepo.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    final user = await _authRepo.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }
}
