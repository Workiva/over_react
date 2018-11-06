import 'package:over_react/over_react.dart';

//part 'abstract_inheritance.g.dart';
part 'abstract_inheritance.overReact.g.dart';

// ignore: mixin_of_non_class,undefined_class
abstract class SuperProps extends _$SuperProps with _$SuperPropsAccessorsMixin {}

@AbstractProps()
abstract class _$SuperProps extends UiProps {
  static const PropsMeta meta = $metaForSuperProps;

  String superProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class SuperState extends _$SuperState with _$SuperStateAccessorsMixin {}

@AbstractState()
abstract class _$SuperState extends UiState {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForSuperState;

  String superState;
}

@AbstractComponent()
abstract class SuperComponent<T extends SuperProps, V extends SuperState> extends UiStatefulComponent<T, V> {
  getDefaultProps() => newProps()..id = 'super';

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
UiFactory<SubProps> Sub = $Sub;

// ignore: mixin_of_non_class,undefined_class
class SubProps extends _$SubProps with _$SubPropsAccessorsMixin {}

@Props()
class _$SubProps extends SuperProps {
 static const PropsMeta meta = $metaForSubProps;

  String subProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class SubState extends _$SubState with _$SubStateAccessorsMixin {}

@State()
class _$SubState extends SuperState {// ignore: non_abstract_class_inherits_abstract_member_two
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
 static const StateMeta meta = $metaForSubState;

  String subState;
}

@Component()
class SubComponent extends SuperComponent<SubProps, SubState> {
  getDefaultProps() => newProps()..id = 'sub';

  @override
  getInitialState() {
    return newState()..superState = '<the super state value>'
      ..subState = '<the sub state value>'
    ;
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
