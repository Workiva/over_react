// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_mixins.dart';

// ignore: uri_has_not_been_generated
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
        LegacyErrorBoundaryApi<CustomErrorBoundaryProps, CustomErrorBoundaryState> {}
