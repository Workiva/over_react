import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/error_boundary_mixins.dart';

// ignore: uri_has_not_been_generated
part 'custom_error_boundary_component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;

class CustomErrorBoundaryProps = UiProps with ErrorBoundaryPropsMixin;

class CustomErrorBoundaryState = UiState with ErrorBoundaryStateMixin;

@Component2(isErrorBoundary: true)
class CustomErrorBoundaryComponent
    extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState>
    with
        ErrorBoundaryMixin<CustomErrorBoundaryProps, CustomErrorBoundaryState>,
        ErrorBoundaryApi<CustomErrorBoundaryProps, CustomErrorBoundaryState> {}
