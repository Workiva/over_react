import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_utils.dart';
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
          final unit = parseAndGetUnit(/*language=dart*/ r'''
          import 'package:over_react/over_react.dart';
          
          UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
          
          mixin FooProps on UiProps {}
          
          class FooComponent extends UiComponent2<FooProps> {
            @override
            render() {}
          }
        ''');
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
