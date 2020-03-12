part of '../component_integration_test.dart';

UiFactory<IsNotErrorBoundaryProps> IsNotErrorBoundary = _$IsNotErrorBoundary;

mixin IsNotErrorBoundaryProps on UiProps {}

class IsNotErrorBoundaryComponent extends UiComponent2<IsNotErrorBoundaryProps> {
  static var calls = [];

  @override
  Map getDerivedStateFromError(_) {
    calls.add('getDerivedStateFromError');
    return null;
  }

  @override
  void componentDidCatch(_, __) {
    calls.add('componentDidCatch');
  }

  @override
  render() => props.children;
}
