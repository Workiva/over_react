// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupComponentFactory = registerComponent2(
  () => new _$ListGroupComponent(),
  builderFactory: ListGroup,
  componentClass: ListGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ListGroup',
);

abstract class _$ListGroupPropsAccessorsMixin implements _$ListGroupProps {
  @override
  Map get props;

  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ///
  /// <!-- Generated from [_$ListGroupProps.elementType] -->
  @override
  ListGroupElementType get elementType =>
      props[_$key__elementType___$ListGroupProps];

  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ///
  /// <!-- Generated from [_$ListGroupProps.elementType] -->
  @override
  set elementType(ListGroupElementType value) =>
      props[_$key__elementType___$ListGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__elementType___$ListGroupProps =
      const PropDescriptor(_$key__elementType___$ListGroupProps);
  static const String _$key__elementType___$ListGroupProps =
      'ListGroupProps.elementType';

  static const List<PropDescriptor> $props = const [
    _$prop__elementType___$ListGroupProps
  ];
  static const List<String> $propKeys = const [
    _$key__elementType___$ListGroupProps
  ];
}

const PropsMeta _$metaForListGroupProps = const PropsMeta(
  fields: _$ListGroupPropsAccessorsMixin.$props,
  keys: _$ListGroupPropsAccessorsMixin.$propKeys,
);

class ListGroupProps extends _$ListGroupProps
    with _$ListGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForListGroupProps;
}

_$$ListGroupProps _$ListGroup([Map backingProps]) => backingProps == null
    ? new _$$ListGroupProps$JsMap(new JsBackedMap())
    : new _$$ListGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ListGroupProps extends _$ListGroupProps
    with _$ListGroupPropsAccessorsMixin
    implements ListGroupProps {
  _$$ListGroupProps._();

  factory _$$ListGroupProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ListGroupProps$JsMap(backingMap);
    } else {
      return new _$$ListGroupProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ListGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ListGroupProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ListGroupProps$PlainMap extends _$$ListGroupProps {
  _$$ListGroupProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ListGroupProps$JsMap extends _$$ListGroupProps {
  _$$ListGroupProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ListGroupComponent extends ListGroupComponent {
  _$$ListGroupProps$JsMap _cachedTypedProps;

  @override
  _$$ListGroupProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$ListGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ListGroupProps$JsMap(backingMap);

  @override
  _$$ListGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ListGroupProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ListGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForListGroupProps
  ];
}
