import 'package:meta/meta.dart';
import 'package:web_skin_dart/src/toolbars/base/abstract_toolbar_component.dart';
import 'package:web_skin_dart/src/toolbars/base/utils.dart';
import 'super_class.dart' as parent;
import 'package:web_skin_dart/ui_core.dart';

part 'button.overReactBuilder.g.dart';

@Factory()
UiFactory<ButtonProps> Button;

@Props()
class ButtonProps extends wsd.ButtonProps {}

@Component(subtypeOf: wsd.ButtonComponent)
class ButtonComponent extends AbstractToolbarItemComponent<ButtonProps, wsd.ButtonComponent> {
  @override
  Map getDefaultProps() => (newProps()
    ..isVertical = false
  );

  @override
  UiFactory<wsd.ButtonProps> get baseFactory => wsd.Button;

  @override
  Map getOverridingBaseProps() {
    return baseFactory()
      ..skin = getButtonSkin(props.isVertical)
      ..size = getButtonSize(props.isVertical)
      ..allowedHandlersWhenDisabled = wsd.EventHandlers.MOUSE_HOVER;
  }

  @override
  Map getAdditionalProps() {
    return baseFactory()
      ..onClick = mouseEventCallbacks.chain(props.onClick, (_) { restoreFocus(); })
      ..onMouseDown = mouseEventCallbacks.chain(props.onMouseDown, (_) { storeFocus(); })
      ..onTouchStart = touchEventCallbacks.chain(props.onTouchStart, (_) { storeFocus(); });
  }

  @override
  @mustCallSuper
  void validateProps(Map propsMap) {
    super.validateProps(propsMap);

    assert(!typedPropsFactory(propsMap).isVertical || ValidationUtil.warn(
        'It looks like you are trying to make a vertical button, it is recommended that you use VerticalButton instead.'
    ));
  }
}