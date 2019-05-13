part of '../component_integration_test.dart';

@Factory()
UiFactory<IsErrorBoundaryProps> IsErrorBoundary = _$IsErrorBoundary;

@Props()
class _$IsErrorBoundaryProps extends UiProps {}

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
