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

part 'required_accessor_integration_test.over_react.g.dart';

void main() {
  group('(Component2) propTypes required props', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        expect(() {
          mount(
            (ComponentTest()
              ..nullable = true
              ..requiredAndLengthLimited = [1,2]
              ..lateProp = true
            )(),
            attachedToDocument: true,
          );
        }, logsPropRequiredError('ComponentTestProps.required', 'This Prop is Required for testing purposes.'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
                ..lateProp = true
              )(),
              attachedToDocument: true
          );
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
              ..nullable = true
              ..requiredAndLengthLimited = [1,2]
              ..lateProp = true
            )()
          );
        }, logsPropRequiredError('ComponentTestProps.required', 'This Prop is Required for testing purposes.'));
      });

    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsPropRequiredError('ComponentTestProps.required', 'This Prop is Required for testing purposes.'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
                ..lateProp = true
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsPropRequiredError('ComponentTestProps.required', 'This Prop is Required for testing purposes.'));
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() {
          render((ComponentTest()
            ..required = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable', 'This prop can be set to null!'));
      });

      test('on re-render', () {
        late TestJacket jacket;

        expect(() {
          jacket = mount(
              (ComponentTest()
                ..required = true
                ..nullable = true
                ..requiredAndLengthLimited = [1,2]
                ..lateProp = true
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsPropRequiredError('ComponentTestProps.nullable', 'This prop can be set to null!'));
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() {
          mount((ComponentTest()
            ..nullable = true
            ..required = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsNoPropTypeWarnings);
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )(),
          attachedToDocument: true,
        );

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
          )());
        }, logsNoPropTypeWarnings);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() {
          render((ComponentTest()
            ..nullable = null
            ..requiredAndLengthLimited = [1,2]
            ..required = true
            ..lateProp = true
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
                ..lateProp = true
              )(),
              attachedToDocument: true);
        }, logsNoPropTypeWarnings);

        expect(() {
          jacket.rerender((ComponentTest()
            ..required = true
            ..nullable = null
            ..requiredAndLengthLimited = [1,2]
            ..lateProp = true
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
            ..lateProp = true
          )());
        }, logsPropValueError('null', 'ComponentTestProps.requiredAndLengthLimited'));
      });

      test('consumer check fires', () {
        expect(() {
          mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1]
            ..lateProp = true
          )());
        }, logsPropValueError('1', 'ComponentTestProps.requiredAndLengthLimited'));
      });
    });

    group('for late props', () {
      test('does not throw on invocation', () {
        expect(() {
          (ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )();
        },
            returnsNormally);
      });

      test('does not throw on mount', () {
        expect(() => render(ComponentTest()
          ..nullable = null
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        ), returnsNormally);
      });
    });
  });
}

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  @Accessor(isRequired: true, requiredErrorMessage: 'This Prop is Required for testing purposes.')
  dynamic required;

  @Accessor(isRequired: true, isNullable: true, requiredErrorMessage: 'This prop can be set to null!')
  dynamic nullable;

  @Accessor(isRequired: true, isNullable: false, requiredErrorMessage: 'This Prop Array is Required for testing purposes.')
  List? requiredAndLengthLimited;

  late bool lateProp;
}

@Component2()
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
