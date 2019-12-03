part of '../annotation_error_integration_test.dart';

@Factory()
UiFactory<AnnotationErrorStatefulDefaultPropsProps>
    AnnotationErrorStatefulDefaultProps = _$AnnotationErrorStatefulDefaultProps;

@Props()
class _$AnnotationErrorStatefulDefaultPropsProps extends UiProps {}

@State()
class _$AnnotationErrorStatefulDefaultPropsState extends UiState {}

// ignore: deprecated_member_use_from_same_package
@Component()
class AnnotationErrorStatefulDefaultPropsComponent extends UiStatefulComponent2<
    AnnotationErrorStatefulDefaultPropsProps,
    AnnotationErrorStatefulDefaultPropsState> {
  @override
  // ignore: must_call_super
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => props.children;
}
