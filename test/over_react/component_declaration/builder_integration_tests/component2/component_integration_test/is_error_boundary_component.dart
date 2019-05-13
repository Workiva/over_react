part of '../component_integration_test.dart';

@Factory()
UiFactory<IsErrorBoundaryProps> IsErrorBoundary = _$IsErrorBoundary;

@Props()
class _$IsErrorBoundaryProps extends UiProps {}

@Component2(isErrorBoundary: true)
class IsErrorBoundaryComponent extends UiComponent2<IsErrorBoundaryProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => (Dom.div()
  )('rendered content');
}
