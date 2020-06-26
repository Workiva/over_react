import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';

import 'test_bases/server_plugin_contributor_test_base.dart';

/// Returns a [Matcher] that verifies that the item is a source change with a
/// priority and ID matching [assistKind].
///
/// If [locatedAt] is non-null, the analysis error's location (offset and
/// length) matches it
TypeMatcher<PrioritizedSourceChange> isAssist(AssistKind assistKind, {SourceSelection locatedAt}) {
  var matcher = isA<PrioritizedSourceChange>()
      .having((psc) => psc.priority, 'priority', assistKind.priority)
      .having((psc) => psc.change.id, 'assist ID', assistKind.id);
  if (locatedAt != null) {
    matcher = matcher.havingLocation(locatedAt.offset);
  }
  return matcher;
}

/// Returns a [Matcher] that verifies that the item is a source change with a
/// priority and ID matching [fixKind].
///
/// If [locatedAt] is non-null, the analysis error's location (offset and
/// length) matches it
TypeMatcher<PrioritizedSourceChange> isFix(FixKind fixKind, {SourceSelection locatedAt}) {
  var matcher = isA<PrioritizedSourceChange>()
      .having((psc) => psc.priority, 'priority', fixKind.priority)
      .having((psc) => psc.change.id, 'fix ID', fixKind.id);
  if (locatedAt != null) {
    matcher = matcher.havingLocation(locatedAt.offset);
  }
  return matcher;
}

/// Returns a [Matcher] that verifies that the item is an analysis error that
/// contains the expected information for the given [DiagnosticCode].
///
/// Verifies the following properties:
/// - The item is of type [AnalysisError]
/// - The analysis error code, type, severity, and correction text all match the
///   corresponding values from [diagnosticCode]
/// - The analysis error either has a fix or does not, based on [hasFix]
/// - If [locatedAt] is non-null, the analysis error's location (offset and
///   length) matches it
TypeMatcher<AnalysisError> isDiagnostic(DiagnosticCode diagnosticCode, {bool hasFix, SourceSelection locatedAt}) {
  hasFix ??= false;
  var matcher = isA<AnalysisError>()
      .havingCode(diagnosticCode.name)
      .havingSeverity(diagnosticCode.errorSeverity)
      .havingType(diagnosticCode.type);
  if (diagnosticCode.correction != null) {
    matcher = matcher.havingCorrection(diagnosticCode.correction);
  }
  if (locatedAt != null) {
    matcher = matcher.havingLocation(locatedAt.offset, locatedAt.length);
  }
  return hasFix ? matcher.thatHasFix() : matcher.thatHasNoFix();
}

/// Convenience methods that leverage [TypeMatcher.having] to make it easy to
/// add expectations for properties specific to [AnalysisError].
extension AnalysisErrorHavingUtils on TypeMatcher<AnalysisError> {
  TypeMatcher<AnalysisError> havingCode(String code) => having((e) => e.code, 'code', code);

  TypeMatcher<AnalysisError> havingCorrection(String correction) =>
      having((e) => e.correction, 'correction', correction);

  TypeMatcher<AnalysisError> havingLocation(int offset, int length) =>
      having((e) => e.location.offset, 'location (offset)', offset)
          .having((e) => e.location.length, 'location (length)', length);

  TypeMatcher<AnalysisError> havingSeverity(AnalysisErrorSeverity severity) =>
      having((e) => e.severity, 'severity', severity);

  TypeMatcher<AnalysisError> havingType(AnalysisErrorType type) => having((e) => e.type, 'type', type);

  TypeMatcher<AnalysisError> thatHasFix() => having((e) => e.hasFix, 'hasFix', isTrue);

  TypeMatcher<AnalysisError> thatHasNoFix() => having((e) => e.hasFix, 'hasFix', isFalse);
}

extension PrioritizedSourceChangeHavingUtils on TypeMatcher<PrioritizedSourceChange> {
  TypeMatcher<PrioritizedSourceChange> havingLocation(int offset) =>
      having((psc) => psc.change.selection.offset, 'location (offset)', offset);
}
