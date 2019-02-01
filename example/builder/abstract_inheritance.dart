import 'package:over_react/over_react.dart';

part 'abstract_inheritance.over_react.g.dart';

abstract class SuperProps extends _$SuperProps with _$SuperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSuperProps;
}

@AbstractProps()
abstract class _$SuperProps extends UiProps {
  String superProp;
}

abstract class SuperState extends _$SuperState with _$SuperStateAccessorsMixin {
  static const StateMeta meta = _$metaForSuperState;
}

@AbstractState()
abstract class _$SuperState extends UiState {
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
    }.toString());
  }
}

//---------------------------- Sub Component ----------------------------
@Factory()
UiFactory<SubProps> Sub = _$Sub;

class SubProps extends _$SubProps with _$SubPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSubProps;
}

@Props()
class _$SubProps extends SuperProps {
  String subProp;
}

abstract class SubState extends _$SubState with _$SubStateAccessorsMixin {
  static const StateMeta meta = _$metaForSubState;
}

@State()
class _$SubState extends SuperState {
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
