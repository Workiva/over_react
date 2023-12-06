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
          late rtl.RenderResult view;

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
          late rtl.RenderResult view;

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
        logsPropRequiredError('ComponentTestProps.requiredDynamic'),
      ));
    });
  }, tags: 'ddc');
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

mixin ComponentTestProps on UiProps {
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
}

class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  render() => Dom.div()();
}
