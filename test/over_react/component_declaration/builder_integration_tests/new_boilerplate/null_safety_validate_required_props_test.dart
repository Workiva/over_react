// @dart=2.11
// Copyright 2023 Workiva Inc.
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

import 'package:over_react/over_react.dart';
import 'package:react_testing_library/react_testing_library.dart' as rtl;
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'null_safety_validate_required_props_test.over_react.g.dart';

void main() {
  group('(New boilerplate) validates required props:', () {
    group('non-nullable required prop', () {
      group('throws when a prop is required and not set', () {
        group('on invocation', () {
          test('via call()', () {
            expect(() {
              (ComponentTest()
                ..requiredNullable = true
              )();
            },
                throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                    'toString value',
                    contains(
                        'Required prop `requiredNonNullable` is missing.'))));
          });

          test('via build()', () {
            expect(() {
              (ComponentTest()
                ..requiredNullable = true
              ).build();
            },
                throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                    'toString value',
                    contains(
                        'Required prop `requiredNonNullable` is missing.'))));
          });
        });

        test('on mount', () {
          expect(() {
            rtl.render((ComponentTest()
              ..requiredNullable = true
            )());
          },
              throwsA(isA<MissingRequiredPropsError>().having(
                  (e) => e.toString(),
                  'toString value',
                  contains(
                      'Required prop `requiredNonNullable` is missing.'))));
        });

        test('on re-render', () {
           rtl.RenderResult view;

          expect(() {
            view = rtl.render((ComponentTest()
              ..requiredNonNullable = true
              ..requiredNullable = true
            )());
          }, returnsNormally);

          expect(() {
            view.rerender((ComponentTest()
              ..requiredNullable = true
            )());
          },
              throwsA(isA<MissingRequiredPropsError>().having(
                  (e) => e.toString(),
                  'toString value',
                  contains(
                      'Required prop `requiredNonNullable` is missing.'))));
        });
      });

      test('does not throw when the prop is set', () {
        expect(() {
          rtl.render((ComponentTest()
            ..requiredNonNullable = true
            ..requiredNullable = true
          )());
        }, returnsNormally);
      });
    });

    group('nullable required prop', () {
      group('throws when a prop is required and not set', () {
        group('on invocation', () {
          test('via call()', () {
            expect(() {
              (ComponentTest()
                ..requiredNonNullable = true
              )();
            },
                throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                    'toString value',
                    contains('Required prop `requiredNullable` is missing.'))));
          });

          test('via build()', () {
            expect(() {
              (ComponentTest()
                ..requiredNonNullable = true
              ).build();
            },
                throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                    'toString value',
                    contains('Required prop `requiredNullable` is missing.'))));
          });
        });

        test('on mount', () {
          expect(() {
            rtl.render((ComponentTest()
              ..requiredNonNullable = true
            )());
          },
              throwsA(isA<MissingRequiredPropsError>().having(
                  (e) => e.toString(),
                  'toString value',
                  contains('Required prop `requiredNullable` is missing.'))));
        });

        test('on re-render', () {
           rtl.RenderResult view;

          expect(() {
            view = rtl.render((ComponentTest()
              ..requiredNonNullable = true
              ..requiredNullable = true
            )());
          }, returnsNormally);

          expect(() {
            view.rerender((ComponentTest()
              ..requiredNonNullable = true
            )());
          },
              throwsA(isA<MissingRequiredPropsError>().having(
                  (e) => e.toString(),
                  'toString value',
                  contains('Required prop `requiredNullable` is missing.'))));
        });
      });

      test('does not throw when the prop is set to null', () {
        expect(() {
          rtl.render((ComponentTest()
            ..requiredNonNullable = true
            ..requiredNullable = null
          )());
        }, returnsNormally);
      });

      test('does not throw when the prop is set', () {
        expect(() {
          rtl.render((ComponentTest()
            ..requiredNonNullable = true
            ..requiredNullable = true
          )());
        }, returnsNormally);
      });
    });

    test('@disableRequiredPropValidation annotation turns off validation for specific props', () {
      expect(() {
        rtl.render((ComponentTest()
          ..requiredNonNullable = true
          ..requiredNullable = true
        )());
      }, allOf(returnsNormally,
        logsPropRequiredError('ComponentTestProps.disabledRequiredProp'),
        logsPropRequiredError('ComponentTestProps.disabledNullableRequiredProp'),
        logsPropRequiredError('ComponentTestProps.ref'),
      ));
    });

    test('disableRequiredPropValidation method turns off validation for component usage', () {
      expect(() {
        rtl.render((ComponentTest()
          ..disableRequiredPropValidation()
        )());
      }, allOf(returnsNormally,
        logsPropRequiredError('ComponentTestProps.disabledRequiredProp'),
        logsPropRequiredError('ComponentTestProps.disabledNullableRequiredProp'),
        logsPropRequiredError('ComponentTestProps.ref'),
        logsPropRequiredError('ComponentTestProps.requiredNonNullable'),
        logsPropRequiredError('ComponentTestProps.requiredNullable'),
      ));
    });

    group('required props in multiple mixins', () {
      test('throw an error when a prop in the first mixin is missing', () {
        expect(() {
          (MultipleMixinsTest()
            ..requiredNullable = true
            ..secondRequiredProp = true
          )();
        },
            throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                'toString value',
                contains(
                    'Required prop `requiredNonNullable` is missing.'))));
      });

      test('throw an error when a prop in the second mixin is missing', () {
        expect(() {
          (MultipleMixinsTest()
            ..requiredNullable = true
            ..requiredNonNullable = true
          )();
        },
            throwsA(isA<MissingRequiredPropsError>().having(
                    (e) => e.toString(),
                'toString value',
                contains(
                    'Required prop `secondRequiredProp` is missing.'))));
      });

      test('does not throw when all required props are set or ignored via @Props(disableRequiredPropValidation: ...)', () {
        expect(() {
          (MultipleMixinsTest()
            ..requiredNullable = true
            ..requiredNonNullable = true
            ..secondRequiredProp = true
          )();
        },
          returnsNormally);
      });
    });

    group('@Props(disableRequiredPropValidation) turns off validation for specific props', () {
      // Test both class and function components to ensure so we have test coverage that the builder wires up
      // disableRequiredPropValidation correctly for each.
      test('for function components', () {
        expect(() {
          rtl.render(FunctionWrapperTest()());
        }, returnsNormally);
      });

      test('for class components', () {
        expect(() {
          rtl.render(ClassWrapperTest()());
        }, returnsNormally);
      });
    });

    group('validation is disabled for defaulted class component props', () {
      test('by default', () {
        final factory = DefaultedInClassTest;
        expect(() => rtl.render(factory()()), throwsA(isA<MissingRequiredPropsError>()),
            reason: 'test setup check: test component throws when missing other required props');
        // `requiredDefaulted` and should is defaulted, it's not required
        expect(() => rtl.render((factory()..required = true)()),
            allOf(returnsNormally, logsNoPropTypeWarnings));
      });

      test('unless consumers opt out via @Props(disableValidationForClassDefaultProps: false)', () {
        final factory = DefaultedInClassOptedOutTest;
        expect(() => rtl.render(factory()()), throwsA(isA<MissingRequiredPropsError>()),
            reason: 'test setup check: test component throws when missing other required props');
        expect(
            () => rtl.render((factory()..required = true)()),
            throwsA(isA<MissingRequiredPropsError>().having((e) => e.toString(), 'toString value',
                contains('Required prop `requiredDefaulted` is missing.'))));
      });

      test('and does not interfere with ignores in annotation ', () {
        final factory = DefaultedInClassOptedOutWithIgnoresTest;
        expect(() => rtl.render(factory()()), throwsA(isA<MissingRequiredPropsError>()),
            reason: 'test setup check: test component throws when missing other required props');
        expect(
            () => rtl.render((factory()
              ..required = true
              ..requiredDefaulted = true
            )()),
            allOf(
                returnsNormally,
                logsPropRequiredError(
                    'DefaultedInClassOptedOutWithIgnoresTestProps.requiredDisabledByName')));
      });
    });
  }, tags: 'ddc');

  test('(New boilerplate) validates required props: does not throw in dart2js', () {
    expect(() {
      rtl.render(ComponentTest()());
      rtl.render(ComponentTest().build());
    },
    returnsNormally);
  }, tags: 'no-ddc');
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props(disableRequiredPropValidation: {'testIgnoreOnMixin'})
mixin ComponentTestProps on UiProps {
   bool requiredNonNullable;

   bool requiredNullable;

  @disableRequiredPropValidation
   bool disabledRequiredProp;

  @disableRequiredPropValidation
   bool disabledNullableRequiredProp;

  @disableRequiredPropValidation
  @override
   dynamic ref;

  bool nullable;

   bool testIgnoreOnMixin;
}

