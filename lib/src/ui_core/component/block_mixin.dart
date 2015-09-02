part of web_skin_dart.ui_core;

/// Mixin for [Block] props
/// To use:
/// - add [BlockProps] mixin class to component definition.
/// - add [BlockProps] mixin class to component class.
/// - add defaults to getDefaultProps method of component class using [BlockProps.defaultProps]
///   ..addProps(BlockMixin.defaultProps)
/// - call `getBlockClasses` function to retrieve a list of classNames to be added
@GenerateProps(#BlockProps)
abstract class _$template_BlockProps {
  /// The size of the [Block] at any screen size.
  ///
  /// When this prop is a positive integer, a CSS class for the specified size will be added,
  /// in addition to the base class.
  ///
  /// When this prop is any other value besides `false` or `null`, only the base class will be added.
  ///
  /// Example:
  /// <code><pre>
  ///     (Block()..size = 2)()      ->  adds 'grid-block grid-block-2'
  ///     (Block()..size = true)()   ->  only adds 'grid-block'
  ///     (Block())()                ->  only adds 'grid-block' (default of [size] is true)
  ///     (Block()..size = false)()  ->  does not add 'grid-block'
  ///
  ///
  /// Default: true
  dynamic get size;

  /// The size of the [Block] above the 'sm' responsive breakpoint.
  ///
  /// When this prop is a positive integer, a breakpoint-specific CSS class for the specified size will be added,
  /// in addition to the breakpoint-specific base class.
  ///
  /// When this prop is any other value besides `false` or `null`, only the breakpoint-specific base class will be added.
  ///
  /// Example:
  /// <code><pre>
  ///     (Block()..smSize = 2)()      ->  adds 'grid-block-sm' and 'grid-block-sm-2'
  ///     (Block()..smSize = true)()   ->  only adds 'grid-block-sm'
  ///     (Block()..smSize = false)()  ->  does not add 'grid-block-sm'
  /// </pre></code>
  dynamic get smSize;

  /// The size of the [Block] above the 'md' responsive breakpoint.
  ///
  /// When this prop is a positive integer, a breakpoint-specific CSS class for the specified size will be added,
  /// in addition to the breakpoint-specific base class.
  ///
  /// When this prop is any other value besides `false` or `null`, only the breakpoint-specific base class will be added.
  ///
  /// Example:
  /// <code><pre>
  ///     (Block()..mdSize = 2)()      ->  adds 'grid-block-md' and 'grid-block-md-2'
  ///     (Block()..mdSize = true)()   ->  only adds 'grid-block-md'
  ///     (Block()..mdSize = false)()  ->  does not add 'grid-block-md'
  /// </pre></code>
  dynamic get mdSize;

  /// The size of the [Block] above the 'lg' responsive breakpoint.
  ///
  /// When this prop is a positive integer, a breakpoint-specific CSS class for the specified size will be added,
  /// in addition to the breakpoint-specific base class.
  ///
  /// When this prop is any other value besides `false` or `null`, only the breakpoint-specific base class will be added.
  ///
  /// Example:
  /// <code><pre>
  ///     (Block()..lgSize = 2)()      ->  adds 'grid-block-lg' and 'grid-block-lg-2'
  ///     (Block()..lgSize = true)()   ->  only adds 'grid-block-lg'
  ///     (Block()..lgSize = false)()  ->  does not add 'grid-block-lg'
  /// </pre></code>
  dynamic get lgSize;

  /// The order that the [Block] should display in at any screen size.
  int get order;

  /// The order that the [Block] should display in above the 'sm' responsive breakpoint.
  int get smOrder;

  /// The order that the [Block] should display in above the 'md' responsive breakpoint.
  int get mdOrder;

  /// The order that the [Block] should display in above the 'lg' responsive breakpoint.
  int get lgOrder;

  /// The offset of the [Block] at any screen size.
  /// Move a [Block] to the right using the offset prop.
  /// This prop increases the left margin of a [Block] by n blocks. For example, offset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  int get offset;

  /// The offset of the [Block] above the 'sm' responsive breakpoint.
  /// Move a [Block] to the right using the smOffset prop.
  /// This prop increases the left margin of a small [Block] by n blocks. For example, smOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  int get smOffset;

  /// The offset of the [Block] above the 'md' responsive breakpoint.
  /// Move a [Block] to the right using the mdOffset prop.
  /// This prop increases the left margin of a medium [Block] by n blocks. For example, mdOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  int get mdOffset;

  /// The offset of the [Block] above the 'lg' responsive breakpoint.
  /// Move a [Block] to the right using the lgOffset prop.
  /// This prop increases the left margin of a large [Block] by n blocks. For example, lgOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  int get lgOffset;

  /// Whether this [Block] is a content [Block] at any screen size
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  bool get content;

  /// Whether this [Block] is a content [Block] above the 'sm' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  bool get smContent;

  /// Whether this [Block] is a content [Block] above the 'md' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  bool get mdContent;

  /// Whether this [Block] is a content [Block] above the 'lg' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  bool get lgContent;

  /// Whether this [Block] should shrink to the size of its content at any screen size.
  bool get shrink;

  /// Whether this [Block] should shrink to the size of its content above the 'sm' responsive breakpoint.
  bool get smShrink;

  /// Whether this [Block] should shrink to the size of its content above the 'md' responsive breakpoint.
  bool get mdShrink;

  /// Whether this [Block] should shrink to the size of its content above the 'lg' responsive breakpoint.
  bool get lgShrink;

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
    // Default the base size to true so 'grid-block' is added by default.
    BlockProps.Z_$KEY__SIZE: true,
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
    const String gridBlock   = 'grid-block';
    const String gridOrder   = 'grid-order';
    const String gridOffset  = 'grid-offset';
    const String gridContent = 'grid-content';
    const String gridShrink  = 'grid-shrink';

    const String blockSm = 'sm';
    const String blockMd = 'md';
    const String blockLg = 'lg';

    ClassNameBuilder blockClasses = new ClassNameBuilder()
      ..add('$gridBlock',          tProps.size   != false && tProps.size   != null)
      ..add('$gridBlock-$blockSm', tProps.smSize != false && tProps.smSize != null)
      ..add('$gridBlock-$blockMd', tProps.mdSize != false && tProps.mdSize != null)
      ..add('$gridBlock-$blockLg', tProps.lgSize != false && tProps.lgSize != null)

      ..add((tProps.size   is int && tProps.size   >= 1) ? '$gridBlock-${tProps.size}'            : null)
      ..add((tProps.smSize is int && tProps.smSize >= 1) ? '$gridBlock-$blockSm-${tProps.smSize}' : null)
      ..add((tProps.mdSize is int && tProps.mdSize >= 1) ? '$gridBlock-$blockMd-${tProps.mdSize}' : null)
      ..add((tProps.lgSize is int && tProps.lgSize >= 1) ? '$gridBlock-$blockLg-${tProps.lgSize}' : null)

      ..add((tProps.order   != null && tProps.order   >= 1) ? '$gridOrder-${tProps.order}'            : null)
      ..add((tProps.smOrder != null && tProps.smOrder >= 1) ? '$gridOrder-$blockSm-${tProps.smOrder}' : null)
      ..add((tProps.mdOrder != null && tProps.mdOrder >= 1) ? '$gridOrder-$blockMd-${tProps.mdOrder}' : null)
      ..add((tProps.lgOrder != null && tProps.lgOrder >= 1) ? '$gridOrder-$blockLg-${tProps.lgOrder}' : null)

      ..add((tProps.offset   != null && tProps.offset   >= 1) ? '$gridOffset-${tProps.offset}'            : null)
      ..add((tProps.smOffset != null && tProps.smOffset >= 1) ? '$gridOffset-$blockSm-${tProps.smOffset}' : null)
      ..add((tProps.mdOffset != null && tProps.mdOffset >= 1) ? '$gridOffset-$blockMd-${tProps.mdOffset}' : null)
      ..add((tProps.lgOffset != null && tProps.lgOffset >= 1) ? '$gridOffset-$blockLg-${tProps.lgOffset}' : null)

      ..add('$gridContent',          tProps.content)
      ..add('$gridContent-$blockSm', tProps.smContent)
      ..add('$gridContent-$blockMd', tProps.mdContent)
      ..add('$gridContent-$blockLg', tProps.lgContent)

      ..add('$gridShrink',          tProps.shrink)
      ..add('$gridShrink-$blockSm', tProps.smShrink)
      ..add('$gridShrink-$blockMd', tProps.mdShrink)
      ..add('$gridShrink-$blockLg', tProps.lgShrink)

      ..add(_getCollapseClasses())
      ..add(tProps.gutter.className)
      ..add('no-scroll', !tProps.scroll);

    return blockClasses.toClassName();
  }

  /// Get the classNames for the collapsing the padding of the [Block].
  String _getCollapseClasses() {
    if (tProps.collapse == BlockCollapse.NONE) {
      return null;
    }

    var collapseClasses = new ClassNameBuilder();

    // Determine the type for the collapse prop
    if (tProps.collapse == BlockCollapse.ALL) {
      collapseClasses.add('grid-collapse');
    } else {
      if ((tProps.collapse & BlockCollapse.VERTICAL) == BlockCollapse.VERTICAL) {
        collapseClasses.add('grid-collapse-vertical');
      } else {
        collapseClasses.add('grid-collapse-top', (tProps.collapse & BlockCollapse.TOP) != 0);
        collapseClasses.add('grid-collapse-bottom', (tProps.collapse & BlockCollapse.BOTTOM) != 0);
      }

      if ((tProps.collapse & BlockCollapse.HORIZONTAL) == BlockCollapse.HORIZONTAL) {
        collapseClasses.add('grid-collapse-horizontal');
      } else {
        collapseClasses.add('grid-collapse-right', (tProps.collapse & BlockCollapse.RIGHT) != 0);
        collapseClasses.add('grid-collapse-left', (tProps.collapse & BlockCollapse.LEFT) != 0);
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
  // Value = [LEFT] | [RIGHT] = 1010
  static const int HORIZONTAL = (LEFT | RIGHT);

  /// > Collapses the left and right padding.
  // Value = [TOP] | [BOTTOM] = 0101
  static const int VERTICAL = (TOP | BOTTOM);

  /// > Collapses top, bottom, left, and right padding.
  // Value = [HORIZONTAL] | [VERTICAL] = 1111
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
