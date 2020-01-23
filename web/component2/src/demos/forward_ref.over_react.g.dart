// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'forward_ref.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $LogPropsComponentFactory = registerComponent2(
  () => _$LogPropsComponent(),
  builderFactory: _LogProps,
  componentClass: LogPropsComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_LogProps',
);

abstract class _$LogPropsPropsAccessorsMixin implements _$LogPropsProps {
  @override
  Map get props;

  /// <!-- Generated from [_$LogPropsProps.builder] -->
  @override
  BuilderOnlyUiFactory<DomProps> get builder =>
      props[_$key__builder___$LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$LogPropsProps.builder] -->
  @override
  set builder(BuilderOnlyUiFactory<DomProps> value) =>
      props[_$key__builder___$LogPropsProps] = value;

  /// <!-- Generated from [_$LogPropsProps._forwardedRef] -->
  @override
  Ref get _forwardedRef =>
      props[_$key___forwardedRef___$LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$LogPropsProps._forwardedRef] -->
  @override
  set _forwardedRef(Ref value) =>
      props[_$key___forwardedRef___$LogPropsProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__builder___$LogPropsProps =
      PropDescriptor(_$key__builder___$LogPropsProps);
  static const PropDescriptor _$prop___forwardedRef___$LogPropsProps =
      PropDescriptor(_$key___forwardedRef___$LogPropsProps);
  static const String _$key__builder___$LogPropsProps = 'LogPropsProps.builder';
  static const String _$key___forwardedRef___$LogPropsProps =
      'LogPropsProps._forwardedRef';

  static const List<PropDescriptor> $props = [
    _$prop__builder___$LogPropsProps,
    _$prop___forwardedRef___$LogPropsProps
  ];
  static const List<String> $propKeys = [
    _$key__builder___$LogPropsProps,
    _$key___forwardedRef___$LogPropsProps
  ];
}

const PropsMeta _$metaForLogPropsProps = PropsMeta(
  fields: _$LogPropsPropsAccessorsMixin.$props,
  keys: _$LogPropsPropsAccessorsMixin.$propKeys,
);

class LogPropsProps extends _$LogPropsProps with _$LogPropsPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForLogPropsProps;
}

_$$LogPropsProps _$_LogProps([Map backingProps]) => backingProps == null
    ? _$$LogPropsProps$JsMap(JsBackedMap())
    : _$$LogPropsProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$LogPropsProps extends _$LogPropsProps
    with _$LogPropsPropsAccessorsMixin
    implements LogPropsProps {
  _$$LogPropsProps._();

  factory _$$LogPropsProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$LogPropsProps$JsMap(backingMap);
    } else {
      return _$$LogPropsProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $LogPropsComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'LogPropsProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$LogPropsProps$PlainMap extends _$$LogPropsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LogPropsProps$PlainMap(Map backingMap)
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
class _$$LogPropsProps$JsMap extends _$$LogPropsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LogPropsProps$JsMap(JsBackedMap backingMap)
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
class _$LogPropsComponent extends LogPropsComponent {
  _$$LogPropsProps$JsMap _cachedTypedProps;

  @override
  _$$LogPropsProps$JsMap get props => _cachedTypedProps;

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
  _$$LogPropsProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$LogPropsProps$JsMap(backingMap);

  @override
  _$$LogPropsProps typedPropsFactory(Map backingMap) =>
      _$$LogPropsProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$LogPropsProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForLogPropsProps
  ];
}
