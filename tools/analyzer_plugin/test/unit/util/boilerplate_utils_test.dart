import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_utils.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

main() {
  group('boilerplate_util', () {
    group('getOverReactGeneratedPartDirective', () {
      test('returns correct PartDirective', () {
        final unit = parseAndGetUnit(/*language=dart*/ r'''
          import 'package:over_react/over_react.dart';
  
          part 'foo.over_react.g.dart';
          
          UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
          
          mixin FooProps on UiProps {}
          
          class FooComponent extends UiComponent2<FooProps> {
            @override
            render() {}
          }
        ''');
        final result = getOverReactGeneratedPartDirective(unit);
        expect(result, isA<PartDirective>());
        expect(result.uri?.stringValue, 'foo.over_react.g.dart');
      });

      group('returns null when', () {
        test('PartDirective does not contain `.over_react.g.dart`', () {
          final unit = parseAndGetUnit(/*language=dart*/ r'''
            import 'package:over_react/over_react.dart';
    
            part 'foo.not_over_react.g.dart';
            
            UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
            
            mixin FooProps on UiProps {}
            
            class FooComponent extends UiComponent2<FooProps> {
              @override
              render() {}
            }
          ''');
          final result = getOverReactGeneratedPartDirective(unit);
          expect(result, isA<PartDirective>());
          expect(result.uri?.stringValue, 'foo.over_react.g.dart');
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
  });
}
