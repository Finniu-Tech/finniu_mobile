// helpers/debug_logger.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DebugLogger {
  static const String _fileName = 'notification_logs.txt';

  static Future<void> log(String message) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_fileName');
      final timestamp = DateTime.now().toIso8601String();
      final logMessage = '$timestamp: $message\n';

      await file.writeAsString(
        logMessage,
        mode: FileMode.append,
      );
    } catch (e) {
      print('Error writing to log file: $e');
    }
  }

  static Future<String> getLogs() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_fileName');
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      print('Error reading logs: $e');
    }
    return 'No logs available';
  }

  static Future<void> clearLogs() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_fileName');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error clearing logs: $e');
    }
  }
}
