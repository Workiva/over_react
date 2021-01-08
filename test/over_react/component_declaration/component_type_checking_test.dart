// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ignore_for_file: deprecated_member_use_from_same_package
library over_react.component_declaration.component_type_checking_test;

import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart' show connect;
import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:over_react/src/component_declaration/component_base.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:test/test.dart';

import '../../test_util/one_level_wrapper.dart';
import '../../test_util/two_level_wrapper.dart';
import 'component_type_checking_test/test_a.dart';
import 'component_type_checking_test/test_b.dart';
import 'component_type_checking_test/type_inheritance/abstract_inheritance/abstract.dart';
import 'component_type_checking_test/type_inheritance/abstract_inheritance/extendedtype.dart';
import 'component_type_checking_test/type_inheritance/parent.dart';
import 'component_type_checking_test/type_inheritance/subsubtype.dart';
import 'component_type_checking_test/type_inheritance/subtype.dart';

import '../../test_util/component2/one_level_wrapper2.dart';
import '../../test_util/component2/two_level_wrapper2.dart';
import 'component2_type_checking_test/test_a2.dart';
import 'component2_type_checking_test/test_b2.dart';
import 'component2_type_checking_test/type_inheritance/abstract_inheritance/abstract2.dart';
import 'component2_type_checking_test/type_inheritance/abstract_inheritance/extendedtype2.dart';
import 'component2_type_checking_test/type_inheritance/parent2.dart';
import 'component2_type_checking_test/type_inheritance/subsubtype2.dart';
import 'component2_type_checking_test/type_inheritance/subtype2.dart';
import 'component2_type_checking_test/type_inheritance/subsubtype_of_component1.dart';
import 'component2_type_checking_test/type_inheritance/subtype_of_component1.dart';

import 'function_type_checking_test/components.dart' as function;

