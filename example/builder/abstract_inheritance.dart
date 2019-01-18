import 'package:over_react/over_react.dart';

part 'abstract_inheritance.over_react.g.dart';

// ignore: mixin_of_non_class,undefined_class
abstract class SuperProps extends _$SuperProps with _$SuperPropsAccessorsMixin {}

@AbstractProps()
abstract class _$SuperProps extends UiProps {
  static const PropsMeta meta = _$metaForSuperProps;

  String superProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class SuperState extends _$SuperState with _$SuperStateAccessorsMixin {}

@AbstractState()
abstract class _$SuperState extends UiState {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForSuperState;

  String superState;
}

@AbstractComponent()
abstract class SuperComponent<T extends SuperProps, V extends SuperState> extends UiStatefulComponent<T, V> {
  @override
  Map getDefaultProps() => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('Super', {
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}

//---------------------------- Sub Component ----------------------------
@Factory()
UiFactory<SubProps> Sub = _$Sub;

// ignore: mixin_of_non_class,undefined_class
class SubProps extends _$SubProps with _$SubPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSubProps;
}

@Props()
class _$SubProps extends SuperProps {

  String subProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class SubState extends _$SubState with _$SubStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForSubState;
}

@State()
class _$SubState extends SuperState {// ignore: non_abstract_class_inherits_abstract_member_two
  String subState;
}

@Component()
class SubComponent extends SuperComponent<SubProps, SubState> {
  @override
  Map getDefaultProps() => newProps()..id = 'sub';

  @override
  Map getInitialState() {
    return newState()
      ..superState = '<the super state value>'
      ..subState = '<the sub state value>';
  }

  @override
  render() {
    return Dom.div()('SubProps:', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString(),
      'SubState:', {
      'state.subState': state.subState,
      'state.superState': state.superState,
    }.toString()
    );
  }
}
