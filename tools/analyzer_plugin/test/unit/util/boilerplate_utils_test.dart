// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_utils.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

const sourceWithOverReactPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  // ignore: uri_has_not_been_generated
  part 'foo.over_react.g.dart';
  
  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment
  
  mixin FooProps on UiProps {}
  
  class FooComponent extends UiComponent2<FooProps> {
    @override
    void render() {}
  }
''';

const sourceWithNonOverReactPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  // ignore: uri_has_not_been_generated
  part 'foo.not_over_react.g.dart';
  
  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment
  
  mixin FooProps on UiProps {}
  
  class FooComponent extends UiComponent2<FooProps> {
    @override
    void render() {}
  }
''';

const sourceWithNoPart = /*language=dart*/ r'''
  import 'package:over_react/over_react.dart';

  UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment

  mixin FooProps on UiProps {}

  class FooComponent extends UiComponent2<FooProps> {
    @override
    void render() {}
  }
''';

void main() {
  group('boilerplate_util', () {
    group('getOverReactGeneratedPartDirective', () {
      test('returns correct over_react part directive', () {
        final unit = parseAndGetUnit(sourceWithOverReactPart);
        final result = getOverReactGeneratedPartDirective(unit);
        expect(result, isA<PartDirective>());
        expect(result.uri.stringValue, 'foo.over_react.g.dart');
      });

      group('returns null when', () {
        test('PartDirective does not contain `.over_react.g.dart`', () {
          final unit = parseAndGetUnit(sourceWithNonOverReactPart);
          expect(getOverReactGeneratedPartDirective(unit), isNull);
        });

        test('there is no part directive', () {
          final unit = parseAndGetUnit(sourceWithNoPart);
          expect(getOverReactGeneratedPartDirective(unit), isNull);
        });
      });
    });

    group('overReactGeneratedPartDirectiveIsValid', () {
      test('returns true when valid part directive matches the file uri', () async {
        await checkPartValidity();
      });

      group('returns false when', () {
        test('part directive is not over_react', () async {
          await checkPartValidity(
            isPartOverReact: false,
            shouldBeValid: false,
          );
        });

        test('part directive does not match the file uri', () async {
          await checkPartValidity(
            path: 'different_file_path.dart',
            shouldBeValid: false,
          );
        });
      });
    });

    group('addOverReactGeneratedPartDirective', () {
      test('does nothing if there is already a valid part directive', () async {
        final sourceFileEdits = await getSourceFileEdits(
          sourceWithOverReactPart,
          (builder, result) => addOverReactGeneratedPartDirective(builder, result.unit, result.lineInfo, result.uri),
          path: 'foo.dart',
        );
        expect(sourceFileEdits, isEmpty);
      });

      group('adds a valid part directive', () {
        test('when there are no part directives in the file', () async {
          final result = await parseAndGetResolvedUnit(sourceWithNoPart, path: 'foo.dart');
          final sourceChange = await buildFileEdit(result, (builder) {
            addOverReactGeneratedPartDirective(builder, result.unit, result.lineInfo, result.uri);
          });
          final editList = sourceChange.edits.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final offset = result.lineInfo
              .getOffsetOfLineAfter(nextLine(result.unit.directives.last.end, result.lineInfo));
          expect(editList.first.offset, offset, reason: 'should be new line between existing directives and new part');
          expect(editList.first.length, 0, reason: 'nothing is replaced');
          expect(editList.first.replacement, 'part \'foo.over_react.g.dart\';\n\n');
        });

        test('when there is an existing part directive in the file', () async {
          final result = await parseAndGetResolvedUnit(sourceWithNonOverReactPart, path: 'foo.dart');
          final sourceChange = await buildFileEdit(result, (builder) {
            addOverReactGeneratedPartDirective(builder, result.unit, result.lineInfo, result.uri);
          });
          final editList = sourceChange.edits.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final offset = result.lineInfo.getOffsetOfLineAfter(result.unit.directives.last.end);
          expect(editList.first.offset, offset, reason: 'new part should be on the line after existing part');
          expect(editList.first.length, 0, reason: 'nothing is replaced');
          expect(editList.first.replacement, 'part \'foo.over_react.g.dart\';\n\n');
        });
      });

      test('replaces existing over_react part directive if it doesn\'t match file uri', () async {
        final result = await parseAndGetResolvedUnit(sourceWithOverReactPart, path: 'different_file_name.dart');
        final sourceChange = await buildFileEdit(result, (builder) {
          addOverReactGeneratedPartDirective(builder, result.unit, result.lineInfo, result.uri);
        });
        final editList = sourceChange.edits.firstOrNull?.edits;

        expect(editList, isNotNull);
        expect(editList.length, 1, reason: 'there should be one edit in the file');

        final part = getOverReactGeneratedPartDirective(result.unit);
        expect(editList.first.offset, part.offset, reason: 'new part should be on the line after existing part');
        expect(editList.first.length, part.length, reason: 'mismatched part is replaced');
        expect(editList.first.replacement, 'part \'different_file_name.over_react.g.dart\';');
      });
    });

    group('removeOverReactGeneratedPartDirective', () {
      group('does nothing if', () {
        test('there is no part directive in file', () async {
          final sourceFileEdits = await getSourceFileEdits(
            sourceWithNoPart,
            (builder, result) => removeOverReactGeneratedPartDirective(builder, result.unit),
            path: 'foo.dart',
          );
          expect(sourceFileEdits, isEmpty);
        });

        test('there is no over_react part directive in the file', () async {
          final sourceFileEdits = await getSourceFileEdits(
            sourceWithNonOverReactPart,
            (builder, result) => removeOverReactGeneratedPartDirective(builder, result.unit),
            path: 'foo.dart',
          );
          expect(sourceFileEdits, isEmpty);
        });
      });

      group('removes over_react part directive if it exists', () {
        test('', () async {
          final result = await parseAndGetResolvedUnit(sourceWithOverReactPart, path: 'foo.dart');
          final sourceChange = await buildFileEdit(result, (builder) {
            removeOverReactGeneratedPartDirective(builder, result.unit);
          });
          final editList = sourceChange.edits.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final part = getOverReactGeneratedPartDirective(result.unit);
          expect(editList.first.offset, part.offset);
          expect(editList.first.length, part.length);
          expect(editList.first.replacement, '');
        });

        test('and there are other part directives in file', () async {
          final result = await parseAndGetResolvedUnit(/*language=dart*/ r'''
            import 'package:over_react/over_react.dart';
          
            // ignore: uri_has_not_been_generated
            part 'foo.not_over_react.g.dart';
            // ignore: uri_has_not_been_generated
            part 'foo.over_react.g.dart';
            // ignore: uri_has_not_been_generated
            part 'other.not_over_react.g.dart';
            
            UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment
            
            mixin FooProps on UiProps {}
            
            class FooComponent extends UiComponent2<FooProps> {
              @override
              void render() {}
            }
          ''', path: 'foo.dart');
          final sourceChange = await buildFileEdit(result, (builder) {
            removeOverReactGeneratedPartDirective(builder, result.unit);
          });
          final editList = sourceChange.edits.firstOrNull?.edits;

          expect(editList, isNotNull);
          expect(editList.length, 1, reason: 'there should be one edit in the file');

          final part = getOverReactGeneratedPartDirective(result.unit);
          expect(editList.first.offset, part.offset);
          expect(editList.first.length, part.length);
          expect(editList.first.replacement, '');
        });
      });
    });

    group('fixOverReactGeneratedPartDirective', () {
      group('does nothing if', () {
        test('there is no part directive in file', () async {
          final sourceFileEdits = await getSourceFileEdits(
            sourceWithNoPart,
            (builder, result) => fixOverReactGeneratedPartDirective(builder, result.unit, result.uri),
            path: 'foo.dart',
          );
          expect(sourceFileEdits, isEmpty);
        });

        test('part directive in file is valid', () async {
          final sourceFileEdits = await getSourceFileEdits(
            sourceWithOverReactPart,
            (builder, result) => fixOverReactGeneratedPartDirective(builder, result.unit, result.uri),
            path: 'foo.dart',
          );
          expect(sourceFileEdits, isEmpty);
        });

        test('part directive in file is not over_react', () async {
          final sourceFileEdits = await getSourceFileEdits(
            sourceWithNonOverReactPart,
            (builder, result) => fixOverReactGeneratedPartDirective(builder, result.unit, result.uri),
            path: 'foo.dart',
          );
          expect(sourceFileEdits, isEmpty);
        });
      });

      test('replaces over_react part directive that does not match file uri', () async {
        final result = await parseAndGetResolvedUnit(sourceWithOverReactPart, path: 'different_file_name.dart');
        final sourceChange = await buildFileEdit(result, (builder) {
          fixOverReactGeneratedPartDirective(builder, result.unit, result.uri);
        });
        final editList = sourceChange.edits.firstOrNull?.edits;

        expect(editList, isNotNull);
        expect(editList.length, 1, reason: 'there should be one edit in the file');

        final part = getOverReactGeneratedPartDirective(result.unit);
        expect(editList.first.offset, part.offset);
        expect(editList.first.length, part.length);
        expect(editList.first.replacement, 'part \'different_file_name.over_react.g.dart\';');
      });
    });
  });
}

Future<void> checkPartValidity({
  bool shouldBeValid = true,
  bool isPartOverReact = true,
  String path = 'foo.dart',
}) async {
  final result = await parseAndGetResolvedUnit(
    isPartOverReact ? sourceWithOverReactPart : sourceWithNonOverReactPart,
    path: path,
  );
  final part = result.unit.directives.whereType<PartDirective>().firstOrNull;
  expect(part, isNotNull);
  expect(result.uri.toFilePath(), endsWith('/$path'));
  expect(overReactGeneratedPartDirectiveIsValid(part, result.uri), shouldBeValid);
}

Future<List<SourceFileEdit>> getSourceFileEdits(
  String dartSource,
  void Function(DartFileEditBuilder builder, ResolvedUnitResult result) callUtilityFunction, {
  String path = 'foo.dart',
}) async {
  final result = await parseAndGetResolvedUnit(dartSource, path: path);
  final sourceChange = await buildFileEdit(result, (builder) {
    callUtilityFunction(builder, result);
  });
  return sourceChange.edits;
}
