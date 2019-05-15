import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';

// ignore: uri_has_not_been_generated
part 'custom_error_boundary.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;

@Props()
class _$CustomErrorBoundaryProps extends UiProps {
  Function(dynamic error, ReactErrorInfo info) onComponentDidCatch;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps with _$CustomErrorBoundaryPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForCustomErrorBoundaryProps;
}

@State()
class _$CustomErrorBoundaryState extends UiState {
  bool hasError;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class CustomErrorBoundaryState extends _$CustomErrorBoundaryState with _$CustomErrorBoundaryStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForCustomErrorBoundaryState;
}

@Component2(isErrorBoundary: true)
class CustomErrorBoundaryComponent extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState> {
  @override
  Map getInitialState() => (newState()..hasError = false);

  @override
  CustomErrorBoundaryState getDerivedStateFromError(_) {
    return newState()..hasError = true;
  }

  @override
  void componentDidCatch(dynamic error, ReactErrorInfo info) {
    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, info);
    }
  }

  @override
  render() {
    return state.hasError
        ? Dom.h3()('This is a custom error message!')
        : props.children;
  }
}
