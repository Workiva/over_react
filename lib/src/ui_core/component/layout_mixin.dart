part of w_ui_platform.ui_core;

/// Mixin for [GridBlock] layout options
/// To use:
/// - add [LayoutProps] mixin class to component definition.
/// - add [LayoutProps] mixin class to component class.
/// - add defaults to getDefaultProps method of component class using [LayoutProps.defaultProps]
///   ..addProps(LayoutMixin.defaultProps)
/// - call `getLayoutClasses` function to retrieve a list of classNames to be added
@GenerateProps(#LayoutProps)
abstract class _$template_LayoutProps {

  static const String _ALIGN = 'grid-align';
  static const String _UP = 'grid-up';
  static const String _WRAP = 'grid-wrap';
  static const String _LAYOUT = 'grid';

  static const String _BLOCK_SM = '-sm';
  static const String _BLOCK_MD = '-md';
  static const String _BLOCK_LG = '-lg';

  /// The number of blocks can fit horizontally in one "row" at any screen size.
  @Prop("'$_UP'") int get up;

  /// The number of blocks can fit horizontally in one "row" above the 'sm' responsive breakpoint.
  @Prop("'$_UP$_BLOCK_SM'") int get smUp;

  /// The number of blocks can fit horizontally in one "row" above the 'md' responsive breakpoint.
  @Prop("'$_UP$_BLOCK_MD'") int get mdUp;

  /// The number of blocks can fit horizontally in one "row" above the 'lg' responsive breakpoint.
  @Prop("'$_UP$_BLOCK_LG'") int get lgUp;

  /// Make child blocks wrap to the next line if they take up too much space at any screen size.
  @Prop("'$_WRAP'") int get wrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'sm' responsive breakpoint.
  @Prop("'$_WRAP$_BLOCK_SM'") int get smWrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'md' responsive breakpoint.
  @Prop("'$_WRAP$_BLOCK_MD'") int get mdWrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'lg' responsive breakpoint.
  @Prop("'$_WRAP$_BLOCK_LG'") int get lgWrap;

  /// Alignment for child blocks at any screen size.
  ///
  /// Default: [BlockLayout.LEFT]
  @Prop("'$_ALIGN-?'") BlockAlign get align;

  /// Alignment for child blocks above the 'sm' responsive breakpoint.
  @Prop("'$_ALIGN-?$_BLOCK_SM'") BlockAlign get smAlign;

  /// Alignment for child blocks above the 'md' responsive breakpoint.
  @Prop("'$_ALIGN-?$_BLOCK_MD'") BlockAlign get mdAlign;

  /// Alignment for child blocks above the 'lg' responsive breakpoint.
  @Prop("'$_ALIGN-?$_BLOCK_LG'") BlockAlign get lgAlign;

  /// Alignment for child blocks at any screen size.
  @Prop("'$_LAYOUT-?'") BlockLayout get layout;

  /// Alignment for child blocks above the 'sm' responsive breakpoint.
  @Prop("'$_LAYOUT-?$_BLOCK_SM'") BlockLayout get smLayout;

  /// Alignment for child blocks above the 'md' responsive breakpoint.
  @Prop("'$_LAYOUT-?$_BLOCK_MD'") BlockLayout get mdLayout;

  /// Alignment for child blocks above the 'lg' responsive breakpoint.
  @Prop("'$_LAYOUT-?$_BLOCK_LG'") BlockLayout get lgLayout;

  /// Whether this [GridBlock] is nested inside of another [GridBlock].
  ///
  /// * This is required to be true to make vertical grid layouts work when
  ///   nested within one-another.
  ///
  /// Default: false
  bool get isNested;
}

abstract class LayoutMixin<P extends LayoutProps> {
  /// Standard HitAreaProps defaults.
  static const Map defaultProps = const {
    LayoutProps.Z_$KEY__IS_NESTED: false,
    LayoutProps.Z_$KEY__ALIGN: BlockAlign.LEFT,
  };

  P get tProps;
  Map get props;

  /// Get all the required classNames for the block mixin
  String getBlockLayoutClasses() {
    ClassNameBuilder layoutClasses = new ClassNameBuilder();

    // Copy over the prop keys and remove any that we
    // do not want to iterate over
    List<String> keys = new List()
      ..addAll(LayoutProps.Z_$propKeys)
      ..remove(LayoutProps.Z_$KEY__IS_NESTED);

    // Iterate the props keys: (keys should be the class name required)
    // - For int props append the provided value with a hyphen to complete the full class name
    // - For bool props add the key directly.
    // - For BlockLayout and BlockAlign we need to replace the '?' with the value
    for (String classPrefix in keys) {
      var value = props[classPrefix];
      if (value != null) {
        var className;
        if (value is int && value >= 0) {
          className = (classPrefix + '-' + value.toString());
        } else if (value is bool && value == true) {
          className = classPrefix;
        } else if (value is BlockAlign) {
          var align = (value as BlockAlign);
          if (align.classPart != null) {
            className = classPrefix.replaceFirst('?', align.classPart);
          }
        } else if (value is BlockLayout) {
          var layout = (value as BlockLayout);
          if (layout.classPart != null) {
            className = classPrefix.replaceFirst('?', layout.classPart);
          }
        }

        if (className != null) {
          layoutClasses.add(className);
        }
      }
    }

    return layoutClasses.toClassName();
  }
}

/// The alignment options for the [GridBlock]
@GenerateConstants(#BlockAlign, #classPart)
class _$template_BlockAlign {
  static const LEFT = null;
  static const RIGHT = 'right';
  static const CENTER = 'center';
  static const JUSTIFIED = 'justified';
  static const SPACED = 'spaced';
}

/// The alignment options for the [GridBlock]
@GenerateConstants(#BlockLayout, #classPart)
class _$template_BlockLayout {
  static const NONE = null;
  static const HORIZONTAL = 'horizontal';
  static const VERTICAL = 'vertical';
}
