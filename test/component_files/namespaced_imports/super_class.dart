
/// Use Button to quickly make a styled `.btn` DOM node.
///
/// See: <https://dev.workiva.net/docs/api/web_skin_dart/latest/components/#button>.
@Factory()
UiFactory<ButtonProps> Button;

@PropsMixin()
abstract class ButtonPropsMixin implements UiProps {
  @override
  Map get props;

  String parentPropMixin1;
}

@Props()
class ButtonProps extends UiProps
    with ButtonPropsMixin {}

@Component()
class ButtonComponent extends UiComponent<ButtonProps> {
  getDefaultProps() => newProps()..id = 'basic';

  @override
  render() {
    return Dom.div()(props., props.basic5);
  }
}

/// A MapView with the typed getters/setters for [ButtonPropsMixin] and [ButtonDisplayPropsMixin].
class ButtonPropsMapView extends UiPropsMapView with
    ButtonPropsMixin,
    ButtonDisplayPropsMixin,
    HitAreaDisplayVariationPropsMixin {
  /// Create a new instance backed by the specified map.
  ButtonPropsMapView(Map map) : super(map);
}
