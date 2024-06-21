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

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'constant_required_accessor_integration_test.over_react.g.dart';

void main() {
  group('(New boilerplate) propTypes properly identifies required props by', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        expect(() {
          mount(
            (ComponentTest()
              ..nullable = true
              ..requiredAndLengthLimited = [1,2]
            )(),
            attachedToDocument: true,
          );
        }, logsPropRequiredError('ComponentTestProps.required'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )()
          );
        }, logsPropRequiredError('ComponentTestProps.required'));
      });
    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.required'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.required'));
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..required = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable'));
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..nullable = true
            ..required = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..nullable = null
            ..requiredAndLengthLimited = [1,2]
            ..required = true
          )());
        }, logsNoPropTypeWarnings);
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..nullable = null
            ..requiredAndLengthLimited = [1,2]
          )());
        }, logsNoPropTypeWarnings);
      });
    });

    group('when a consumer propType function is also provided', () {
      test('required fires', () {
        expect(() {
          mount((ComponentTest()
            ..nullable = null
            ..required = true
          )());
        }, logsPropValueError('null', 'ComponentTestProps.requiredAndLengthLimited'));
      });

      test('consumer check fires', () {
        expect(() {
          mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1]
          )());
        }, logsPropValueError('1', 'ComponentTestProps.requiredAndLengthLimited'));
      });
    });
  });
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

mixin ComponentTestProps on UiProps {
  @requiredProp
  dynamic required;

  @nullableRequiredProp
  dynamic nullable;

  @requiredProp
  List? requiredAndLengthLimited;
}

class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  get propTypes => {
      keyForProp((p) => p.requiredAndLengthLimited): (props, info) {
        final length = props.requiredAndLengthLimited?.length;
        if (length != 2) {
          return PropError.value(length, info.propName, 'must have a length of 2');
        }
        return null;
      },
    };

  @override
  render() => Dom.div()();
}
