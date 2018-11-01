import 'package:over_react/over_react.dart';
import 'generic_inheritance_super.dart';

part 'generic_inheritance_sub.overReact.g.dart';

@Factory()
UiFactory<GenericSubProps> GenericSub = $GenericSub;

// ignore: mixin_of_non_class,undefined_class
class GenericSubProps extends UiProps with _$GenericSubPropsAccessorsMixin implements _$GenericSubProps {}

@Props()
class _$GenericSubProps extends GenericSuperProps {
  static const PropsMeta meta = $metaForGenericSubProps;

  String subProp;
}

// ignore: mixin_of_non_class,undefined_class
abstract class GenericSubState extends UiState with _$GenericSubStateAccessorsMixin implements _$GenericSubState {}

@State()
class _$GenericSubState extends GenericSuperState {
  static const StateMeta meta = $metaForGenericSubState;

  String subState;
}

@Component()
class GenericSubComponent extends GenericSuperComponent<GenericSubProps, GenericSubState> {
  getDefaultProps() => newProps()..id = 'generic_sub';

  @override
  getInitialState() => newState()
    ..subState = '<generic sub state>'
    ..superState= '<generic super state>';

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

