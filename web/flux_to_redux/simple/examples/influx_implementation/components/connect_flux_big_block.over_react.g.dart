// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'connect_flux_big_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ConnectFluxBigBlockComponentFactory = registerComponent2(
  () => _$ConnectFluxBigBlockComponent(),
  builderFactory: ConnectFluxBigBlock,
  componentClass: ConnectFluxBigBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ConnectFluxBigBlock',
);

_$$ConnectFluxBigBlockProps _$ConnectFluxBigBlock([Map backingProps]) =>
    backingProps == null
        ? _$$ConnectFluxBigBlockProps$JsMap(JsBackedMap())
        : _$$ConnectFluxBigBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ConnectFluxBigBlockProps extends UiProps
    with
        ConnectFluxBigBlockPropsMixin,
        $ConnectFluxBigBlockPropsMixin, // If this generated mixin is undefined, it's likely because ConnectFluxBigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectFluxBigBlockPropsMixin.
        ConnectPropsMixin,
        $ConnectPropsMixin // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectPropsMixin.
    implements
        ConnectFluxBigBlockProps {
  _$$ConnectFluxBigBlockProps._();

  factory _$$ConnectFluxBigBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ConnectFluxBigBlockProps$JsMap(backingMap);
    } else {
      return _$$ConnectFluxBigBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ConnectFluxBigBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ConnectFluxBigBlockProps$PlainMap extends _$$ConnectFluxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxBigBlockProps$PlainMap(Map backingMap)
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
class _$$ConnectFluxBigBlockProps$JsMap extends _$$ConnectFluxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxBigBlockProps$JsMap(JsBackedMap backingMap)
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
class _$ConnectFluxBigBlockComponent extends ConnectFluxBigBlockComponent {
  _$$ConnectFluxBigBlockProps$JsMap _cachedTypedProps;

  @override
  _$$ConnectFluxBigBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$ConnectFluxBigBlockProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$ConnectFluxBigBlockProps$JsMap(backingMap);

  @override
  _$$ConnectFluxBigBlockProps typedPropsFactory(Map backingMap) =>
      _$$ConnectFluxBigBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ConnectFluxBigBlockProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps => const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ConnectFluxBigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectFluxBigBlockPropsMixin.
        ConnectFluxBigBlockPropsMixin: $ConnectFluxBigBlockPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectPropsMixin.
        ConnectPropsMixin: $ConnectPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ConnectFluxBigBlockPropsMixin on ConnectFluxBigBlockPropsMixin {
  static const PropsMeta meta = _$metaForConnectFluxBigBlockPropsMixin;
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor__ConnectFluxBigBlockPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor__ConnectFluxBigBlockPropsMixin] = value;
  @override
  void Function() get changeBackgroundColor =>
      props[_$key__changeBackgroundColor__ConnectFluxBigBlockPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set changeBackgroundColor(void Function() value) =>
      props[_$key__changeBackgroundColor__ConnectFluxBigBlockPropsMixin] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__backgroundColor__ConnectFluxBigBlockPropsMixin =
      PropDescriptor(_$key__backgroundColor__ConnectFluxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__changeBackgroundColor__ConnectFluxBigBlockPropsMixin =
      PropDescriptor(
          _$key__changeBackgroundColor__ConnectFluxBigBlockPropsMixin);
  static const String _$key__backgroundColor__ConnectFluxBigBlockPropsMixin =
      'ConnectFluxBigBlockPropsMixin.backgroundColor';
  static const String
      _$key__changeBackgroundColor__ConnectFluxBigBlockPropsMixin =
      'ConnectFluxBigBlockPropsMixin.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor__ConnectFluxBigBlockPropsMixin,
    _$prop__changeBackgroundColor__ConnectFluxBigBlockPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor__ConnectFluxBigBlockPropsMixin,
    _$key__changeBackgroundColor__ConnectFluxBigBlockPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForConnectFluxBigBlockPropsMixin = PropsMeta(
  fields: $ConnectFluxBigBlockPropsMixin.$props,
  keys: $ConnectFluxBigBlockPropsMixin.$propKeys,
);
