import 'dart:math';

import 'package:color/color.dart';
import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'avatar_with_colors.over_react.g.dart';

@Factory()
UiFactory<AvatarWithColorsProps> AvatarWithColors =
    // ignore: undefined_identifier
    _$AvatarWithColors;

@Props()
class _$AvatarWithColorsProps extends UiProps {
  String fullName;
}

@State()
class _$AvatarWithColorsState extends UiState {
  String fullName;
  String backgroundColor;
  String textColor;
}

@Component2()
class AvatarWithColorsComponent extends UiStatefulComponent2<AvatarWithColorsProps, AvatarWithColorsState> {
  @override
  get initialState => (newState()
    ..fullName = props.fullName
    ..addAll(_getDerivedColorsFromName())
  );

  @override
  Map getDerivedStateFromProps(Map nextProps, Map prevState) {
    if (prevState == null) return null; // Initial mount is handled by initialState getter
    final tNextProps = typedPropsFactory(nextProps);
    if (typedStateFactory(prevState).fullName == tNextProps.fullName) return null; // Nothing is going to change. Short-circuit a bunch of color calc logic
    return (newState()
      ..fullName = tNextProps.fullName
      ..addAll(_getDerivedColorsFromName(tNextProps))
    );
  }

  @override
  render() {
    return Avatar({
      'style': {
        'backgroundColor': state.backgroundColor,
        'color': state.textColor,
      }
    }, _renderAvatarContent());
  }

  dynamic _renderAvatarContent() {
    if (props.fullName != null) {
      return _getUserInitials(state.fullName);
    }

    return GroupIcon({'color': 'inherit'});
  }

  Map _getDerivedColorsFromName([AvatarWithColorsProps propsMap]) {
    propsMap ??= props;
    final stateToSet = newState();

    final newBackgroundColor = _getRandomColorBasedOnUserName(propsMap.fullName);
    if (newBackgroundColor != state?.backgroundColor) {
      stateToSet.backgroundColor = newBackgroundColor;

      String newTextColor;
      if (newBackgroundColor == 'transparent') {
        newTextColor = 'inherit';
      } else {
        final lightness = Color.hex(newBackgroundColor).toHslColor().l;
        newTextColor = lightness < 70 ? '#fff' : '#595959';
      }

      if (newTextColor != state?.textColor) {
        stateToSet.textColor = newTextColor;
      }
    }

    if (stateToSet.isNotEmpty) {
      return stateToSet;
    }

    return null;
  }

  static String _getUserInitials(String fullName) {
    if (fullName == null) return ' ';

    String initials;

    var names = splitSpaceDelimitedString(fullName);
    if (names.length > 1) {
      initials = names.first[0].toUpperCase() + names.last[0].toUpperCase();
    } else if (names.length == 1) {
      initials = names.first[0].toUpperCase();
    } else {
      initials = '?';
    }

    return initials;
  }

  static String _getRandomColorBasedOnUserName(String fullName) {
    if (fullName == null) return 'transparent';

    final randomColorPaletteKeyIndex = Random(fullName?.hashCode).nextInt(colors.keys.length - 1);
    final JsBackedMap colorMap = colors[colors.keys.elementAt(randomColorPaletteKeyIndex)];
    final randomColorHueKeyIndex = Random(fullName?.hashCode).nextInt(colorMap.keys.length - 1);
    final String color = colorMap[colorMap.keys.elementAt(randomColorHueKeyIndex)];

    if (color.length == 4) {
      final v = color.split('');
      return '#${v[1]}${v[1]}${v[2]}${v[2]}${v[3]}${v[3]}';
    }

    return color;
  }
}

// ignore: mixin_of_non_class, undefined_class
class AvatarWithColorsProps extends _$AvatarWithColorsProps with _$AvatarWithColorsPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForAvatarWithColorsProps;
}

// ignore: mixin_of_non_class, undefined_class
class AvatarWithColorsState extends _$AvatarWithColorsState with _$AvatarWithColorsStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForAvatarWithColorsState;
}
