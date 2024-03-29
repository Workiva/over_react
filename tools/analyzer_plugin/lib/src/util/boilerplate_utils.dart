import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:path/path.dart' as p;

const overReactPackageUri = 'package:over_react/over_react.dart';
const overReactGeneratedPartPathSuffix = '.over_react.g.dart';

/// Returns whether the [unit] contains an `.over_react.g.dart` `part` declaration.
///
/// > Related: [overReactGeneratedPartDirectiveIsValid]
PartDirective? getOverReactGeneratedPartDirective(CompilationUnit unit) {
  return unit.directives.whereType<PartDirective>().firstWhereOrNull((d) {
    return d.uri.stringValue?.endsWith(overReactGeneratedPartPathSuffix) ?? false;
  });
}

/// Returns whether the [directive] is a valid `.over_react.g.dart` directive path based
/// on the [fileUri].
///
/// Returns `false` if the directive is not of the form:
///
/// ```dart
/// part 'filePortionOfFilePath.over_react.g.dart';
/// ```
///
/// > Related: [getOverReactGeneratedPartDirective], [fixOverReactGeneratedPartDirective]
bool overReactGeneratedPartDirectiveIsValid(PartDirective directive, Uri fileUri) {
  final stringValue = directive.uri.stringValue;
  if (stringValue == null || !stringValue.endsWith(overReactGeneratedPartPathSuffix)) return false;

  return p.setExtension(p.basename(fileUri.path), overReactGeneratedPartPathSuffix) == stringValue;
}

String _generateValidOverReactGeneratedPartDirective(CompilationUnit unit, Uri fileUri) {
  final partPath = p.setExtension(p.basename(fileUri.path), overReactGeneratedPartPathSuffix);
  return "part '$partPath';";
}

/// Adds a `.over_react.g.dart` [PartDirective] to the file being edited by the [builder].
///
/// Corrects existing over_react part directives and is a no-op if a valid one already exists.
void addOverReactGeneratedPartDirective(
    DartFileEditBuilder builder, CompilationUnit unit, LineInfo lineInfo, Uri fileUri) {
  Directive? lastDirective;
  if (unit.directives.isNotEmpty) {
    lastDirective = unit.directives.last;
  }

  if (lastDirective is PartDirective && overReactGeneratedPartDirectiveIsValid(lastDirective, fileUri)) return;

  final overReactPartDirective = getOverReactGeneratedPartDirective(unit);
  if (overReactPartDirective != null && !overReactGeneratedPartDirectiveIsValid(overReactPartDirective, fileUri)) {
    fixOverReactGeneratedPartDirective(builder, unit, fileUri);
    return;
  }

  final insertionOffset = lastDirective == null
      ? 0
      : lastDirective is! PartDirective
          ? lineInfo.getOffsetOfLineAfter(nextLine(lastDirective.end, lineInfo))
          : lineInfo.getOffsetOfLineAfter(lastDirective.end);
  builder.addSimpleInsertion(insertionOffset, '${_generateValidOverReactGeneratedPartDirective(unit, fileUri)}\n\n');
}

/// Removes a `.over_react.g.dart` [PartDirective] from the file being edited by the [builder].
///
/// Is a no-op if one does not exist.
void removeOverReactGeneratedPartDirective(DartFileEditBuilder builder, CompilationUnit unit) {
  final generatedPartDirective = getOverReactGeneratedPartDirective(unit);

  if (generatedPartDirective == null) return;

  builder.addDeletion(SourceRange(generatedPartDirective.offset, generatedPartDirective.length));
}

/// Fixes an invalid `.over_react.g.dart` [PartDirective] by making its URI match the
/// path of the file being edited by the [builder].
///
/// > Related: [overReactGeneratedPartDirectiveIsValid]
void fixOverReactGeneratedPartDirective(DartFileEditBuilder builder, CompilationUnit unit, Uri fileUri) {
  final partDirective = getOverReactGeneratedPartDirective(unit);

  if (partDirective == null || overReactGeneratedPartDirectiveIsValid(partDirective, fileUri)) return;

  builder.addReplacement(SourceRange(partDirective.offset, partDirective.length), (editBuilder) {
    editBuilder.write(_generateValidOverReactGeneratedPartDirective(unit, fileUri));
  });
}
