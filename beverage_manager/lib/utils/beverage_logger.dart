import 'dart:ffi';

class BeverageLogger {
  static List<String> logs = []; // Static list to store log messages

  static void log(String message) {
    logs.add(message); // Add the provided message to the logs list
  }

  static void printLogs() {
    for (var log in logs) {
      print(log); // Print each log message to the console
    }
  }
}
