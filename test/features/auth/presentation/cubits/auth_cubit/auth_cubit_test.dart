import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';
import 'package:safe_scan/features/auth/domain/repos/auth_repo.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateMocks([AuthRepo]) // or can use firebaseAuthRepo if preferred
void main() {
  late AuthCubit authCubit;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    authCubit = AuthCubit(mockAuthRepo);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tName = 'Test User';
  const tUid = '123';
  final tAppUserModel = const AppUserModel(
    uid: tUid,
    email: tEmail,
    name: tName,
  );
  final tException = Exception('Something went wrong');

  // This is a standard sanity check. We use a regular test() function to assert that when the AuthCubit is first created, its state is AuthInitial, just as we defined in its constructor.
  test('initial state is AuthInitial', () {
    expect(authCubit.state, isA<AuthInitial>());
  });

  group('login', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, Authenticated] when login is successful', // description for the test case
      // Arrange
      build: () {
        when(
          mockAuthRepo.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tAppUserModel);
        return authCubit;
      },

      // Act
      act: (cubit) => cubit.login(tEmail, tPassword),

      // Assert
      expect: () => <AuthState>[
        AuthLoading(),
        Authenticated(user: tAppUserModel),
      ],
      verify: (_) {
        verify(
          mockAuthRepo.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        );
        verifyNoMoreInteractions(mockAuthRepo);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailure, AuthInitial] when login fails',
      build: () {
        when(
          mockAuthRepo.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(tException);
        return authCubit;
      },
      act: (cubit) => cubit.login(tEmail, tPassword),
      expect: () => <AuthState>[
        AuthLoading(),
        AuthFailure(tException.toString().replaceFirst('Exception: ', '')),
        AuthInitial(),
      ],
    );
  });

  group('register', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, Authenticated] when registration is successful',
      build: () {
        when(
          mockAuthRepo.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tAppUserModel);
        return authCubit;
      },
      act: (cubit) => cubit.register(tName, tEmail, tPassword),
      expect: () => <AuthState>[
        AuthLoading(),
        Authenticated(user: tAppUserModel),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailure, AuthInitial] when registration fails',
      build: () {
        when(
          mockAuthRepo.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(tException);
        return authCubit;
      },
      act: (cubit) => cubit.register(tName, tEmail, tPassword),
      expect: () => <AuthState>[
        AuthLoading(),
        AuthFailure(tException.toString().replaceFirst('Exception: ', '')),
        AuthInitial(),
      ],
    );
  });

  group('logout', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, Unauthenticated] when logout is successful',
      build: () {
        when(mockAuthRepo.logout()).thenAnswer((_) async {}); // void return
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => <AuthState>[AuthLoading(), Unauthenticated()],
      verify: (_) {
        verify(mockAuthRepo.logout());
        verifyNoMoreInteractions(mockAuthRepo);
      },
    );
  });

  group('checkAuthStatus', () {
    blocTest<AuthCubit, AuthState>(
      'emits [Authenticated] when user is found',
      build: () {
        when(
          mockAuthRepo.getCurrentUser(),
        ).thenAnswer((_) async => tAppUserModel);
        return authCubit;
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => <AuthState>[Authenticated(user: tAppUserModel)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Unauthenticated] when user is not found',
      build: () {
        when(mockAuthRepo.getCurrentUser()).thenAnswer((_) async => null);
        return authCubit;
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => <AuthState>[Unauthenticated()],
    );
  });
}
