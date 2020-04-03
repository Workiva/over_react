import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/error_boundary_mixins.dart';

part 'custom_error_boundary_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;

@Props()
class _$CustomErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@State()
class _$CustomErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Component2(isErrorBoundary: true)
class CustomErrorBoundaryComponent extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState>
    with
        ErrorBoundaryMixin<CustomErrorBoundaryProps, CustomErrorBoundaryState>,
        ErrorBoundaryApi<CustomErrorBoundaryProps, CustomErrorBoundaryState> {}
