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
    List<String> consoleErrors;
    JsFunction originalConsoleError;

    setUp(() {
      // PropTypes by default will only throw a specific error one time per Component Class.
      // This resets the cache after each test so it throws again.
      // See: https://www.npmjs.com/package/prop-types#proptypesresetwarningcache
      PropTypes.resetWarningCache();

      originalConsoleError = context['console']['error'];
      consoleErrors = [];
      context['console']['error'] = JsFunction.withThis((self, message) {
        consoleErrors.add(message);
        originalConsoleError.apply([message], thisArg: self);
      });
    });

    tearDown(() {
      context['console']['error'] = originalConsoleError;
    });
    group('throwing when a prop is required and not set', () {

      test('on mount', () {
        mount(
          (ComponentTest()
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.required')]);
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');

        jacket.rerender((ComponentTest()
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )()
        );

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.required')]);
      });

    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        render((ComponentTest()
            ..required = null
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )());

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.required')]);
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');

        jacket.rerender((ComponentTest()
              ..required = null
              ..nullable = true
              ..requiredAndLengthLimited = [1,2]
            )());

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.required')]);
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        render((ComponentTest()
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        )());
        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.nullable')]);
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');

        jacket.rerender((ComponentTest()
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        )());

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.nullable')]);
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        render((ComponentTest()
          ..nullable = true
          ..required = true
          ..requiredAndLengthLimited = [1,2]
        )());
        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');

        jacket.rerender((ComponentTest()
          ..required = true
          ..nullable = true
          ..requiredAndLengthLimited = [1,2]
        )());

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
       render((ComponentTest()
          ..nullable = null
          ..requiredAndLengthLimited = [1,2]
          ..required = true
        )());
        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1,2]
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');

        jacket.rerender((ComponentTest()
          ..required = true
          ..nullable = null
          ..requiredAndLengthLimited = [1,2]
        )());

        expect(consoleErrors, isEmpty, reason: 'should not have outputted a warning but found: $consoleErrors');
      });
    });

    group('when a consumer propType function is also provided', () {
      test('required fires', () {
       render((ComponentTest()
            ..nullable = null
            ..required = true
          )());

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('ComponentTestProps.requiredAndLengthLimited')]);
      });

      test('consumer check fires', () {
        render((ComponentTest()
            ..required = true
            ..nullable = true
            ..requiredAndLengthLimited = [1]
          )());

        expect(consoleErrors, isNotEmpty, reason: 'should have outputted a warning');
        expect(consoleErrors, [contains('must have a length of 2')]);
      });
    });
  });
}

@Factory()
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  @requiredProp
  dynamic required;

  @nullableRequiredProp
  dynamic nullable;

  @requiredProp
  List requiredAndLengthLimited;
}

@Component2()
class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  get propTypes => {
      getPropKey((props) => props.requiredAndLengthLimited, typedPropsFactory):
          (props, propName, componentName, location, propFullName) {
        final length = props.requiredAndLengthLimited?.length;
        if (length != 2) {
          return PropError.value(length, propName, 'must have a length of 2');
        }
        return null;
      },
    };

  @override
  render() => Dom.div()();
}

