import 'package:over_react/over_react.dart';

part 'abstract_inheritance.over_react.g.dart';

@AbstractProps()
abstract class _$SuperProps extends UiProps {
  String superProp;
}

@AbstractState()
abstract class _$SuperState extends UiState {
  String superState;
}

@AbstractComponent2()
abstract class SuperComponent<T extends SuperProps, V extends SuperState> extends UiStatefulComponent2<T, V> {
  @override
  get defaultProps => newProps()..id = 'super';

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

@Props()
class _$SubProps extends SuperProps {
  String subProp;
}

@State()
class _$SubState extends SuperState {
  String subState;
}

@Component2()
class SubComponent extends SuperComponent<SubProps, SubState> {
  @override
  get defaultProps => newProps()..id = 'sub';

  @override
  get initialState {
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
