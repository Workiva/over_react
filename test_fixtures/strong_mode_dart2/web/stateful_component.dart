import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'stateful_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<StatefulProps> Stateful = _$Stateful;

@Props()
class _$StatefulProps extends UiProps {}

@State()
class _$StatefulState extends UiState {}

@Component()
class StatefulComponent extends UiStatefulComponent<StatefulProps, StatefulState> {
  @override
  render() { }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class StatefulProps extends _$StatefulProps with _$StatefulPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForStatefulProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class StatefulState extends _$StatefulState with _$StatefulStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForStatefulState;
}
