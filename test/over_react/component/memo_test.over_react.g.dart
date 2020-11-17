// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'memo_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicUiComponent2ComponentFactory = registerComponent2(
  () => _$BasicUiComponent2Component(),
  builderFactory: _$BasicUiComponent2,
  componentClass: BasicUiComponent2Component,
  isWrapper: false,
  parentType: null,
  displayName: 'BasicUiComponent2',
);

abstract class _$BasicUiComponent2PropsAccessorsMixin
    implements _$BasicUiComponent2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$BasicUiComponent2Props.childId] -->
  @override
  String get childId =>
      props[_$key__childId___$BasicUiComponent2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicUiComponent2Props.childId] -->
  @override
  set childId(String value) =>
      props[_$key__childId___$BasicUiComponent2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__childId___$BasicUiComponent2Props =
      PropDescriptor(_$key__childId___$BasicUiComponent2Props);
  static const String _$key__childId___$BasicUiComponent2Props =
      'BasicUiComponent2Props.childId';

  static const List<PropDescriptor> $props = [
    _$prop__childId___$BasicUiComponent2Props
  ];
  static const List<String> $propKeys = [
    _$key__childId___$BasicUiComponent2Props
  ];
}

const PropsMeta _$metaForBasicUiComponent2Props = PropsMeta(
  fields: _$BasicUiComponent2PropsAccessorsMixin.$props,
  keys: _$BasicUiComponent2PropsAccessorsMixin.$propKeys,
);

class BasicUiComponent2Props extends _$BasicUiComponent2Props
    with _$BasicUiComponent2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicUiComponent2Props;
}

_$$BasicUiComponent2Props _$BasicUiComponent2([Map backingProps]) =>
    backingProps == null
        ? _$$BasicUiComponent2Props$JsMap(JsBackedMap())
        : _$$BasicUiComponent2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$BasicUiComponent2Props extends _$BasicUiComponent2Props
    with _$BasicUiComponent2PropsAccessorsMixin
    implements BasicUiComponent2Props {
  _$$BasicUiComponent2Props._();

  factory _$$BasicUiComponent2Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicUiComponent2Props$JsMap(backingMap);
    } else {
      return _$$BasicUiComponent2Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicUiComponent2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicUiComponent2Props.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicUiComponent2Props$PlainMap extends _$$BasicUiComponent2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicUiComponent2Props$PlainMap(Map backingMap)
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
class _$$BasicUiComponent2Props$JsMap extends _$$BasicUiComponent2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicUiComponent2Props$JsMap(JsBackedMap backingMap)
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
class _$BasicUiComponent2Component extends BasicUiComponent2Component {
  _$$BasicUiComponent2Props$JsMap _cachedTypedProps;

  @override
  _$$BasicUiComponent2Props$JsMap get props => _cachedTypedProps;

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
  _$$BasicUiComponent2Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicUiComponent2Props$JsMap(backingMap);

  @override
  _$$BasicUiComponent2Props typedPropsFactory(Map backingMap) =>
      _$$BasicUiComponent2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicUiComponent2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasicUiComponent2Props
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FunctionCustomPropsProps on FunctionCustomPropsProps {
  static const PropsMeta meta = _$metaForFunctionCustomPropsProps;
  @override
  int get testProp =>
      props[_$key__testProp__FunctionCustomPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set testProp(int value) =>
      props[_$key__testProp__FunctionCustomPropsProps] = value;
  @override
  Function() get testFuncProp =>
      props[_$key__testFuncProp__FunctionCustomPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set testFuncProp(Function() value) =>
      props[_$key__testFuncProp__FunctionCustomPropsProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__testProp__FunctionCustomPropsProps =
      PropDescriptor(_$key__testProp__FunctionCustomPropsProps);
  static const PropDescriptor _$prop__testFuncProp__FunctionCustomPropsProps =
      PropDescriptor(_$key__testFuncProp__FunctionCustomPropsProps);
  static const String _$key__testProp__FunctionCustomPropsProps =
      'FunctionCustomPropsProps.testProp';
  static const String _$key__testFuncProp__FunctionCustomPropsProps =
      'FunctionCustomPropsProps.testFuncProp';

  static const List<PropDescriptor> $props = [
    _$prop__testProp__FunctionCustomPropsProps,
    _$prop__testFuncProp__FunctionCustomPropsProps
  ];
  static const List<String> $propKeys = [
    _$key__testProp__FunctionCustomPropsProps,
    _$key__testFuncProp__FunctionCustomPropsProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFunctionCustomPropsProps = PropsMeta(
  fields: $FunctionCustomPropsProps.$props,
  keys: $FunctionCustomPropsProps.$propKeys,
);

final UiFactoryConfig<_$$FunctionCustomPropsProps> $FunctionCustomPropsConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$FunctionCustomPropsProps(map),
          jsMap: (map) => _$$FunctionCustomPropsProps$JsMap(map),
        ),
        displayName: 'FunctionCustomProps');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$FunctionCustomPropsProps extends UiProps
    with
        FunctionCustomPropsProps,
        $FunctionCustomPropsProps // If this generated mixin is undefined, it's likely because FunctionCustomPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FunctionCustomPropsProps, and check that $FunctionCustomPropsProps is exported/imported properly.
{
  _$$FunctionCustomPropsProps._();

  factory _$$FunctionCustomPropsProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FunctionCustomPropsProps$JsMap(backingMap);
    } else {
      return _$$FunctionCustomPropsProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because FunctionCustomPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FunctionCustomPropsProps, and check that $FunctionCustomPropsProps is exported/imported properly.
        FunctionCustomPropsProps: $FunctionCustomPropsProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FunctionCustomPropsProps$PlainMap extends _$$FunctionCustomPropsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FunctionCustomPropsProps$PlainMap(Map backingMap)
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
class _$$FunctionCustomPropsProps$JsMap extends _$$FunctionCustomPropsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FunctionCustomPropsProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
