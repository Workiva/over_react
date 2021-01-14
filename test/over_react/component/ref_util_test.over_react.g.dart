// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'ref_util_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: _$Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? _$$BasicProps$JsMap(JsBackedMap())
    : _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicProps extends UiProps
    with
        BasicProps,
        $BasicProps // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicProps, and check that $BasicProps is exported/imported properly.
{
  _$$BasicProps._();

  factory _$$BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicProps, and check that $BasicProps is exported/imported properly.
        BasicProps: $BasicProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicProps$PlainMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$PlainMap(Map backingMap)
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
class _$$BasicProps$JsMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicProps$JsMap(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) => _$$BasicProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by BasicProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicProps, and check that $BasicProps is exported/imported properly.
        BasicProps: $BasicProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicProps on BasicProps {
  static const PropsMeta meta = _$metaForBasicProps;
  @override
  String get childId =>
      props[_$key__childId__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childId(String value) => props[_$key__childId__BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__childId__BasicProps =
      PropDescriptor(_$key__childId__BasicProps);
  static const String _$key__childId__BasicProps = 'BasicProps.childId';

  static const List<PropDescriptor> $props = [_$prop__childId__BasicProps];
  static const List<String> $propKeys = [_$key__childId__BasicProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: $BasicProps.$props,
  keys: $BasicProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicUiFunctionProps on BasicUiFunctionProps {
  static const PropsMeta meta = _$metaForBasicUiFunctionProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicUiFunctionProps = PropsMeta(
  fields: $BasicUiFunctionProps.$props,
  keys: $BasicUiFunctionProps.$propKeys,
);

final UiFactoryConfig<_$$BasicUiFunctionProps> _$BasicUiFunctionConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$BasicUiFunctionProps(map),
          jsMap: (map) => _$$BasicUiFunctionProps$JsMap(map),
        ),
        displayName: 'BasicUiFunction');

@Deprecated(r'Use the private variable, _$BasicUiFunctionConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final dynamic $BasicUiFunctionConfig = _$BasicUiFunctionConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicUiFunctionProps extends UiProps
    with
        BasicUiFunctionProps,
        $BasicUiFunctionProps // If this generated mixin is undefined, it's likely because BasicUiFunctionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicUiFunctionProps, and check that $BasicUiFunctionProps is exported/imported properly.
{
  _$$BasicUiFunctionProps._();

  factory _$$BasicUiFunctionProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicUiFunctionProps$JsMap(backingMap);
    } else {
      return _$$BasicUiFunctionProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because BasicUiFunctionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicUiFunctionProps, and check that $BasicUiFunctionProps is exported/imported properly.
        BasicUiFunctionProps: $BasicUiFunctionProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicUiFunctionProps$PlainMap extends _$$BasicUiFunctionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicUiFunctionProps$PlainMap(Map backingMap)
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
class _$$BasicUiFunctionProps$JsMap extends _$$BasicUiFunctionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicUiFunctionProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$SecondaryBasicUiFunctionProps>
    _$TopLevelForwardUiRefFunctionConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$SecondaryBasicUiFunctionProps(map),
          jsMap: (map) => _$$SecondaryBasicUiFunctionProps$JsMap(map),
        ),
        displayName: 'TopLevelForwardUiRefFunction');

@Deprecated(
    r'Use the private variable, _$TopLevelForwardUiRefFunctionConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final dynamic $TopLevelForwardUiRefFunctionConfig =
    _$TopLevelForwardUiRefFunctionConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SecondaryBasicUiFunctionProps extends UiProps
    with
        BasicUiFunctionProps,
        $BasicUiFunctionProps // If this generated mixin is undefined, it's likely because BasicUiFunctionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicUiFunctionProps, and check that $BasicUiFunctionProps is exported/imported properly.
    implements
        SecondaryBasicUiFunctionProps {
  _$$SecondaryBasicUiFunctionProps._();

  factory _$$SecondaryBasicUiFunctionProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SecondaryBasicUiFunctionProps$JsMap(backingMap);
    } else {
      return _$$SecondaryBasicUiFunctionProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because BasicUiFunctionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicUiFunctionProps, and check that $BasicUiFunctionProps is exported/imported properly.
        BasicUiFunctionProps: $BasicUiFunctionProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SecondaryBasicUiFunctionProps$PlainMap
    extends _$$SecondaryBasicUiFunctionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SecondaryBasicUiFunctionProps$PlainMap(Map backingMap)
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
class _$$SecondaryBasicUiFunctionProps$JsMap
    extends _$$SecondaryBasicUiFunctionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SecondaryBasicUiFunctionProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
