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

import '../../../../test_util/test_util.dart';

part 'stateful_component_integration_test.over_react.g.dart';

main() {
  group('(Component2) stateful component integration:', () {
    test('state class cannot be instantiated directly', () {
      expect(() {
        StatefulComponentTestState();
      }, throwsA(isA<IllegalInstantiationError>()));
    });

    test('renders a component from end to end, successfully reading state via typed getters', () {
      var renderedInstance = render(StatefulComponentTest()());
      expect(renderedInstance, isNotNull);

      var node = findDomNode(renderedInstance);
      expect(node.text, 'rendered content');
      expect(node.dataset, containsPair('state-string-state', '1'));
      expect(node.dataset, containsPair('state-dynamic-state', '2'));
      expect(node.dataset, containsPair('state-untyped-state', '3'));
      expect(node.dataset, containsPair('state-custom-key-state', '4'));
      expect(node.dataset, containsPair('state-custom-namespace-state', '5'));
      expect(node.dataset, containsPair('state-custom-key-and-namespace-state', '6'));
    });

    group('generates state getters/setters with', () {
      StatefulComponentTestComponent component;

      setUp(() {
        var renderedInstance = render(StatefulComponentTest()());
        component = getDartComponent(renderedInstance);
      });

      test('prop keys using the props class name as a namespace and the prop name as the key by default', () {
        expect(component.newState()..stringState = 'test',
            containsPair('StatefulComponentTestState.stringState', 'test'));

        expect(component.newState()..dynamicState = 2,
            containsPair('StatefulComponentTestState.dynamicState', 2));

        expect(component.newState()..untypedState = false,
            containsPair('StatefulComponentTestState.untypedState', false));
      });

      test('custom prop keys', () {
        expect(component.newState()..customKeyState = 'test',
            containsPair('StatefulComponentTestState.custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(component.newState()..customNamespaceState = 'test',
            containsPair('custom namespace~~customNamespaceState', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(component.newState()..customKeyAndNamespaceState = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });
    });
  });
}


@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<StatefulComponentTestProps> StatefulComponentTest = _$StatefulComponentTest;

@Props()
class _$StatefulComponentTestProps extends UiProps {
  /// Used to test if a component has the capability to set state via this.setState.
  bool setStateDirectly;
}

@State()
class _$StatefulComponentTestState extends UiState {
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

@Component2()
class StatefulComponentTestComponent extends UiStatefulComponent2<StatefulComponentTestProps, StatefulComponentTestState> {
  @override
  Map get defaultProps => newProps()..setStateDirectly = false;

  @override
  Map get initialState {
    if (this.props.setStateDirectly) {
      return newState()..stringState = '1';
    } else {
      return newState()
      ..stringState = '1'
      ..dynamicState = '2'
      ..untypedState = '3'
      ..customKeyState = '4'
      ..customNamespaceState = '5'
      ..customKeyAndNamespaceState = '6';
    }
  }

  @override
  render() => (Dom.div()
    // ignore: deprecated_member_use_from_same_package
    ..addProps(copyUnconsumedProps())
    ..addProp('data-who', state.stringState)
    ..addProp('data-state-string-state', state.stringState)
    ..addProp('data-state-dynamic-state', state.dynamicState)
    ..addProp('data-state-untyped-state', state.untypedState)
    ..addProp('data-state-custom-key-state', state.customKeyState)
    ..addProp('data-state-custom-namespace-state', state.customNamespaceState)
    ..addProp('data-state-custom-key-and-namespace-state', state.customKeyAndNamespaceState)
  )('rendered content');
}

