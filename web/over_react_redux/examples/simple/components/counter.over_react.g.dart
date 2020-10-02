// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'counter.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $CounterComponentFactory = registerComponent2(
  () => _$CounterComponent(),
  builderFactory: _$_Counter,
  componentClass: CounterComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_Counter',
);

_$$CounterProps _$_Counter([Map backingProps]) => backingProps == null
    ? _$$CounterProps$JsMap(JsBackedMap())
    : _$$CounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$CounterProps extends UiProps
    with
        CounterPropsMixin,
        $CounterPropsMixin, // If this generated mixin is undefined, it's likely because CounterPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of CounterPropsMixin, and check that $CounterPropsMixin is exported/imported properly.
        ConnectPropsMixin,
        $ConnectPropsMixin // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ConnectPropsMixin, and check that $ConnectPropsMixin is exported/imported properly.
    implements
        CounterProps {
  _$$CounterProps._();

  factory _$$CounterProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$CounterProps$JsMap(backingMap);
    } else {
      return _$$CounterProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CounterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$CounterProps$PlainMap extends _$$CounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CounterProps$PlainMap(Map backingMap)
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
class _$$CounterProps$JsMap extends _$$CounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CounterProps$JsMap(JsBackedMap backingMap)
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
class _$CounterComponent extends CounterComponent {
  _$$CounterProps$JsMap _cachedTypedProps;

  @override
  _$$CounterProps$JsMap get props => _cachedTypedProps;

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
  _$$CounterProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$CounterProps$JsMap(backingMap);

  @override
  _$$CounterProps typedPropsFactory(Map backingMap) =>
      _$$CounterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by CounterProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because CounterPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of CounterPropsMixin, and check that $CounterPropsMixin is exported/imported properly.
        CounterPropsMixin: $CounterPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ConnectPropsMixin, and check that $ConnectPropsMixin is exported/imported properly.
        ConnectPropsMixin: $ConnectPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $CounterPropsMixin on CounterPropsMixin {
  static const PropsMeta meta = _$metaForCounterPropsMixin;
  @override
  int get currentCount =>
      props[_$key__currentCount__CounterPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set currentCount(int value) =>
      props[_$key__currentCount__CounterPropsMixin] = value;
  @override
  Map<String, dynamic> get wrapperStyles =>
      props[_$key__wrapperStyles__CounterPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set wrapperStyles(Map<String, dynamic> value) =>
      props[_$key__wrapperStyles__CounterPropsMixin] = value;
  @override
  void Function() get increment =>
      props[_$key__increment__CounterPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set increment(void Function() value) =>
      props[_$key__increment__CounterPropsMixin] = value;
  @override
  void Function() get decrement =>
      props[_$key__decrement__CounterPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set decrement(void Function() value) =>
      props[_$key__decrement__CounterPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__currentCount__CounterPropsMixin =
      PropDescriptor(_$key__currentCount__CounterPropsMixin);
  static const PropDescriptor _$prop__wrapperStyles__CounterPropsMixin =
      PropDescriptor(_$key__wrapperStyles__CounterPropsMixin);
  static const PropDescriptor _$prop__increment__CounterPropsMixin =
      PropDescriptor(_$key__increment__CounterPropsMixin);
  static const PropDescriptor _$prop__decrement__CounterPropsMixin =
      PropDescriptor(_$key__decrement__CounterPropsMixin);
  static const String _$key__currentCount__CounterPropsMixin =
      'CounterPropsMixin.currentCount';
  static const String _$key__wrapperStyles__CounterPropsMixin =
      'CounterPropsMixin.wrapperStyles';
  static const String _$key__increment__CounterPropsMixin =
      'CounterPropsMixin.increment';
  static const String _$key__decrement__CounterPropsMixin =
      'CounterPropsMixin.decrement';

  static const List<PropDescriptor> $props = [
    _$prop__currentCount__CounterPropsMixin,
    _$prop__wrapperStyles__CounterPropsMixin,
    _$prop__increment__CounterPropsMixin,
    _$prop__decrement__CounterPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__currentCount__CounterPropsMixin,
    _$key__wrapperStyles__CounterPropsMixin,
    _$key__increment__CounterPropsMixin,
    _$key__decrement__CounterPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForCounterPropsMixin = PropsMeta(
  fields: $CounterPropsMixin.$props,
  keys: $CounterPropsMixin.$propKeys,
);