main() {
  group('Component1', () {
    testComponentTypeChecking(
      TestParent: TestParent,
      TestSubtype: TestSubtype,
      TestSubsubtype: TestSubsubtype,
      TestExtendtype: TestExtendtype,
      TestAbstractComponent: TestAbstractComponent,
      TestA: TestA,
      TestAComponent: TestAComponent,
      TestB: TestB,
      TestBComponent: TestBComponent,
      OneLevelWrapper: OneLevelWrapper,
      TwoLevelWrapper: TwoLevelWrapper,
    );
  });

  group('Component2', () {
    testComponentTypeChecking(
      isComponent2: true,
      TestParent: TestParent2,
      TestSubtype: TestSubtype2,
      TestSubsubtype: TestSubsubtype2,
      TestExtendtype: TestExtendtype2,
      TestAbstractComponent: TestAbstract2Component,
      TestA: TestA2,
      TestAComponent: TestA2Component,
      TestB: TestB2,
      TestBComponent: TestB2Component,
      OneLevelWrapper: OneLevelWrapper2,
      TwoLevelWrapper: TwoLevelWrapper2,
    );
  });

  group('Component2 (subtypeOf: Component1)', () {
    testComponentTypeChecking(
      isComponent2: true,
      TestParent: TestParent,
      TestSubtype: TestSubtypeOfComponent1,
      TestSubsubtype: TestSubsubtypeOfComponent1,
      TestExtendtype: TestExtendtype2,
      TestAbstractComponent: TestAbstract2Component,
      TestA: TestA2,
      TestAComponent: TestA2Component,
      TestB: TestB2,
      TestBComponent: TestB2Component,
      OneLevelWrapper: OneLevelWrapper2,
      TwoLevelWrapper: TwoLevelWrapper2,
    );
  });

  group('Function component', () {
    testComponentTypeChecking(
      isComponent2: true,
      TestParent: function.TestParent,
      TestSubtype: function.TestSubtype,
      TestSubsubtype: function.TestSubsubtype,
      TestExtendtype: function.TestExtendtype,
      TestAbstractComponent: TestAbstract2Component,
      TestA: function.TestA,
      TestAComponent: null,
      TestB: function.TestB,
      TestBComponent: null,
      OneLevelWrapper: function.OneLevelWrapper,
      TwoLevelWrapper: function.TwoLevelWrapper,
    );

    // This is a regression test for issues encountered in an earlier implementation
    // where auto-detecting the subtypeOf arg resulted in the UiFactory itself
    // being treated as the subtype, causing type checking to fail.
    test('works when subtyping a component whose factory hasn\'t been initialized yet', () {
      final element = function.TestUninitializedParent()();
      expect(isComponentOfType(element, function.DoNotReferenceThisFactoryExceptForInASingleTest), isTrue);
      expect(isComponentOfType(element, TestAbstract2Component), isTrue);
    });
  });

  group('private utilities', () {
    group('getComponentTypeFromAlias', () {
      group('passes through valid component types:', () {
        test('String', () {
          expect(getComponentTypeFromAlias('div'), equals('div'));
        });

        test('ReactClass', () {
          var reactClass = createTestReactClass();
          expect(getComponentTypeFromAlias(reactClass), same(reactClass));
        });
      });

      test('returns the ReactClass type for a ReactDartComponentFactoryProxy', () {
        var reactClass = createTestReactClass();
        // ignore: deprecated_member_use
        var factory = ReactDartComponentFactoryProxy(reactClass);
        expect(getComponentTypeFromAlias(factory), same(reactClass));
      });

      test('returns the ReactClass type for a ReactDartComponentFactoryProxy2', () {
        var reactClass = createTestReactClass();
        var factory = ReactDartComponentFactoryProxy2(reactClass);
        expect(getComponentTypeFromAlias(factory), same(reactClass));
      });

      test('returns the String type for a ReactDomComponentFactoryProxy', () {
        var factory = ReactDomComponentFactoryProxy('div');
        expect(getComponentTypeFromAlias(factory), equals('div'));
      });

      test('returns the ReactClass type for an aliased ReactDartComponentFactoryProxy', () {
        var reactClass = createTestReactClass();
        // ignore: deprecated_member_use
        var factory = ReactDartComponentFactoryProxy(reactClass);

        var typeAlias = Object();
        registerComponentTypeAlias(factory, typeAlias);

        expect(getComponentTypeFromAlias(typeAlias), same(reactClass));
      });

      test('returns the ReactClass type for an aliased ReactDartComponentFactoryProxy2', () {
        var reactClass = createTestReactClass();
        var factory = ReactDartComponentFactoryProxy2(reactClass);

        var typeAlias = Object();
        registerComponentTypeAlias(factory, typeAlias);

        expect(getComponentTypeFromAlias(typeAlias), same(reactClass));
      });

      test('returns null for an unregistered/invalid type alias', () {
        var unregisteredTypeAlias = Object();
        expect(getComponentTypeFromAlias(unregisteredTypeAlias), isNull);
      });

      group('returns null and does not throw when passed', () {
        dynamic type;

        test('null', () {
          expect(() {
            type = getComponentTypeFromAlias(null);
          }, returnsNormally);

          expect(type, isNull);
        });

        test('a number', () {
          expect(() {
            type = getComponentTypeFromAlias(2);
          }, returnsNormally);

          expect(type, isNull);
        });

        test('a bool', () {
          expect(() {
            type = getComponentTypeFromAlias(true);
          }, returnsNormally);

          expect(type, isNull);
        });
      });
    });

    void sharedAliasTests(void Function(dynamic alias) testBody) {
      group('an alias', () {
        test('a UiFactory', () {
          // This need to be a new instance every test run, which is why we
          // don't set it up within the group.
          final UiFactory alias = ([_]) => null; // ignore: prefer_function_declarations_over_variables
          final factory = ReactDartComponentFactoryProxy2(createTestReactClass());
          registerComponentTypeAlias(factory, alias);
          testBody(alias);
        });

        test('an arbitrary object', () {
          // This need to be a new instance every test run, which is why we
          // don't set it up within the group.
          final alias = Object();
          final factory = ReactDartComponentFactoryProxy2(createTestReactClass());
          registerComponentTypeAlias(factory, alias);
          testBody(alias);
        });
      });
    }

    void sharedBadTypeTests(void Function(dynamic badType) testBody) {
      group('a bad type', () {
        test('null', () => testBody(null));
        test('a primitive', () => testBody(1));
        test('a string', () => testBody('I am a string'));
      });
    }

    Matcher throwsAssertionErrorContaining(String messageSubstring) =>
        throwsA(isA<AssertionError>().having((e) => e.toString(),
            'toString() value', contains(messageSubstring)));

    group('setComponentTypeMeta', () {
      // other behavior is tested functionally as part of the shared suite and other callers like registerComponent

      group('asserts that the type argument is not', () {
        sharedAliasTests((alias) {
          expect(() => setComponentTypeMeta(alias, parentType: null),
              throwsAssertionErrorContaining('must pass in the raw JS component type'));
        });

        sharedBadTypeTests((badType) {
          expect(() => setComponentTypeMeta(badType, parentType: null),
              throwsAssertionErrorContaining(badType is String
                  ? 'cannot set type metadata on strings'
                  : 'must pass in the raw JS component type'));
        });
      }, tags: 'no-dart2js');
    });

    group('ComponentTypeMeta constrictor', () {
      // other behavior is tested functionally as part of the shared suite and other callers like setComponentTypeMeta and its callers

      group('asserts that the parentType argument is not', () {
        sharedAliasTests((alias) {
          expect(() => ComponentTypeMeta(parentType: alias),
              throwsAssertionErrorContaining('must pass in the raw JS component type'));
        });

        sharedBadTypeTests((badType) {
          expect(() => ComponentTypeMeta(parentType: badType),
              throwsAssertionErrorContaining('must pass in the raw JS component type'));
        });
      });
    });
  });
}

