import 'dart:collection';
import 'dart:convert';

import 'package:collection/collection.dart';

/// Normalizes compiled dart2js code so it can be diffed cleanly against other
/// compiled dart2js code.
///
/// Useful for isolating changes introduced by a program
///
/// This logic is a bit brittle, but the goal is to improve readability/diffing,
/// and works well enough without having to pull in a JS formatter or something.
String normalizeDart2jsContents(String contents) => contents
    // Replace numbers and identifiers that change when compiling additional code
    .replaceAll(RegExp(r'\b\d+\b'), '###') // number literals
    .replaceAll(RegExp(r'\b_static(_\d+)?\b'), 'static###')
    .replaceAll(RegExp(r'\bt\d+\b'), 't#') // local variables (e.g., `t1`)
    .replaceAllMapped(RegExp(r'\b(B\.\w+_)[0-9a-zA-Z]+\b'), (match) {
      return match.group(1)! + '####'; // compile-time constant declarations
    })
    // Remove newlines in empty function bodies
    .replaceAllMapped(
        RegExp(r'(function [\w$]+\(\) {)\s+}'), (match) => '${match[1]}}')
    // Break up long type inheritance lists onto separate lines
    .replaceAllMapped(RegExp(r'(_inheritMany\()([^\n]+)(\]\);)'), (match) {
      return '${match[1]}${match[2]!.replaceAll(', ', ',\n      ')},\n    ${match[3]}';
    })
    // Break up long type metadata list onto separate lines, and sort
    .replaceAllMapped(RegExp(r'types: (\["[^\n]+~[^\n]+"\]),'), (match) {
      try {
        final parsed = jsonDecode(match.group(1)!) as List;
        return 'types: ${JsonEncoder.withIndent('  ').convert(deepSorted(parsed))},';
      } catch (_) {}
      return match.group(0)!;
    })
    // Try to format inlined JSON strings that contain type metadata
    .replaceAllMapped(RegExp(r"JSON\.parse\('(\{[^\n]+\})'\)"), (match) {
      final stringContents = match.group(1)!;
      String formatted;
      try {
        formatted = const JsonEncoder.withIndent(' ')
            .convert(deepSorted(jsonDecode(stringContents)));
      } catch (_) {
        formatted = stringContents.replaceAll(',"', ',\n"');
      }
      return "#JSON_PARSE#'$formatted#/JSON_PARSE#";
    });

/// Returns a deep copy of [original], with all nested Lists and Maps sorted.
Object? deepSorted(Object? original) {
  if (original is List) return original.map(deepSorted).toList()..sort();
  if (original is Map) {
    return LinkedHashMap.fromEntries(original.entries
        .sortedBy((entry) => entry.key.toString())
        .map((e) => MapEntry(e.key, deepSorted(e.value))));
  }
  return original;
}
