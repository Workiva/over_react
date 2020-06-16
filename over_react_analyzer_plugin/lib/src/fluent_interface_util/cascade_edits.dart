import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';

void addProp(
  FluentComponentUsage usage,
  DartFileEditBuilder fileBuilder,
  String source,
  LineInfo lineInfo, {
  String name,
  String value,
  void Function(DartEditBuilder builder) buildNameEdit,
  void Function(DartEditBuilder builder) buildValueEdit,
  bool forceOwnLine = false,
}) {
  if ((name == null) == (buildNameEdit == null)) {
    throw ArgumentError();
  }

  if ((value != null) && (buildValueEdit != null)) {
    throw ArgumentError();
  }

  final function = usage.node.function;
  final needsParens = function is! ParenthesizedExpression;
  final addOnOwnLine = forceOwnLine || usage.cascadeExpression != null;

  final widgetIndent = getIndent(source, lineInfo, usage.node.offset);
  final cascadeIndent = '$widgetIndent  ';

  if (needsParens) {
    fileBuilder.addSimpleInsertion(function.offset, '(');
  }

  if (usage.cascadeExpression != null) {
    final sections = usage.cascadeExpression.cascadeSections;
    if (isSameLine(lineInfo, usage.node.function.offset, sections.first.offset)) {
      // todo handle some cascades being on separate lines
      // todo handle multiline cascades
      for (final section in sections) {
        fileBuilder.addSimpleInsertion(section.offset, '\n$cascadeIndent');
      }
    }
  }

  fileBuilder.addInsertion(function.unParenthesized.end, (builder) {
    if (addOnOwnLine) {
      builder.write('\n$cascadeIndent');
    }
    builder.write('..');

    if (name != null) {
      builder.write(name);
    } else {
      buildNameEdit(builder);
    }

    if (value != null) {
      builder.write(' = ');
      builder.write(value);
    } else if (buildValueEdit != null) {
      builder.write(' = ');
      buildValueEdit(builder);
    }
  });

  if (needsParens) {
    fileBuilder.addSimpleInsertion(function.end, ')');
  }
}
