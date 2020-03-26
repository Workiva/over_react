import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'generic_inheritance_super.over_react.g.dart';

UiFactory<GenericSuperProps> GenericSuper = _$GenericSuper; // ignore: undefined_identifier

class GenericSuperProps = UiProps with GenericSuperPropsMixin;

mixin GenericSuperPropsMixin on UiProps {
  String otherSuperProp;
  String superProp;
  String superProp1;
}

mixin GenericSuperStateMixin on UiState {
  String superState;
}

class GenericSuperComponent<T extends GenericSuperPropsMixin, V extends GenericSuperStateMixin> extends UiStatefulComponent2<T, V> {
  @override
  get defaultProps => newProps()..id = 'generic_super';

  @override
  get initialState => newState()..superState = '<generic super state>';

  @override
  render() {
    return Dom.div()('GenericSuperProps', {
      'props.superProp': props.superProp,
    }.toString(),
      'GenericSuperState', {
      'state.superState': state.superState,
    }.toString()
    );
  }
}
