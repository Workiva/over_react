import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'menu_overlay.over_react.g.dart';

/// Use the `MenuOverlay` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.
@Factory()
UiFactory<MenuOverlayProps> MenuOverlay =
    // ignore: undefined_identifier
    _$MenuOverlay;

@Props(keyNamespace: '')
class _$MenuOverlayProps extends UiProps {
  ReactElement trigger;
  bool useDerivedMaxWidth;
}

@State()
class _$MenuOverlayState extends UiState {
  Element anchorEl;
  dynamic menuMaxWidth;
}

@Component2()
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
      }, props.children),
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

// ignore: mixin_of_non_class, undefined_class
class MenuOverlayProps extends _$MenuOverlayProps with _$MenuOverlayPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForMenuOverlayProps;
}

// ignore: mixin_of_non_class, undefined_class
class MenuOverlayState extends _$MenuOverlayState with _$MenuOverlayStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForMenuOverlayState;
}
