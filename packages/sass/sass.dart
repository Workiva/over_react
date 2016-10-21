library sass;

import 'dart:async';
import 'dart:io';
import 'package:utf/utf.dart';
import 'package:path/path.dart' as path;

/// Facade for Sass-transformations.
class Sass {

  String executable = defaultExecutable;
  bool scss = false;
  String style = null; // nested, compact, compressed, expanded
  List<String> loadPath = [];
  bool lineNumbers = false;
  bool compass = false;

  static get defaultExecutable => (Platform.operatingSystem == "windows" ? "sass.bat" : "sass") ;

  /// Transforms given Sass-source to CSS.
  Future<String> transform(String content) {
    var flags = _createFlags();

    return Process.start(executable, flags).then((Process process) {
      StringBuffer errors = new StringBuffer();
      StringBuffer output = new StringBuffer();

      process.stdin.write(content);

      // These writeln -calls are needed or the transformer will produce empty output on Windows.
      // See https://bitbucket.org/evidentsolutions/dart-sass/issue/19/sass-transformer-produces-zero-length
      process.stdin.writeln();
      process.stdin.writeln();

      process.stdin.close();
      process.stdout.transform(new Utf8DecoderTransformer()).listen((str) => output.write(str));
      process.stderr.transform(new Utf8DecoderTransformer()).listen((str) => errors.write(str));

      return process.exitCode.then((exitCode) {
        if (exitCode == 0) {
          return output.toString();
        } else {
          throw new SassException(errors.length != 0 ? errors.toString() : output.toString());
        }
      });
    }).catchError((ProcessException e) {
      throw new SassException(e.toString());
    }, test: (e) => e is ProcessException);
  }

  List<String> _createFlags() {
    bool sassc = executable.endsWith('sassc');
    var flags = [];

    if (sassc) {
      // check that we don't try to use features not supported by sassc
      if (!scss)
        throw new SassException("SassC supports only scss syntax");

      if (compass)
        throw new SassException("SassC does not support Compass");

    } else {
      // classic sass
      flags.add('--no-cache');

      if (scss)
        flags.add('--scss');

      if (compass)
        flags.add('--compass');
    }

    // we have to use the short argument names here since SassC does not support the long ones
    if (lineNumbers)
      flags.add('-l');

    if (style != null)
      flags..add('-t')..add(style);

    loadPath.forEach((dir) {
      // Normalize the load paths to platform's native format
      var normalized = path.joinAll(path.posix.split(dir));
      flags..add('-I')..add(normalized);
    });

    return flags;
  }
}

/// Exception thrown when there's a problem transforming Sass.
class SassException implements Exception {

  final String message;

  SassException(this.message);

  String toString() => message;
}
