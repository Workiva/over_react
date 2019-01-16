import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'generic_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<GenericStatefulProps> GenericStateful = _$GenericStateful;

@Props()
class _$GenericStatefulProps extends UiProps {}

@State()
class _$GenericStatefulState extends UiState {}

@Component()
class GenericStatefulComponent<T extends GenericStatefulProps, S extends GenericStatefulState> extends UiStatefulComponent<T, S> {
  @override
  render() { }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class GenericStatefulProps extends _$GenericStatefulProps with _$GenericStatefulPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForGenericStatefulProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class GenericStatefulState extends _$GenericStatefulState with _$GenericStatefulStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForGenericStatefulState;
}
