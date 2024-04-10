import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// this will show formatted debug statement s
void debug(
  dynamic message, [
  dynamic error,
  StackTrace? stackTrace,
]) {
  try {
    Logger logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(
      message,
      error: [
        error,
        stackTrace,
      ],
    );
  } catch (e) {
    debugPrintStack(label: 'Error `$e`');
  }
}

void debugError(
  dynamic message, [
  dynamic error,
  StackTrace? stackTrace,
]) {
  try {
    Logger().e(message);
  } catch (e) {
    debugPrintStack(stackTrace: stackTrace);
  }
}
