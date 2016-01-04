library ui_core.component_declaration.component_type_checking_test;

import 'dart:js';

import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_type_checking.dart';
import 'package:web_skin_dart/ui_core.dart';

import 'component_type_checking_test/one_level_wrapper.dart';
import 'component_type_checking_test/test_a.dart';
import 'component_type_checking_test/test_b.dart';
import 'component_type_checking_test/two_level_wrapper.dart';
import 'component_type_checking_test/type_inheritance/parent.dart';
import 'component_type_checking_test/type_inheritance/subsubtype.dart';
import 'component_type_checking_test/type_inheritance/subtype.dart';
import 'package:react/react_client.dart';

main() {
  group('component type checking:', () {
    group('getComponentTypeFromAlias', () {
      group('passes through valid component types:', () {
        test('String', () {
          expect(getComponentTypeFromAlias('div'), equals('div'));
        });

        test('JsFunction', () {
          var jsFunction = new JsFunction.withThis((_) {});
          expect(getComponentTypeFromAlias(jsFunction), same(jsFunction));
        });
      });

      test('returns the JsFunction type for a ReactDartComponentFactoryProxy', () {
        var jsFunction = new JsFunction.withThis((_) {});
        var factory = new ReactDartComponentFactoryProxy(jsFunction);
        expect(getComponentTypeFromAlias(factory), same(jsFunction));
      });

      test('returns the String type for a ReactDomComponentFactoryProxy', () {
        var factory = new ReactDomComponentFactoryProxy('div');
        expect(getComponentTypeFromAlias(factory), equals('div'));
      });

      test('returns the JsFunction type for an aliased ReactDartComponentFactoryProxy', () {
        var jsFunction = new JsFunction.withThis((_) {});
        var factory = new ReactDartComponentFactoryProxy(jsFunction);

        var typeAlias = new Object();
        registerComponentTypeAlias(factory, typeAlias);

        expect(getComponentTypeFromAlias(typeAlias), same(jsFunction));
      });

      test('returns null for an unregistered/invalid type alias', () {
        var unregisteredTypeAlias = new Object();
        expect(getComponentTypeFromAlias(unregisteredTypeAlias), isNull);
      });

      group('returns null and does not throw when passed', () {
        var type;

        test('null', () {
          expect(() {
            type = getComponentTypeFromAlias(null);
          }, isNot(throws));

          expect(type, isNull);
        });

        test('a number', () {
          expect(() {
            type = getComponentTypeFromAlias(2);
          }, isNot(throws));

          expect(type, isNull);
        });

        test('a bool', () {
          expect(() {
            type = getComponentTypeFromAlias(true);
          }, isNot(throws));

          expect(type, isNull);
        });
      });
    });

    group('getParentTypes', () {
      group('getParentTypes', () {
        group('returns an iterable of the parent types', () {
          setUpAll(() {
            // Force lazy-instantiation of factory variables so that component class type aliases
            // are registered when we read them in the `getComponentTypeFromAlias` calls.
            TestParent()();
            TestSubtype()();
            TestSubsubtype()();
          });

          test('that is empty for a component without parent types', () {
            expect(getParentTypes(getComponentTypeFromAlias(TestParent)), isEmpty);
          });

          test('that contains a component\'s parent type', () {
            expect(
                getParentTypes(getComponentTypeFromAlias(TestSubtype)),
                orderedEquals([
                  getComponentTypeFromAlias(TestParent),
                ])
            );
          });

          test('that contains all of a component\'s parent types', () {
            expect(
                getParentTypes(getComponentTypeFromAlias(TestSubsubtype)),
                orderedEquals([
                  getComponentTypeFromAlias(TestSubtype),
                  getComponentTypeFromAlias(TestParent),
                ])
            );
          });
        });

        test('asserts that the input is a valid component type', () {
          expect(() {
            // Fully iterate the result by calling toList().
            getParentTypes(new Object()).toList();
          }, throwsA(const isInstanceOf<AssertionError>()));
        }, testOn: 'dart-vm');
      });
    });

    group('isComponentOfType()', () {
      group('returns expected result when given', (){
        test('null', () {
          expect(isComponentOfType(null, TestA), isFalse);
        });

        test('a component and an invalid/unregistered type alias', () {
          expect(isComponentOfType(TestA()(), new Object()), isFalse);
        });

        test('a component and its factory', () {
          expect(isComponentOfType(TestA()(), TestA), isTrue);
        });

        test('a component and its ReactComponentFactory', () {
          expect(isComponentOfType(TestA()(), TestA().componentFactory), isTrue);
        });

        test('a component and its component class', () {
          expect(isComponentOfType(TestA()(), TestAComponent), isTrue);
        });

        test('a component and its component type', () {
          expect(isComponentOfType(TestA()(), TestA()()['type']), isTrue);
        });

        test('a component and a factory for a different component', () {
          expect(isComponentOfType(TestA()(), TestB), isFalse);
        });

        test('a component and a ReactComponentFactory for a different component', () {
          expect(isComponentOfType(TestA()(), TestB().componentFactory), isFalse);
        });

        test('a component and a component class for a different component', () {
          expect(isComponentOfType(TestA()(), TestBComponent), isFalse);
        });

        test('a component and a component type for a different component', () {
          expect(isComponentOfType(TestA()(), TestB()()['type']), isFalse);
        });

        test('a DOM component and a factory for a Dart component', () {
          expect(isComponentOfType(Dom.div()(), TestB), isFalse);
        });

        test('a DOM component and its tagName', () {
          expect(isComponentOfType(Dom.div()(), 'div'), isTrue);
        });

        test('a DOM component and its ReactComponentFactory', () {
          expect(isComponentOfType(Dom.div()(), Dom.div().componentFactory), isTrue);
        });

        group('a subtype component', () {
          group('(matchParentTypes: true)', () {
            test('and its own factory', () {
              expect(isComponentOfType(TestSubsubtype()(), TestSubsubtype), isTrue);
            });

            test('and the factory of its parent', () {
              expect(isComponentOfType(TestSubsubtype()(), TestSubtype), isTrue);
            });

            test('and the factory of its grandparent', () {
              expect(isComponentOfType(TestSubsubtype()(), TestParent), isTrue);
            });
          });

          group('(matchParentTypes: false)', () {
            test('and its own factory', () {
              expect(isComponentOfType(TestSubsubtype()(), TestSubsubtype, matchParentTypes: false), isTrue);
            });

            test('and the factory of its parent', () {
              expect(isComponentOfType(TestSubsubtype()(), TestSubtype, matchParentTypes: false), isFalse);
            });

            test('and the factory of its grandparent', () {
              expect(isComponentOfType(TestSubsubtype()(), TestParent, matchParentTypes: false), isFalse);
            });
          });
        });

        test('a component and the factory of its subtype', () {
          expect(isComponentOfType(TestParent()(), TestSubtype), isFalse);
        });

        group('a component that nests the component factory', () {
          group('one level deep and traverseWrappers is', () {
            test('true', () {
              expect(isComponentOfType(
                  OneLevelWrapper()(TestA()()),
                  TestA
              ), isTrue);
            });

            test('false', () {
              expect(isComponentOfType(
                  OneLevelWrapper()(TestA()()),
                  TestA,
                  traverseWrappers: false
              ), isFalse);
            });
          });

          group('two levels deep and traverseWrappers is', () {
            test('true', () {
              expect(isComponentOfType(
                  TwoLevelWrapper()(OneLevelWrapper()(TestA()())),
                  TestA
              ), isTrue);
            });

            test('false', () {
              expect(isComponentOfType(
                  TwoLevelWrapper()(OneLevelWrapper()(TestA()())),
                  TestA,
                  traverseWrappers: false
              ), isFalse);
            });
          });

          test('and does not throw when children is null', () {
            expect(() => isComponentOfType(OneLevelWrapper()(), TestA), isNot(throws));
          });
        });
      });
    });

    group('isValidElementOfType()', () {
      group('returns expected result when given', (){
        test('null', () {
          expect(isValidElementOfType(null, TestA), isFalse);
        });

        test('a String', () {
          expect(isValidElementOfType('Test String', TestA), isFalse);
        });

        test('a List', () {
          expect(isValidElementOfType(['item1', 'item2'], TestA), isFalse);
        });

        test('a ReactComponent', () {
          expect(isValidElementOfType(Dom.div()(), Dom.div().componentFactory), isTrue);
        });
      });
    });
  });
}
