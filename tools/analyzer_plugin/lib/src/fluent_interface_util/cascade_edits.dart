import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

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
    if (addOnOwnLine) {
      fileBuilder.addSimpleInsertion(function.unParenthesized.end, '\n$widgetIndent');
    }

    fileBuilder.addSimpleInsertion(function.end, ')');
  }
}

/// Adds edits to [fileBuilder] that remove [prop] from [usage].
///
/// If [prop] is the last cascade on the parenthesized builder, this removes the parentheses for a better user experience.
void removeProp(FluentComponentUsage usage, DartFileEditBuilder fileBuilder, PropAssignment prop) {
  final cascade = usage.cascadeExpression;
  // Defensively check that this is a ParenthesizedExpression in case there's some weird syntax issue.
  final parenthesizedCascade = cascade.parent.tryCast<ParenthesizedExpression>();

  if (parenthesizedCascade != null && cascade.cascadeSections.length == 1) {
    fileBuilder.addDeletion(range.token(parenthesizedCascade.leftParenthesis));
    // Remove from the first `..` through the closing paren, which also removes all whitespace/newlines as desired.
    fileBuilder.addDeletion(range.endEnd(cascade.target, parenthesizedCascade.rightParenthesis));
  } else {
    // Include the space between the previous token and the start of this assignment, so that
    // the entire prop line is removed.
    fileBuilder.addDeletion(range.endEnd(prop.node.beginToken.previous, prop.node));
  }
}
