part of '../component_integration_test.dart';

@Factory()
UiFactory<IsNotErrorBoundaryProps> IsNotErrorBoundary = _$IsNotErrorBoundary;

@Props()
class _$IsNotErrorBoundaryProps extends UiProps {}

@Component2()
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
