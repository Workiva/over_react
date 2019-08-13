// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $DummyComponentFactory = registerComponent2(
  () => new _$DummyComponent(),
  builderFactory: Dummy,
  componentClass: DummyComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Dummy',
);

abstract class _$DummyPropsAccessorsMixin implements _$DummyProps {
  @override
  Map get props;

  /// <!-- Generated from [_$DummyProps.onComponentDidMount] -->
  @override
  Function get onComponentDidMount =>
      props[_$key__onComponentDidMount___$DummyProps];

  /// <!-- Generated from [_$DummyProps.onComponentDidMount] -->
  @override
  set onComponentDidMount(Function value) =>
      props[_$key__onComponentDidMount___$DummyProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onComponentDidMount___$DummyProps =
      const PropDescriptor(_$key__onComponentDidMount___$DummyProps);
  static const String _$key__onComponentDidMount___$DummyProps =
      'DummyProps.onComponentDidMount';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidMount___$DummyProps
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidMount___$DummyProps
  ];
}

const PropsMeta _$metaForDummyProps = const PropsMeta(
  fields: _$DummyPropsAccessorsMixin.$props,
  keys: _$DummyPropsAccessorsMixin.$propKeys,
);

_$$DummyProps _$Dummy([Map backingProps]) => backingProps == null
    ? new _$$DummyProps$JsMap(new JsBackedMap())
    : new _$$DummyProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$DummyProps extends _$DummyProps
    with _$DummyPropsAccessorsMixin
    implements DummyProps {
  _$$DummyProps._();

  factory _$$DummyProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$DummyProps$JsMap(backingMap);
    } else {
      return new _$$DummyProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $DummyComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'DummyProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$DummyProps$PlainMap extends _$$DummyProps {
  _$$DummyProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$DummyProps$JsMap extends _$$DummyProps {
  _$$DummyProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$DummyComponent extends DummyComponent {
  _$$DummyProps$JsMap _cachedTypedProps;

  @override
  _$$DummyProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$DummyProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$DummyProps$JsMap(backingMap);

  @override
  _$$DummyProps typedPropsFactory(Map backingMap) =>
      new _$$DummyProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$DummyProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForDummyProps];
}
