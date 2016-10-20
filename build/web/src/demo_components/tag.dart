part of over_react.web.demo_components;

/// Bootstrap's `Tag` component is flexible and powerful for
/// displaying lists of [TagItem] components.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<TagProps> Tag = ([Map backingProps]) => new _$TagPropsImpl(backingProps);

@Props()
class TagProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__skin = const PropDescriptor(_$key__skin), _$prop__isPill = const PropDescriptor(_$key__isPill); static const List<PropDescriptor> $props = const [_$prop__skin, _$prop__isPill]; static const String _$key__skin = 'TagProps.skin', _$key__isPill = 'TagProps.isPill'; static const List<String> $propKeys = const [_$key__skin, _$key__isPill]; 
  /// The skin / "context" for the [Tag].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#contextual-variations>.
  ///
  /// Default: [TagSkin.DEFAULT]
  TagSkin get skin => props[_$key__skin];  set skin(TagSkin value) => props[_$key__skin] = value;

  /// Whether to render the [Tag] with rounded corners that make it look
  /// more like a "pill" (a.k.a Bootstrap v3 "badge")
  ///
  /// Default: false
  bool get isPill => props[_$key__isPill];  set isPill(bool value) => props[_$key__isPill] = value;
}

@Component()
class TagComponent extends UiComponent<TagProps> with _$TagComponentImplMixin {
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



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TagComponentFactory = registerComponent(() => new TagComponent(),
    builderFactory: Tag,
    componentClass: TagComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Tag'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$TagPropsImpl extends TagProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$TagPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $TagComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TagProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TagComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from TagProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [TagProps.$consumedProps];
  @override
  TagProps typedPropsFactory(Map backingMap) => new _$TagPropsImpl(backingMap);

}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

