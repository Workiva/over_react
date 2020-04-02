import 'package:over_react/over_react.dart';

part 'with_legacy_props_mixin.over_react.g.dart';

UiFactory<BasicProps> Basic = _$Basic; // ignore: undefined_identifier

mixin BasicPropsMixin on UiProps {
  String basicProp;
}

class BasicProps = UiProps with BasicPropsMixin, TransitionPropsMixin;

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  get defaultProps => (newProps()
    ..basicProp = 'basicProp'
    ..transitionCount = 2
  );

  @override
  render() {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('default prop testing: ${props.basicProp}'),
      Dom.div()('default prop testing (from legacy mixin): ${props.transitionCount}'),
    );
  }
}
