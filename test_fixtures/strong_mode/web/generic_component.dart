import 'package:over_react/over_react.dart';
// ignore: uri_has_not_been_generated
part 'generic_component.over_react.g.dart';

@Factory()
UiFactory<GenericStatefulProps> GenericStateful =
    // ignore: undefined_identifier
    _$GenericStateful;

@Props()
class _$GenericStatefulProps extends UiProps {}

@State()
class _$GenericStatefulState extends UiState {}

@Component()
class GenericStatefulComponent<T extends GenericStatefulProps, S extends GenericStatefulState> extends UiStatefulComponent<T, S> {
  @override
  render() { }
}

// This will be removed once the transition to Dart 2 is complete.
class GenericStatefulProps extends _$GenericStatefulProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$GenericStatefulPropsAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const PropsMeta meta = _$metaForGenericStatefulProps;
}

// This will be removed once the transition to Dart 2 is complete.
class GenericStatefulState extends _$GenericStatefulState
    with
        // ignore: mixin_of_non_class, undefined_class
        _$GenericStatefulStateAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const StateMeta meta = _$metaForGenericStatefulState;
}
