import 'package:over_react/over_react.dart';

import 'package:react_material_ui/react_material_ui.dart';

part 'empty_view.over_react.g.dart';

/// Use the `EmptyView` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.

UiFactory<EmptyViewProps> EmptyView =
        _$EmptyView; // ignore: undefined_identifier

mixin EmptyViewProps on UiProps {
  /// The layout of the [EmptyView].
  ///
  /// Default: [EmptyViewType.DEFAULT]
  EmptyViewType type;

  /// Optional rendered icon glyph for the [EmptyView].
  ///
  /// [glyph] and [content] cannot both be set simultaneously.
  ReactElement glyph;

  /// Optional content to be displayed above the [header] in the [EmptyView].
  ///
  /// [glyph] and [content] cannot both be set simultaneously.
  dynamic content;

  /// Header for the [EmptyView].
  ///
  /// If [type] is [EmptyViewType.PAGE_FRAME], the enclosing element is a [Dom.h1]. Otherwise, the enclosing
  /// element is a [Dom.h4];
  @requiredProp
  dynamic header;
}

class EmptyViewComponent extends UiComponent2<EmptyViewProps> {
  @override
  get defaultProps => (newProps()..type = EmptyViewType.DEFAULT);

  @override
  get propTypes => {
    keyForProp((p) => p.glyph): (props, info) {
      if (props.glyph != null && props.content != null) {
        return PropError.combination(info.propName, 'EmptyViewProps.content',
          'EmptyView does not support `props.glyph` and `props.content` being set simultaneously.');
      }

      return null;
    },
  };

  @override
  render() {
    return _renderInContainer(_renderBody());
  }

  ReactElement _renderBody() {
    return (Dom.div()
      ..modifyProps(addUnconsumedDomProps)
      ..role = Role.status
      ..className = (forwardingClassNameBuilder() //
        ..add('empty-view'))
        .toClassName()
    )(
      _renderAboveHeaderContent(),
      _renderHeader(),
      (Typography()
          ..variant = TypographyVariant.BODY1
      )(props.children),
    );
  }

  ReactElement _renderInContainer(dynamic content) {
    if (props.type == EmptyViewType.DEFAULT) return content;

    return (Dom.div()..className = props.type.className)(content);
  }

  ReactElement _renderHeader() {
    return (Typography()
        ..component = ElementType.fromString(props.type.headerFactory)
        ..variant = TypographyVariant(props.type.headerFactory)
        ..gutterBottom = true
        ..className = 'empty-view__message-heading'
    )(props.header);
  }

  ReactElement _renderAboveHeaderContent() {
    if (props.glyph != null) {
      return (Dom.span()..className = 'empty-view__icon')(
        cloneElement(props.glyph, {'fontSize': 'inherit'}),
      );
    }

    if (props.content != null) {
      return Dom.div()(props.content);
    }

    return null;
  }
}

/// Available layout options for an `EmptyView`.
///
/// If you need to vertically center the messaging within the height of your layout, use `PAGE_FRAME` or `VBLOCK`.
class EmptyViewType extends ClassNameConstant {
  /// The "heading level" that will be used as the parent node of `EmptyViewProps.header`.
  final String headerFactory;

  /// Private constructor, for use by generated code only.
  const EmptyViewType._(String name, String className, this.headerFactory) : super(name, className);

  /// Used as the root node of the within `<body>`.
  ///
  /// * [className] value: 'empty-view-page-frame'
  /// * [headerFactory] value: ['h1']
  static const EmptyViewType PAGE_FRAME = EmptyViewType._('PAGE_FRAME', 'empty-view-page-frame', 'h1');

  /// An element nested within an element that has relative positioning, and a defined height either via an existing
  /// flexbox axis surrounding it, or a fixed CSS height value.
  ///
  /// * [className] value: 'empty-view-vblock'
  /// * [headerFactory] value: ['h4']
  static const EmptyViewType VBLOCK = EmptyViewType._('VBLOCK', 'empty-view-vblock', 'h4');

  /// By default, the `EmptyView` element has some top margin applied to vertically space it within its container.
  ///
  /// * [className] value: ''
  /// * [headerFactory] value: ['h4']
  static const EmptyViewType DEFAULT = EmptyViewType._('DEFAULT', null, 'h4');
}
