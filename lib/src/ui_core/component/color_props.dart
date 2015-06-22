part of w_ui_platform.ui_core;

/// Options for background color property
@GenerateConstants(#BackgroundColor, #className)
class _$template_BackgroundColor {
  // default
  static const DEFAULT      = null;

  // application state colors
  static const ALTERNATE    = 'bg-alt';
  static const SUCCESS      = 'bg-success';
  static const WARNING      = 'bg-warning';
  static const DANGER       = 'bg-danger';

  // zesty crayon colors
  static const GREEN        = 'bg-green';
  static const GREEN_ALT    = 'bg-green-alt';
  static const GREEN_ALT_2  = 'bg-green-alt2';
  static const BLUE         = 'bg-blue';
  static const ORANGE       = 'bg-orange';
  static const RED          = 'bg-red';
  static const GRAY         = 'bg-gray';

  // doc type colors
  static const DOC_TYPE_BLUE        = 'bg-doctype-blue';
  static const DOC_TYPE_LIGHT_BLUE  = 'bg-doctype-blue-light';
  static const DOC_TYPE_TEAL        = 'bg-doctype-teal';
  static const DOC_TYPE_GRAY        = 'bg-doctype-gray';
  static const DOC_TYPE_RED         = 'bg-doctype-red';
  static const DOC_TYPE_GREEN       = 'bg-doctype-green';
  static const DOC_TYPE_PURPLE      = 'bg-doctype-purple';
  static const DOC_TYPE_ORANGE      = 'bg-doctype-orange';
  static const DOC_TYPE_MAGENTA     = 'bg-doctype-magenta';
}

/// Options for border color property
@GenerateConstants(#BorderColor, #className)
class _$template_BorderColor {
  // default
  static const DEFAULT      = null;

  // application state colors
  static const ALTERNATE    = 'bd-alt';
  static const SUCCESS      = 'bd-success';
  static const WARNING      = 'bd-warning';
  static const DANGER       = 'bd-danger';

  // zesty crayon colors
  static const GREEN        = 'bd-green';
  static const GREEN_ALT    = 'bd-green-alt';
  static const GREEN_ALT_2  = 'bd-green-alt2';
  static const BLUE         = 'bd-blue';
  static const ORANGE       = 'bd-orange';
  static const RED          = 'bd-red';
  static const GRAY         = 'bd-gray';
  static const whaha        = 'djldsjkld';
}

/// Options for text color property
@GenerateConstants(#TextColor, #className)
class _$template_TextColor {
  // application state colors
  static const ALTERNATE    = 'text-alt';
  static const SUCCESS      = 'text-success';
  static const WARNING      = 'text-warning';
  static const DANGER       = 'text-danger';

  // zesty crayon colors
  static const GREEN        = 'text-green';
  static const GREEN_ALT    = 'text-green-alt';
  static const GREEN_ALT_2  = 'text-green-alt2';
  static const BLUE         = 'text-blue';
  static const ORANGE       = 'text-orange';
  static const RED          = 'text-red';
  static const GRAY         = 'text-gray';
}

/// All of the keys used in [ColorProps].
enum ColorPropsKey {
  BACKGROUND_COLOR,
  BORDER_COLOR,
  TEXT_COLOR
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
