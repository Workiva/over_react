import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

const overReactPackageUri = 'package:over_react/over_react.dart';
const overReactGeneratedPartPathSuffix = '.over_react.g.dart';

/// Returns whether the [unit] contains a `package:over_react/over_react.dart` [ImportDirective].
///
/// > Related: [addOverReactImportDirective]
ImportDirective getOverReactImportDirective(CompilationUnit unit) {
  return unit.directives.whereType<ImportDirective>().firstWhere((d) {
    return d.uri.stringValue == overReactPackageUri;
  }, orElse: () => null);
}

/// Adds a `package:over_react/over_react.dart` [ImportDirective] to the file being edited by the [builder].
///
/// Is a no-op if one already exists.
void addOverReactImportDirective(DartFileEditBuilder builder, CompilationUnit unit) {
  if (getOverReactImportDirective(unit) != null) return;

  builder.importLibrary(Uri(path: overReactPackageUri));
}

/// Returns whether the [unit] contains an `.over_react.g.dart` `part` declaration.
///
/// > Related: [overReactGeneratedPartDirectiveIsValid]
PartDirective getOverReactGeneratedPartDirective(CompilationUnit unit) {
  return unit.directives.whereType<PartDirective>().firstWhere((d) {
    return d.uri.stringValue.contains(overReactGeneratedPartPathSuffix);
  }, orElse: () => null);
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
  if (directive == null) return false;

  if (!directive.uri.stringValue.contains(overReactGeneratedPartPathSuffix)) return false;

  final filePath = fileUri.pathSegments.last;
  final fileUriWithoutMimeType = filePath.substring(0, filePath.lastIndexOf('.dart'));

  return '$fileUriWithoutMimeType$overReactGeneratedPartPathSuffix' == directive.uri.stringValue;
}

String _generateValidOverReactGeneratedPartDirective(CompilationUnit unit, Uri fileUri) {
  final filePath = fileUri.pathSegments.last;
  final fileUriWithoutMimeType = filePath.substring(0, filePath.lastIndexOf('.dart'));
  return "part '$fileUriWithoutMimeType$overReactGeneratedPartPathSuffix';";
}

/// Adds a `.over_react.g.dart` [PartDirective] to the file being edited by the [builder].
///
/// Is a no-op if one already exists.
void addOverReactGeneratedPartDirective(DartFileEditBuilder builder, CompilationUnit unit, Uri fileUri) {
  if (getOverReactGeneratedPartDirective(unit) != null) return;
  addOverReactImportDirective(builder, unit);

  final insertionOffset = unit.lineInfo.getOffsetOfLineAfter(unit.directives.last.end);
  builder.addSimpleInsertion(insertionOffset, '${_generateValidOverReactGeneratedPartDirective(unit, fileUri)}\n');
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
