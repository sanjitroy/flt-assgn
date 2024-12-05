import 'dart:async';

abstract class Failure {
  final String message;
  final String displayMessage;
  final int code;
  final StackTrace? stackTrace;

  Failure({
    required this.message,
    required this.displayMessage,
    required this.code,
    this.stackTrace,
  });

  Future<void> retry({
    Future<void> Function()? action,
    int maxAttempts = 3,
  }) async {
    if (action != null) {
      int attempt = 0;
      while (attempt < maxAttempts) {
        try {
          await action();
          return;
        } catch (e) {
          attempt++;
          if (attempt >= maxAttempts) {
            throw this;
          }
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    } else {
      throw ArgumentError('action cannot be null');
    }
  }

  @override
  String toString() {
    return 'Failure(code: $code, message: $message, displayMessage: $displayMessage)';
  }
}
