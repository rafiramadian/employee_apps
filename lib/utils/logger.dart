import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'dart:developer' as developer;

void initializeLogger() {
  // only enable logging for debug mode
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    if (!kDebugMode) {
      return;
    }

    // coloring log
    var start = '\x1b[90m';
    switch (record.level.name) {
      case 'INFO':
        start = '\x1b[37m';
        break;
      case 'WARNING':
        start = '\x1b[93m';
        break;
      case 'SEVERE':
        start = '\x1b[31m';
        break;
      case 'SHOUT':
        start = '\x1b[32m';
        break;
      case 'CONFIG':
        start = '\x1b[94m';
        break;
    }

    String time = DateFormat('dd-MM-yyyy HH:m:s').format(record.time);
    String message = '$time: $start${record.level.name}: ${record.message}';

    developer.log(
      message,
      name: record.loggerName,
      level: record.level.value,
      time: record.time,
    );
  });
}
