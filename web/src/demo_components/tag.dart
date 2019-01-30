part of over_react.web.demo_components;

/// Bootstrap's `Tag` component renders a small and adaptive tag
/// for adding context to just about any content.
///
/// See: <http://v4-alpha.getbootstrap.com/components/tag/>
@Factory()
// ignore: undefined_identifier
UiFactory<TagProps> Tag = $Tag;

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

@Component()
class TagComponent extends UiComponent<TagProps> {
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

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TagProps extends _$TagProps with _$TagPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTagProps;
}
