part of '../component_integration_test.dart';

UiFactory<IsErrorBoundaryProps> IsErrorBoundary = _$IsErrorBoundary;

mixin IsErrorBoundaryProps on UiProps {}

@Component2(isErrorBoundary: true)
class IsErrorBoundaryComponent extends UiComponent2<IsErrorBoundaryProps> {
  static var calls = [];

  @override
  Map getDerivedStateFromError(_) {
    calls.add('getDerivedStateFromError');
    return {};
  }

  @override
  void componentDidCatch(_, __) {
    calls.add('componentDidCatch');
  }

  @override
  render() => props.children.single;
}
