// ignore_for_file: deprecated_member_use_from_same_package
part of '../annotation_error_integration_test.dart';

@Factory()
UiFactory<AnnotationErrorStatefulDefaultPropsProps>
    AnnotationErrorStatefulDefaultProps = _$AnnotationErrorStatefulDefaultProps;

@Props()
class _$AnnotationErrorStatefulDefaultPropsProps extends UiProps {}

@State()
class _$AnnotationErrorStatefulDefaultPropsState extends UiState {}

@Component()
class AnnotationErrorStatefulDefaultPropsComponent extends UiStatefulComponent2<
    AnnotationErrorStatefulDefaultPropsProps,
    AnnotationErrorStatefulDefaultPropsState> {
  @override
  Map get defaultProps => newProps()..id = 'testId';

  @override
  render() => props.children;
}
