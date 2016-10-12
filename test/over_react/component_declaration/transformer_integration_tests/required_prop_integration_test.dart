library over_react.component_declaration.transformer_integration_tests.required_prop_integration;

import 'dart:html';

import 'package:react/react_dom.dart' as react_dom;
import 'package:test/test.dart';
import '../../../test_util/test_util.dart';
import 'package:over_react/over_react.dart';

void requiredPropsIntegrationTest() {
  group('properly identifies required props by', () {
    group('throwing when a prop is required and not set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()..nullableProp = true),
            throwsPropError_Required('ComponentTestProps.requiredProp', 'This Prop is Required for testing purposes.')
        );
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()..nullableProp = true)(), mountNode),
            throwsPropError_Required('ComponentTestProps.requiredProp', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is required and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..requiredProp = null
          ..nullableProp = true
        ), throwsPropError_Required('ComponentTestProps.requiredProp'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode);

        expect(
            () => react_dom.render((ComponentTest()
              ..requiredProp = null
              ..nullableProp = true
            )(), mountNode),
            throwsPropError_Required('ComponentTestProps.requiredProp', 'This Prop is Required for testing purposes.')
        );
      });
    });

    group('throwing when a prop is nullable and not set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()..requiredProp = true),
            throwsPropError_Required('ComponentTestProps.nullableProp'));
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()..requiredProp = true)(), mountNode),
            throwsPropError_Required('ComponentTestProps.nullableProp', 'This prop can be set to null!')
        );
      });
    });

    group('not throwing when a prop is required and set', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..nullableProp = true
          ..requiredProp = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode), returnsNormally);
      });
    });

    group('not throwing when a prop is nullable and set to null', () {
      test('on mount', () {
        expect(() => render(ComponentTest()
          ..nullableProp = null
          ..requiredProp = true
        ), returnsNormally);
      });

      test('on re-render', () {
        var mountNode = new DivElement();
        react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = true
        )(), mountNode);

        expect(() => react_dom.render((ComponentTest()
          ..requiredProp = true
          ..nullableProp = null
        )(), mountNode), returnsNormally);
      });
    });
  });
}

@Factory()
UiFactory<ComponentTestProps> ComponentTest;

@Props()
class ComponentTestProps extends UiProps {
  @Required(message: 'This Prop is Required for testing purposes.')
  var requiredProp;

  @Required(isNullable: true, message: 'This prop can be set to null!')
  var nullableProp;
}

@Component()
class ComponentTestComponent extends UiComponent<ComponentTestProps> {
  @override
  render() => Dom.div()();
}
