part of w_ui_platform.ui_core;

/// All of the keys used in [ColorProps].
enum ColorPropsKey {
  BACKGROUND_COLOR,
  BORDER_COLOR,
  TEXT_COLOR
}

/// Options for background color property
class BackgroundColor {
  final String className;

  const BackgroundColor._internal(this.className);

  // default
  static const BackgroundColor DEFAULT      = null;

  // application state colors
  static const BackgroundColor ALTERNATE    = const BackgroundColor._internal('bg-alt');
  static const BackgroundColor SUCCESS      = const BackgroundColor._internal('bg-success');
  static const BackgroundColor WARNING      = const BackgroundColor._internal('bg-warning');
  static const BackgroundColor DANGER       = const BackgroundColor._internal('bg-danger');

  // zesty crayon colors
  static const BackgroundColor GREEN        = const BackgroundColor._internal('bg-green');
  static const BackgroundColor GREEN_ALT    = const BackgroundColor._internal('bg-green-alt');
  static const BackgroundColor GREEN_ALT_2  = const BackgroundColor._internal('bg-green-alt2');
  static const BackgroundColor BLUE         = const BackgroundColor._internal('bg-blue');
  static const BackgroundColor ORANGE       = const BackgroundColor._internal('bg-orange');
  static const BackgroundColor RED          = const BackgroundColor._internal('bg-red');
  static const BackgroundColor GRAY         = const BackgroundColor._internal('bg-gray');

  // doc type colors
  static const BackgroundColor DOC_TYPE_BLUE        = const BackgroundColor._internal('bg-doctype-blue');
  static const BackgroundColor DOC_TYPE_LIGHT_BLUE  = const BackgroundColor._internal('bg-doctype-blue-light');
  static const BackgroundColor DOC_TYPE_TEAL        = const BackgroundColor._internal('bg-doctype-teal');
  static const BackgroundColor DOC_TYPE_GRAY        = const BackgroundColor._internal('bg-doctype-gray');
  static const BackgroundColor DOC_TYPE_RED         = const BackgroundColor._internal('bg-doctype-red');
  static const BackgroundColor DOC_TYPE_GREEN       = const BackgroundColor._internal('bg-doctype-green');
  static const BackgroundColor DOC_TYPE_PURPLE      = const BackgroundColor._internal('bg-doctype-purple');
  static const BackgroundColor DOC_TYPE_ORANGE      = const BackgroundColor._internal('bg-doctype-orange');
}

/// Options for border color property
class BorderColor {
  final String className;

  const BorderColor._internal(this.className);

  // default
  static const BorderColor DEFAULT      = null;

  // application state colors
  static const BorderColor ALTERNATE    = const BorderColor._internal('bd-alt');
  static const BorderColor SUCCESS      = const BorderColor._internal('bd-success');
  static const BorderColor WARNING      = const BorderColor._internal('bd-warning');
  static const BorderColor DANGER       = const BorderColor._internal('bd-danger');

  // zesty crayon colors
  static const BorderColor GREEN        = const BorderColor._internal('bd-green');
  static const BorderColor GREEN_ALT    = const BorderColor._internal('bd-green-alt');
  static const BorderColor GREEN_ALT_2  = const BorderColor._internal('bd-green-alt2');
  static const BorderColor BLUE         = const BorderColor._internal('bd-blue');
  static const BorderColor ORANGE       = const BorderColor._internal('bd-orange');
  static const BorderColor RED          = const BorderColor._internal('bd-red');
  static const BorderColor GRAY         = const BorderColor._internal('bd-gray');
}

/// Options for text color property
class TextColor {
  final String className;

  const TextColor._internal(this.className);

  // application state colors
  static const TextColor ALTERNATE    = const TextColor._internal('text-alt');
  static const TextColor SUCCESS      = const TextColor._internal('text-success');
  static const TextColor WARNING      = const TextColor._internal('text-warning');
  static const TextColor DANGER       = const TextColor._internal('text-danger');

  // zesty crayon colors
  static const TextColor GREEN        = const TextColor._internal('text-green');
  static const TextColor GREEN_ALT    = const TextColor._internal('text-green-alt');
  static const TextColor GREEN_ALT_2  = const TextColor._internal('text-green-alt2');
  static const TextColor BLUE         = const TextColor._internal('text-blue');
  static const TextColor ORANGE       = const TextColor._internal('text-orange');
  static const TextColor RED          = const TextColor._internal('text-red');
  static const TextColor GRAY         = const TextColor._internal('text-gray');
}

/// Mixin for component definitions with color props for background, border, and text.
abstract class ColorProps {
  Map get props;

  /// Prop for specifying the background color for components that support it.
  BackgroundColor get backgroundColor => props[ColorPropsKey.BACKGROUND_COLOR];
  set backgroundColor(BackgroundColor value) => props[ColorPropsKey.BACKGROUND_COLOR] = value;

  /// Prop for specifying the border color for components that support it.
  /// This prop will only work if the element already has a 'border-width'
  /// and 'border-style' CSS property set.
  BorderColor get borderColor => props[ColorPropsKey.BORDER_COLOR];
  set borderColor(BorderColor value) => props[ColorPropsKey.BORDER_COLOR] = value;

  TextColor get textColor => props[ColorPropsKey.TEXT_COLOR];
  set textColor(TextColor value) => props[ColorPropsKey.TEXT_COLOR] = value;

  static Map getDefaults() => {
    ColorPropsKey.BACKGROUND_COLOR: null,
    ColorPropsKey.BORDER_COLOR: null,
    ColorPropsKey.TEXT_COLOR: null,
  };

  /// Returns a [Map] of classnames based on existence of values of color props.
  static String getClassNames(Map props) {
    ClassNameBuilder classes = new ClassNameBuilder();

    ColorPropsKey.values.forEach((propKey) {
      if (props.containsKey(propKey) && props[propKey] != null) {
        classes.add(props[propKey].className);
      }
    });

    return classes.toClassName();
  }

}
