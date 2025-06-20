import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void i(dynamic message) => _logger.i(message);
  static void d(dynamic message) => _logger.d(message);
  static void w(dynamic message) => _logger.w(message);
  static void e(dynamic message) => _logger.e(message);
}
