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
import 'package:test/test.dart';

part 'accessor_mixin_integration_test.over_react.g.dart';

main() {
  group('(New boilerplate) accessor for props/state mixin integration:', () {
    group('@PropsMixin()', () {
      group('generates prop getters/setters with', () {
        test('the props class name as a namespace and the prop name as the key by default', () {
          var mixinsTest = Test()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('TestPropsMixin.stringProp', 'test'));

          mixinsTest = Test()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('TestPropsMixin.dynamicProp', 2));

          mixinsTest = Test()..untypedProp = false;
          expect(mixinsTest.props, containsPair('TestPropsMixin.untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = Test()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('TestPropsMixin.custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = Test()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = Test()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates prop getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the prop name as the key by default', () {
          var mixinsTest = TestCustomNamespace()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**stringProp', 'test'));

          mixinsTest = TestCustomNamespace()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('custom mixin namespace**dynamicProp', 2));

          mixinsTest = TestCustomNamespace()..untypedProp = false;
          expect(mixinsTest.props, containsPair('custom mixin namespace**untypedProp', false));

          mixinsTest = TestCustomNamespace()..propsAnnotationProp = 'test';
          expect(mixinsTest.props,
              containsPair('custom mixin namespace from @Props**propsAnnotationProp', 'test'));
        });

        test('custom prop keys', () {
          var mixinsTest = TestCustomNamespace()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = TestCustomNamespace()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = TestCustomNamespace()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });

    group('@StateMixin()', () {
      group('generates state getters/setters with', () {
        test('the state class name as a namespace and the state name as the key by default', () {
          var mixinsTest = TestState()..stringState = 'test';
          expect(mixinsTest.state, containsPair('TestStateMixin.stringState', 'test'));

          mixinsTest = TestState()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('TestStateMixin.dynamicState', 2));

          mixinsTest = TestState()..untypedState = false;
          expect(mixinsTest.state, containsPair('TestStateMixin.untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = TestState()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('TestStateMixin.custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestState()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestState()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates state getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the state name as the key by default', () {
          var mixinsTest = TestCustomNamespaceState()..stringState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**stringState', 'test'));

          mixinsTest = TestCustomNamespaceState()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('custom mixin namespace**dynamicState', 2));

          mixinsTest = TestCustomNamespaceState()..untypedState = false;
          expect(mixinsTest.state, containsPair('custom mixin namespace**untypedState', false));

          mixinsTest = TestCustomNamespaceState()..stateAnnotationState = 'test';
          expect(mixinsTest.state,
              containsPair('custom mixin namespace from @State**stateAnnotationState', 'test'));
        });

        test('custom state keys', () {
          var mixinsTest = TestCustomNamespaceState()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestCustomNamespaceState()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestCustomNamespaceState()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });
  });
}

// fixme use props mapview or component instead of this
class TestUiStateBaseClass extends UiState {
  @override
  final Map state = {};

  @override
  bool get $isClassGenerated => true;
}

UiFactory<TestPropsMixin> Test = _$Test; // ignore: undefined_identifier

mixin TestPropsMixin on UiProps {
  String stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}

// ---

UiFactory<TestCustomNamespaceProps> TestCustomNamespace =
    _$TestCustomNamespace;  // ignore: undefined_identifier

@PropsMixin(keyNamespace: 'custom mixin namespace**')
mixin TestCustomNamespacePropsMixin on UiProps {
  String stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}

@Props(keyNamespace: 'custom mixin namespace from @Props**')
mixin TestCustomNamespaceWithPropsAnnotationPropsMixin on UiProps {
  String propsAnnotationProp;
}

class TestCustomNamespaceProps = UiProps
    with TestCustomNamespacePropsMixin, TestCustomNamespaceWithPropsAnnotationPropsMixin;

// ---

mixin TestStateMixin on UiState {
  String stringState;
  dynamic dynamicState;
  var untypedState; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceState;
}

// ignore: deprecated_member_use_from_same_package
class TestState = TestUiStateBaseClass with TestStateMixin, $TestStateMixin;

// ---

@StateMixin(keyNamespace: 'custom mixin namespace**')
mixin TestCustomNamespaceStateMixin on UiState {
  String stringState;
  dynamic dynamicState;
  var untypedState; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceState;
}

@State(keyNamespace: 'custom mixin namespace from @State**')
mixin TestCustomNamespaceWithStateAnnotationStateMixin on UiState {
  String stateAnnotationState;
}

class TestCustomNamespaceState = TestUiStateBaseClass
    with
        TestCustomNamespaceStateMixin,
        // ignore: deprecated_member_use_from_same_package
        $TestCustomNamespaceStateMixin,
        TestCustomNamespaceWithStateAnnotationStateMixin,
        // ignore: deprecated_member_use_from_same_package
        $TestCustomNamespaceWithStateAnnotationStateMixin;
