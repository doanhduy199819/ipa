import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebaseAuthException implements Exception {
  CustomFirebaseAuthException(this.code);
  final String code;

  static const String DUPLICATE_DISPLAY_NAME = 'duplicate-display-name';
  static const String EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const String INVALID_EMAIL = 'invalid-email';
  static const String OPERATION_NOT_ALLOWED = 'operation-not-allowed';
  static const String WEAK_PASSWORD = 'weak-password';
}
