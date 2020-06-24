import 'dart:io';

import 'package:io/ansi.dart' as ansi;
import 'package:logging/logging.dart';

void initLogging({bool verbose = true}) {
  Logger.root.level = verbose ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((rec) {
    String Function(String) colorizer;
    IOSink output;

    if (rec.level >= Level.SEVERE) {
      colorizer = ansi.red.wrap;
      output = stderr;
    } else if (rec.level >= Level.WARNING) {
      colorizer = ansi.yellow.wrap;
      output = stderr;
    } else {
      colorizer = (string) => string;
      output = stdout;
    }

    if (rec.message != '') {
      output.writeln(colorizer(rec.message));
    }
    if (rec.error != null) {
      output.writeln(colorizer(rec.error.toString()));
    }
    if (verbose && rec.stackTrace != null) {
      output.writeln(colorizer(rec.stackTrace.toString()));
    }
  });
}
