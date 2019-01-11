import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';

//part 'generic_inheritance_super.g.dart';
part 'generic_inheritance_super.over_react.g.dart';

@Factory()
UiFactory<GenericSuperProps> GenericSuper = _$GenericSuper;

// ignore: mixin_of_non_class,undefined_class
class GenericSuperProps extends _$GenericSuperProps with _$GenericSuperPropsAccessorsMixin {}

@Props()
class _$GenericSuperProps extends UiProps {
  static const PropsMeta meta = _$metaForGenericSuperProps;

  String otherSuperProp;
  String superProp;
  String superProp1;
}


// ignore: mixin_of_non_class,undefined_class
abstract class GenericSuperState extends _$GenericSuperState with _$GenericSuperStateAccessorsMixin {}

@State()
class _$GenericSuperState extends UiState {
  static const StateMeta meta = _$metaForGenericSuperState;

  String superState;
}


@Component()
class GenericSuperComponent<T extends GenericSuperProps, V extends GenericSuperState> extends UiStatefulComponent<T, V> {
  getDefaultProps() => newProps()..id = 'generic_super';

  @override
  getInitialState() => newState()..superState = '<generic super state>';

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
