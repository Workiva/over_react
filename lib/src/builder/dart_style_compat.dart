import 'dart:mirrors';

import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:pub_semver/pub_semver.dart' show Version;

/// Uses `dart:mirrors` to construct a [DartFormatter] instance, since we can't
/// statically author code that works in both Dart 2 and dart_style 3.0.0.
///
/// Returns null if, for some reason, we can't construct a formatter.
///
// TODO remove this code once this package supports only Dart 3 and dart_style >=2.3.7
DartFormatter? constructFormatter({required Version languageVersion}) {
  // In dart_style 3.0.0, the languageVersion parameter is required.
  // However, that parameter wasn't added until dart_style 2.3.7,
  // which doesn't support Dart 2.

  try {
    // Works with dart_style >=2.3.7 <4.0.0 (Dart 3 only)
    return _dartFormatterMirror.newInstance(
      Symbol.empty,
      [],
      {#languageVersion: languageVersion},
    ).reflectee as DartFormatter;
  } catch (_) {}

  // Works with dart_style >=2.0.0 <3.0.0 (Dart 2, Dart 3)
  return _dartFormatterMirror.newInstance(
    Symbol.empty,
    [],
  ).reflectee as DartFormatter;
}

late final _dartFormatterMirror = reflectClass(DartFormatter);
