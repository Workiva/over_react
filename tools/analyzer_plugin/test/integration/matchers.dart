import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';

import 'mocks.dart';

TypeMatcher<AnalysisError> isAnalysisErrorForDiagnostic(
    DiagnosticCode diagnosticCode,
    {SourceSelection atSelection,
    bool hasFix}) {
  var matcher = isA<AnalysisError>()
      .havingCode(diagnosticCode.name)
      .havingSeverity(diagnosticCode.errorSeverity)
      .havingType(diagnosticCode.type);
  if (diagnosticCode.correction != null) {
    matcher = matcher.havingCorrection(diagnosticCode.correction);
  }
  if (atSelection != null) {
    matcher = matcher.havingLocation(atSelection.offset, atSelection.length);
  }
  return hasFix ? matcher.thatHasFix() : matcher.thatHasNoFix();
}

extension AnalysisErrorHavingUtils on TypeMatcher<AnalysisError> {
  TypeMatcher<AnalysisError> havingCode(String code) =>
      having((e) => e.code, 'code', code);

  TypeMatcher<AnalysisError> havingCorrection(String correction) =>
      having((e) => e.correction, 'correction', correction);

  TypeMatcher<AnalysisError> havingLocation(int offset, int length) =>
      having((e) => e.location.offset, 'location (offset)', offset)
          .having((e) => e.location.length, 'location (length)', length);

  TypeMatcher<AnalysisError> havingSeverity(AnalysisErrorSeverity severity) =>
      having((e) => e.severity, 'severity', severity);

  TypeMatcher<AnalysisError> havingType(AnalysisErrorType type) =>
      having((e) => e.type, 'type', type);

  TypeMatcher<AnalysisError> thatHasFix() =>
      having((e) => e.hasFix, 'hasFix', isTrue);

  TypeMatcher<AnalysisError> thatHasNoFix() =>
      having((e) => e.hasFix, 'hasFix', isFalse);
}

