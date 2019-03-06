// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_factory_public_component.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FormActionInputComponentFactory = registerComponent(
    () => new _$FormActionInputComponent(),
    builderFactory: _FormActionInput,
    componentClass: FormActionInputComponent,
    isWrapper: false,
    parentType: null,
    displayName: '_FormActionInput');

abstract class _$FormActionInputPropsAccessorsMixin
    implements _$FormActionInputProps {
  @override
  Map get props;

  /// Go to [_$FormActionInputProps.prop1] to see the source code for this prop
  @override
  String get prop1 =>
      props[_$key__prop1___$FormActionInputProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$FormActionInputProps.prop1] to see the source code for this prop
  @override
  set prop1(String value) =>
      props[_$key__prop1___$FormActionInputProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__prop1___$FormActionInputProps =
      const PropDescriptor(_$key__prop1___$FormActionInputProps);
  static const String _$key__prop1___$FormActionInputProps =
      'FormActionInputProps.prop1';

  static const List<PropDescriptor> $props = const [
    _$prop__prop1___$FormActionInputProps
  ];
  static const List<String> $propKeys = const [
    _$key__prop1___$FormActionInputProps
  ];
}

const PropsMeta _$metaForFormActionInputProps = const PropsMeta(
  fields: _$FormActionInputPropsAccessorsMixin.$props,
  keys: _$FormActionInputPropsAccessorsMixin.$propKeys,
);

class FormActionInputProps extends _$FormActionInputProps
    with _$FormActionInputPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForFormActionInputProps;
}

_$$FormActionInputProps _$_FormActionInput([Map backingProps]) =>
    backingProps == null
        ? new _$$FormActionInputProps$JsMap(new JsBackedMap())
        : new _$$FormActionInputProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FormActionInputProps extends _$FormActionInputProps
    with _$FormActionInputPropsAccessorsMixin
    implements FormActionInputProps {
  _$$FormActionInputProps._();
  factory _$$FormActionInputProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$FormActionInputProps$PlainMap(backingMap);
    } else {
      return new _$$FormActionInputProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $FormActionInputComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FormActionInputProps.';
}

class _$$FormActionInputProps$PlainMap extends _$$FormActionInputProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

class _$$FormActionInputProps$JsMap extends _$$FormActionInputProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$FormActionInputProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
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
  @override
  _$$FormActionInputProps typedPropsFactory(Map backingMap) =>
      new _$$FormActionInputProps(backingMap);
  @override
  _$$FormActionInputProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$FormActionInputProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FormActionInputProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFormActionInputProps
  ];
  _$$FormActionInputProps$JsMap _cachedTypedProps;
  @override
  _$$FormActionInputProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
