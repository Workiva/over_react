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
import 'dart:js';

import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart' show PropTypes;
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'constant_required_accessor_integration_test.over_react.g.dart';

void main() {
  group('(Component2) propTypes properly identifies required props by', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        var component = (ComponentTest()
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]
        );

        testPropTypesWithUiProps(componentProps: component,
            customErrorMessageList: ['ComponentTestProps.required']);
      });

      group('on re-render', () {
        var goodComponent = (ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]);

        var badComponent = (ComponentTest()
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]
        );

        propTypesRerenderTest(firstComponent: goodComponent,
            secondComponent: badComponent);
      });

    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        var component = (ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
        );

        testPropTypesWithUiProps(componentProps: component,
            customErrorMessageList: ['ComponentTestProps.required']);
      });

      group('on re-render', () {
        var goodComponent = (ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]);

        var badComponent = (ComponentTest()
          ..required = null
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]
        );

        propTypesRerenderTest(firstComponent: goodComponent,
            secondComponent: badComponent);
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {

        var component = (ComponentTest()
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        );

        testPropTypesWithUiProps(componentProps: component,
            customErrorMessageList: ['ComponentTestProps.nullable']);
      });

      group('on re-render', () {
        var goodComponent = (ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]);

        var badComponent = (ComponentTest()
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        );

        propTypesRerenderTest(firstComponent: goodComponent,
            secondComponent: badComponent);
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        var component = (ComponentTest()
          ..nullable = true
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        );

        validateNoPropTypeErrors(componentProps: component);
      });

      group('on re-render', () {
        var component = (ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          );

        propTypesRerenderTest(firstComponent: component, secondComponent:
            component, shouldErrorOnReRender: false);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        var component = (ComponentTest()
          ..nullable = null
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        );

        validateNoPropTypeErrors(componentProps: component);
      });

      group('on re-render', () {
        var component = (ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]
        );

        var component2 = (ComponentTest()
          ..required = true
          ..nullable = null
          ..requiredAndLengthLimited = [1,2]
        );

        propTypesRerenderTest(firstComponent: component, secondComponent:
        component2, shouldErrorOnReRender: false);
      });
    });

    group('when a consumer propType function is also provided', () {
      test('required fires', () {
        var component = (ComponentTest()
          ..required = true
          ..nullable = null
        );

        testPropTypesWithUiProps(componentProps: component,
            customErrorMessageList:
                ['ComponentTestProps.requiredAndLengthLimited']);
      });

      test('consumer check fires', () {
        var component = (ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1]
        );

        testPropTypesWithUiProps(componentProps: component,
            customErrorMessageList: ['must have a length of 2']);
      });
    });
  });
}

@Factory()
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  @requiredProp
  var required;

  @nullableRequiredProp
  var nullable;

  @requiredProp
  List requiredAndLengthLimited;
}

@Component2()
class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  get propTypes => {
      getPropKey((ComponentTestProps props) => props.requiredAndLengthLimited, typedPropsFactory):
          (props, propName, componentName, location, propFullName) {
        final length = props.requiredAndLengthLimited?.length;
        if (length != 2) {
          return new PropError.value(length, propName, 'must have a length of 2');
        }
        return null;
      },
    };

  @override
  render() => Dom.div()();
}

