import 'package:over_react/over_react.dart';
import 'generic_inheritance_super.dart';

part 'generic_inheritance_sub.over_react.g.dart';

@Factory()
UiFactory<GenericSubProps> GenericSub = _$GenericSub;

class GenericSubProps extends _$GenericSubProps with _$GenericSubPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForGenericSubProps;
}

@Props()
class _$GenericSubProps extends GenericSuperProps {
  String subProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class GenericSubState extends _$GenericSubState with _$GenericSubStateAccessorsMixin {
  static const StateMeta meta = _$metaForGenericSubState;
}

@State()
class _$GenericSubState extends GenericSuperState {
  String subState;
}

@Component()
class GenericSubComponent extends GenericSuperComponent<GenericSubProps, GenericSubState> {
  @override
  Map getDefaultProps() => newProps()..id = 'generic_sub';

  @override
  Map getInitialState() => newState()
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