class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  render() => Dom.div()();
}

UiFactory<MultipleMixinsTestProps> MultipleMixinsTest = uiFunction(
  (props) {},
  _$MultipleMixinsTestConfig, // ignore: undefined_identifier
);

mixin MultipleMixinsTestPropsMixin on UiProps {
   bool secondRequiredProp;
}

@Props(disableRequiredPropValidation: {'testIgnoreOnMixin'})
class MultipleMixinsTestProps = UiProps with MultipleMixinsTestPropsMixin, ComponentTestProps;


mixin WrapperTestPropsMixin on UiProps {
   bool thirdRequiredProp;
}

UiFactory<FunctionWrapperTestProps> FunctionWrapperTest = uiFunction(
      (props) {},
  _$FunctionWrapperTestConfig, // ignore: undefined_identifier
);


@Props(disableRequiredPropValidation: {'thirdRequiredProp', 'secondRequiredProp', 'requiredNonNullable', 'requiredNullable', 'testIgnoreOnMixin'})
class FunctionWrapperTestProps = UiProps with WrapperTestPropsMixin, MultipleMixinsTestPropsMixin, ComponentTestProps;


UiFactory<ClassWrapperTestProps> ClassWrapperTest = castUiFactory(_$ClassWrapperTest); // ignore: undefined_identifier

