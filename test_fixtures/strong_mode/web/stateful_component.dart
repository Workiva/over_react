import 'package:over_react/over_react.dart';
// ignore: uri_has_not_been_generated
part 'stateful_component.over_react.g.dart';

@Factory()
UiFactory<StatefulProps> Stateful =
    // ignore: undefined_identifier
    _$Stateful;

@Props()
class _$StatefulProps extends UiProps {}

@State()
class _$StatefulState extends UiState {}

@Component()
class StatefulComponent extends UiStatefulComponent<StatefulProps, StatefulState> {
  @override
  render() { }
}

// This will be removed once the transition to Dart 2 is complete.
class StatefulProps extends _$StatefulProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$StatefulPropsAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const PropsMeta meta = _$metaForStatefulProps;
}

// This will be removed once the transition to Dart 2 is complete.
class StatefulState extends _$StatefulState
    with
        // ignore: mixin_of_non_class, undefined_class
        _$StatefulStateAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const StateMeta meta = _$metaForStatefulState;
}
