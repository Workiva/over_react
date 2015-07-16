part of w_ui_platform.ui_core;

/// Mixin for [GridBlock] props
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

  /// The size of the [GridBlock] at any screen size.
  @Prop("'$_SIZE'") int get size;

  /// The size of the [GridBlock] above the 'sm' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_SM'") int get smSize;

  /// The size of the [GridBlock] above the 'md' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_MD'") int get mdSize;

  /// The size of the [GridBlock] above the 'lg' responsive breakpoint.
  @Prop("'$_SIZE$_BLOCK_LG'") int get lgSize;

  /// The order that the [GridBlock] should display in at any screen size.
  @Prop("'$_ORDER'") int get order;

  /// The order that the [GridBlock] should display in above the 'sm' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_SM'") int get smOrder;

  /// The order that the [GridBlock] should display in above the 'md' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_MD'") int get mdOrder;

  /// The order that the [GridBlock] should display in above the 'lg' responsive breakpoint.
  @Prop("'$_ORDER$_BLOCK_LG'") int get lgOrder;

  /// The offset of the [GridBlock] at any screen size.
  /// Move a [GridBlock] to the right using the Offset prop.
  /// This prop increases the left margin of a [GridBlock] by n blocks. For example, Offset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET'") int get offset;

  /// The offset of the [GridBlock] above the 'sm' responsive breakpoint.
  /// Move a [GridBlock] to the right using the Offset prop.
  /// This prop increases the left margin of a small [GridBlock] by n blocks. For example, smOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_SM'") int get smOffset;

  /// The offset of the [GridBlock] above the 'md' responsive breakpoint.
  /// Move a [GridBlock] to the right using the Offset prop.
  /// This prop increases the left margin of a medium [GridBlock] by n blocks. For example, mdOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_MD'") int get mdOffset;

  /// The offset of the [GridBlock] above the 'lg' responsive breakpoint.
  /// Move a [GridBlock] to the right using the Offset prop.
  /// This prop increases the left margin of a large [GridBlock] by n blocks. For example, lgOffset=4 moves it over four blocks.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-options-offsets
  @Prop("'$_OFFSET$_BLOCK_LG'") int get lgOffset;

  /// Whether this [GridBlock] is a content [GridBlock] at any screen size
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT'") bool get content;

  /// Whether this [GridBlock] is a content [GridBlock] above the 'sm' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_SM'") bool get smContent;

  /// Whether this [GridBlock] is a content [GridBlock] above the 'md' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_MD'") bool get mdContent;

  /// Whether this [GridBlock] is a content [GridBlock] above the 'lg' responsive breakpoint.
  /// See: https://api.atl.workiva.net/WebSkinReact/docs/build/html/components.html#grid-v2-block-content
  @Prop("'$_CONTENT$_BLOCK_LG'") bool get lgContent;

  /// Whether this [GridBlock] should shrink to the size of its content at any screen size.
  @Prop("'$_SHRINK'") bool get shrink;

  /// Whether this [GridBlock] should shrink to the size of its content above the 'sm' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_SM'") bool get smShrink;

  /// Whether this [GridBlock] should shrink to the size of its content above the 'md' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_MD'") bool get mdShrink;

  /// Whether this [GridBlock] should shrink to the size of its content above the 'lg' responsive breakpoint.
  @Prop("'$_SHRINK$_BLOCK_LG'") bool get lgShrink;

  /// Whether to collapse some or all of the sides of the [GridBlock].
  /// Valid values are:
  ///    1. false - same as BlockCollapse.NONE (default).
  ///    2. BlockCollapse.ALL, BlockCollapse.HORIZONTAL or BlockCollapse.VERTICAL.
  ///    3. BlockCollapse.LEFT, BlockCollapse.RIGHT, BlockCollapse.TOP, BlockCollapse.BOTTOM.
  ///    4. List with any combination of the four [BlockCollapse] sides.
  ///
  /// Default: BlockCollapse.NONE
  dynamic get collapse;

  /// Whether to add a gutter around the [GridBlock]
  /// Valid values are:
  ///    1. BlockGutter.NONE (default).
  ///    2. BlockGutter.ALL.
  ///    3. BlockGutter.HORIZONTAL or BlockGutter.VERTICAL.
  ///
  /// Default: BlockCollapse.NONE
  BlockGutter get gutter;

  /// Whether the [GridBlock] should enable scrolling.
  ///
  /// Default: true
  bool get scroll;
}

abstract class GridBlockMixin<P extends BlockProps> {
  /// Standard HitAreaProps defaults.
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

  /// Get all the required classNames for the block mixin
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
        } else if (value is bool && value == true) {
          className = classPrefix;
        }
        if (className != null) {
          blockClasses.add(className);
        }
      }
    }

    blockClasses.add(_getCollapseClasses());
    blockClasses.add(_getGutterClasses());

    if (!tProps.scroll) {
      blockClasses.add('no-scroll');
    }

    return blockClasses.toClassName();
  }

  /// Get the classNames for the collapsing the padding of the [GridBlock].
  String _getCollapseClasses() {
    if (tProps.collapse == false || tProps.collapse == BlockCollapse.NONE) {
      return null;
    }

    var collapseClasses = new ClassNameBuilder();

    // Determine the type for the collapse prop
    if (tProps.collapse is List) {

      // Collapse was provided a list so run through the list and
      // ensure the values are valid BlockCollapse values
      for (var item in tProps.collapse) {
        if (item is! BlockCollapse
            || item == BlockCollapse.NONE
            || item == BlockCollapse.ALL
            || item == BlockCollapse.HORIZONTAL
            || item == BlockCollapse.VERTICAL) {
          assert(ValidationUtil.warn('Invalid collapse option given to Block collapse List.'));
        } else {
          collapseClasses.add((item as BlockCollapse).className);
        }
      }
    } else if (tProps.collapse is BlockCollapse) {
      // collapse was provided a BlockCollapse object so use that directly
      collapseClasses.add((tProps.collapse as BlockCollapse).className);
    } else {
      // Anything other type of value is unsupported
      assert(ValidationUtil.warn('Invalid value provided for collapse prop.'));
    }
    return collapseClasses.toClassName();
  }

  /// Get the classNames for the gutters of the [GridBlock]
  String _getGutterClasses() {
    if (tProps.gutter == BlockGutter.NONE) {
      return null;
    }

    return tProps.gutter.className;
  }

}

/// The collapse options for the [GridBlock]
@GenerateConstants(#BlockCollapse, #className)
class _$template_GridBlockCollapse {
  static const NONE = null;
  static const ALL = 'grid-collapse';
  static const HORIZONTAL = 'grid-collapse-horizontal';
  static const VERTICAL = 'grid-collapse-vertical';
  static const LEFT = 'grid-collapse-left';
  static const RIGHT = 'grid-collapse-right';
  static const TOP = 'grid-collapse-top';
  static const BOTTOM = 'grid-collapse-bottom';
}

/// The gutter options for the [GridBlock]
@GenerateConstants(#BlockGutter, #className)
class _$template_GridBlockGutter {
  static const NONE = null;
  static const ALL = 'grid-gutter';
  static const HORIZONTAL = 'grid-gutter-horizontal';
  static const VERTICAL = 'grid-gutter-vertical';
}
