import 'package:deen_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppValidators Tests', () {
    test('required validator', () {
      expect(AppValidators.required(null), equals('Field is required'));
      expect(AppValidators.required(''), equals('Field is required'));
      expect(AppValidators.required('   '), equals('Field is required'));
      expect(AppValidators.required('Hello'), isNull);
    });

    test('email validator', () {
      expect(AppValidators.email(null), equals('Email address is required'));
      expect(AppValidators.email(''), equals('Email address is required'));
      expect(
        AppValidators.email('not-an-email'),
        equals('Please enter a valid email address'),
      );
      expect(AppValidators.email('user@example.com'), isNull);
    });

    test('password validator', () {
      expect(AppValidators.password(null), equals('Password is required'));
      expect(
        AppValidators.password('123'),
        equals('Password must be at least 6 characters'),
      );
      expect(AppValidators.password('123456'), isNull);
    });

    test('registrationPassword validator', () {
      expect(
        AppValidators.registrationPassword(null),
        equals('Password is required'),
      );
      expect(
        AppValidators.registrationPassword('123456'),
        equals('Password must be at least 8 characters'),
      );
      expect(
        AppValidators.registrationPassword('12345678'),
        equals('Password cannot be entirely numeric'),
      );
      expect(AppValidators.registrationPassword('Str0ngPass!'), isNull);
    });

    test('confirmPassword validator', () {
      expect(
        AppValidators.confirmPassword('123', '456'),
        equals('Passwords do not match'),
      );
      expect(AppValidators.confirmPassword('secret', 'secret'), isNull);
    });

    test('compose combines multiple validators', () {
      final combined = AppValidators.compose([
        (val) => AppValidators.required(val, 'Email'),
        AppValidators.email,
      ]);

      expect(combined(''), equals('Email is required'));
      expect(combined('invalid'), equals('Please enter a valid email address'));
      expect(combined('test@deen.com'), isNull);
    });
  });
}
