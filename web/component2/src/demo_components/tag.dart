import 'package:over_react/over_react.dart';
part 'tag.over_react.g.dart';

/// Bootstrap's `Tag` component renders a small and adaptive tag
/// for adding context to just about any content.
///
/// See: <http://v4-alpha.getbootstrap.com/components/tag/>
@Factory()
UiFactory<TagProps> Tag = _$Tag;

@Props()
class _$TagProps extends UiProps {
  /// The skin / "context" for the [Tag].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#contextual-variations>.
  ///
  /// Default: [TagSkin.DEFAULT]
  TagSkin skin;

  /// Whether to render the [Tag] with rounded corners that make it look
  /// more like a "pill" (a.k.a Bootstrap v3 "badge")
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#pill-tags>.
  ///
  /// Default: false
  bool isPill;
}

@Component2()
class TagComponent extends UiComponent2<TagProps> {
  @override
  Map getDefaultProps() => (newProps()
    ..skin = TagSkin.DEFAULT
    ..isPill = false
  );

  @override
  render() {
    var classes = forwardingClassNameBuilder()
      ..add('tag')
      ..add('tag-pill', props.isPill)
      ..add(props.skin.className);

    return (Dom.span()
      ..addProps(copyUnconsumedDomProps())
      ..className = classes.toClassName()
    )(props.children);
  }
}

/// Contextual skin options for a [Tag] component.
class TagSkin extends ClassNameConstant {
  const TagSkin._(String name, String className) : super(name, className);

  /// [className] value: 'tag-default'
  static const TagSkin DEFAULT =
      const TagSkin._('DEFAULT', 'tag-default');

  /// [className] value: 'tag-primary'
  static const TagSkin PRIMARY =
      const TagSkin._('PRIMARY', 'tag-primary');

  /// [className] value: 'tag-danger'
  static const TagSkin DANGER =
      const TagSkin._('DANGER', 'tag-danger');

  /// [className] value: 'tag-success'
  static const TagSkin SUCCESS =
      const TagSkin._('SUCCESS', 'tag-success');

  /// [className] value: 'tag-warning'
  static const TagSkin WARNING =
      const TagSkin._('WARNING', 'tag-warning');

  /// [className] value: 'tag-info'
  static const TagSkin INFO =
      const TagSkin._('INFO', 'tag-info');
}

