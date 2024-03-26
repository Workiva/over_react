// Copyright 2019 Workiva Inc.
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

library fragment_component_test;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import 'fixtures/dummy_component.dart';

void main() {
  group('Fragment', () {
    test('renders only its children', () {
      final wrappingDivRef = createRef<Element>();

      renderAttachedToDocument(
        (Dom.div()
          ..ref = wrappingDivRef
        )(
          Fragment()(
            Dom.div()(),
            Dom.div()(),
            Dom.div()(),
            Dom.div()(),
          ),
        ),
      );

      expect(wrappingDivRef.current!.children, hasLength(4));
    });

    test('passes the key properly onto the fragment', () {
      var callCount = 0;
      var jacket = mount(
        (Fragment()..key = 1)(
          (Dummy()
            ..onComponentDidMount = () {
              callCount++;
            })(),
        ),
      );

      expect(callCount, 1);

      jacket.rerender(
        (Fragment()..key = 2)(
          (Dummy()
            ..onComponentDidMount = () {
              callCount++;
            })(),
        ),
      );

      expect(callCount, 2,
          reason:
              'Dummy should have been remounted as a result of Fragment key changing');
    });
  });
}
