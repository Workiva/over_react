// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'required_prop_integration_tests.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent(
    () => new _$ComponentTestComponent(),
    builderFactory: ComponentTest,
    componentClass: ComponentTestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ComponentTest');

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// Go to [_$ComponentTestProps.required] to see the source code for this prop
  @override
  @Required(message: 'This Prop is Required for testing purposes.')
  get required =>
      props[_$key__required___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ComponentTestProps.required] to see the source code for this prop
  @override
  @Required(message: 'This Prop is Required for testing purposes.')
  set required(value) => props[_$key__required___$ComponentTestProps] = value;

  /// Go to [_$ComponentTestProps.nullable] to see the source code for this prop
  @override
  @Required(isNullable: true, message: 'This prop can be set to null!')
  get nullable =>
      props[_$key__nullable___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ComponentTestProps.nullable] to see the source code for this prop
  @override
  @Required(isNullable: true, message: 'This prop can be set to null!')
  set nullable(value) => props[_$key__nullable___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required___$ComponentTestProps =
      const PropDescriptor(_$key__required___$ComponentTestProps,
          isRequired: true,
          errorMessage: 'This Prop is Required for testing purposes.');
  static const PropDescriptor _$prop__nullable___$ComponentTestProps =
      const PropDescriptor(_$key__nullable___$ComponentTestProps,
          isRequired: true,
          isNullable: true,
          errorMessage: 'This prop can be set to null!');
  static const String _$key__required___$ComponentTestProps =
      'ComponentTestProps.required';
  static const String _$key__nullable___$ComponentTestProps =
      'ComponentTestProps.nullable';

  static const List<PropDescriptor> $props = const [
    _$prop__required___$ComponentTestProps,
    _$prop__nullable___$ComponentTestProps
  ];
  static const List<String> $propKeys = const [
    _$key__required___$ComponentTestProps,
    _$key__nullable___$ComponentTestProps
  ];
}

const PropsMeta _$metaForComponentTestProps = const PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    backingProps == null
        ? new _$$ComponentTestProps$JsMap(new JsBackedMap())
        : new _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  _$$ComponentTestProps._();
  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$ComponentTestProps$PlainMap(backingMap);
    } else {
      return new _$$ComponentTestProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ComponentTestProps.';
}

class _$$ComponentTestProps$PlainMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

class _$$ComponentTestProps$JsMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ComponentTestProps$JsMap(JsBackedMap backingMap)
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
class _$ComponentTestComponent extends ComponentTestComponent {
  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      new _$$ComponentTestProps(backingMap);
  @override
  _$$ComponentTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ComponentTestProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
  _$$ComponentTestProps$JsMap _cachedTypedProps;
  @override
  _$$ComponentTestProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
