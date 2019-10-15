import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';

part 'custom_error_boundary.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;

@Props()
class _$CustomErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@State()
class _$CustomErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Component2(isErrorBoundary: true)
class CustomErrorBoundaryComponent extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState>
    with ErrorBoundaryMixin<CustomErrorBoundaryProps, CustomErrorBoundaryState> {
  @override
  Map getDefaultProps() => newProps()
    ..fallbackUIRenderer = _renderFallbackUI;

  ReactElement _renderFallbackUI(_, __) {
    return Dom.div()(
      Dom.h3()('Error!'),
    );
  }
}
