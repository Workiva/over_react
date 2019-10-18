import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'private_component.over_react.g.dart' as _$;
export 'private_component.over_react.g.dart';

UiFactory<_PrivatePropsMixin> _Private = _$.$Private;

mixin _PrivatePropsMixin on UiProps {
  bool prop1;
}

mixin _PrivateStateMixin on UiState {
  bool state1;
}

@Component2()
class PrivateComponent extends UiStatefulComponent2<_PrivatePropsMixin, _PrivateStateMixin> {
  @override
  get defaultProps => newProps()..prop1 = true;

  @override
  get initialState => newState()..state1 = true;

  @override
  render() {
    return Dom.div()('PrivateComponent', {
      'props.prop1': props.prop1,
      'props.state1': state.state1,
    }.toString());
  }
}
