import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'private_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<_PrivateProps> _Private = _$_Private;

@Props()
class _$_PrivateProps extends UiProps {
  bool prop1;
}

@State()
class _$_PrivateState extends UiState {
  bool state1;
}

@Component()
class PrivateComponent extends UiStatefulComponent<_PrivateProps, _PrivateState> {
  @override
  Map getDefaultProps() => newProps()..prop1 = true;

  @override
  Map getInitialState() => newState()..state1 = true;

  @override
  render() {
    return Dom.div()('PrivateComponent', {
      'props.prop1': props.prop1,
      'props.state1': state.state1,
    }.toString());
  }
}

// ignore: mixin_of_non_class, undefined_class
class _PrivateProps extends _$_PrivateProps with _$_PrivatePropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaFor_PrivateProps;
}

// ignore: mixin_of_non_class, undefined_class
class _PrivateState extends _$_PrivateState with _$_PrivateStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaFor_PrivateState;
}
