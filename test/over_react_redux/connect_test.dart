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

library abstract_transition_test;

import 'dart:html';
import 'dart:js';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:test/test.dart';
import 'dart:js_util' as js_util;

import '../test_util/test_util.dart';
import './fixtures/basic.dart';
import './fixtures/store.dart';

//part 'connect_test.over_react.g.dart';

/// Main entry point for AbstractTransition testing
main() {
  group('connect', () {

    test('Custom Context', (){});

    group('Provider Usage', (){
      test('throws without a provider', () {
        UiFactory<BasicProps> ConnectedBasic = connect<AppState, BasicProps>()(Basic);
        expect(() => render(ConnectedBasic()('test')), throwsA(anything));
      });

      test('does not throw with a provider', () {
        UiFactory<BasicProps> ConnectedBasic = connect<AppState, BasicProps>()(Basic);
        var renderedInstance = render(
          (ReduxProvider()..store = store)(
            ConnectedBasic()('test'),
          ),
        );
        expect(renderedInstance, isNot(throwsA(anything)));
      });
    });

    group('forwardRef when', (){
      test('true: forwards the ref to the wrapped component', () {
        UiFactory<BasicProps> ConnectedBasic = connect<AppState, BasicProps>(forwardRef: true)(Basic);
        var basicRef;
        render(
          (ReduxProvider()..store = store)(
            (ConnectedBasic()..ref=(ref){basicRef = ref;})('test'),
          ),
        );
        expect(getDartComponent(basicRef), isA<BasicComponent>());
      });

      test('false: leaves the ref on the connect hoc', () {
        UiFactory<BasicProps> ConnectedBasic = connect<AppState, BasicProps>()(Basic);
        var basicRef;
        render(
          (ReduxProvider()..store = store)(
            (ConnectedBasic()..id="test"..ref=(ref){basicRef = ref;})('test'),
          ),
        );
        print(basicRef);
        expect(basicRef, 'Connect(Basic)');
      });
    });

    group('mapStateToProps', (){});

    group('mapDispatchToProps', (){});

    group('mergeProps', (){});

    group('areOwnPropsEqual', (){});

    group('areStatePropsEqual', (){});

    group('areMergedPropsEqual', (){});
  });
}


