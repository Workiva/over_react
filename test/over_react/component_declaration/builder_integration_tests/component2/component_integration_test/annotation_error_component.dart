// ignore_for_file: deprecated_member_use_from_same_package
part of '../annotation_error_integration_test.dart';

@Factory()
UiFactory<AnnotationErrorProps> AnnotationError = _$AnnotationError;

@Props()
class _$AnnotationErrorProps extends UiProps {}

@Component()
class AnnotationErrorComponent extends UiComponent2<AnnotationErrorProps> {
  @override
  render() => props.children;
}
