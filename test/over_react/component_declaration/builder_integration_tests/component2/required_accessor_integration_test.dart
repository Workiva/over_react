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
import 'package:test/test.dart';
import 'package:react/react_client/react_interop.dart' show PropTypes;

import '../../../../test_util/test_util.dart';

part 'required_accessor_integration_test.over_react.g.dart';

void main() {
  group('(Component2) propTypes properly identifies required props by', () {
    bool consoleErrorCalled;
    var consoleErrorMessage;
    JsFunction originalConsoleError;

    setUp(() {
      consoleErrorCalled = false;
      consoleErrorMessage = null;

      // PropTypes by default will only throw a specific error one time per Component Class.
      // This resets the cache after each test so it throws again.
      // See: https://www.npmjs.com/package/prop-types#proptypesresetwarningcache
      PropTypes.resetWarningCache();

      originalConsoleError = context['console']['error'];
      context['console']['error'] = new JsFunction.withThis((self, message, arg1, arg2, arg3) {
        consoleErrorCalled = true;
        consoleErrorMessage = message;
        originalConsoleError.apply([message], thisArg: self);
      });
    });

    tearDown(() {
      context['console']['error'] = originalConsoleError;
    });
    group('throwing when a prop is required and not set', () {

      test('on mount', () {
        mount(
          (ComponentTest()..nullable = true)(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.required'));
        expect(consoleErrorMessage, contains('This Prop is Required for testing purposes.'));
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');

        jacket.rerender((ComponentTest()
            ..nullable = true
          )()
        );

        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.required'));
        expect(consoleErrorMessage, contains('This Prop is Required for testing purposes.'));
      });

    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        render((ComponentTest()
            ..required = null
            ..nullable = true
          )());

        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.required'));
        expect(consoleErrorMessage, contains('This Prop is Required for testing purposes.'));
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');

        jacket.rerender((ComponentTest()
              ..required = null
              ..nullable = true
            )());

        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.required'));
        expect(consoleErrorMessage, contains('This Prop is Required for testing purposes.'));
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        render((ComponentTest()..required = true)());
        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.nullable'));
        expect(consoleErrorMessage, contains('This prop can be set to null!'));
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');

        jacket.rerender((ComponentTest()..required = true)());

        expect(consoleErrorCalled, isTrue, reason: 'should have outputted a warning');
        expect(consoleErrorMessage, contains('ComponentTestProps.nullable'));
        expect(consoleErrorMessage, contains('This prop can be set to null!'));
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        render((ComponentTest()
          ..nullable = true
          ..required = true
        )());
        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');

        jacket.rerender((ComponentTest()
          ..required = true
          ..nullable = true
        )());

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
       render((ComponentTest()
          ..nullable = null
          ..required = true
        )());
        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');
      });

      test('on re-render', () {
        var jacket = mount((ComponentTest()
            ..required = true
            ..nullable = true
          )(),
          attachedToDocument: true,
        );

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');

        jacket.rerender((ComponentTest()
          ..required = true
          ..nullable = null
        )());

        expect(consoleErrorCalled, isFalse, reason: 'should not have outputted a warning but found: $consoleErrorMessage');
      });
    });
  });
}

@Factory()
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  @Accessor(isRequired: true, requiredErrorMessage: 'This Prop is Required for testing purposes.')
  var required;

  @Accessor(isRequired: true, isNullable: true, requiredErrorMessage: 'This prop can be set to null!')
  var nullable;
}

@Component2()
class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  render() => Dom.div()();
}

