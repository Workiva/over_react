import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';
import 'package:over_react/react_dom.dart' as react_dom;

import '../../../../test_util/test_util.dart';

part 'annotation_error_integration_test.over_react.g.dart';
part 'component_integration_test/annotation_error_component.dart';
part 'component_integration_test/annotation_error_stateful_component.dart';
part 'component_integration_test/annotation_error_stateful_default_props_component.dart';

main() {
  group('(Component2) throws a helpful error message if the @Component annotation is used:',
      () {
    Element mountNode;

    setUp(() {
      mountNode = new DivElement();
    });

    tearDown(() {
      mountNode = null;
    });

    test('when rendering a UiComponent2', () {
      expect(
          () => react_dom.render(AnnotationError()(), mountNode),
          throwsA(hasToStringValue(contains(
              'This error may be due to your `UiComponent2` class not being annotated with `@Component2()`'))));
    });

    test('when rendering a UiStatefulComponent2', () {
      expect(
          () => react_dom.render(AnnotationErrorStateful()(), mountNode),
          throwsA(hasToStringValue(contains(
              'This error may be due to your `UiStatefulComponent2` class not being annotated with `@Component2()`'))));
    });

    test('when rendering a UiComponent2 with default props', () {
      expect(
          () =>
              react_dom.render(AnnotationErrorDefaultProps()(), mountNode),
          throwsA(hasToStringValue(contains(
              'This error may be due to your `UiComponent2` or `UiStatefulComponent2` class not being annotated with `@Component2()`'))));
    });

    test('when rendering a UiComponentStateful2 with default props', () {
      expect(
              () =>
              react_dom.render(AnnotationErrorStatefulDefaultProps()(), mountNode),
          throwsA(hasToStringValue(contains(
              'This error may be due to your `UiComponent2` or `UiStatefulComponent2` class not being annotated with `@Component2()`'))));
    });
  });
}

@Factory()
UiFactory<AnnotationErrorDefaultPropsProps>
    AnnotationErrorDefaultProps = _$AnnotationErrorDefaultProps;

@Props()
class _$AnnotationErrorDefaultPropsProps extends UiProps {}

@Component()
class AnnotationErrorDefaultPropsComponent
    extends UiComponent2<AnnotationErrorDefaultPropsProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => props.children;
}
