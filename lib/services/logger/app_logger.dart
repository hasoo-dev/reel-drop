import 'package:logger/logger.dart';

/// Centralised logger for the entire app.
/// Usage:  AppLogger.i('message');   AppLogger.e('error', error: e, stackTrace: st);
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.trace,
  );

  // Convenience wrappers -------------------------------------------------

  static void t(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.t(msg, error: error, stackTrace: stackTrace);

  static void d(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.d(msg, error: error, stackTrace: stackTrace);

  static void i(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.i(msg, error: error, stackTrace: stackTrace);

  static void w(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(msg, error: error, stackTrace: stackTrace);

  static void e(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(msg, error: error, stackTrace: stackTrace);

  static void wtf(dynamic msg, {Object? error, StackTrace? stackTrace}) =>
      _logger.f(msg, error: error, stackTrace: stackTrace);
}