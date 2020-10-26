// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'should_not_update.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ShouldNotUpdateComponentFactory = registerComponent2(
  () => _$ShouldNotUpdateComponent(),
  builderFactory: _$ShouldNotUpdate,
  componentClass: ShouldNotUpdateComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ShouldNotUpdate',
);

_$$ShouldNotUpdateProps _$ShouldNotUpdate([Map backingProps]) =>
    backingProps == null
        ? _$$ShouldNotUpdateProps$JsMap(JsBackedMap())
        : _$$ShouldNotUpdateProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ShouldNotUpdateProps extends UiProps
    with
        ShouldNotUpdateProps,
        $ShouldNotUpdateProps // If this generated mixin is undefined, it's likely because ShouldNotUpdateProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ShouldNotUpdateProps, and check that $ShouldNotUpdateProps is exported/imported properly.
{
  _$$ShouldNotUpdateProps._();

  factory _$$ShouldNotUpdateProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ShouldNotUpdateProps$JsMap(backingMap);
    } else {
      return _$$ShouldNotUpdateProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ShouldNotUpdateComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ShouldNotUpdateProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ShouldNotUpdateProps, and check that $ShouldNotUpdateProps is exported/imported properly.
        ShouldNotUpdateProps: $ShouldNotUpdateProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ShouldNotUpdateProps$PlainMap extends _$$ShouldNotUpdateProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ShouldNotUpdateProps$PlainMap(Map backingMap)
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
class _$$ShouldNotUpdateProps$JsMap extends _$$ShouldNotUpdateProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ShouldNotUpdateProps$JsMap(JsBackedMap backingMap)
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
class _$ShouldNotUpdateComponent extends ShouldNotUpdateComponent {
  _$$ShouldNotUpdateProps$JsMap _cachedTypedProps;

  @override
  _$$ShouldNotUpdateProps$JsMap get props => _cachedTypedProps;

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
  _$$ShouldNotUpdateProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ShouldNotUpdateProps$JsMap(backingMap);

  @override
  _$$ShouldNotUpdateProps typedPropsFactory(Map backingMap) =>
      _$$ShouldNotUpdateProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ShouldNotUpdateProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ShouldNotUpdateProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ShouldNotUpdateProps, and check that $ShouldNotUpdateProps is exported/imported properly.
        ShouldNotUpdateProps: $ShouldNotUpdateProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ShouldNotUpdateProps on ShouldNotUpdateProps {
  static const PropsMeta meta = _$metaForShouldNotUpdateProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForShouldNotUpdateProps = PropsMeta(
  fields: $ShouldNotUpdateProps.$props,
  keys: $ShouldNotUpdateProps.$propKeys,
);
