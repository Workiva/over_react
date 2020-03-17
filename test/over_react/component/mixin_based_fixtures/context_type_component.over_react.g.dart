// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'context_type_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ContextTypeComponentFactory = registerComponent2(
  () => _$ContextTypeComponent(),
  builderFactory: ContextType,
  componentClass: ContextTypeComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ContextType',
);

_$$ContextTypeProps _$ContextType([Map backingProps]) => backingProps == null
    ? _$$ContextTypeProps$JsMap(JsBackedMap())
    : _$$ContextTypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextTypeProps extends UiProps
    with
        ContextTypeProps,
        $ContextTypeProps // If this generated mixin is undefined, it's likely because ContextTypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ContextTypeProps.
{
  _$$ContextTypeProps._();

  factory _$$ContextTypeProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextTypeProps$JsMap(backingMap);
    } else {
      return _$$ContextTypeProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextTypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ContextTypeProps$PlainMap extends _$$ContextTypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeProps$PlainMap(Map backingMap)
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
class _$$ContextTypeProps$JsMap extends _$$ContextTypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeProps$JsMap(JsBackedMap backingMap)
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
class _$ContextTypeComponent extends ContextTypeComponent {
  _$$ContextTypeProps$JsMap _cachedTypedProps;

  @override
  _$$ContextTypeProps$JsMap get props => _cachedTypedProps;

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
  _$$ContextTypeProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ContextTypeProps$JsMap(backingMap);

  @override
  _$$ContextTypeProps typedPropsFactory(Map backingMap) =>
      _$$ContextTypeProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ContextTypeProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(ContextTypeProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ContextTypeProps.
        ContextTypeProps: $ContextTypeProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextTypeProps on ContextTypeProps {
  static const PropsMeta meta = _$metaForContextTypeProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForContextTypeProps = PropsMeta(
  fields: $ContextTypeProps.$props,
  keys: $ContextTypeProps.$propKeys,
);
