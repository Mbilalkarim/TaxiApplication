class CustomFirebaseAuthException implements Exception {
  final String code;
  final String message;
  final String? phoneNumber;

  CustomFirebaseAuthException({required this.code, required this.message, this.phoneNumber});

  @override
  String toString() {
    return 'CustomFireBAseAuthExceptiom{code: $code, message: $message, phoneNumber: $phoneNumber ';
  }
}

class InvalidVerificationCodeException extends CustomFirebaseAuthException {
  InvalidVerificationCodeException(String message, {String? phoneNumber})
      : super(code: 'invalid-verification-code', message: message, phoneNumber: phoneNumber);
}

class InvalidPlayStoreCodeException extends CustomFirebaseAuthException {
  InvalidPlayStoreCodeException(String message, {String? phoneNumber})
      : super(code: 'CANNOT_BIND_TO_SERVICE', message: message, phoneNumber: phoneNumber);
}

class InvalidPhoneNumber extends CustomFirebaseAuthException {
  InvalidPhoneNumber(String message, {String? phoneNumber})
      : super(code: 'invalid-phone-number', message: message, phoneNumber: phoneNumber);
}

class InvalidVerificationIdException extends CustomFirebaseAuthException {
  InvalidVerificationIdException(String message, {String? phoneNumber})
      : super(code: 'invalid-verification-id', message: message, phoneNumber: phoneNumber);
}

class SessionExpiredException extends CustomFirebaseAuthException {
  SessionExpiredException(String message, {String? phoneNumber})
      : super(code: 'session-expired', message: message, phoneNumber: phoneNumber);
}

class TooManyRequestsException extends CustomFirebaseAuthException {
  TooManyRequestsException(String message, {String? phoneNumber})
      : super(code: 'too-many-requests', message: message, phoneNumber: phoneNumber);
}

class QuotaExceededException extends CustomFirebaseAuthException {
  QuotaExceededException(String message, {String? phoneNumber})
      : super(code: 'quota-exceeded', message: message, phoneNumber: phoneNumber);
}

class CredentialAlreadyInUseException extends CustomFirebaseAuthException {
  CredentialAlreadyInUseException(String message, {String? phoneNumber})
      : super(code: 'credential-already-in-use', message: message, phoneNumber: phoneNumber);
}

class UserDisabledException extends CustomFirebaseAuthException {
  UserDisabledException(String message, {String? phoneNumber})
      : super(code: 'user-disabled', message: message, phoneNumber: phoneNumber);
}

class UserNotFoundException extends CustomFirebaseAuthException {
  UserNotFoundException(String message, {String? phoneNumber})
      : super(code: 'user-not-found', message: message, phoneNumber: phoneNumber);
}

class UserTokenExpiredException extends CustomFirebaseAuthException {
  UserTokenExpiredException(String message, {String? phoneNumber})
      : super(code: 'user-token-expired', message: message, phoneNumber: phoneNumber);
}

// Additional Exceptions

class UnknownFirebaseAuthException extends CustomFirebaseAuthException {
  UnknownFirebaseAuthException(String message, {String? phoneNumber})
      : super(code: 'unknown', message: message, phoneNumber: phoneNumber);
}

class FirebaseAuthNetworkRequestFailedException extends CustomFirebaseAuthException {
  FirebaseAuthNetworkRequestFailedException(String message, {String? phoneNumber})
      : super(code: "network-request-failed", message: message, phoneNumber: phoneNumber);
}

class FirebaseAuthNetworkException extends CustomFirebaseAuthException {
  FirebaseAuthNetworkException(String message, {String? phoneNumber})
      : super(code: 'network-error', message: message, phoneNumber: phoneNumber);
}

class FirebaseAuthInternalException extends CustomFirebaseAuthException {
  FirebaseAuthInternalException(String message, {String? phoneNumber})
      : super(code: 'internal-error', message: message, phoneNumber: phoneNumber);
}

class CodeAutoRetrievalTimeoutException extends CustomFirebaseAuthException {
  CodeAutoRetrievalTimeoutException(String message, {String? phoneNumber})
      : super(code: 'code-auto-retrieval-timeout', message: message, phoneNumber: phoneNumber);
}

class CodeExpiredException extends CustomFirebaseAuthException {
  CodeExpiredException(String message, {String? phoneNumber})
      : super(code: 'code-expired', message: message, phoneNumber: phoneNumber);
}

class CodeLengthException extends CustomFirebaseAuthException {
  CodeLengthException(String message, {String? phoneNumber})
      : super(code: 'code-length-exception', message: message, phoneNumber: phoneNumber);
}

class CodeMismatchException extends CustomFirebaseAuthException {
  CodeMismatchException(String message, {String? phoneNumber})
      : super(code: 'code-mismatch', message: message, phoneNumber: phoneNumber);
}
