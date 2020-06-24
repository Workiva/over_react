import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_utils.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

const sourceWithValidPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  part 'foo.over_react.g.dart';
  
  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
  
  mixin FooProps on UiProps {}
  
  class FooComponent extends UiComponent2<FooProps> {
    @override
    render() {}
  }
''';

const sourceWithInvalidPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  part 'foo.not_over_react.g.dart';
  
  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
  
  mixin FooProps on UiProps {}
  
  class FooComponent extends UiComponent2<FooProps> {
    @override
    render() {}
  }
''';

const sourceWithNoPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

  mixin FooProps on UiProps {}

  class FooComponent extends UiComponent2<FooProps> {
    @override
    render() {}
  }
''';

main() {
  group('boilerplate_util', () {
    group('getOverReactGeneratedPartDirective', () {
      test('returns correct PartDirective', () {
        final unit = parseAndGetUnit(sourceWithValidPart);
        final result = getOverReactGeneratedPartDirective(unit);
        expect(result, isA<PartDirective>());
        expect(result.uri?.stringValue, 'foo.over_react.g.dart');
      });

      group('returns null when', () {
        test('PartDirective does not contain `.over_react.g.dart`', () {
          final unit = parseAndGetUnit(sourceWithInvalidPart);
          expect(getOverReactGeneratedPartDirective(unit), isNull);
        });

        test('there is no PartDirective', () {
          final unit = parseAndGetUnit(sourceWithNoPart);
          expect(getOverReactGeneratedPartDirective(unit), isNull);
        });
      });
    });

    group('overReactGeneratedPartDirectiveIsValid', () {
      test('returns true when valid part directive matches the file uri', () async {
        await overReactGeneratedPartDirectiveIsValidTestHelper(
          isPartValid: true,
          path: 'foo.dart',
          expectedResult: true,
        );
      });

      group('returns false when', () {
        test('invalid part directive matches the file uri', () async {
          await overReactGeneratedPartDirectiveIsValidTestHelper(
            isPartValid: false,
            path: 'foo.dart',
            expectedResult: false,
          );
        });

        test('valid part directive does not match the file uri', () async {
          await overReactGeneratedPartDirectiveIsValidTestHelper(
            isPartValid: true,
            path: 'different_file_path.dart',
            expectedResult: false,
          );
        });
      });
    });

    group('addOverReactGeneratedPartDirective', () {
      test('does nothing if there is already a valid part directive', () async {
        final sourceFileEdits = await getSourceFileEdits(
          sourceWithValidPart,
          (builder, result) => addOverReactGeneratedPartDirective(builder, result.unit, result.uri),
          path: 'foo.dart',
          shouldThrowErrors: false,
        );
        expect(sourceFileEdits, isEmpty);
      });

      group('adds a valid part directive', () {
        test('when there are no directives in the file', () async {
          final sourceFileEdits = await getSourceFileEdits(
            /*language=dart*/ r'''
              UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
            
              mixin FooProps on UiProps {}
            
              class FooComponent extends UiComponent2<FooProps> {
                @override
                render() {}
              }
            ''',
            (builder, result) => addOverReactGeneratedPartDirective(builder, result.unit, result.uri),
            path: 'foo.dart',
            shouldThrowErrors: false,
          );
          final editList = sourceFileEdits.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');
          expect(editList.first.offset, 0);
          expect(editList.first.replacement, 'part \'foo.over_react.g.dart\';\n\n');
        });

        test('when there are no part directives in the file', () async {
          final result = await parseAndGetResolvedUnit(
            sourceWithNoPart,
            path: 'foo.dart',
            shouldThrowErrors: false,
          );
          final sourceChange = await buildFileEdit(result, (builder) {
            addOverReactGeneratedPartDirective(builder, result.unit, result.uri);
          });
          final editList = sourceChange.edits?.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final offset = result.unit.lineInfo
              .getOffsetOfLineAfter(nextLine(result.unit.directives.last.end, result.unit.lineInfo));
          expect(editList.first.offset, offset, reason: 'should be new line between existing directives and new part');
          expect(editList.first.replacement, 'part \'foo.over_react.g.dart\';\n\n');
        });

        test('when there is an existing part directive in the file', () async {
          final result = await parseAndGetResolvedUnit(
            sourceWithValidPart,
            path: 'different_file_name.dart',
            shouldThrowErrors: false,
          );
          final sourceChange = await buildFileEdit(result, (builder) {
            addOverReactGeneratedPartDirective(builder, result.unit, result.uri);
          });
          final editList = sourceChange.edits?.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final offset = result.unit.lineInfo.getOffsetOfLineAfter(result.unit.directives.last.end);
          expect(editList.first.offset, offset, reason: 'new part should be on the line after existing part');
          expect(editList.first.replacement, 'part \'different_file_name.over_react.g.dart\';\n\n');
        });
      });
    });
  });
}

Future<void> overReactGeneratedPartDirectiveIsValidTestHelper({
  bool isPartValid,
  String path,
  bool expectedResult,
}) async {
  final result = await parseAndGetResolvedUnit(
    isPartValid ? sourceWithValidPart : sourceWithInvalidPart,
    path: path,
    shouldThrowErrors: false,
  );
  final part = result.unit.directives.whereType<PartDirective>()?.first;
  expect(part, isNotNull);
  expect(result.uri.toFilePath(), endsWith('/$path'));
  expect(overReactGeneratedPartDirectiveIsValid(part, result.uri), expectedResult);
}

Future<List<SourceFileEdit>> getSourceFileEdits(
  String dartSource,
  void Function(DartFileEditBuilder builder, ResolvedUnitResult result) callUtilityFunction, {
  String path = 'foo.dart',
  bool shouldThrowErrors = true,
}) async {
  final result = await parseAndGetResolvedUnit(
    dartSource,
    path: path,
    shouldThrowErrors: shouldThrowErrors,
  );
  final sourceChange = await buildFileEdit(result, (builder) {
    callUtilityFunction(builder, result);
  });
  return sourceChange.edits;
}
