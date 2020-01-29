import 'dart:math';

import 'package:color/color.dart';
import 'package:memoize/memoize.dart';
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

@Component2()
class AvatarWithColorsComponent extends UiComponent2<AvatarWithColorsProps> {
  @override
  render() {
    return Avatar({
      'style': {
        'backgroundColor': _backgroundColorMemo(props.fullName),
        'color': _textColorMemo(_backgroundColorMemo(props.fullName)),
      },
    },
      _renderAvatarContent(),
    );
  }

  dynamic _renderAvatarContent() {
    if (props.fullName != null) {
      return _getUserInitials(props.fullName);
    }

    return GroupIcon({'color': 'inherit'});
  }

  static final _backgroundColorMemo = memo1(_getRandomColorBasedOnUserName);
  static final _textColorMemo = memo1<String, String>((backgroundColor) {
    if (backgroundColor == 'transparent') return 'inherit';

    final lightness = Color.hex(backgroundColor).toHslColor().l;
    return lightness < 70 ? '#fff' : '#595959';
  });

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

    final randomColorPaletteKeyIndex = Random(fullName?.hashCode).nextInt(muiColors.keys.length - 1);
    final JsBackedMap colorMap = muiColors[muiColors.keys.elementAt(randomColorPaletteKeyIndex)];
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
