import 'package:over_react/over_react.dart';
import 'generic_inheritance_super.dart';

// ignore_for_file: uri_has_not_been_generated
import 'generic_inheritance_sub.example.over_react.g.dart' as $;
export 'generic_inheritance_sub.example.over_react.g.dart';

UiFactory<GenericSubProps> GenericSub = $.$GenericSub;

class GenericSubProps = UiProps with GenericSuperPropsMixin, GenericSubPropsMixin;
class GenericSubState = UiState with GenericSuperStateMixin, GenericSubStateMixin;

mixin GenericSubPropsMixin on UiProps, GenericSuperPropsMixin {
  String subProp;
}

mixin GenericSubStateMixin on UiState, GenericSuperStateMixin {
  String subState;
}

class GenericSubComponent extends GenericSuperComponent<GenericSubPropsMixin, GenericSubStateMixin> {
  @override
  get defaultProps => newProps()..id = 'generic_sub';

  @override
  get initialState => newState()
    ..subState = '<generic sub state>'
    ..superState = '<generic super state>';

  @override
  render() {
    return Dom.div()('GenericSubProps', {
      'props.subProp': props.subProp,
      'props.superProps': props.superProp,
    }.toString(),
        'GenericSubState', {
      'props.subState': state.subState,
      'state.superState': state.superState,
    }.toString()
    );
  }
}

