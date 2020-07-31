import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:react_material_ui/react_material_ui.dart';

part 'menu_overlay.over_react.g.dart';

/// Use the `MenuOverlay` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.

UiFactory<MenuOverlayProps> MenuOverlay =
    _$MenuOverlay; // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin MenuOverlayProps on UiProps {
  ReactElement trigger;
  bool useDerivedMaxWidth;
}

mixin MenuOverlayState on UiState {
  Element anchorEl;
  dynamic menuMaxWidth;
}

class MenuOverlayComponent extends UiStatefulComponent2<MenuOverlayProps, MenuOverlayState> {
  bool get open => state.anchorEl != null;
  String get id => open ? props.id ?? 'popover' : null;

  @override
  get defaultProps => (newProps()..useDerivedMaxWidth = false);

  @override
  get initialState => (newState()..menuMaxWidth = 'none');

  @override
  render() {
    final propsToForward = Map.of(props)
      ..remove('trigger')
      ..remove('dispatch')
      ..remove('useDerivedMaxWidth');

    return Dom.div()(
      cloneElement(props.trigger, {
        'onClick': _handleTriggerClick,
        'aria-describedby': id,
      }),
      Menu({
        ...propsToForward,
        'MenuListProps': {
          'id': id,
          'style': {
            'maxWidth': state.menuMaxWidth,
          },
        },
        'open': open,
        'anchorEl': state.anchorEl,
        'onClose': close,
        'onEntered': (_, __) {
          if (!props.useDerivedMaxWidth) return;
          final currentMenuWidth = querySelector('#$id')?.getBoundingClientRect()?.width?.ceil();
          if (currentMenuWidth != state.menuMaxWidth) {
            setState(newState()..menuMaxWidth = currentMenuWidth ?? 'none');
          }
        },
      },
        props.children,
      ),
    );
  }

  // TODO: Look into the cloneElement issue with the missing/problematic SyntheticEvent wrapper that forces us to use dynamic here
  void _handleTriggerClick(dynamic event) {
    event.stopPropagation();
    setState(newState()..anchorEl = event.target);
  }

  void close([event, __]) {
    if (!open) return;
    if (event != null) {
      event.stopPropagation();
    }
    setState(newState()..anchorEl = null);
  }
}