testComponentTypeChecking({
  bool isComponent2 = false,
  @required UiFactory TestParent,
  @required UiFactory TestSubtype,
  @required UiFactory TestSubsubtype,
  @required UiFactory TestExtendtype,
  @required Type TestAbstractComponent,
  @required UiFactory TestA,
  @required Type TestAComponent,
  @required UiFactory TestB,
  @required Type TestBComponent,
  @required UiFactory OneLevelWrapper,
  @required UiFactory TwoLevelWrapper,
}) {
  group('type checking:', () {
    group('getParentTypes', () {
      group('getParentTypes', () {
        group('returns an iterable of the parent types', () {
          setUpAll(() {
            // Force lazy-instantiation of factory variables so that component class type aliases
            // are registered when we read them in the `getComponentTypeFromAlias` calls.
            TestParent()();
            TestSubtype()();
            TestSubsubtype()();
            TestExtendtype()();
          });

          test('that is empty for a component without parent types', () {
            expect(getParentTypes(getComponentTypeFromAlias(TestParent)), isEmpty);
          });

          test('that contains a component\'s parent type', () {
            expect(
                getParentTypes(getComponentTypeFromAlias(TestSubtype)),
                orderedEquals([
                  getComponentTypeFromAlias(TestParent),
                ]));
          });

          test('that contains all of a component\'s parent types', () {
            expect(
                getParentTypes(getComponentTypeFromAlias(TestSubsubtype)),
                orderedEquals([
                  getComponentTypeFromAlias(TestSubtype),
                  getComponentTypeFromAlias(TestParent),
                ]));
          });

          test('that contains all of a component\'s parent abstract types', () {
            expect(
                getParentTypes(getComponentTypeFromAlias(TestExtendtype)),
                orderedEquals([
                  getComponentTypeFromAlias(TestAbstractComponent),
                ]));
          });
        });

        test('asserts that the input is a valid component type', () {
          expect(() {
            // Fully iterate the result by calling toList().
            getParentTypes(Object()).toList();
          }, throwsA(isA<AssertionError>()));
        }, tags: 'ddc');
      });
    });

    group('isComponentOfType()', () {
      group('returns expected result when given', () {
        test('null', () {
          expect(isComponentOfType(null, TestA), isFalse);
        });

        test('a component and an invalid/unregistered type alias', () {
          expect(isComponentOfType(TestA()(), Object()), isFalse);
        });

        test('a component and its factory', () {
          expect(isComponentOfType(TestA()(), TestA), isTrue);
        });

        test('a component and its ReactComponentFactory', () {
          expect(isComponentOfType(TestA()(), TestA().componentFactory), isTrue);
        });

        if (TestAComponent != null) {
          test('a component and its component class', () {
            expect(isComponentOfType(TestA()(), TestAComponent), isTrue);
          });
        }

        test('a component and its component type', () {
          expect(isComponentOfType(TestA()(), TestA()().type), isTrue);
        });

        test('a component and a factory for a different component', () {
          expect(isComponentOfType(TestA()(), TestB), isFalse);
        });

        test('a component and a ReactComponentFactory for a different component', () {
          expect(isComponentOfType(TestA()(), TestB().componentFactory), isFalse);
        });

        if (TestBComponent != null) {
          test('a component and a component class for a different component', () {
            expect(isComponentOfType(TestA()(), TestBComponent), isFalse);
          });
        }

        test('a component and a component type for a different component', () {
          expect(isComponentOfType(TestA()(), TestB()().type), isFalse);
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

        group('a subtype, of an abstract component, component', () {
          group('(matchParentTypes: true)', () {
            test('and its own factory', () {
              expect(isComponentOfType(TestExtendtype()(), TestExtendtype), isTrue);
            });

            test('and the factory of its parent', () {
              expect(isComponentOfType(TestExtendtype()(), TestAbstractComponent), isTrue);
            });
          });

          group('(matchParentTypes: false)', () {
            test('and its own factory', () {
              expect(isComponentOfType(TestExtendtype()(), TestExtendtype, matchParentTypes: false), isTrue);
            });

            test('and the factory of its parent', () {
              expect(isComponentOfType(TestExtendtype()(), TestAbstractComponent, matchParentTypes: false), isFalse);
            });
          });
        });

        test('a component and the factory of its subtype', () {
          expect(isComponentOfType(TestParent()(), TestSubtype), isFalse);
        });

        group('a component that nests the component factory', () {
          group('one level deep and traverseWrappers is', () {
            test('true', () {
              expect(isComponentOfType(OneLevelWrapper()(TestA()()), TestA), isTrue);
            });

            test('false', () {
              expect(isComponentOfType(OneLevelWrapper()(TestA()()), TestA, traverseWrappers: false), isFalse);
            });
          });

          group('two levels deep and traverseWrappers is', () {
            test('true', () {
              expect(isComponentOfType(TwoLevelWrapper()(OneLevelWrapper()(TestA()())), TestA), isTrue);
            });

            test('false', () {
              expect(isComponentOfType(TwoLevelWrapper()(OneLevelWrapper()(TestA()())), TestA, traverseWrappers: false),
                  isFalse);
            });
          });

          test('and does not throw when children is null', () {
            expect(() => isComponentOfType(OneLevelWrapper()(), TestA), returnsNormally);
          });
        });

        group('a higher-order component created by', () {
          if (TestA().componentFactory.type.dartComponentVersion == '1') {
            test('forwardRef', () {
              expect(() => forwardRef((props, ref) => null)(TestA), throwsArgumentError);
            });

            test('connect', () {
              expect(() => connect(mapStateToProps: (state) => {})(TestA), throwsArgumentError);
            });
          } else {
            test('forwardRef', () {
              final hocFactory = forwardRef((props, ref) => null)(TestA);
              expect(isComponentOfType(hocFactory()(), TestA), isTrue);
            });

            test('connect', () {
              final hocFactory = connect(mapStateToProps: (state) => {})(TestA);
              expect(isComponentOfType(hocFactory()(), TestA), isTrue);
            });
          }
        });
      });
    });

    group('isValidElementOfType()', () {
      group('returns expected result when given', () {
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

react_interop.ReactClass createTestReactClass() {
  // ignore: deprecated_member_use
  return react_interop.React.createClass(react_interop.ReactClassConfig(render: allowInterop(() => false)))..dartDefaultProps = const {};
}
