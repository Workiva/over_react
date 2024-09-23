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
              (RequiredPropsTest()
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
              (RequiredPropsTest()
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
            rtl.render((RequiredPropsTest()
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
          late rtl.RenderResult view;

          expect(() {
            view = rtl.render((RequiredPropsTest()
              ..requiredNonNullable = true
              ..requiredNullable = true
            )());
          }, returnsNormally);

          expect(() {
            view.rerender((RequiredPropsTest()
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
          rtl.render((RequiredPropsTest()
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
              (RequiredPropsTest()
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
              (RequiredPropsTest()
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
            rtl.render((RequiredPropsTest()
              ..requiredNonNullable = true
            )());
          },
              throwsA(isA<MissingRequiredPropsError>().having(
                  (e) => e.toString(),
                  'toString value',
                  contains('Required prop `requiredNullable` is missing.'))));
        });

        test('on re-render', () {
          late rtl.RenderResult view;

          expect(() {
            view = rtl.render((RequiredPropsTest()
              ..requiredNonNullable = true
              ..requiredNullable = true
            )());
          }, returnsNormally);

          expect(() {
            view.rerender((RequiredPropsTest()
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
          rtl.render((RequiredPropsTest()
            ..requiredNonNullable = true
            ..requiredNullable = null
          )());
        }, returnsNormally);
      });

      test('does not throw when the prop is set', () {
        expect(() {
          rtl.render((RequiredPropsTest()
            ..requiredNonNullable = true
            ..requiredNullable = true
          )());
        }, returnsNormally);
      });
    });

    test('@disableRequiredPropValidation annotation turns off validation for specific props', () {
      expect(() {
        rtl.render((RequiredPropsTest()
          ..requiredNonNullable = true
          ..requiredNullable = true
        )());
      }, allOf(returnsNormally, logsNoPropTypeWarnings));
    });

    test('disableRequiredPropValidation method turns off validation for component usage', () {
      expect(() {
        rtl.render((RequiredPropsTest()
          ..disableRequiredPropValidation()
        )());
      }, allOf(returnsNormally, logsNoPropTypeWarnings));
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

      test('does not throw or warn when all required props are set or ignored via @Props(disableRequiredPropValidation: ...)', () {
        expect(() {
          (MultipleMixinsTest()
            ..requiredNullable = true
            ..requiredNonNullable = true
            ..secondRequiredProp = true
          )();
        },
          allOf(returnsNormally, logsNoPropTypeWarnings));
      });
    });

    group('@Props(disableRequiredPropValidation) turns off validation and prop type warnings for specific props', () {
      // Test both class and function components to ensure so we have test coverage that the builder wires up
      // disableRequiredPropValidation correctly for each.
      test('for function components', () {
        expect(() {
          rtl.render(FunctionWrapperTest()());
        }, allOf(returnsNormally, logsNoPropTypeWarnings));
      });

      test('for class components - UiComponent', () {
        expect(() {
          rtl.render(ClassWrapperTest()());
        }, allOf(returnsNormally, logsNoPropTypeWarnings));
      });

      test('for class components - UiComponent2', () {
        expect(() {
          rtl.render(ClassWrapperTest2()());
        }, allOf(returnsNormally, logsNoPropTypeWarnings));

        expect(() {
          rtl.render(ClassWrapperTest2()());
        }, allOf(returnsNormally, logsNoPropTypeWarnings));
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
                logsNoPropTypeWarnings));
      });
    });
  }, tags: 'ddc');

  test('(New boilerplate) validates required props: does not throw in dart2js', () {
    expect(() {
      rtl.render(RequiredPropsTest()());
      rtl.render(RequiredPropsTest().build());
    },
    returnsNormally);
  }, tags: 'no-ddc');
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<RequiredPropsTestProps> RequiredPropsTest = _$RequiredPropsTest;

@Props(disableRequiredPropValidation: {'testIgnoreOnMixin'})
mixin RequiredPropsTestProps on UiProps {
  late bool requiredNonNullable;

  late bool? requiredNullable;

  @disableRequiredPropValidation
  late bool disabledRequiredProp;

  @disableRequiredPropValidation
  late bool? disabledNullableRequiredProp;

  @disableRequiredPropValidation
  @override
  late dynamic ref;

  bool? nullable;

  late bool testIgnoreOnMixin;
}

class RequiredPropsTestComponent extends UiComponent2<RequiredPropsTestProps> {
  @override
  render() => Dom.div()();
}

UiFactory<MultipleMixinsTestProps> MultipleMixinsTest = uiFunction(
  (props) {},
  _$MultipleMixinsTestConfig, // ignore: undefined_identifier
);

mixin MultipleMixinsTestPropsMixin on UiProps {
  late bool secondRequiredProp;
}

@Props(disableRequiredPropValidation: {'testIgnoreOnMixin'})
class MultipleMixinsTestProps = UiProps with MultipleMixinsTestPropsMixin, RequiredPropsTestProps;


mixin WrapperTestPropsMixin on UiProps {
  late bool thirdRequiredProp;
}

UiFactory<FunctionWrapperTestProps> FunctionWrapperTest = uiFunction(
      (props) {},
  _$FunctionWrapperTestConfig, // ignore: undefined_identifier
);


@Props(disableRequiredPropValidation: {'thirdRequiredProp', 'secondRequiredProp', 'requiredNonNullable', 'requiredNullable', 'testIgnoreOnMixin'})
class FunctionWrapperTestProps = UiProps with WrapperTestPropsMixin, MultipleMixinsTestPropsMixin, RequiredPropsTestProps;

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ClassWrapperTestProps> ClassWrapperTest = _$ClassWrapperTest;

// ignore: undefined_class, mixin_of_non_class
class ClassWrapperTestProps extends _$ClassWrapperTestProps with _$ClassWrapperTestPropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForClassWrapperTestProps;
}

@Props(disableRequiredPropValidation: {'thirdRequiredProp'})
//// ignore: mixin_of_non_class,undefined_class
class _$ClassWrapperTestProps extends UiProps {
  late bool thirdRequiredProp;
}

// ignore: deprecated_member_use_from_same_package
@Component()
// ignore: deprecated_member_use_from_same_package
class ClassWrapperTestComponent extends UiComponent<ClassWrapperTestProps> {
  @override
  render() {
    return Dom.div()();
  }
}

UiFactory<ClassWrapperTest2Props> ClassWrapperTest2 = castUiFactory(_$ClassWrapperTest2); // ignore: undefined_identifier

mixin ClassWrapperTest2PropsMixin on UiProps {
  late bool thirdRequiredProp;
}

@Props(disableRequiredPropValidation: {'thirdRequiredProp', 'secondRequiredProp', 'requiredNonNullable', 'requiredNullable', 'testIgnoreOnMixin'})
class ClassWrapperTest2Props = UiProps with ClassWrapperTest2PropsMixin, MultipleMixinsTestPropsMixin, RequiredPropsTestProps;

class ClassWrapperTest2Component extends UiComponent2<ClassWrapperTest2Props> {
  @override
  render() {}
}

UiFactory<DefaultedInClassTestProps> DefaultedInClassTest = castUiFactory(_$DefaultedInClassTest); // ignore: undefined_identifier

mixin DefaultedInClassTestProps on UiProps {
  late bool required;
  late bool requiredDefaulted;
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
  late bool required;
  late bool requiredDefaulted;
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
  late bool required;
  late bool requiredDefaulted;
  late bool requiredDisabledByName;
}

class DefaultedInClassOptedOutWithIgnoresTestPropsComponent extends UiComponent2<DefaultedInClassOptedOutWithIgnoresTestProps> {
  @override
  get defaultProps => (newProps()..requiredDefaulted = true);

  @override
  render() => Dom.div()();
}
