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

library over_react.component_declaration.transformer_integration_tests.abstract_accessor_integration_test;

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

main() {
  group('transformed abstract accessor integration:', () {
    group('@AbstractProps()', () {
      group('generates prop getters/setters with', () {
        test('the props class name as a namespace and the prop name as the key by default', () {
          var mixinsTest;

          mixinsTest = new TestAbstractPropsSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('TestAbstractProps.stringProp', 'test'));

          mixinsTest = new TestAbstractPropsSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('TestAbstractProps.dynamicProp', 2));

          mixinsTest = new TestAbstractPropsSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('TestAbstractProps.untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = new TestAbstractPropsSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('TestAbstractProps.custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = new TestAbstractPropsSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = new TestAbstractPropsSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates prop getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the prop name as the key by default', () {
          var mixinsTest;

          mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**stringProp', 'test'));

          mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('custom mixin namespace**dynamicProp', 2));

          mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('custom mixin namespace**untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = new TestCustomNamespaceAbstractPropsSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });

    group('@AbstractState()', () {
      group('generates state getters/setters with', () {
        test('the state class name as a namespace and the state name as the key by default', () {
          var mixinsTest;

          mixinsTest = new TestAbstractStateSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('TestAbstractState.stringState', 'test'));

          mixinsTest = new TestAbstractStateSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('TestAbstractState.dynamicState', 2));

          mixinsTest = new TestAbstractStateSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('TestAbstractState.untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = new TestAbstractStateSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('TestAbstractState.custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = new TestAbstractStateSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = new TestAbstractStateSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates state getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the state name as the key by default', () {
          var mixinsTest;

          mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**stringState', 'test'));

          mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('custom mixin namespace**dynamicState', 2));

          mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('custom mixin namespace**untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = new TestCustomNamespaceAbstractStateSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });
  });
}


@AbstractProps()
abstract class TestAbstractProps extends UiProps {
  String stringProp;
  dynamic dynamicProp;
  var untypedProp;

  @Accessor(key: 'custom key!')
  var customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceProp;
}

class TestAbstractPropsSubclass extends TestAbstractProps {
  @override final Map props = {};
  @override bool get $isClassGenerated => true;

  @override String get propKeyNamespace => null;
  @override ReactComponentFactoryProxy get componentFactory => null;
}


@AbstractProps(keyNamespace: 'custom mixin namespace**')
abstract class TestCustomNamespaceAbstractProps extends UiProps {
  String stringProp;
  dynamic dynamicProp;
  var untypedProp;

  @Accessor(key: 'custom key!')
  var customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceProp;
}

class TestCustomNamespaceAbstractPropsSubclass extends TestCustomNamespaceAbstractProps {
  @override final Map props = {};
  @override bool get $isClassGenerated => true;

  @override String get propKeyNamespace => null;
  @override ReactComponentFactoryProxy get componentFactory => null;
}


@AbstractState()
abstract class TestAbstractState extends UiState {
  String stringState;
  dynamic dynamicState;
  var untypedState;

  @Accessor(key: 'custom key!')
  var customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceState;
}

class TestAbstractStateSubclass extends TestAbstractState {
  @override final Map state = {};
  @override bool get $isClassGenerated => true;
}


@AbstractState(keyNamespace: 'custom mixin namespace**')
abstract class TestCustomNamespaceAbstractState extends UiState {
  String stringState;
  dynamic dynamicState;
  var untypedState;

  @Accessor(key: 'custom key!')
  var customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceState;
}

class TestCustomNamespaceAbstractStateSubclass extends TestCustomNamespaceAbstractState {
  @override final Map state = {};
  @override bool get $isClassGenerated => true;
}
