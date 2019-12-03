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

@TestOn('browser')

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

// ignore: uri_has_not_been_generated
part 'abstract_accessor_integration_test.over_react.g.dart';

main() {
  group('(backwards compatible with Dart 1) transformed abstract accessor integration:', () {
    group('@AbstractProps()', () {
      group('generates prop getters/setters with', () {
        test('the props class name as a namespace and the prop name as the key by default', () {
          TestAbstractPropsSubclass mixinsTest;

          mixinsTest = TestAbstractPropsSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('TestAbstractProps.stringProp', 'test'));

          mixinsTest = TestAbstractPropsSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('TestAbstractProps.dynamicProp', 2));

          mixinsTest = TestAbstractPropsSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('TestAbstractProps.untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = TestAbstractPropsSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('TestAbstractProps.custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = TestAbstractPropsSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = TestAbstractPropsSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates prop getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the prop name as the key by default', () {
          TestCustomNamespaceAbstractPropsSubclass mixinsTest;

          mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**stringProp', 'test'));

          mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('custom mixin namespace**dynamicProp', 2));

          mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('custom mixin namespace**untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = TestCustomNamespaceAbstractPropsSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });

    group('@AbstractState()', () {
      group('generates state getters/setters with', () {
        test('the state class name as a namespace and the state name as the key by default', () {
          TestAbstractStateSubclass mixinsTest;

          mixinsTest = TestAbstractStateSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('TestAbstractState.stringState', 'test'));

          mixinsTest = TestAbstractStateSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('TestAbstractState.dynamicState', 2));

          mixinsTest = TestAbstractStateSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('TestAbstractState.untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = TestAbstractStateSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('TestAbstractState.custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestAbstractStateSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestAbstractStateSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates state getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the state name as the key by default', () {
          TestCustomNamespaceAbstractStateSubclass mixinsTest;

          mixinsTest = TestCustomNamespaceAbstractStateSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**stringState', 'test'));

          mixinsTest = TestCustomNamespaceAbstractStateSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('custom mixin namespace**dynamicState', 2));

          mixinsTest = TestCustomNamespaceAbstractStateSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('custom mixin namespace**untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = TestCustomNamespaceAbstractStateSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestCustomNamespaceAbstractStateSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestCustomNamespaceAbstractStateSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });
  });
}


@AbstractProps()
abstract class _$TestAbstractProps extends UiProps {
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

class TestAbstractPropsSubclass extends TestAbstractProps {
  @override final Map props = {};
  @override bool get $isClassGenerated => true;

  @override String get propKeyNamespace => null;
  @override ReactComponentFactoryProxy get componentFactory => null;
}


@AbstractProps(keyNamespace: 'custom mixin namespace**')
abstract class _$TestCustomNamespaceAbstractProps extends UiProps {
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

class TestCustomNamespaceAbstractPropsSubclass extends TestCustomNamespaceAbstractProps {
  @override final Map props = {};
  @override bool get $isClassGenerated => true;

  @override String get propKeyNamespace => null;
  @override ReactComponentFactoryProxy get componentFactory => null;
}


@AbstractState()
abstract class _$TestAbstractState extends UiState {
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

class TestAbstractStateSubclass extends TestAbstractState {
  @override final Map state = {};
  @override bool get $isClassGenerated => true;
}


@AbstractState(keyNamespace: 'custom mixin namespace**')
abstract class _$TestCustomNamespaceAbstractState extends UiState {
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

class TestCustomNamespaceAbstractStateSubclass extends TestCustomNamespaceAbstractState {
  @override final Map state = {};
  @override bool get $isClassGenerated => true;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestAbstractProps extends _$TestAbstractProps with _$TestAbstractPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestAbstractProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestCustomNamespaceAbstractProps extends _$TestCustomNamespaceAbstractProps with _$TestCustomNamespaceAbstractPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestCustomNamespaceAbstractProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestAbstractState extends _$TestAbstractState with _$TestAbstractStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForTestAbstractState;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestCustomNamespaceAbstractState extends _$TestCustomNamespaceAbstractState with _$TestCustomNamespaceAbstractStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForTestCustomNamespaceAbstractState;
}
