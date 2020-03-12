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

import '../../../component/fixtures/flawed_component.dart';
import './constant_required_accessor_integration_test.dart' as r;
import '../../../../test_util/test_util.dart';

part 'component_integration_test.over_react.g.dart';
part 'component_integration_test/is_error_boundary_component.dart';
part 'component_integration_test/is_not_error_boundary_component.dart';

main() {
  group('(New boilerplate) component integration:', () {
    test('renders a component from end to end, successfully reading props via typed getters', () {
      var instance = render((ComponentTest()
        ..stringProp = '1'
        ..dynamicProp = '2'
        ..untypedProp = '3'
        ..customKeyProp = '4'
        ..customNamespaceProp = '5'
        ..customKeyAndNamespaceProp = '6'
      )());
      expect(instance, isNotNull);

      var node = findDomNode(instance);
      expect(node.text, 'rendered content');
      expect(node.dataset, containsPair('prop-string-prop', '1'));
      expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
      expect(node.dataset, containsPair('prop-untyped-prop', '3'));
      expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
      expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
      expect(node.dataset, containsPair('prop-custom-key-and-namespace-prop', '6'));
    });

    group('isErrorBoundary annotation is set to', () {
      test('true, allowing use of getDerivedStateFromError and componentDidCatch', () {
        var jacket = mount(
          (IsErrorBoundary())(Flawed()()),
          attachedToDocument: true,
        );
        queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton').click();
        expect(IsErrorBoundaryComponent.calls, unorderedEquals(['getDerivedStateFromError','componentDidCatch']));
      });

      test('false, restricting use of getDerivedStateFromError and componentDidCatch', () {
        var jacket = mount(
          (IsNotErrorBoundary())(Flawed()()),
          attachedToDocument: true,
        );
        queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton').click();
        expect(IsNotErrorBoundaryComponent.calls, []);
      });
    });

    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        var instance = ComponentTest();
        expect(instance, isA<ComponentTestProps>());
        expect(instance, isA<Map>());
      });

      test('that returns a new props class implementation instance backed by an existing map', () {
        Map existingMap = {'ComponentTestProps.stringProp': 'test'};
        var props = ComponentTest(existingMap);

        expect(props.stringProp, equals('test'));

        props.stringProp = 'modified';
        expect(props.stringProp, equals('modified'));
        expect(existingMap['ComponentTestProps.stringProp'], equals('modified'));
      });
    });

    group('generates prop getters/setters', () {
      test('and throws when set directly with a normal map', () {
        expect(() => render((ComponentTest()..shouldSetPropsDirectly = true)()),
            throwsA(hasToStringValue(contains('Component2.props should never be set directly '
                'in production.'))));
      }, testOn: '!js');

      test('and does not throw when set directly using a typedJsFactory', () {
        TestJacket jacket = mount((ComponentTest()
        ..shouldSetPropsDirectly = true
        ..shouldUseJsFactory = true)());

        expect(ComponentTest(jacket.getProps()).shouldUseJsFactory, isTrue,
            reason: 'Sanity check to ensure that setting props directly does '
                'not throw.');
      });

      group('with', () {
        test('the props class name as a namespace and the prop name as the key by default', () {
          expect(ComponentTest()..stringProp = 'test',
              containsPair('ComponentTestProps.stringProp', 'test'));

          expect(ComponentTest()..dynamicProp = 2,
              containsPair('ComponentTestProps.dynamicProp', 2));

          expect(ComponentTest()..untypedProp = false,
              containsPair('ComponentTestProps.untypedProp', false));

        });

        test('custom prop keys', () {
          expect(ComponentTest()..customKeyProp = 'test',
              containsPair('ComponentTestProps.custom key!', 'test'));
        });

        test('custom prop key namespaces', () {
          expect(ComponentTest()..customNamespaceProp = 'test',
              containsPair('custom namespace~~customNamespaceProp', 'test'));
        });

        test('custom prop keys and namespaces', () {
          expect(ComponentTest()..customKeyAndNamespaceProp = 'test',
              containsPair('custom namespace~~custom key!', 'test'));
        });

        test('default props', () {
          expect(ComponentTest().componentDefaultProps, equals
            ({'id':'testId',
            'ComponentTestProps.shouldSetPropsDirectly': false,
            'ComponentTestProps.shouldUseJsFactory': false,
            }));
        });

        test('empty map when no default props set', () {
          expect(r.ComponentTest().componentDefaultProps, equals({}));
        });

        test('empty map when componentFactory is not ReactDartComponentFactoryProxy', () {
          expect(Dom.div().componentDefaultProps, equals({}));
        });
      });

      test('omits props declared in the @Props() class when forwarding by default', () {
        var shallowInstance = renderShallow((ComponentTest()
          ..addProp('extraneous', true)
          ..stringProp = 'test'
          ..dynamicProp = 'test'
          ..untypedProp = 'test'
          ..customKeyProp = 'test'
          ..customNamespaceProp = 'test'
          ..customKeyAndNamespaceProp = 'test'
        )());

        var shallowProps = getProps(shallowInstance);
        Iterable<String> shallowPropKeys = shallowProps.keys.map((key) => key as String); // ignore: avoid_as

        expect(shallowPropKeys.where((key) => !key.startsWith('data-prop-')), unorderedEquals(['id', 'extraneous', 'children']));
      });
    });
  });
}


UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;


    // FIXME: A Workiva Semver report was not found. `ComponentTestProps` is assumed to be exported from
    // a library in this repo and thus was not auto-migrated to the new over_react boilerplate.
    //
    // --------- If you are migrating an OSS library outside of Workiva ---------
    // You do not have access to Workiva's internal Semver audit tool. 
    // To complete the migration, you should:
    //
    //   1. Revert all changes to remove this FIXME comment
    //   2. Re-run the migration script with the following flag:    
    //
    //        pub global run over_react_codemod:boilerplate_upgrade --treat-all-components-as-private
    //
    //   NOTE: The changes made to props / state classes by the codemod constitute breaking changes
    //   if you publicly export them from your library. We strongly recommend that you release 
    //   the subsequent changes in a major version.
    //
    // --------- If you are migrating a Workiva library ---------
    // To complete the migration, you should:
    //   1. Revert all changes to remove this FIXME comment
    //   2. Generate a semver report by running the following script:
    //
    //        pub global activate semver_audit --hosted-url=https://pub.workiva.org
    //        pub global run semver_audit generate 2> semver_report.json
    //
    //   3. Re-run the migration script:
    //
    //        pub global run over_react_codemod:boilerplate_upgrade
    mixin ComponentTestProps on UiProps {
  String stringProp;
  bool shouldSetPropsDirectly;
  bool shouldUseJsFactory;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}


class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  Map get defaultProps => newProps()
    ..id = 'testId'
    ..shouldSetPropsDirectly = false
    ..shouldUseJsFactory = false;

  @override
  render() => (Dom.div()
    ..modifyProps(addUnconsumedProps)
    ..addProp('data-prop-string-prop', props.stringProp)
    ..addProp('data-prop-dynamic-prop', props.dynamicProp)
    ..addProp('data-prop-untyped-prop', props.untypedProp)
    ..addProp('data-prop-custom-key-prop', props.customKeyProp)
    ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
    ..addProp('data-prop-custom-key-and-namespace-prop', props.customKeyAndNamespaceProp)
  )('rendered content');

  @override
  void componentDidMount() {
    if (props.shouldSetPropsDirectly) {
      if (props.shouldUseJsFactory) {
        this.props = typedPropsFactoryJs(JsBackedMap());
      } else {
        this.props = {'shouldSetPropsDirectly': false};
      }
    }
  }
}
