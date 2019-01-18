import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;
import 'state_mixin.dart';


part 'basic_with_state.over_react.g.dart';

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

// ignore: mixin_of_non_class,undefined_class
class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps with  pm.ExamplePropsMixinClass, pm.$ExamplePropsMixinClass {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForBasicProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

// ignore: mixin_of_non_class,undefined_class
abstract class BasicState extends _$BasicState with _$BasicStateAccessorsMixin {}

@State()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicState extends UiState with $ExampleStateMixinClass, ExampleStateMixinClass {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForBasicState;

  String basicState;
}


@Component()
class BasicComponent extends UiStatefulComponent<BasicProps, BasicState> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps';

  @override
  Map getInitialState() => newState()..basicState = '<basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
        Dom.div()('default state testing:  ${state.basicState}'),
        Dom.div()('state mixin in basic.dart: ${state.stateMixin1}'),
    );
  }
}
