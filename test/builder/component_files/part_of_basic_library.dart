part of basic.library;

@Factory()
UiFactory<BasicPartOfLibProps> BasicPartOfLib = _$BasicPartOfLib;

// ignore: mixin_of_non_class,undefined_class
class BasicPartOfLibProps extends _$BasicPartOfLibProps with _$BasicPartOfLibPropsAccessorsMixin {}

@Props()
class _$BasicPartOfLibProps extends UiProps
// ignore: mixin_of_non_class,undefined_class
    with  ExamplePropsMixinClass, $ExamplePropsMixinClass {
  static const PropsMeta meta = _$metaForBasicPartOfLibProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

// ignore: mixin_of_non_class,undefined_class
abstract class BasicPartOfLibState extends _$BasicPartOfLibState with _$BasicPartOfLibStateAccessorsMixin {}

@State()
class _$BasicPartOfLibState extends UiState
// ignore: mixin_of_non_class,undefined_class
    with ExampleStateMixinClass, $ExampleStateMixinClass {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForBasicPartOfLibState;

  String basicState;
}

@Component()
class BasicPartOfLibComponent extends UiStatefulComponent<BasicPartOfLibProps, BasicPartOfLibState> {
  @override
  Map getDefaultProps() => newProps()..id = 'BasicPartOfLib';

  @override
  Map getInitialState() => newState()..basicState = '<Basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        'BasicPartOfLibComponentProps: ${props.basicProp}, ${props.propMixin1}',
        'BasicPartOfLibComponentState: ${state.basicState}, ${state.stateMixin1}');
  }
}
