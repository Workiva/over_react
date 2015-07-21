part of w_ui_platform.ui_core;

/// Mixin for [Block] props
/// To use:
/// - add [BlockProps] mixin class to component definition.
/// - add [BlockProps] mixin class to component class.
/// - add defaults to getDefaultProps method of component class using [BlockProps.defaultProps]
///   ..addProps(BlockMixin.defaultProps)
/// - call `getBlockClasses` function to retrieve a list of classNames to be added
@GenerateProps(#BlockProps)
abstract class _$template_BlockProps {

  static const String _CONTENT = 'grid-content';
  static const String _OFFSET = 'grid-offset';
  static const String _ORDER = 'grid-order';
  static const String _SHRINK = 'grid-shrink';
  static const String _SIZE = 'grid-block';

  static const String _BLOCK_SM = '-sm';
  static const String _BLOCK_MD = '-md';
  static const String _BLOCK_LG = '-lg';

  /// The size of the [Block] at any screen size.
  @Prop("'$_SIZE'") int get size;

  /// The size of the [Block] above the 'sm' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_SM'") int get smSize;

  /// The size of the [Block] above the 'md' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_MD'") int get mdSize;

  /// The size of the [Block] above the 'lg' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_LG'") int get lgSize;

  /// The order that the [Block] should display in at any screen size.
  @Prop("'$_ORDER'") int get order;

  /// The order that the [Block] should display in above the 'sm' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_SM'") int get smOrder;

  /// The order that the [Block] should display in above the 'md' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_MD'") int get mdOrder;

  /// The order that the [Block] should display in above the 'lg' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_LG'") int get lgOrder;

  /// The offset of the [Block] at any screen size.
  /// Move a [Block] to the right using the offset prop.
  /// This prop increases the left margin of a [Block] by n blocks. For example, offset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET'") int get offset;

  /// The offset of the [Block] above the 'sm' responsive breakpoint.
  /// Move a [Block] to the right using the smOffset prop.
  /// This prop increases the left margin of a small [Block] by n blocks. For example, smOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_SM'") int get smOffset;

  /// The offset of the [Block] above the 'md' responsive breakpoint.
  /// Move a [Block] to the right using the mdOffset prop.
  /// This prop increases the left margin of a medium [Block] by n blocks. For example, mdOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_MD'") int get mdOffset;

  /// The offset of the [Block] above the 'lg' responsive breakpoint.
  /// Move a [Block] to the right using the lgOffset prop.
  /// This prop increases the left margin of a large [Block] by n blocks. For example, lgOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_LG'") int get lgOffset;

  /// Whether this [Block] is a content [Block] at any screen size
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT'") bool get content;

  /// Whether this [Block] is a content [Block] above the 'sm' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_SM'") bool get smContent;

  /// Whether this [Block] is a content [Block] above the 'md' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_MD'") bool get mdContent;

  /// Whether this [Block] is a content [Block] above the 'lg' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_LG'") bool get lgContent;

  /// Whether this [Block] should shrink to the size of its content at any screen size.
  @Prop("'$_SHRINK'") bool get shrink;

  /// Whether this [Block] should shrink to the size of its content above the 'sm' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_SM'") bool get smShrink;

  /// Whether this [Block] should shrink to the size of its content above the 'md' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_MD'") bool get mdShrink;

  /// Whether this [Block] should shrink to the size of its content above the 'lg' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_LG'") bool get lgShrink;

  /// Determines what sides of the [Block] to collapse.
  /// Valid values are:
  /// > 1. Any option from [BlockCollapse]
  /// > 2. Any combination of options from [BlockCollapse]
  /// >> - To use multiple BlockCollapse options use the bit-wise or operator.
  /// For example if you wanted to collapse the right and top side of the [Block] you would set the collapse prop to:
  /// `BlockCollapse.RIGHT | BlockCollapse.TOP`
  ///
  /// Default: BlockCollapse.NONE
  int get collapse;

  /// Whether to add a gutter around the [Block]
  /// Valid values are:
  ///    1. BlockGutter.NONE (default).
  ///    2. BlockGutter.ALL.
  ///    3. BlockGutter.HORIZONTAL or BlockGutter.VERTICAL.
  ///
  /// Default: BlockGutter.NONE
  BlockGutter get gutter;

  /// Whether the [Block] should enable scrolling.
  ///
  /// Default: true
  bool get scroll;
}

abstract class BlockMixin<P extends BlockProps> {
  /// Standard BlockMixin defaults.
  static const Map defaultProps = const {
    BlockProps.Z_$KEY__COLLAPSE: BlockCollapse.NONE,
    BlockProps.Z_$KEY__CONTENT: false,
    BlockProps.Z_$KEY__SM_CONTENT: false,
    BlockProps.Z_$KEY__MD_CONTENT: false,
    BlockProps.Z_$KEY__LG_CONTENT: false,
    BlockProps.Z_$KEY__SHRINK: false,
    BlockProps.Z_$KEY__SM_SHRINK: false,
    BlockProps.Z_$KEY__MD_SHRINK: false,
    BlockProps.Z_$KEY__LG_SHRINK: false,
    BlockProps.Z_$KEY__SCROLL: true,
    BlockProps.Z_$KEY__GUTTER: BlockGutter.NONE
  };

  P get tProps;
  Map get props;

  /// Get all the CSS classes generated by the [BlockMixin]
  String getBlockClasses() {
    ClassNameBuilder blockClasses = new ClassNameBuilder();

    // Copy over the prop keys and remove any that we
    // do not want to iterate over
    List<String> keys = new List()
      ..addAll(BlockProps.Z_$propKeys)
      ..remove(BlockProps.Z_$KEY__SCROLL)
      ..remove(BlockProps.Z_$KEY__COLLAPSE)
      ..remove(BlockProps.Z_$KEY__GUTTER);

    // Iterate the props keys: (keys should be the class name required)
    // - For int props append the provided value with a hyphen to complete the full class name
    // - For bool props add the key directly.
    for (String classPrefix in keys) {
      var value = props[classPrefix];

      if (value != null) {
        var className;

        if (value is int && value >= 0) {
          className = (classPrefix + '-' + value.toString());
        } else if (value) {
          className = classPrefix;
        }

        if (className != null) {
          blockClasses.add(className);
        }
      }
    }

    blockClasses.add(_getCollapseClasses());
    blockClasses.add(tProps.gutter.className);

    if (!tProps.scroll) {
      blockClasses.add('no-scroll');
    }

    return blockClasses.toClassName();
  }

  /// Get the classNames for the collapsing the padding of the [Block].
  String _getCollapseClasses() {
    if (tProps.collapse == BlockCollapse.NONE) {
      return null;
    }

    var collapseClasses = new ClassNameBuilder();

    // Determine the type for the collapse prop
    if ((tProps.collapse & BlockCollapse.ALL) != 0) {
      collapseClasses.add('grid-collapse');
    } else {
      if ((tProps.collapse & BlockCollapse.VERTICAL) != 0) {
        collapseClasses.add('grid-collapse-vertical');
      } else {
        if ((tProps.collapse & BlockCollapse.RIGHT) != 0) {
          collapseClasses.add('grid-collapse-right');
        }

        if ((tProps.collapse & BlockCollapse.LEFT) != 0) {
          collapseClasses.add('grid-collapse-left');
        }
      }

      if ((tProps.collapse & BlockCollapse.HORIZONTAL) != 0) {
        collapseClasses.add('grid-collapse-horizontal');
      } else {
        if ((tProps.collapse & BlockCollapse.TOP) != 0) {
          collapseClasses.add('grid-collapse-top');
        }

        if ((tProps.collapse & BlockCollapse.BOTTOM) != 0) {
          collapseClasses.add('grid-collapse-bottom');
        }
      }
    }

    return collapseClasses.toClassName();
  }
}

/// The collapse options for the [Block].
/// Collapses the padding on the specified side.
/// See: <https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content-padding>.
abstract class BlockCollapse {
  /// > Insures all sides keep their padding.
  // Value = 0000
  static const int NONE = 0;

  /// > Collapses the top padding.
  // Value = 0001
  static const int TOP = 1 << 0;

  /// > Collapses the left padding.
  // Value = 0010
  static const int LEFT = 1 << 1;

  /// > Collapses the bottom padding.
  // Value = 0100
  static const int BOTTOM = 1 << 2;

  /// > Collapses the right padding.
  // Value = 1000
  static const int RIGHT = 1 << 3;

  /// > Collapses the top and bottom padding.
  // Value = 0001 | 0100 = 0101
  static const int HORIZONTAL = (TOP | BOTTOM);

  /// > Collapses the left and right padding.
  // Value = 0010 | 1000 = 1010
  static const int VERTICAL = (LEFT | RIGHT);

  /// > Collapses top, bottom, left, and right padding.
  // Value = 0101 | 1010 = 1111
  static const int ALL = (HORIZONTAL | VERTICAL);
}

/// The gutter options for the [Block].
/// Used to add negative space beteen nested [Block]s but need to continue nesting more blocks within them,
/// use the gutter prop.
/// See: <https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-gutters>.
@GenerateConstants(#BlockGutter, #className)
class _$template_BlockGutter {
  static const NONE = null;
  static const ALL = 'grid-gutter';
  static const HORIZONTAL = 'grid-gutter-horizontal';
  static const VERTICAL = 'grid-gutter-vertical';
}
