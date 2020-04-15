// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'constant_required_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent2(
  () => _$ComponentTestComponent(),
  builderFactory: _$ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ComponentTest',
);

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ComponentTestProps.required] -->
  @override
  @requiredProp
  dynamic get required =>
      props[_$key__required___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.required] -->
  @override
  @requiredProp
  set required(dynamic value) =>
      props[_$key__required___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  @nullableRequiredProp
  dynamic get nullable =>
      props[_$key__nullable___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  @nullableRequiredProp
  set nullable(dynamic value) =>
      props[_$key__nullable___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.requiredAndLengthLimited] -->
  @override
  @requiredProp
  List get requiredAndLengthLimited =>
      props[_$key__requiredAndLengthLimited___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.requiredAndLengthLimited] -->
  @override
  @requiredProp
  set requiredAndLengthLimited(List value) =>
      props[_$key__requiredAndLengthLimited___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required___$ComponentTestProps =
      PropDescriptor(_$key__required___$ComponentTestProps, isRequired: true);
  static const PropDescriptor _$prop__nullable___$ComponentTestProps =
      PropDescriptor(_$key__nullable___$ComponentTestProps,
          isRequired: true, isNullable: true);
  static const PropDescriptor
      _$prop__requiredAndLengthLimited___$ComponentTestProps = PropDescriptor(
          _$key__requiredAndLengthLimited___$ComponentTestProps,
          isRequired: true);
  static const String _$key__required___$ComponentTestProps =
      'ComponentTestProps.required';
  static const String _$key__nullable___$ComponentTestProps =
      'ComponentTestProps.nullable';
  static const String _$key__requiredAndLengthLimited___$ComponentTestProps =
      'ComponentTestProps.requiredAndLengthLimited';

  static const List<PropDescriptor> $props = [
    _$prop__required___$ComponentTestProps,
    _$prop__nullable___$ComponentTestProps,
    _$prop__requiredAndLengthLimited___$ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__required___$ComponentTestProps,
    _$key__nullable___$ComponentTestProps,
    _$key__requiredAndLengthLimited___$ComponentTestProps
  ];
}

const PropsMeta _$metaForComponentTestProps = PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

class ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForComponentTestProps;
}

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    backingProps == null
        ? _$$ComponentTestProps$JsMap(JsBackedMap())
        : _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  _$$ComponentTestProps._();

  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ComponentTestProps$JsMap(backingMap);
    } else {
      return _$$ComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ComponentTestProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ComponentTestProps$PlainMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$PlainMap(Map backingMap)
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
class _$$ComponentTestProps$JsMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$JsMap(JsBackedMap backingMap)
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
class _$ComponentTestComponent extends ComponentTestComponent {
  _$$ComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$ComponentTestProps$JsMap get props => _cachedTypedProps;

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
  _$$ComponentTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ComponentTestProps$JsMap(backingMap);

  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      _$$ComponentTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}
