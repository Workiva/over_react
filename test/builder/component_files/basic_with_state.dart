import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;


part 'basic.overReact.g.dart';

@Factory()
UiFactory<BasicProps> Basic = $Basic;

// ignore: mixin_of_non_class,undefined_class
class BasicProps extends UiProps with _$BasicPropsAccessorsMixin implements _$BasicProps {}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps with pm.$ExamplePropsMixinClass, pm.ExamplePropsMixinClass {
  static const PropsMeta meta = $metaForBasicProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

// ignore: mixin_of_non_class,undefined_class
abstract class BasicState extends UiState with _$BasicStateAccessorsMixin implements _$BasicState {}

@State()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicState extends UiState {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForBasicState;

  String basicState;
}


@Component()
class BasicComponent extends UiStatefulComponent<BasicProps, BasicState> {
  getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps';

  getInitialState() => newState()..basicState = 'basic state';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
        Dom.div()('default state testing:  ${state.basicState}'),
    );
  }
}
