import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/style_value_diagnostic.dart';

import 'hooks_exhaustive_deps_cases.dart';

void main() {
  // Hack: make a mutable copy of these
  final testCases = (jsonDecode(jsonEncode({
    'tests': tests,
    'testsFlow': testsFlow,
    'testsTypescript': testsTypescript,
    'testsTypescriptEslintParserV4': testsTypescriptEslintParserV4,
  })) as Map)
      .cast<String, Map>();

  testCases.values.expand((element) => element.values.cast<List<dynamic>>()).flatten().cast<Map>().forEach((e) {
    e['code'] = portJsToDart(e['code'] as String);
    final output = e['output'] as String?;
    if (output != null) {
      e['output'] = portJsToDart(output);
    }
    (e['errors'] as List<dynamic>?)
        ?.whereType<Map>()
        .expand<dynamic>((error) => error['suggestions'] as List<dynamic>? ?? <dynamic>[])
        .forEach((dynamic suggestion) {
      if (suggestion is! Map) {
        throw Exception('Not a map: $suggestion');
      }
      suggestion['output'] = portJsToDart(suggestion['output'] as String);
    });
  });

  final output = StringBuffer()
    ..writeln(
        '// ignore_for_file: implicit_dynamic_map_literal, implicit_dynamic_list_literal, prefer_adjacent_string_concatenation');

  testCases
      .mapKeyValue((name, cases) => convertToDartConstantSource(testCases, variableName: name).toString())
      .forEach(output.write);

  File('test/integration/diagnostics/test_cases_output.dart').writeAsStringSync(output.toString());
  File('test/integration/diagnostics/test_cases_output.dart')
      .writeAsStringSync(DartFormatter().format(output.toString()));
}

// extension<E> on Iterable<E> {
//   Iterable<T> betterErrorCast<T>() => map((e) {
//         if (e is! T) throw ArgumentError('Not a T: $e');
//         return e;
//       }).cast<T>();
// }

extension<T> on Iterable<Iterable<T>> {
  Iterable<T> flatten() => expand((element) => element);
}

extension<K, V> on Map<K, V> {
  Iterable<T> mapKeyValue<T>(T Function(K, V) mapper) => entries.map((entry) => mapper(entry.key, entry.value));
}

/// Does an incomplete port of JS syntax to the Dart equivalent,
/// to help assist in porting JS test cases to dart.
String portJsToDart(String code) {
  var newCode = code;

  newCode = unindent(newCode.trimRight());

  newCode = newCode
      // Arrow functions without parens (need to run before arrow block functions are handled)
      .replaceAllMapped(RegExp(r'(\w+) =>'), (match) => '(${match[1]!}) =>')
      // arrow block functions
      .replaceAll(') => {', ') {')
      .replaceAll('console.log(', 'print(')
      .replaceAll('===', '==')
      .replaceAll('!==', '!=')
      .replaceAll('React.', 'over_react.')
      .replaceAll('JSON.stringify', 'jsonEncode')
      // This needs to happen before other function conversions
      .replaceAllMapped(RegExp(r'^(\s*)function\s*([A-Z]\w+)(\([\s\S]+\n\1\})', multiLine: true),
          (match) => '${match.group(1)}final ${match.group(2)} = uiFunction(${match.group(3)}, null);')
      // Local functions
      .replaceAllMapped(RegExp(r'\bfunction\s*(\w+)\s*\('), (match) => '${match.group(1)}(')
      // Function expressions
      .replaceAllMapped(RegExp(r'\bfunction\s*\w*\s*\('), (match) => '(')
      .replaceAllMapped(RegExp(r'async\s+(\w*\s*\([^(]*\))\s+\{'), (match) => '${match[1]!} async {');

  {
    final useStatePattern = RegExp(r'(?:const|let) \[(\w+)?,\s*(\w+)?] =');
    final namesByMatch = <String, StateNames>{
      for (final match in useStatePattern.allMatches(newCode))
        match.group(0)!: StateNames(match.group(1), match.group(2)),
    };

    newCode = newCode.splitMapJoin('\n', onNonMatch: (line) {
      final match = useStatePattern.firstMatch(line);
      if (match != null) {
        final names = namesByMatch[match.group(0)!]!;
        return line.replaceFirst(useStatePattern, 'var ${names.stateNameOrNewStateName} =');
      } else {
        var newLine = line;
        RegExp getWordPattern(String word) => RegExp(r'\b(' + RegExp.escape(word) + r')\b');
        namesByMatch.forEach((match, names) {
          final stateName = names.stateName;
          final setStateName = names.setStateName;

          if (stateName != null) {
            newLine = newLine.replaceAllMapped(
                getWordPattern(stateName), (match) => '${names.stateNameOrNewStateName}.value');
          }
          if (setStateName != null) {
            newLine = newLine.replaceAllMapped(
                getWordPattern(setStateName), (match) => '${names.stateNameOrNewStateName}.set');
          }
        });
        return newLine;
      }
    });
  }
  newCode = newCode
      .replaceAll('.set()', '.set(null)')
      .replaceAllMapped(RegExp(r'uiFunction\(\(\{([\w,\s]+)\}\)\s*{'), (match) {
        final args = match.group(1)!.split(',').map((e) => e.trim());
        return 'uiFunction((props) {\n' + args.map((arg) => '  var $arg = props.$arg;\n').join();
      })
      .replaceAll('uiFunction(()', 'uiFunction((_)')
      // This needs to happen after the hook conversion
      .replaceAllMapped(RegExp(r'\bconst (\w+)'), (match) => 'final ${match.group(1)}')
      .replaceAllMapped(RegExp(r'\blet (\w+)'), (match) => 'var ${match.group(1)}');

  return newCode;
}

