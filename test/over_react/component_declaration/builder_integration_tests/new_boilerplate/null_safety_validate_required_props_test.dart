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

import 'dart:developer';

import 'package:over_react/over_react.dart';
import 'package:react_testing_library/react_testing_library.dart' as rtl;
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart' hide mount;

part 'null_safety_validate_required_props_test.over_react.g.dart';

void main() {
  group('(New boilerplate) validates required props:', () {
    group('non-nullable required prop - throws when a prop is required and not set', () {
      test('on mount', () {
        expect(() {
          rtl.render(
            (ComponentTest()
              ..requiredDynamic = true
              ..requiredNullable = true

                // ..requiredAndLengthLimited = [1,2]
            )(),
          );
        }, throwsA(isA<MissingRequiredPropsError>().having((e) => e.toString(), 'toString value',
            contains('Required prop `requiredNonNullable` is missing.'))));
      });

      test('on re-render', () {
        late rtl.RenderResult view;

        expect(() {
          view = rtl.render(
              (ComponentTest()
                ..required = true
                ..nullable = true
                  // ..requiredAndLengthLimited = [1,2]
              )());
        }, logsNoPropTypeWarnings);

        expect(() {
          view.rerender((ComponentTest()
            ..required = true
              // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable'));
      });
    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() {
          rtl.render((ComponentTest()
            // ..required = null
            ..nullable = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.required'));
      });

      test('on re-render', () {
        late rtl.RenderResult view;

        expect(() {
          view = rtl.render(
              (ComponentTest()
                ..required = true
                ..nullable = true
                // ..requiredAndLengthLimited = [1,2]
              )());
        }, logsNoPropTypeWarnings);

        expect(() {
          view.rerender((ComponentTest()
            // ..required = null
            ..nullable = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.required'));
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() {
          rtl.render((ComponentTest()
            ..required = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable'));
      });

      test('on re-render', () {
        late rtl.RenderResult view;

        expect(() {
          view = rtl.render(
              (ComponentTest()
                ..required = true
                ..nullable = true
                // ..requiredAndLengthLimited = [1,2]
              )());
        }, logsNoPropTypeWarnings);

        expect(() {
          view.rerender((ComponentTest()
            ..required = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable'));
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() {
          rtl.render((ComponentTest()
            ..nullable = true
            ..required = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });

      test('on re-render', () {
        var view = rtl.render((ComponentTest()
            ..required = true
            ..nullable = true
            // ..requiredAndLengthLimited = [1,2]
          )()
        );

        expect(() {
          view.rerender((ComponentTest()
            ..required = true
            ..nullable = true
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() {
          rtl.render((ComponentTest()
            ..nullable = null
            // ..requiredAndLengthLimited = [1,2]
            ..required = true
          )());
        }, logsNoPropTypeWarnings);
      });

      test('on re-render', () {
        late rtl.RenderResult view;

        expect(() {
          view = rtl.render(
              (ComponentTest()
                ..required = true
                ..nullable = true
                // ..requiredAndLengthLimited = [1,2]
              )());
        }, logsNoPropTypeWarnings);

        expect(() {
          view.rerender((ComponentTest()
            ..required = true
            ..nullable = null
            // ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });
    });

    group('when a consumer propType function is also provided', () {
      test('required fires', () {
        expect(() {
          rtl.render((ComponentTest()
            ..nullable = null
            ..required = true
          )());
        }, logsPropValueError('null', 'ComponentTestProps.requiredAndLengthLimited'));
      });

      test('consumer check fires', () {
        expect(() {
          rtl.render((ComponentTest()
            ..required = true
            ..nullable = true
            // ..requiredAndLengthLimited = [1]
          )());
        }, logsPropValueError('1', 'ComponentTestProps.requiredAndLengthLimited'));
      });
    });
  });
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

mixin ComponentTestProps on UiProps {
  late bool required;

  late bool? requiredNullable;

  late dynamic requiredDynamic;

  bool? nullable;
}

class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  // todo test default props
  // todo test other boilerplates
  @override
  render() => Dom.div()();
}
