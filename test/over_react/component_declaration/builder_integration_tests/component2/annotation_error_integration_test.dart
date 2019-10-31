@TestOn('browser')

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'annotation_error_integration_test.over_react.g.dart';
part 'component_integration_test/annotation_error_component.dart';
part 'component_integration_test/annotation_error_stateful_component.dart';
part 'component_integration_test/annotation_error_stateful_default_props_component.dart';

main() {
  group('(Component2) throws a helpful error message if the @Component annotation is used:',
      () {
    final throwsExpectedError = throwsA(hasToStringValue(contains(
      GeneratedErrorMessages.component1AnnotationOnComponent2,
    )));

    test('when rendering a UiComponent2', () {
      expect(() => mount(AnnotationError()()), throwsExpectedError);
    });

    test('when rendering a UiStatefulComponent2', () {
      expect(() => mount(AnnotationErrorStateful()()), throwsExpectedError);
    });

    test('when rendering a UiComponent2 with default props', () {
      expect(() => mount(AnnotationErrorDefaultProps()()), throwsExpectedError);
    });

    test('when rendering a UiComponentStateful2 with default props', () {
      expect(() => mount(AnnotationErrorStatefulDefaultProps()()), throwsExpectedError);
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
  Map get defaultProps => newProps()..id = 'testId';

  @override
  render() => props.children;
}
