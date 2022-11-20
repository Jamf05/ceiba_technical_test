import 'dart:developer';

import 'package:ceiba_technical_test/core/failures/failure.dart';

class ErrorFailure extends Failure {
  final Error? error;
  @override
  final String? message;
  ErrorFailure._({
    this.error,
    this.message,
  });
  factory ErrorFailure.decode(Error? error,) {
    log(error.toString(), name: 'ERRORFAILURE');
    return ErrorFailure._(
      error: error,
      message: error.toString(),
    );
  }
}