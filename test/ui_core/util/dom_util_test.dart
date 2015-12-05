library dom_util_test;

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' show ReactComponentFactory;
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../wsd_test_util/key_down_util.dart';

/// Main entry point for DomUtil testing
main() {
  group('isOrContains returns', () {
    group('true when', () {
      test('root is the other element', () {
        var rootNode = renderAndGetDom(Dom.div());

        expect(isOrContains(rootNode, rootNode), isTrue);
      });

      test('root contains the other element', () {
        var rootInstance = render(DomTest());
        var rootNode = findDomNode(rootInstance);
        var otherNode = findDomNode(getRef(rootInstance, 'innerComponent'));

        expect(isOrContains(rootNode, otherNode), isTrue);
      });
    });

    group('false when', () {
      test('root is null', () {
        var otherNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(null, otherNode), isFalse);
      });

      test('other is null', () {
        var rootNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(rootNode, null), isFalse);
      });

      test('root and other is null', () {
        expect(isOrContains(null, null), isFalse);
      });

      test('root is not, or does not contain, the other element', () {
        var rootNode = renderAndGetDom(Dom.div()());
        var otherNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(rootNode, otherNode), isFalse);
      });
    });
  });
}

DomTestDefinition DomTest() => new DomTestDefinition({});

class DomTestDefinition extends BaseComponentDefinition with HitAreaProps {
  DomTestDefinition(Map props) : super(_DomTestComponentFactory, props);
}

ReactComponentFactory _DomTestComponentFactory = react.registerComponent(() => new _DomTest());
class _DomTest extends BaseComponent<DomTestDefinition> with HitAreaMixin<DomTestDefinition> {
  @override
  Map getDefaultProps() => (newProps()
    ..addProps(HitAreaMixin.defaultProps)
  );

  @override
  render() {
    return Dom.div()(
      (Dom.div()..ref = 'innerComponent')()
    );
  }

  @override
  DomTestDefinition typedPropsFactory(Map propsMap) => new DomTestDefinition(propsMap);
}
