import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'abstract_inheritance.example.over_react.g.dart' as $;
export 'abstract_inheritance.example.over_react.g.dart';

mixin SuperPropsMixin on UiProps {
  String superProp;
}

mixin SuperStateMixin on UiState {
  String superState;
}

abstract class SuperComponent<T extends SuperPropsMixin, V extends SuperStateMixin> extends UiStatefulComponent2<T, V> {
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

UiFactory<SubProps> Sub = $.$Sub;

mixin SubPropsMixin on UiProps {
  String subProp;
}

class SubProps = UiProps with SuperPropsMixin, SubPropsMixin;

mixin SubStateMixin on UiState {
  String subState;
}

class SubState = UiState with SuperStateMixin, SubStateMixin;

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
