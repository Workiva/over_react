// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'should_not_update.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ShouldNotUpdateComponentFactory = registerComponent2(
  () => _$ShouldNotUpdateComponent(),
  builderFactory: ShouldNotUpdate,
  componentClass: ShouldNotUpdateComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ShouldNotUpdate',
);

abstract class _$ShouldNotUpdatePropsAccessorsMixin
    implements _$ShouldNotUpdateProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ShouldNotUpdateProps.text] -->
  @override
  String get text =>
      props[_$key__text___$ShouldNotUpdateProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ShouldNotUpdateProps.text] -->
  @override
  set text(String value) => props[_$key__text___$ShouldNotUpdateProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__text___$ShouldNotUpdateProps =
      PropDescriptor(_$key__text___$ShouldNotUpdateProps);
  static const String _$key__text___$ShouldNotUpdateProps =
      'ShouldNotUpdateProps.text';

  static const List<PropDescriptor> $props = [
    _$prop__text___$ShouldNotUpdateProps
  ];
  static const List<String> $propKeys = [_$key__text___$ShouldNotUpdateProps];
}

const PropsMeta _$metaForShouldNotUpdateProps = PropsMeta(
  fields: _$ShouldNotUpdatePropsAccessorsMixin.$props,
  keys: _$ShouldNotUpdatePropsAccessorsMixin.$propKeys,
);

class ShouldNotUpdateProps extends _$ShouldNotUpdateProps
    with _$ShouldNotUpdatePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForShouldNotUpdateProps;
}

_$$ShouldNotUpdateProps _$ShouldNotUpdate([Map backingProps]) =>
    backingProps == null
        ? _$$ShouldNotUpdateProps$JsMap(JsBackedMap())
        : _$$ShouldNotUpdateProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ShouldNotUpdateProps extends _$ShouldNotUpdateProps
    with _$ShouldNotUpdatePropsAccessorsMixin
    implements ShouldNotUpdateProps {
  _$$ShouldNotUpdateProps._();

  factory _$$ShouldNotUpdateProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ShouldNotUpdateProps$JsMap(backingMap);
    } else {
      return _$$ShouldNotUpdateProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ShouldNotUpdateComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ShouldNotUpdateProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ShouldNotUpdateProps$PlainMap extends _$$ShouldNotUpdateProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ShouldNotUpdateProps$PlainMap(Map backingMap)
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
class _$$ShouldNotUpdateProps$JsMap extends _$$ShouldNotUpdateProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ShouldNotUpdateProps$JsMap(JsBackedMap backingMap)
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
class _$ShouldNotUpdateComponent extends ShouldNotUpdateComponent {
  _$$ShouldNotUpdateProps$JsMap _cachedTypedProps;

  @override
  _$$ShouldNotUpdateProps$JsMap get props => _cachedTypedProps;

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
  _$$ShouldNotUpdateProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ShouldNotUpdateProps$JsMap(backingMap);

  @override
  _$$ShouldNotUpdateProps typedPropsFactory(Map backingMap) =>
      _$$ShouldNotUpdateProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ShouldNotUpdateProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      const [_$metaForShouldNotUpdateProps];
}
