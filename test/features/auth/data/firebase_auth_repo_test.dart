import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:safe_scan/features/auth/data/firebase_auth_repo.dart';
import 'package:safe_scan/features/auth/domain/entities/app_user_model.dart';

import 'firebase_auth_repo_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential])
// Have to run the command to generate mocks: flutter pub run build_runner build
// so you can use the generated mock classes, such as MockFirebaseAuth, MockUser, and MockUserCredential.
// in other words "Please create fake, controllable versions of the FirebaseAuth, User, and UserCredential classes and put them in the firebase_auth_repo_test.mocks.dart file."
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late FirebaseAuthRepo authRepo;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  // setUp: Runs before each test
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authRepo = FirebaseAuthRepo(
      mockFirebaseAuth,
    ); // Takes the mockFirebaseAuth as a dependency (fake version of FirebaseAuth)
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
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

  group('FirebaseAuthRepo', () {
    group('getCurrentUser', () {
      test('should return AppUserModel when firebase user is not null', () async {
        // Arrange
        when(mockUser.uid).thenReturn(tUid);
        when(mockUser.email).thenReturn(tEmail);
        when(mockUser.displayName).thenReturn(tName);
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final result = await authRepo.getCurrentUser();

        // Assert
        expect(result, tAppUserModel);
        // Check that the returned user matches our expected model using more detailed checks
        expect(
          result,
          isA<AppUserModel>()
              .having((user) => user.uid, "user id", tUid)
              .having((user) => user.email, "email", tEmail)
              .having((user) => user.name, "name", tName),
        );
        verify(mockFirebaseAuth.currentUser);
        verifyNoMoreInteractions(mockFirebaseAuth);
      });

      test('should return null when firebase user is null', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final result = await authRepo.getCurrentUser();

        // Assert
        expect(result, isNull);
        verify(mockFirebaseAuth.currentUser);
        verifyNoMoreInteractions(mockFirebaseAuth);
      });
    });

    group('logout', () {
      test('should call signOut on FirebaseAuth', () async {
        // Arrange
        // when(mockFirebaseAuth.signOut()).thenAnswer((_) async => {}); // Not strictly necessary since signOut returns Future<void>

        // Act
        await authRepo.logout();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
        verifyNoMoreInteractions(mockFirebaseAuth);
      });
    });

    group('loginWithEmailAndPassword', () {
      test('should return AppUserModel on successful login', () async {
        // Arrange
        when(mockUser.uid).thenReturn(tUid);
        when(mockUser.email).thenReturn(tEmail);
        when(mockUser.displayName).thenReturn(tName);
        when(mockUserCredential.user).thenReturn(mockUser);

        // Essentially, we are faking the API call and telling our test exactly what the result should be.
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        // Act: We execute the one piece of code we are actually trying to test.
        final result = await authRepo.loginWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );

        // Assert: we verify that the result is what we expect.
        // Check that the returned user matches our expected model
        expect(result, tAppUserModel);

        // Check that the returned user matches our expected model using more detailed checks
        expect(
          result,
          isA<AppUserModel>()
              .having((user) => user.uid, 'uid', tUid)
              .having((user) => user.email, "email", tEmail)
              .having((user) => user.name, "name", tName),
        );
        verify(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        );
      });

      test('should throw an exception on FirebaseAuthException', () async {
        // Arrange
        final exception = FirebaseAuthException(code: 'user-not-found');
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => authRepo.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('registerWithEmailAndPassword', () {
      test('should return AppUserModel on successful registration', () async {
        // Arrange
        when(mockUser.uid).thenReturn(tUid);
        when(mockUser.email).thenReturn(tEmail);
        when(mockUser.displayName).thenReturn(tName);
        when(mockUser.updateDisplayName(any)).thenAnswer((_) async => {});
        when(mockUserCredential.user).thenReturn(mockUser);
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        // Act
        final result = await authRepo.registerWithEmailAndPassword(
          name: tName,
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(result, tAppUserModel);
        expect(result.uid, tUid);
        expect(result.email, tEmail);
        // Check that the returned user matches our expected model using more detailed checks
        expect(
          result,
          isA<AppUserModel>()
              .having((user) => user.uid, 'uid', tUid)
              .having((user) => user.email, "email", tEmail)
              .having((user) => user.name, "name", tName),
        );
        // Note: The name is updated async, and might not be reflected immediately in the returned model
        // depending on implementation. The key is to verify the updateDisplayName call.
        verify(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        );
        verify(mockUser.updateDisplayName(tName));
      });

      test('should throw an exception on FirebaseAuthException', () async {
        // Arrange
        final exception = FirebaseAuthException(code: 'email-already-in-use');
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => authRepo.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
