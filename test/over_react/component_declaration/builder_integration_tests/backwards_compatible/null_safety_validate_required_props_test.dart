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

part 'null_safety_validate_required_props_test.over_react.g.dart';

void main() {
  group('(backwards compatible with Dart 1) validates required props:', () {
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

    // Do not test the validation escape hatches because this boilerplate version has existing error throwing for required props.
  }, tags: 'ddc');
}

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  late bool requiredNonNullable;

  late bool? requiredNullable;

  bool? nullable;
}

@Component()
class ComponentTestComponent extends UiComponent<ComponentTestProps> {
  @override
  render() => Dom.div()();
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class ComponentTestProps extends _$ComponentTestProps with _$ComponentTestPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForComponentTestProps;
}
