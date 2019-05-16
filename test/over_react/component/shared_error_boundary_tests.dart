import 'dart:html';
import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:test/test.dart';

import './fixtures/flawed_component.dart';

void sharedErrorBoundaryTests(BuilderOnlyUiFactory builder) {
  TestJacket<ErrorBoundaryMixin> jacket;
  ReactElement dummyChild;

  setUp(() {
    dummyChild = Dom.div()('hi there');
  });

  tearDown(() {
    jacket = null;
    dummyChild = null;
  });

  // TODO: Add tests that exercise the actual ReactJS 16 error lifecycle methods once implemented.
  group('catches component errors', () {
    List<Map<String, List>> calls;
    DivElement mountNode;

    void verifyReact16ErrorHandlingWithoutErrorBoundary() {
      mountNode = new DivElement();
      document.body.append(mountNode);
      var jacketOfFlawedComponentWithNoErrorBoundary = mount(Flawed()(), mountNode: mountNode);
      expect(mountNode.children, isNotEmpty, reason: 'test setup sanity check');
      jacketOfFlawedComponentWithNoErrorBoundary.getNode().click();
      expect(mountNode.children, isEmpty,
          reason: 'rendered trees not wrapped in an ErrorBoundary '
                  'should get unmounted when an error is thrown within child component lifecycle methods');

      mountNode.remove();
      mountNode = new DivElement();
      document.body.append(mountNode);
    }

    setUp(() {
      // Verify the behavior of a component that throws when it is not wrapped in an error boundary first
      verifyReact16ErrorHandlingWithoutErrorBoundary();

      calls = [];
      jacket = mount(
        (builder()
          ..addProps(new ErrorBoundaryPropsMapView({})..onComponentDidCatch = (err, info) {
            calls.add({'onComponentDidCatch': [err, info]});
          })
        )(Flawed()()),
        mountNode: mountNode,
      );
      expect(mountNode.children, isNotEmpty, reason: 'test setup sanity check');
      // Cause an error to be thrown within a ReactJS lifecycle method
      jacket.getNode().click();
    });

    tearDown(() {
      mountNode.remove();
      mountNode = null;
    });

    test('and calls `props.onComponentDidCatch`', () {
      expect(calls.single.keys, ['onComponentDidCatch']);
      final errArg = calls.single['onComponentDidCatch'][0];
      expect(errArg, isA<FlawedComponentException>());

      final infoArg = calls.single['onComponentDidCatch'][1];
      expect(infoArg, isA<ReactErrorInfo>());
    });

    test('and sets `state.hasError` to true as a result', () {
      expect(jacket.getDartInstance().state.hasError, isTrue);
    });

    test('and re-renders the tree as a result', () {
      expect(mountNode.children, isNotEmpty,
          reason: 'rendered trees wrapped in an ErrorBoundary '
                  'should NOT get unmounted when an error is thrown within child component lifecycle methods');
    });

    test('does not throw a null exception when `props.onComponentDidCatch` is not set', () {
      jacket = mount(builder()((Flawed()..addTestId('flawed'))()), mountNode: mountNode);
      // The click causes the componentDidCatch lifecycle method to execute
      // and we want to ensure that no Dart null error is thrown as a result of no consumer prop callback being set.
      expect(() => jacket.getNode().click(), returnsNormally);
    });
  });

  test('initializes with the expected initial state values', () {
    jacket = mount(builder()(dummyChild));

    expect(jacket.getDartInstance().state.hasError, isFalse);
  });

  group('renders', () {
    test('its children when `state.error` is false', () {
      jacket = mount(builder()(dummyChild));
      expect(jacket.getDartInstance().state.hasError, isFalse, reason: 'test setup sanity check');

      expect(jacket.getNode().text, 'hi there');
    });

    test('its children when `state.error` is true and props.fallbackUIRenderer is not set', () {
      jacket = mount(builder()(dummyChild));
      expect(jacket.getDartInstance().state.hasError, isFalse, reason: 'test setup sanity check');
      final component = jacket.getDartInstance();
      component.setState(component.newState()..hasError = true);

      expect(jacket.getNode().text, 'hi there');
    });

    test('fallback UI when `state.error` is true and props.fallbackUIRenderer is set', () {
      ReactElement _fallbackUIRenderer() {
        return Dom.h4()('Something super not awesome just happened.');
      }

      jacket = mount((builder()..addProps(new ErrorBoundaryPropsMapView({})..fallbackUIRenderer = _fallbackUIRenderer))(dummyChild));
      final component = jacket.getDartInstance();
      component.setState(component.newState()..hasError = true);

      expect(jacket.getNode(), hasNodeName('H4'));
      expect(jacket.getNode().text, 'Something super not awesome just happened.');
    });
  });
}
