import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'test_source.dart';

Future<ResolvedUnitResult> setUpResult(SharedAnalysisContext sharedContext) async {
  final libraryFilename = sharedContext.nextFilename();
  final partFilename = p.setExtension(libraryFilename, '.over_react.g.dart');
  final libraryPath =
      sharedContext.createTestFile(source.replaceSingle('{{PART_PATH}}', partFilename), filename: libraryFilename);
  final partPath = sharedContext.createTestFile(partSource.replaceSingle('{{PART_OF_PATH}}', libraryFilename),
      filename: partFilename);

  final libraryResult = await sharedContext.collection
      .contextFor(libraryPath)
      .currentSession
      .getResolvedUnit(libraryPath) as ResolvedUnitResult;

  List<AnalysisError> filterErrors(List<AnalysisError> errors) => errors
      .where((e) => e.severity != Severity.info && !e.errorCode.name.toLowerCase().startsWith('unused_'))
      .toList();
  expect(filterErrors(libraryResult.errors), isEmpty);

  final partResult = await sharedContext.collection.contextFor(partPath).currentSession.getResolvedUnit(partPath)
      as ResolvedUnitResult;
  expect(filterErrors(partResult.errors), isEmpty);

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

extension FieldElementMatchers on TypeMatcher<FieldElement> {
  TypeMatcher<FieldElement> havingName(dynamic matcher) => having((f) => f.name, 'name', matcher);
  TypeMatcher<FieldElement> havingIsSynthetic(dynamic matcher) => having((f) => f.isSynthetic, 'isSynthetic', matcher);
}
