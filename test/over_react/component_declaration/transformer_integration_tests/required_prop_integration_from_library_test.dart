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

library over_react.component_declaration.transformer_integration_tests.required_prop_integration_with_library;

import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:test/test.dart';

import '../../../test_util/test_util.dart';
import 'test_fixtures/test_component_library.dart';

void requiredPropsFromLibraryIntegrationTest() {
  group('properly identifies required props from library component by', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        expect(() => render(ComponentInLibrary()..nullable = true),
            throwsPropError_Required('ComponentInLibraryProps.required', 'This Prop is Required for testing purposes.')
        );
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentInLibrary()..nullable = true)(), mountNode),
            throwsPropError_Required('ComponentInLibraryProps.required', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentInLibrary()
          ..required = null
          ..nullable = true
        ), throwsPropError_Required('ComponentInLibraryProps.required'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(
                () => react_dom.render((ComponentInLibrary()
              ..required = null
              ..nullable = true
            )(), mountNode),
            throwsPropError_Required('ComponentInLibraryProps.required', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() => render(ComponentInLibrary()..required = true),
            throwsPropError_Required('ComponentInLibraryProps.nullable'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentInLibrary()..required = true)(), mountNode),
            throwsPropError_Required('ComponentInLibraryProps.nullable', 'This prop can be set to null!')
        );
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() => render(ComponentInLibrary()
          ..nullable = true
          ..required = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode), returnsNormally);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentInLibrary()
          ..nullable = null
          ..required = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentInLibrary()
          ..required = true
          ..nullable = null
        )(), mountNode), returnsNormally);
      });
    });
  });
}