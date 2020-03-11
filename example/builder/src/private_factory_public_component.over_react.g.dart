// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'private_factory_public_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FormActionInputComponentFactory = registerComponent2(
  () => _$FormActionInputComponent(),
  builderFactory: _FormActionInput,
  componentClass: FormActionInputComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_FormActionInput',
);

_$$FormActionInputProps _$_FormActionInput([Map backingProps]) =>
    backingProps == null
        ? _$$FormActionInputProps$JsMap(JsBackedMap())
        : _$$FormActionInputProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$FormActionInputProps extends UiProps
    with FormActionInputProps, $FormActionInputProps {
  _$$FormActionInputProps._();

  factory _$$FormActionInputProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FormActionInputProps$JsMap(backingMap);
    } else {
      return _$$FormActionInputProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FormActionInputComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
class _$$FormActionInputProps$PlainMap extends _$$FormActionInputProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FormActionInputProps$PlainMap(Map backingMap)
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
class _$$FormActionInputProps$JsMap extends _$$FormActionInputProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FormActionInputProps$JsMap(JsBackedMap backingMap)
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
class _$FormActionInputComponent extends FormActionInputComponent {
  _$$FormActionInputProps$JsMap _cachedTypedProps;

  @override
  _$$FormActionInputProps$JsMap get props => _cachedTypedProps;

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
  _$$FormActionInputProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FormActionInputProps$JsMap(backingMap);

  @override
  _$$FormActionInputProps typedPropsFactory(Map backingMap) =>
      _$$FormActionInputProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from FormActionInputProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFormActionInputProps
  ];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        FormActionInputProps: $FormActionInputProps.meta,
      });
}

mixin $FormActionInputProps on FormActionInputProps {
  static const PropsMeta meta = _$metaForFormActionInputProps;
  @override
  String get prop1 =>
      props[_$key__prop1__FormActionInputProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set prop1(String value) => props[_$key__prop1__FormActionInputProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__prop1__FormActionInputProps =
      PropDescriptor(_$key__prop1__FormActionInputProps);
  static const String _$key__prop1__FormActionInputProps =
      'FormActionInputProps.prop1';

  static const List<PropDescriptor> $props = [
    _$prop__prop1__FormActionInputProps
  ];
  static const List<String> $propKeys = [_$key__prop1__FormActionInputProps];
}

const PropsMeta _$metaForFormActionInputProps = PropsMeta(
  fields: $FormActionInputProps.$props,
  keys: $FormActionInputProps.$propKeys,
);
