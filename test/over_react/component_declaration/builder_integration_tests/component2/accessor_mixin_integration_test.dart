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
// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'accessor_mixin_integration_test.over_react.g.dart';

main() {
  group('(Component2) accessor for props/state mixin integration:', () {
    group('@PropsMixin()', () {
      group('generates prop getters/setters with', () {
        test('the props class name as a namespace and the prop name as the key by default', () {
          TestPropsMixinSubclass mixinsTest;

          mixinsTest = TestPropsMixinSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('TestPropsMixin.stringProp', 'test'));

          mixinsTest = TestPropsMixinSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('TestPropsMixin.dynamicProp', 2));

          mixinsTest = TestPropsMixinSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('TestPropsMixin.untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = TestPropsMixinSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('TestPropsMixin.custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = TestPropsMixinSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = TestPropsMixinSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates prop getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the prop name as the key by default', () {
          TestCustomNamespacePropsMixinSubclass mixinsTest;

          mixinsTest = TestCustomNamespacePropsMixinSubclass()..stringProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**stringProp', 'test'));

          mixinsTest = TestCustomNamespacePropsMixinSubclass()..dynamicProp = 2;
          expect(mixinsTest.props, containsPair('custom mixin namespace**dynamicProp', 2));

          mixinsTest = TestCustomNamespacePropsMixinSubclass()..untypedProp = false;
          expect(mixinsTest.props, containsPair('custom mixin namespace**untypedProp', false));
        });

        test('custom prop keys', () {
          var mixinsTest = TestCustomNamespacePropsMixinSubclass()..customKeyProp = 'test';
          expect(mixinsTest.props, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          var mixinsTest = TestCustomNamespacePropsMixinSubclass()..customNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          var mixinsTest = TestCustomNamespacePropsMixinSubclass()..customKeyAndNamespaceProp = 'test';
          expect(mixinsTest.props, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });

    group('@StateMixin()', () {
      group('generates state getters/setters with', () {
        test('the state class name as a namespace and the state name as the key by default', () {
          TestStateMixinSubclass mixinsTest;

          mixinsTest = TestStateMixinSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('TestStateMixin.stringState', 'test'));

          mixinsTest = TestStateMixinSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('TestStateMixin.dynamicState', 2));

          mixinsTest = TestStateMixinSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('TestStateMixin.untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = TestStateMixinSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('TestStateMixin.custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestStateMixinSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestStateMixinSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });

      group('generates state getters/setters, when there is a custom key namespace, with', () {
        test('the custom namespace and the state name as the key by default', () {
          TestCustomNamespaceStateMixinSubclass mixinsTest;

          mixinsTest = TestCustomNamespaceStateMixinSubclass()..stringState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**stringState', 'test'));

          mixinsTest = TestCustomNamespaceStateMixinSubclass()..dynamicState = 2;
          expect(mixinsTest.state, containsPair('custom mixin namespace**dynamicState', 2));

          mixinsTest = TestCustomNamespaceStateMixinSubclass()..untypedState = false;
          expect(mixinsTest.state, containsPair('custom mixin namespace**untypedState', false));
        });

        test('custom state keys', () {
          var mixinsTest = TestCustomNamespaceStateMixinSubclass()..customKeyState = 'test';
          expect(mixinsTest.state, containsPair('custom mixin namespace**custom key!', 'test'));
        });

        test('custom state key namespaces', () {
          var mixinsTest = TestCustomNamespaceStateMixinSubclass()..customNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~customNamespaceState', 'test'));
        });

        test('custom state keys and namespaces', () {
          var mixinsTest = TestCustomNamespaceStateMixinSubclass()..customKeyAndNamespaceState = 'test';
          expect(mixinsTest.state, containsPair('custom namespace~~custom key!', 'test'));
        });
      });
    });
  });
}


@PropsMixin()
abstract class _$TestPropsMixin {
  Map get props;

  String? stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}

class TestPropsMixinSubclass extends Object with
    TestPropsMixin {
  @override final Map props = {};
}


@PropsMixin(keyNamespace: 'custom mixin namespace**')
abstract class _$TestCustomNamespacePropsMixin {
  Map get props;

  String? stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}

class TestCustomNamespacePropsMixinSubclass extends Object with
    TestCustomNamespacePropsMixin {
  @override final Map props = {};
}


@StateMixin()
abstract class _$TestStateMixin {
  Map get state;

  String? stringState;
  dynamic dynamicState;
  var untypedState; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceState;
}

class TestStateMixinSubclass extends Object with
    TestStateMixin {
  @override final Map state = {};
}


@StateMixin(keyNamespace: 'custom mixin namespace**')
abstract class _$TestCustomNamespaceStateMixin {
  Map get state;

  String? stringState;
  dynamic dynamicState;
  var untypedState; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceState;
}

class TestCustomNamespaceStateMixinSubclass extends Object with
    TestCustomNamespaceStateMixin {
  @override final Map state = {};
}
