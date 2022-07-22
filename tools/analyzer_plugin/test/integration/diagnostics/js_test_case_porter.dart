import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/style_value_diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';

import 'codemod/util.dart';

void main() {
  final source = File('test/integration/diagnostics/hooks_exhaustive_deps_cases.dart').readAsStringSync();
  final parsed = parseString(content: source);
  final visitor = TestCaseVisitor(source, parsed.lineInfo);
  parsed.unit.accept(visitor);

  File('test/integration/diagnostics/test_cases_output.dart').writeAsStringSync(applyPatches(source, visitor.patches));
  //
  // final source = File('test/integration/diagnostics/test_cases_output.dart').readAsStringSync();
  // final parsed = parseString(content: source);
  // final visitor = TrailingCommasVisitor(source, parsed.lineInfo);
  // parsed.unit.accept(visitor);
  //
  // File('test/integration/diagnostics/test_cases_output.dart').writeAsStringSync(applyPatches(source, visitor.patches));
}

Iterable<Expression> flattenAdditionExpression(Expression expression) sync* {
  if (expression is BinaryExpression && expression.operator.type == TokenType.PLUS) {
    yield* flattenAdditionExpression(expression.leftOperand);
    yield* flattenAdditionExpression(expression.rightOperand);
  } else {
    yield expression;
  }
}

class TrailingCommasVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final String source;

  TrailingCommasVisitor(this.source, this.lineInfo);

  final patches = <Patch>[];

  @override
  void visitListLiteral(ListLiteral node) {
    if (node.elements.isNotEmpty) {
      final tokenBeforePotentialTrailingComma = node.elements.last.endToken;
      if (tokenBeforePotentialTrailingComma.next!.type != TokenType.COMMA) {
        patches.add(Patch(',', tokenBeforePotentialTrailingComma.end, tokenBeforePotentialTrailingComma.end));
      }
    }
    super.visitListLiteral(node);
  }
}

class TestCaseVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final String source;

  TestCaseVisitor(this.source, this.lineInfo);

  final patches = <Patch>[];

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    void handleExpression(Expression e) {
      if (e is Identifier) {
        patches.add(Patch(e.name == 'undefined' ? 'null' : "'${e.name}'", e.offset, e.end));
      } else {
        e.accept(this);
      }
    }

    // Inline variables
    handleExpression(node.key);
    handleExpression(node.value);
  }

  @override
  void visitBinaryExpression(BinaryExpression node) {
    final expressionsBeingAdded = flattenAdditionExpression(node).toList();
    if (expressionsBeingAdded.length > 1 && expressionsBeingAdded.every((e) => e is SimpleStringLiteral)) {
      patches.add(Patch(
        stringLiteral(
          expressionsBeingAdded.cast<SimpleStringLiteral>().map((s) => s.value).join(''),
          useSingleQuote: true,
        ),
        node.offset,
        node.end,
      ));
    } else {
      super.visitBinaryExpression(node);
    }
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    if (node.isRaw && node.isMultiline) {
      final indent = getIndent(source, lineInfo, node.offset);

      final ported = portJsToDart(unindent(node.value.trimRight()));

      final additionalIndent = ' ' * 2;

      final newString = "r'''\n" +
          ported.splitMapJoin('\n', onNonMatch: (line) => line.isEmpty ? line : '$indent$additionalIndent$line') +
          "\n$indent'''";

      patches.add(Patch(newString, node.offset, node.end));
    } else {
      super.visitSimpleStringLiteral(node);
    }
  }
}

String transformIndentedMultilineString(String string, String Function(String normalized) process) {
  var newString = string.trimRight();
  final indent = getIndentOfString(newString);
  newString = unindent(newString);
  newString = '\n' +
      newString.splitMapJoin('\n', onNonMatch: (line) => line.isEmpty ? line : '$indent$line') +
      '\n${indent.replaceFirst('  ', '')}';
  return newString;
}

/// Does an incomplete port of JS syntax to the Dart equivalent,
/// to help assist in porting JS test cases to dart.
String portJsToDart(String code) {
  if (getIndentOfString(code).isNotEmpty) {
    throw ArgumentError('code must be unindented first');
  }

  var newCode = code;

  newCode = newCode
      // Arrow functions without parens (need to run before arrow block functions are handled)
      .replaceAllMapped(RegExp(r'(\w+) =>'), (match) => '(${match[1]!}) =>')
      // arrow block functions
      .replaceAll(') => {', ') {')
      .replaceAll('console.log(', 'print(')
      .replaceAll(RegExp(r'\balert\('), 'window.alert(')
      .replaceAll('===', '==')
      .replaceAll('!==', '!=')
      .replaceAll('React.', 'over_react.')
      .replaceAll('JSON.stringify', 'jsonEncode')
      // This needs to happen before other function conversions
      // Use replaceAllMappedIteratively to handle nested components
      .replaceAllMappedIteratively(RegExp(r'^(\s*)function\s*([A-Z]\w+)(\([\s\S]+\n\1\})', multiLine: true),
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
      // Add type args to get props typing
      .replaceAll('uiFunction(', 'uiFunction<TestProps>(')
      // This needs to happen after the hook conversion
      .replaceAllMapped(RegExp(r'\bconst (\w+)'), (match) => 'final ${match.group(1)}')
      .replaceAllMapped(RegExp(r'\blet (\w+)'), (match) => 'var ${match.group(1)}')
      // Adjacent commas in lists. This needs to happen after destructuring conversion
      .replaceAllMapped(RegExp(r'\[\s*(,[^\]]+|[^\]]+,|[^\]],\s*,[^\]]+)\s*\]'), (match) {
        final listItems = match[1]!;
        return '[' + listItems.split(',').map((e) => e.trim()).map((e) => e.isEmpty ? 'null' : e).join(', ') + ']';
      })
      .replaceAll('<div ref={myRef} />', '(Dom.div()..ref = myRef)()')
      .replaceAll('<div onClick={handleNext} />', '(Dom.div()..onClick = handleNext)()')
      .replaceAll('<div />', 'Dom.div()()')
      .replaceAll('<h1>{count.value}</h1>', 'Dom.h1()(count.value)');

  return newCode;
}

extension on String {
  String replaceAllMappedIteratively(Pattern from, String Function(Match match) replace, {int maxIterations = 10}) {
    var current = this;
    for (var i = 0; i < maxIterations; i++) {
      var newString = current.replaceAllMapped(from, replace);
      if (newString == current) {
        return newString;
      }
      current = newString;
    }
    throw ArgumentError(
        'String replacement modified the string even after $maxIterations iterations, and may infinitely replace.'
        ' Check your pattern to make sure this doesn\'t happen. String after max replacements: $current');
  }
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
  var indent = getIndentOfString(multilineString);
  if (indent.isEmpty) {
    throw ArgumentError('String has no indent: $multilineString');
  }
  return multilineString.trim().replaceAll('\n$indent', '\n');
}

String getIndentOfString(String multilineString) => RegExp(r'^( *)').firstMatch(multilineString)![1]!;
