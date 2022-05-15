import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';

import '../matchers.dart';
import 'server_plugin_contributor_test_base.dart';

export 'package:analyzer/src/generated/source.dart' show Source;

/// Test base for integration tests that exercise a single diagnostic
/// contributor.
///
/// Tests should extend this class and override [errorUnderTest] to
/// return the error that is being tested.
///
/// Most tests should use [newSource] to create a test source file,
/// [createSelection] to select a range within that source, and one of the
/// `expect` utility methods. Should also use [getAllErrors] to test that
/// multiple distinct errors can be produced over a whole source file.
///
/// Note: it is possible and valid for a diagnostic contributor to produce
/// multiple kinds of errors and/or fixes, in which case a separate test suite
/// for each combination should be created.
abstract class DiagnosticTestBase extends ServerPluginContributorTestBase {
  /// Tests should override this to return the [DiagnosticCode] for the
  /// diagnostic contributor that is being tested.
  ///
  /// This will be used to filter the analysis errors produced by the test
  /// plugin to only those originating from this diagnostic contributor.
  DiagnosticCode? get errorUnderTest;

  /// Tests should override this to return the [FixKind] for the diagnostic
  /// contributor that is being tested.
  ///
  /// This will be used to filter the error fixes produced by the test plugin to
  /// only those originating from this diagnostic contributor.
  FixKind? get fixKindUnderTest;

  void _throwIfNoFix() {
    if (fixKindUnderTest == null) {
      throw UnsupportedError("Expected 'fixKindsUnderTest' to be non-null");
    }
  }

  /// Returns a matcher that matches [errorUnderTest].
  ///
  /// See [isDiagnostic] for more details.
  Matcher isAnErrorUnderTest({bool? hasFix, SourceSelection? locatedAt}) {
    hasFix ??= fixKindUnderTest != null;
    return isDiagnostic(errorUnderTest!, hasFix: hasFix, locatedAt: locatedAt);
  }

  /// Returns a matcher that matches [fixKindUnderTest].
  ///
  /// See [isFix] for more details.
  Matcher isAFixUnderTest() {
    return isFix(fixKindUnderTest!);
  }

  /// Applies the source change from [errorFix] to [source] and returns the
  /// updated source.
  Source applyErrorFixes(AnalysisErrorFixes errorFix, Source source) {
    _throwIfNoFix();
    final fixes = errorFix.fixes;
    expect(fixes, hasLength(1), reason: 'Expected error fix to have exactly one change.');
    final fix = fixes.single;
    expect(fix, isAFixUnderTest(), reason: 'Expected fix to match the fix kind under test.');
    return applySourceChange(fix.change, source);
  }

  /// Fails the test if any selection of [sourceContents] from
  /// [selectionTargets] does not produce a single assist.
  Future<void> expectAllSelectionsProduceAtLeastOneError(String sourceContents, List<String> selectionTargets) async {
    final source = newSource('test.dart', sourceContents);
    for (final target in selectionTargets) {
      final selection = createSelection(source, target);
      await expectSingleErrorFix(selection);
    }
  }

  /// Expects a single error at the given selection string, and returns that error.
  Future<AnalysisError> expectSingleErrorAtSelection(Source source, String selection,
          {bool exactSelectionMatch = true}) =>
      expectSingleErrorAt(createSelection(source, selection), exactSelectionMatch: exactSelectionMatch);

  Future<AnalysisError> expectSingleErrorAt(SourceSelection selection, {bool exactSelectionMatch = true}) async {
    final errorsAtSelection = await _getAllErrorsAtSelection(selection);
    expect(errorsAtSelection, [isAnErrorUnderTest()],
        reason: 'Expected a single error that matches `errorUnderTest` (selection: ${selection.target}.');
    final error = errorsAtSelection[0];

    if (exactSelectionMatch) {
      expect(error.location, matchesSelectionLocation(selection), reason: 'error location should match selection');
    }
    return error;
  }

  /// Returns the error fix for the single error produced at [selection] and
  /// fails the test if anything other than a single error fix is produced.
  Future<AnalysisErrorFixes> expectSingleErrorFixAtSelection(Source source, String selection) =>
      expectSingleErrorFix(createSelection(source, selection));

  /// Returns the error fix for the single error produced at [selection] and
  /// fails the test if anything other than a single error fix is produced.
  Future<AnalysisErrorFixes> expectSingleErrorFix(SourceSelection selection) async {
    _throwIfNoFix();
    final allErrorFixes = await _getAllErrorFixesAtSelection(selection);
    expect(allErrorFixes, hasLength(1),
        reason: 'Expected only a single error at selection (selection: ${selection.target})');
    final errorFix = allErrorFixes.single;
    expect(errorFix.error, isAnErrorUnderTest(),
        reason: 'Expected error to match the `errorUnderTest` (selection: ${selection.target})');
    expect(errorFix.fixes, hasLength(1),
        reason: 'Expected only a single error fix at selection. (selection: ${selection.target})');
    expect(errorFix.fixes, everyElement(isAFixUnderTest()),
        reason: 'Expected error fix to match the `fixKindUnderTest` (selection: ${selection.target})');
    return errorFix;
  }

  /// Fails the test if [selection] produces any errors.
  Future<void> expectNoErrorFix(SourceSelection selection) async {
    expect(await _getAllErrorFixesAtSelection(selection), isEmpty,
        reason: 'Unexpected error at selection: ${selection.target}');
  }

  /// Returns all errors produced over the entire [source] and fails the test if
  /// any of them do not match [isAnErrorUnderTest] or [isAFixUnderTest].
  Future<List<AnalysisError>> getAllErrors(Source source, {bool includeOtherCodes = false}) async {
    final errors = await _getAllErrors(source);
    if (!includeOtherCodes) {
      expect(errors, everyElement(isAnErrorUnderTest()),
          reason: 'Expected all errors to match the error & fix kinds under test.');
    }
    return errors;
  }

  Future<List<AnalysisError>> getAllErrorsAtSelection(SourceSelection selection,
      {bool includeOtherCodes = false}) async {
    final errors = await _getAllErrorsAtSelection(selection);
    if (!includeOtherCodes) {
      expect(errors, everyElement(isAnErrorUnderTest()),
          reason: 'Expected all errors to match the error & fix kinds under test.');
    }
    return errors;
  }

  /// Returns all error fixes produced at [selection].
  Future<List<AnalysisError>> _getAllErrorsAtSelection(SourceSelection selection) async {
    final allErrors = await _getAllErrors(selection.source);
    final errorsOverlappingSelection =
        allErrors.where((e) => e.location.toRange().intersects(selection.toRange())).toList();
    return errorsOverlappingSelection;
  }

  Future<List<AnalysisError>> _getAllErrors(Source source) async {
    final analysisResult = await testPlugin.getResolvedUnitResult(sourcePath(source));
    return testPlugin.getAllErrors(analysisResult);
  }

  /// Returns all error fixes prroduced at [selection].
  Future<List<AnalysisErrorFixes>> _getAllErrorFixesAtSelection(SourceSelection selection) async {
    final parameters = EditGetFixesParams(sourcePath(selection.source), selection.offset);
    return (await testPlugin.handleEditGetFixes(parameters)).fixes;
  }
}
