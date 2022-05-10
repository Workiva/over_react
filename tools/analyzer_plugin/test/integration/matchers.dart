import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';

import 'test_bases/server_plugin_contributor_test_base.dart';

/// Returns a [Matcher] that verifies that the item is a source change with a
/// priority and ID matching [assistKind].
TypeMatcher<PrioritizedSourceChange> isAssist(AssistKind assistKind) => isA<PrioritizedSourceChange>()
    .having((psc) => psc.priority, 'priority', assistKind.priority)
    .having((psc) => psc.change.id, 'assist ID', assistKind.id);

/// Returns a [Matcher] that verifies that the item is a source change with a
/// priority and ID matching [fixKind].
TypeMatcher<PrioritizedSourceChange> isFix(FixKind fixKind) => isA<PrioritizedSourceChange>()
    .having((psc) => psc.priority, 'priority', fixKind.priority)
    .having((psc) => psc.change.id, 'fix ID', fixKind.id);

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
    matcher = matcher.havingLocation(matchesSelectionLocation(locatedAt));
  }
  return hasFix ? matcher.thatHasFix() : matcher.thatHasNoFix();
}

/// Convenience methods that leverage [TypeMatcher.having] to make it easy to
/// add expectations for properties specific to [AnalysisError].
extension AnalysisErrorHavingUtils on TypeMatcher<AnalysisError> {
  TypeMatcher<AnalysisError> havingCode(String code) => having((e) => e.code, 'code', code);

  TypeMatcher<AnalysisError> havingCorrection(String correction) =>
      having((e) => e.correction, 'correction', correction);

  TypeMatcher<AnalysisError> havingLocation(Matcher matcher) => having((e) => e.location, 'location', matcher);

  TypeMatcher<AnalysisError> havingSeverity(AnalysisErrorSeverity severity) =>
      having((e) => e.severity, 'severity', severity);

  TypeMatcher<AnalysisError> havingType(AnalysisErrorType type) => having((e) => e.type, 'type', type);

  TypeMatcher<AnalysisError> thatHasFix() => having((e) => e.hasFix, 'hasFix', isTrue);

  TypeMatcher<AnalysisError> thatHasNoFix() => having((e) => e.hasFix, 'hasFix', isFalse);
}

Matcher matchesSelectionLocation(SourceSelection selection) =>
    _LocationMatcher(selection.source, selection.offset, selection.length, isFromSelection: true);

Matcher matchesLocation(Source source, int offset, int length) => _LocationMatcher(source, offset, length);

class _LocationMatcher extends Matcher {
  final Source source;
  final int expectedOffset;
  final int expectedLength;
  final bool isFromSelection;

  _LocationMatcher(this.source, this.expectedOffset, this.expectedLength, {this.isFromSelection = false});

  String getSelectionContents(int offset, int length) => source.contents.data.substring(offset, offset + length);

  Description describeRange(Description description, int offset, int length) => description
    ..add('has offset ')
    ..addDescriptionOf(offset)
    ..add(' and length ')
    ..addDescriptionOf(length)
    ..add(': "')
    ..add(isFromSelection ? '#' : '')
    ..add(getSelectionContents(offset, length))
    ..add(isFromSelection ? '#' : '')
    ..add('"');

  @override
  Description describe(Description description) => describeRange(description, expectedOffset, expectedLength);

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription, Map matchState, bool verbose) {
    if (matchState.isNotEmpty) {
      describeRange(mismatchDescription, matchState['offset'] as int, matchState['length'] as int);
      return mismatchDescription;
    }

    return super.describeMismatch(item, mismatchDescription, matchState, verbose)
      ..add('is not a location type supported by this matcher');
  }

  @override
  bool matches(dynamic item, Map matchState) {
    int/*!*/ offset;
    int/*!*/ length;
    if (item is SourceSelection) {
      offset = item.offset;
      length = item.length;
    } else if (item is Location) {
      offset = item.offset;
      length = item.length;
    }

    matchState.addAll(<dynamic, dynamic>{
      if (offset != null) 'offset': offset,
      if (length != null) 'length': length,
    });

    return offset == expectedOffset && length == expectedLength;
  }
}
