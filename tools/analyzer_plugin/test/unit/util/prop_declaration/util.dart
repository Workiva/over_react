import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../../util/over_react_builder.dart';
import '../../../util/shared_analysis_context.dart';

/// Generates an over_react part for a library with source [sourceTemplate] and returns the resolved library,
/// validating that the generated part was also resolved.
///
/// The source should include `part '{{PART_PATH}}';` to point to the generated part.
Future<ResolvedUnitResult> resolveFileAndGeneratedPart(SharedAnalysisContext sharedContext, String sourceTemplate) async {
  final libraryFilename = sharedContext.nextFilename();
  final partFilename = p.setExtension(libraryFilename, '.over_react.g.dart');

  final librarySource = sourceTemplate.replaceSingle('{{PART_PATH}}', partFilename);
  // Generate the part so we don't have to keep updating it whenever the source file changes.
  // Doing this here seemed easier than attempting to generate it within the test harness package within tests
  // (and avoid issues with concurrent tests running builds at the same time),
  // or generating it and checking it in.
  final partSource = await generateOverReactPart(libraryPath: libraryFilename, librarySource: librarySource);

  final libraryFullPath = sharedContext.createTestFile(librarySource, filename: libraryFilename);
  final partFullPath = sharedContext.createTestFile(partSource, filename: partFilename);

  Future<ResolvedUnitResult> getResolvedUnit(String path) async {
    final result = await sharedContext.collection.contextFor(path).currentSession.getResolvedUnit(path);
    if (result is! ResolvedUnitResult) {
      throw Exception('Failed to resolve path $path: $result');
    }
    if (!result.exists) {
      throw Exception('Failed to resolve resolve path $path because it did not exist: ${result.uri}');
    }
    return result;
  }

  List<AnalysisError> filterErrors(List<AnalysisError> errors) => errors
      .where((e) => e.severity != Severity.info && !e.errorCode.name.toLowerCase().startsWith('unused_'))
      // FIXME(FED-2015) remove once these are properly ignored in generated code
      .where((e) => e.errorCode.name.toLowerCase() != 'invalid_use_of_visible_for_overriding_member')
      .toList();

  final libraryResult = await getResolvedUnit(libraryFullPath);
  expect(filterErrors(libraryResult.errors), isEmpty);

  // Make sure the generated part is resolved and present during analysis; for these tests, we want to make sure that
  // utilities like `getAllProps` and `getRequiredProps` only deal with user-authored props, and not generated prop
  // overrides.
  final partResult = await getResolvedUnit(partFullPath);
  expect(filterErrors(partResult.errors), isEmpty,
      reason: 'generated file should be free of analysis errors. Full generated source:\n$partSource');
  // Check whether part declarations show up in the main library as a way of verifying they're wired up correctly
  expect(libraryResult.libraryElement.topLevelElements, contains(partResult.unit.declaredElement!.classes.first),
      reason: 'generated part should be wired up to parent library');

  return libraryResult;
}

extension on String {
  /// Creates a new string with the single occurrence of [pattern] replaced by [replacement].
  ///
  /// Throws an error if there is not exactly one non-overlapping occurrence of [pattern].
  String replaceSingle(Pattern pattern, String replacement) {
    final singleMatch = pattern.allMatches(this).single;
    return substring(0, singleMatch.start) + replacement + substring(singleMatch.end);
  }
}

InterfaceElement getInterfaceElement(ResolvedUnitResult result, String name) =>
    result.libraryElement.topLevelElements.whereType<InterfaceElement>().singleWhere((e) => e.name == name);

InterfaceElement getImportedInterfaceElement(ResolvedUnitResult result, String name) =>
    result.libraryElement.importedLibraries.map((l) => l.exportNamespace.get(name)).whereNotNull().single
        as InterfaceElement;

extension FieldElementMatchers on TypeMatcher<FieldElement> {
  TypeMatcher<FieldElement> havingName(dynamic matcher) => having((f) => f.name, 'name', matcher);

  TypeMatcher<FieldElement> havingIsSynthetic(dynamic matcher) => having((f) => f.isSynthetic, 'isSynthetic', matcher);

  TypeMatcher<FieldElement> havingSourceUri(dynamic matcher) => having((f) => f.source?.uri, 'source.uri', matcher);
}
