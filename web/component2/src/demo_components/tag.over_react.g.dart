// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'tag.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $TagComponentFactory = registerComponent2(
  () => _$TagComponent(),
  builderFactory: _$Tag,
  componentClass: TagComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Tag',
);

_$$TagProps _$Tag([Map backingProps]) => backingProps == null
    ? _$$TagProps$JsMap(JsBackedMap())
    : _$$TagProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TagProps extends UiProps
    with
        TagProps,
        $TagProps // If this generated mixin is undefined, it's likely because TagProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of TagProps.
{
  _$$TagProps._();

  factory _$$TagProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TagProps$JsMap(backingMap);
    } else {
      return _$$TagProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TagComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TagProps$PlainMap extends _$$TagProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TagProps$PlainMap(Map backingMap)
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
class _$$TagProps$JsMap extends _$$TagProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TagProps$JsMap(JsBackedMap backingMap)
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
class _$TagComponent extends TagComponent {
  _$$TagProps$JsMap _cachedTypedProps;

  @override
  _$$TagProps$JsMap get props => _cachedTypedProps;

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
  _$$TagProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TagProps$JsMap(backingMap);

  @override
  _$$TagProps typedPropsFactory(Map backingMap) => _$$TagProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by TagProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TagProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of TagProps.
        TagProps: $TagProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TagProps on TagProps {
  static const PropsMeta meta = _$metaForTagProps;
  @override
  TagSkin get skin =>
      props[_$key__skin__TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set skin(TagSkin value) => props[_$key__skin__TagProps] = value;
  @override
  bool get isPill =>
      props[_$key__isPill__TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isPill(bool value) => props[_$key__isPill__TagProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__skin__TagProps =
      PropDescriptor(_$key__skin__TagProps);
  static const PropDescriptor _$prop__isPill__TagProps =
      PropDescriptor(_$key__isPill__TagProps);
  static const String _$key__skin__TagProps = 'TagProps.skin';
  static const String _$key__isPill__TagProps = 'TagProps.isPill';

  static const List<PropDescriptor> $props = [
    _$prop__skin__TagProps,
    _$prop__isPill__TagProps
  ];
  static const List<String> $propKeys = [
    _$key__skin__TagProps,
    _$key__isPill__TagProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTagProps = PropsMeta(
  fields: $TagProps.$props,
  keys: $TagProps.$propKeys,
);