mixin ClassWrapperTestPropsMixin on UiProps {
   bool thirdRequiredProp;
}

@Props(disableRequiredPropValidation: {'thirdRequiredProp', 'secondRequiredProp', 'requiredNonNullable', 'requiredNullable', 'testIgnoreOnMixin'})
class ClassWrapperTestProps = UiProps with WrapperTestPropsMixin, MultipleMixinsTestPropsMixin, ComponentTestProps;

class ClassWrapperTestComponent extends UiComponent2<ClassWrapperTestProps> {
  @override
  render() {}
}

UiFactory<DefaultedInClassTestProps> DefaultedInClassTest = castUiFactory(_$DefaultedInClassTest); // ignore: undefined_identifier

mixin DefaultedInClassTestProps on UiProps {
   bool required;
   bool requiredDefaulted;
}

class DefaultedInClassTestPropsComponent extends UiComponent2<DefaultedInClassTestProps> {
  @override
  get defaultProps => (newProps()..requiredDefaulted = true);

  @override
  render() => Dom.div()();
}

UiFactory<DefaultedInClassOptedOutTestProps> DefaultedInClassOptedOutTest = castUiFactory(_$DefaultedInClassOptedOutTest); // ignore: undefined_identifier

@Props(disableValidationForClassDefaultProps: false)
mixin DefaultedInClassOptedOutTestProps on UiProps {
   bool required;
   bool requiredDefaulted;
}

class DefaultedInClassOptedOutTestPropsComponent extends UiComponent2<DefaultedInClassOptedOutTestProps> {
  @override
  get defaultProps => (newProps()..requiredDefaulted = true);

  @override
  render() => Dom.div()();
}

UiFactory<DefaultedInClassOptedOutWithIgnoresTestProps> DefaultedInClassOptedOutWithIgnoresTest = castUiFactory(_$DefaultedInClassOptedOutWithIgnoresTest); // ignore: undefined_identifier

@Props(
  disableValidationForClassDefaultProps: false,
  disableRequiredPropValidation: {'requiredDisabledByName'},
)
mixin DefaultedInClassOptedOutWithIgnoresTestProps on UiProps {
   bool required;
   bool requiredDefaulted;
   bool requiredDisabledByName;
}

class DefaultedInClassOptedOutWithIgnoresTestPropsComponent extends UiComponent2<DefaultedInClassOptedOutWithIgnoresTestProps> {
  @override
  get defaultProps => (newProps()..requiredDefaulted = true);

  @override
  render() => Dom.div()();
}
