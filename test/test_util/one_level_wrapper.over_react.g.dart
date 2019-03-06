// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_util.one_level_wrapper;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $OneLevelWrapperComponentFactory = registerComponent(
    () => new _$OneLevelWrapperComponent(),
    builderFactory: OneLevelWrapper,
    componentClass: OneLevelWrapperComponent,
    isWrapper: true,
    parentType: null,
    displayName: 'OneLevelWrapper');

abstract class _$OneLevelWrapperPropsAccessorsMixin
    implements _$OneLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForOneLevelWrapperProps = const PropsMeta(
  fields: _$OneLevelWrapperPropsAccessorsMixin.$props,
  keys: _$OneLevelWrapperPropsAccessorsMixin.$propKeys,
);

class OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForOneLevelWrapperProps;
}

_$$OneLevelWrapperProps _$OneLevelWrapper([Map backingProps]) =>
    backingProps == null
        ? new _$$OneLevelWrapperProps$JsMap(new JsBackedMap())
        : new _$$OneLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin
    implements OneLevelWrapperProps {
  _$$OneLevelWrapperProps._();
  factory _$$OneLevelWrapperProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$OneLevelWrapperProps$PlainMap(backingMap);
    } else {
      return new _$$OneLevelWrapperProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $OneLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'OneLevelWrapperProps.';
}

class _$$OneLevelWrapperProps$PlainMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$OneLevelWrapperProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$OneLevelWrapperProps$JsMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$OneLevelWrapperProps$JsMap(JsBackedMap backingMap)
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
class _$OneLevelWrapperComponent extends OneLevelWrapperComponent {
  @override
  _$$OneLevelWrapperProps typedPropsFactory(Map backingMap) =>
      new _$$OneLevelWrapperProps(backingMap);
  @override
  _$$OneLevelWrapperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$OneLevelWrapperProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$OneLevelWrapperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForOneLevelWrapperProps
  ];
  _$$OneLevelWrapperProps$JsMap _cachedTypedProps;
  @override
  _$$OneLevelWrapperProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
