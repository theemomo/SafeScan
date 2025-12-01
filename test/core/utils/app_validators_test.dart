import 'package:flutter_test/flutter_test.dart';
import 'package:safe_scan/core/utils/app_validators.dart';

void main() {
  group('AppValidators', () {
    group('validateEmail', () {
      test('returns error when email is null', () {
        expect(AppValidators.validateEmail(null), 'Please enter your email');
      });

      test('returns error when email is empty', () {
        expect(AppValidators.validateEmail(''), 'Please enter your email');
      });

      test('returns error for invalid email format', () {
        expect(AppValidators.validateEmail('invalid-email'), 'Please enter a valid email');
      });

      test('returns null for valid email', () {
        expect(AppValidators.validateEmail('test@example.com'), null);
      });
    });

    group('validateLoginPassword', () {
      test('returns error when password is null', () {
        expect(AppValidators.validateLoginPassword(null), 'Please enter your password');
      });

      test('returns error when password is empty', () {
        expect(AppValidators.validateLoginPassword(''), 'Please enter your password');
      });

      test('returns error for password less than 6 characters', () {
        expect(AppValidators.validateLoginPassword('12345'), 'Password must be at least 6 characters long');
      });

      test('returns null for valid password', () {
        expect(AppValidators.validateLoginPassword('123456'), null);
      });
    });

    group('validateUsername', () {
      test('returns error when username is null', () {
        expect(AppValidators.validateUsername(null), 'Please enter your username');
      });

      test('returns error when username is empty', () {
        expect(AppValidators.validateUsername(''), 'Please enter your username');
      });

      test('returns null for valid username', () {
        expect(AppValidators.validateUsername('testuser'), null);
      });
    });

    group('validateRegisterPassword', () {
      test('returns error when password is null', () {
        expect(AppValidators.validateRegisterPassword(null), 'Please enter a password.');
      });

      test('returns error when password is empty', () {
        expect(AppValidators.validateRegisterPassword(''), 'Please enter a password.');
      });

      test('returns error for password less than 8 characters', () {
        expect(AppValidators.validateRegisterPassword('1234567'), 'Password must be at least 8 characters long.');
      });

      test('returns error for password without uppercase letter', () {
        expect(AppValidators.validateRegisterPassword('password123!'), 'Password must contain at least one uppercase letter.');
      });

      test('returns error for password without lowercase letter', () {
        expect(AppValidators.validateRegisterPassword('PASSWORD123!'), 'Password must contain at least one lowercase letter.');
      });

      test('returns error for password without digit', () {
        expect(AppValidators.validateRegisterPassword('Password!'), 'Password must include at least one number.');
      });

      test('returns error for password without special character', () {
        expect(AppValidators.validateRegisterPassword('Password123'), 'Password must include at least one special character (! @ # \$ & * ~).');
      });

      test('returns null for valid password', () {
        expect(AppValidators.validateRegisterPassword('Password123!'), null);
      });
    });
  });
}