class StateNames {
  final String? stateName;
  final String? setStateName;

  StateNames(this.stateName, this.setStateName);

  String get stateNameOrNewStateName =>
      stateName ?? setStateName!.replaceFirstMapped(RegExp(r'^set([A-Z])'), (match) => match.group(1)!.toLowerCase());
}

/// Allows the use of `'''` string blocks, without having to unindent them when used within
/// something like markdown's
/// [markdownToHtml](https://www.dartdocs.org/documentation/markdown/latest/markdown/markdownToHtml.html) function.
///
/// __Replace this:__
///
///     (Component()
///       ..description = markdownToHtml(
///     '''
///     Yuck... I'm indented all funky.
///     '''
///       )
///     )()
///
/// __With this:__
///
///     (Component()
///       ..description = markdownToHtml(unindent(
///           '''
///           Proper indentation is yummy...
///           '''
///       ))
///     )()
String unindent(String multilineString) {
  var indent = RegExp(r'^( *)').firstMatch(multilineString)![1];
  if (indent == null || indent.isEmpty) {
    throw ArgumentError('String has no indent: $multilineString');
  }
  return multilineString.trim().replaceAll('\n$indent', '\n');
}

/// Writes Dart source code containing the constant representation of [object]
/// to the provided [outputBuffer] (or a new one if none is specified), and
/// returns that buffer/
///
/// [object] must be a value that can be represented by dart:core
/// collections/primitives, and may have a nested structure of compatible values.
///
/// When [variableName] is non-null, the output will be a constant variable
/// declaration; otherwise, it will be a an expression.
StringBuffer convertToDartConstantSource(Object? object,
    {String? variableName, StringBuffer? outputBuffer, bool multlineStrings = true, String? language = 'dart'}) {
  outputBuffer ??= StringBuffer();

  if (variableName != null) {
    outputBuffer.write('const $variableName = ');
  }

  if (object is Map) {
    outputBuffer.write('{');
    object.forEach((dynamic key, dynamic value) {
      outputBuffer!.write(convertToDartConstantSource(key));
      outputBuffer.write(': ');
      outputBuffer.write(convertToDartConstantSource(value));
      outputBuffer.write(', ');
    });
    outputBuffer.write('}');
  } else if (object is List) {
    outputBuffer.write('[');
    outputBuffer.writeAll(object.map<dynamic>(convertToDartConstantSource), ', ');
    outputBuffer.write(']');
  } else if (object is Set) {
    if (object.isEmpty) {
      // Type parameter needed to disambiguate empty sets from empty Maps where type cannot be inferred
      outputBuffer.write('<dynamic>{}');
    } else {
      outputBuffer.write('{');
      outputBuffer.writeAll(object.map<dynamic>(convertToDartConstantSource), ', ');
      outputBuffer.write('}');
    }
  } else if (object is num) {
    if (object.isFinite) {
      outputBuffer.write(object);
    } else if (object.isNaN) {
      outputBuffer.write('double.nan');
    } else if (object == double.infinity) {
      outputBuffer.write('double.infinity');
    } else if (object == double.negativeInfinity) {
      outputBuffer.write('double.negativeInfinity');
    } else {
      throw ArgumentError.value(object, '', 'Unhandled number value');
    }
  } else if (object is bool || object == null) {
    outputBuffer.write(object);
  } else if (object is String) {
    if (!object.contains('\n')) {
      outputBuffer.write(stringLiteral(object));
    } else if (multlineStrings) {
      if (language != null) {
        outputBuffer.write('/*language=dart*/');
      }
      outputBuffer.write(rawMultlineStringLiteral(object));
    } else {
      // Write strings with newlines as a series of adjacent strings, which is
      // more readable in the generated code (the indentation of multiline
      // strings decreases legibility), which is helpful for debugging the builder.
      //
      // Example of adjacent vs multiline:
      //
      //     const $demoSourceData = {
      //       'someMethodAdjacent': {
      //         'source': ""
      //             "(Dom.div()\n"
      //             "  ..id = 'foo'\n"
      //             "  ..className = 'bar'\n"
      //             ")()",
      //        },
      //       'someMethodMultiline': {
      //         'source': '''
      //     (Dom.div()
      //       ..id = 'foo'
      //       ..className = 'bar'
      //     )()''',
      //        },
      //     };

      // Write an empty string to start the adjacent string list so all lines
      // are aligned with continuation indents.
      // The comment is necessary to force a line break so the strings don't
      // all end up on one line.
      outputBuffer.write('"" //\n');

      final lines = object.split('\n');
      for (var i = 0; i < lines.length - 1; i++) {
        final line = lines[i];
        outputBuffer.write(stringLiteral('$line\n', useSingleQuote: false));
        outputBuffer.write(' ');
      }
      outputBuffer.write(stringLiteral(lines.last, useSingleQuote: false));
    }
  } else {
    throw ArgumentError.value(object, '', 'Unsupported value');
  }

  if (variableName != null) {
    outputBuffer.write(';');
  }

  return outputBuffer;
}

String rawMultlineStringLiteral(String content) {
  if (content.contains("'''")) throw ArgumentError("Must not contain '''");
  return "r'''\n$content'''";
}
