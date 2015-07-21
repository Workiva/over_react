part of w_ui_platform.ui_core;

/// Mixin for [Block] layout options
/// To use:
/// - add [LayoutProps] mixin class to component definition.
/// - add [LayoutProps] mixin class to component class.
/// - add defaults to getDefaultProps method of component class using [LayoutProps.defaultProps]
/// ..addProps(LayoutMixin.defaultProps)
/// - call `getLayoutClasses` function to retrieve a list of classNames to be added
@GenerateProps(#LayoutProps)
abstract class _$template_LayoutProps {
  /// The number of blocks can fit horizontally in one "row" at any screen size.
  int get up;

  /// The number of blocks can fit horizontally in one "row" above the 'sm' responsive breakpoint.
  int get smUp;

  /// The number of blocks can fit horizontally in one "row" above the 'md' responsive breakpoint.
  int get mdUp;

  /// The number of blocks can fit horizontally in one "row" above the 'lg' responsive breakpoint.
  int get lgUp;

  /// Make child blocks wrap to the next line if they take up too much space at any screen size.
  int get wrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'sm' responsive breakpoint.
  int get smWrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'md' responsive breakpoint.
  int get mdWrap;

  /// Make child blocks wrap to the next line if they take up too much space above the 'lg' responsive breakpoint.
  int get lgWrap;

  /// Alignment for child blocks at any screen size.
  ///
  /// Default: [BlockAlign.LEFT]
  BlockAlign get align;

  /// Alignment for child blocks above the 'sm' responsive breakpoint.
  BlockAlign get smAlign;

  /// Alignment for child blocks above the 'md' responsive breakpoint.
  BlockAlign get mdAlign;

  /// Alignment for child blocks above the 'lg' responsive breakpoint.
  BlockAlign get lgAlign;

  /// Primary axis that child blocks display along.
  ///
  /// Default: [BlockLayout.HORIZONTAL]
  BlockLayout get layout;

  /// Primary axis that child blocks display along above the 'sm' responsive breakpoint.
  BlockLayout get smLayout;

  /// Primary axis that child blocks display along above the 'md' responsive breakpoint.
  BlockLayout get mdLayout;

  /// Primary axis that child blocks display along above the 'lg' responsive breakpoint.
  BlockLayout get lgLayout;

  /// Whether this [Block] is nested inside of another [Block].
  ///
  /// * This must be set to `true` when nesting a [VBlock] component within another [VBlock], or when nesting a [VBlock] within a [Block] that is a child of another [VBlock].
  ///
  /// Default: false
  bool get isNested;
}

abstract class LayoutMixin<P extends LayoutProps> {
  /// Standard LayoutMixin defaults.
  static const Map defaultProps = const {
    LayoutProps.Z_$KEY__IS_NESTED: false,
    LayoutProps.Z_$KEY__ALIGN: BlockAlign.LEFT,
    LayoutProps.Z_$KEY__LAYOUT: BlockLayout.HORIZONTAL,
  };

  P get tProps;
  Map get props;

  /// Get all the CSS classes generated by the [LayoutMixin]
  String getBlockLayoutClasses() {
    const String gridAlign = 'grid-align';
    const String gridUp = 'grid-up';
    const String gridWrap = 'grid-wrap';
    const String gridBase = 'grid';
    const String blockSm = 'sm';
    const String blockMd = 'md';
    const String blockLg = 'lg';

    ClassNameBuilder layoutClasses = new ClassNameBuilder()
      ..add(tProps.up       == null ? null : '$gridUp-${tProps.up}')
      ..add(tProps.smUp     == null ? null : '$gridUp-$blockSm-${tProps.smUp}')
      ..add(tProps.mdUp     == null ? null : '$gridUp-$blockMd-${tProps.mdUp}')
      ..add(tProps.lgUp     == null ? null : '$gridUp-$blockLg-${tProps.lgUp}')
      ..add(tProps.wrap     == null ? null : '$gridWrap-${tProps.wrap}')
      ..add(tProps.smWrap   == null ? null : '$gridWrap-$blockSm-${tProps.smWrap}')
      ..add(tProps.mdWrap   == null ? null : '$gridWrap-$blockMd-${tProps.mdWrap}')
      ..add(tProps.lgWrap   == null ? null : '$gridWrap-$blockLg-${tProps.lgWrap}')
      ..add(tProps.align    == null || tProps.align.classPart    == null ? null : '$gridAlign-${tProps.align.classPart}')
      ..add(tProps.smAlign  == null || tProps.smAlign.classPart  == null ? null : '$gridAlign-${tProps.smAlign.classPart}-$blockSm')
      ..add(tProps.mdAlign  == null || tProps.mdAlign.classPart  == null ? null : '$gridAlign-${tProps.mdAlign.classPart}-$blockMd')
      ..add(tProps.lgAlign  == null || tProps.lgAlign.classPart  == null ? null : '$gridAlign-${tProps.lgAlign.classPart}-$blockLg')
      ..add(tProps.layout   == null || tProps.layout.classPart   == null ? null : '$gridBase-${tProps.layout.classPart}')
      ..add(tProps.smLayout == null || tProps.smLayout.classPart == null ? null : '$gridBase-${tProps.smLayout.classPart}-$blockSm')
      ..add(tProps.mdLayout == null || tProps.mdLayout.classPart == null ? null : '$gridBase-${tProps.mdLayout.classPart}-$blockMd')
      ..add(tProps.lgLayout == null || tProps.lgLayout.classPart == null ? null : '$gridBase-${tProps.lgLayout.classPart}-$blockLg');

    return layoutClasses.toClassName();
  }
}

/// The alignment options for the [Block]
@GenerateConstants(#BlockAlign, #classPart)
class _$template_BlockAlign {
  static const LEFT = null;
  static const RIGHT = 'right';
  static const CENTER = 'center';
  static const JUSTIFIED = 'justified';
  static const SPACED = 'spaced';
}

/// The options for determining the primary axis that child [Block]s display along.
@GenerateConstants(#BlockLayout, #classPart)
class _$template_BlockLayout {
  static const NONE = null;
  static const HORIZONTAL = 'horizontal';
  static const VERTICAL = 'vertical';
}
