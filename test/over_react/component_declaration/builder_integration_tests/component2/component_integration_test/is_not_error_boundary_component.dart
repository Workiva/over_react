part of '../component_integration_test.dart';

@Factory()
UiFactory<IsNotErrorBoundaryProps> IsNotErrorBoundary = _$IsNotErrorBoundary;

@Props()
class _$IsNotErrorBoundaryProps extends UiProps {}

@Component2()
class IsNotErrorBoundaryComponent extends UiComponent2<IsNotErrorBoundaryProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => (Dom.div()
  )('rendered content');
}
