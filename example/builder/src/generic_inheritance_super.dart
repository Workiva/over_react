import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';

part 'generic_inheritance_super.over_react.g.dart';

@Factory()
UiFactory<GenericSuperProps> GenericSuper = _$GenericSuper;

@Props()
class _$GenericSuperProps extends UiProps {
  String otherSuperProp;
  String superProp;
  String superProp1;
}

@State()
class _$GenericSuperState extends UiState {
  String superState;
}


@Component2()
class GenericSuperComponent<T extends GenericSuperProps, V extends GenericSuperState> extends UiStatefulComponent2<T, V> {
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
