// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'list_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ListGroupComponentFactory = registerComponent2(
  () => _$ListGroupComponent(),
  builderFactory: ListGroup,
  componentClass: ListGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ListGroup',
);

_$$ListGroupProps _$ListGroup([Map backingProps]) => backingProps == null
    ? _$$ListGroupProps$JsMap(JsBackedMap())
    : _$$ListGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ListGroupProps extends UiProps
    with ListGroupProps, $ListGroupProps {
  _$$ListGroupProps._();

  factory _$$ListGroupProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ListGroupProps$JsMap(backingMap);
    } else {
      return _$$ListGroupProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ListGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ListGroupProps$PlainMap extends _$$ListGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ListGroupProps$JsMap extends _$$ListGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ListGroupComponent extends ListGroupComponent {
  _$$ListGroupProps$JsMap _cachedTypedProps;

  @override
  _$$ListGroupProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$ListGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ListGroupProps$JsMap(backingMap);

  @override
  _$$ListGroupProps typedPropsFactory(Map backingMap) =>
      _$$ListGroupProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ListGroupProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForListGroupProps
  ];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        ListGroupProps: $ListGroupProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ListGroupProps on ListGroupProps {
  static const PropsMeta meta = _$metaForListGroupProps;
  @override
  ListGroupElementType get elementType =>
      props[_$key__elementType__ListGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set elementType(ListGroupElementType value) =>
      props[_$key__elementType__ListGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__elementType__ListGroupProps =
      PropDescriptor(_$key__elementType__ListGroupProps);
  static const String _$key__elementType__ListGroupProps =
      'ListGroupProps.elementType';

  static const List<PropDescriptor> $props = [
    _$prop__elementType__ListGroupProps
  ];
  static const List<String> $propKeys = [_$key__elementType__ListGroupProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForListGroupProps = PropsMeta(
  fields: $ListGroupProps.$props,
  keys: $ListGroupProps.$propKeys,
);
