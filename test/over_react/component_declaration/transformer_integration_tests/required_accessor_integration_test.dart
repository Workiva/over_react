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
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:test/test.dart';

import '../../../test_util/test_util.dart';

// ignore: uri_has_not_been_generated
part 'required_accessor_integration_test.over_react.g.dart';

void main() {
  group('properly identifies required props by', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()..nullable = true),
            throwsPropError_Required('ComponentTestProps.required', 'This Prop is Required for testing purposes.')
        );
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()..nullable = true)(), mountNode),
            throwsPropError_Required('ComponentTestProps.required', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..required = null
          ..nullable = true
        ), throwsPropError_Required('ComponentTestProps.required'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(
            () => react_dom.render((ComponentTest()
              ..required = null
              ..nullable = true
            )(), mountNode),
            throwsPropError_Required('ComponentTestProps.required', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()..required = true),
            throwsPropError_Required('ComponentTestProps.nullable'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()..required = true)(), mountNode),
            throwsPropError_Required('ComponentTestProps.nullable', 'This prop can be set to null!')
        );
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..nullable = true
          ..required = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode), returnsNormally);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..nullable = null
          ..required = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()
          ..required = true
          ..nullable = null
        )(), mountNode), returnsNormally);
      });
    });
  });
}

@Factory()
// ignore: undefined_identifier
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

@Props()
class _$ComponentTestProps extends UiProps {
  @Accessor(isRequired: true, requiredErrorMessage: 'This Prop is Required for testing purposes.')
  var required;

  @Accessor(isRequired: true, isNullable: true, requiredErrorMessage: 'This prop can be set to null!')
  var nullable;
}

@Component()
class ComponentTestComponent extends UiComponent<ComponentTestProps> {
  @override
  render() => Dom.div()();
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class ComponentTestProps extends _$ComponentTestProps with _$ComponentTestPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForComponentTestProps;
}
