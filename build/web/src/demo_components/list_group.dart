part of over_react.web.demo_components;

/// Bootstrap's `ListGroup` component is flexible and powerful for
/// displaying lists of [ListGroupItem] components.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ListGroupProps> ListGroup = ([Map backingProps]) => new _$ListGroupPropsImpl(backingProps);

@Props()
class ListGroupProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__elementType = const PropDescriptor(_$key__elementType); static const List<PropDescriptor> $props = const [_$prop__elementType]; static const String _$key__elementType = 'ListGroupProps.elementType'; static const List<String> $propKeys = const [_$key__elementType]; 
  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ListGroupElementType get elementType => props[_$key__elementType];  set elementType(ListGroupElementType value) => props[_$key__elementType] = value;
}

@Component()
class ListGroupComponent extends UiComponent<ListGroupProps> with _$ListGroupComponentImplMixin {
  @override
  Map getDefaultProps() => (newProps()
    ..elementType = ListGroupElementType.DIV
  );

  @override
  render() {
    var classes = forwardingClassNameBuilder()
      ..add('list-group');

    return (props.elementType.componentBuilderFactory()
      ..addProps(copyUnconsumedDomProps())
      ..className = classes.toClassName()
    )(props.children);
  }
}

/// Options for the [Element] that will be used when
/// rendering a [ListGroup] component.
class ListGroupElementType {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupElementType._internal(this.componentBuilderFactory);

  /// A [Dom.ul] (HTML `<ul>` element)
  static final ListGroupElementType UL  = new ListGroupElementType._internal(Dom.ul);

  /// A [Dom.div] (HTML `<div>` element)
  static final ListGroupElementType DIV = new ListGroupElementType._internal(Dom.div);
}



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupComponentFactory = registerComponent(() => new ListGroupComponent(),
    builderFactory: ListGroup,
    componentClass: ListGroupComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ListGroup'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$ListGroupPropsImpl extends ListGroupProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$ListGroupPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $ListGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ListGroupProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ListGroupComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ListGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [ListGroupProps.$consumedProps];
  @override
  ListGroupProps typedPropsFactory(Map backingMap) => new _$ListGroupPropsImpl(backingMap);

}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

