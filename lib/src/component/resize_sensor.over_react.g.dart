// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'resize_sensor.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ResizeSensorComponentFactory = registerComponent2(
  () => _$ResizeSensorComponent(),
  builderFactory: _$ResizeSensor,
  componentClass: ResizeSensorComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ResizeSensor',
);

_$$ResizeSensorProps _$ResizeSensor([Map? backingProps]) => backingProps == null
    ? _$$ResizeSensorProps$JsMap(JsBackedMap())
    : _$$ResizeSensorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ResizeSensorProps extends UiProps
    with
        ResizeSensorProps,
        $ResizeSensorProps // If this generated mixin is undefined, it's likely because ResizeSensorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ResizeSensorProps, and check that $ResizeSensorProps is exported/imported properly.
{
  _$$ResizeSensorProps._();

  factory _$$ResizeSensorProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ResizeSensorProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ResizeSensorProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ResizeSensorComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ResizeSensorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ResizeSensorProps, and check that $ResizeSensorProps is exported/imported properly.
        ResizeSensorProps: $ResizeSensorProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ResizeSensorProps$PlainMap extends _$$ResizeSensorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ResizeSensorProps$PlainMap(Map? backingMap)
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
class _$$ResizeSensorProps$JsMap extends _$$ResizeSensorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ResizeSensorProps$JsMap(JsBackedMap? backingMap)
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
class _$ResizeSensorComponent extends ResizeSensorComponent {
  late _$$ResizeSensorProps$JsMap _cachedTypedProps;

  @override
  _$$ResizeSensorProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ResizeSensorProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ResizeSensorProps$JsMap(backingMap);

  @override
  _$$ResizeSensorProps typedPropsFactory(Map? backingMap) =>
      _$$ResizeSensorProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ResizeSensorProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ResizeSensorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ResizeSensorProps, and check that $ResizeSensorProps is exported/imported properly.
        ResizeSensorProps: $ResizeSensorProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ResizeSensorProps on ResizeSensorProps {
  static const PropsMeta meta = _$metaForResizeSensorProps;
  @override
  ResizeSensorHandler? get onInitialize =>
      (props[_$key__onInitialize__ResizeSensorProps] ?? null)
          as ResizeSensorHandler?;
  @override
  set onInitialize(ResizeSensorHandler? value) =>
      props[_$key__onInitialize__ResizeSensorProps] = value;
  @override
  ResizeSensorHandler? get onResize =>
      (props[_$key__onResize__ResizeSensorProps] ?? null)
          as ResizeSensorHandler?;
  @override
  set onResize(ResizeSensorHandler? value) =>
      props[_$key__onResize__ResizeSensorProps] = value;
  @override
  bool? get isFlexChild =>
      (props[_$key__isFlexChild__ResizeSensorProps] ?? null) as bool?;
  @override
  set isFlexChild(bool? value) =>
      props[_$key__isFlexChild__ResizeSensorProps] = value;
  @override
  bool? get isFlexContainer =>
      (props[_$key__isFlexContainer__ResizeSensorProps] ?? null) as bool?;
  @override
  set isFlexContainer(bool? value) =>
      props[_$key__isFlexContainer__ResizeSensorProps] = value;
  @override
  bool? get shrink =>
      (props[_$key__shrink__ResizeSensorProps] ?? null) as bool?;
  @override
  set shrink(bool? value) => props[_$key__shrink__ResizeSensorProps] = value;
  @override
  bool? get quickMount =>
      (props[_$key__quickMount__ResizeSensorProps] ?? null) as bool?;
  @override
  set quickMount(bool? value) =>
      props[_$key__quickMount__ResizeSensorProps] = value;
  @override
  BoolCallback? get onDetachedMountCheck =>
      (props[_$key__onDetachedMountCheck__ResizeSensorProps] ?? null)
          as BoolCallback?;
  @override
  set onDetachedMountCheck(BoolCallback? value) =>
      props[_$key__onDetachedMountCheck__ResizeSensorProps] = value;
  @override
  @visibleForTesting
  Callback? get onDidReset =>
      (props[_$key__onDidReset__ResizeSensorProps] ?? null) as Callback?;
  @override
  @visibleForTesting
  set onDidReset(Callback? value) =>
      props[_$key__onDidReset__ResizeSensorProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onInitialize__ResizeSensorProps =
      PropDescriptor(_$key__onInitialize__ResizeSensorProps);
  static const PropDescriptor _$prop__onResize__ResizeSensorProps =
      PropDescriptor(_$key__onResize__ResizeSensorProps);
  static const PropDescriptor _$prop__isFlexChild__ResizeSensorProps =
      PropDescriptor(_$key__isFlexChild__ResizeSensorProps);
  static const PropDescriptor _$prop__isFlexContainer__ResizeSensorProps =
      PropDescriptor(_$key__isFlexContainer__ResizeSensorProps);
  static const PropDescriptor _$prop__shrink__ResizeSensorProps =
      PropDescriptor(_$key__shrink__ResizeSensorProps);
  static const PropDescriptor _$prop__quickMount__ResizeSensorProps =
      PropDescriptor(_$key__quickMount__ResizeSensorProps);
  static const PropDescriptor _$prop__onDetachedMountCheck__ResizeSensorProps =
      PropDescriptor(_$key__onDetachedMountCheck__ResizeSensorProps);
  static const PropDescriptor _$prop__onDidReset__ResizeSensorProps =
      PropDescriptor(_$key__onDidReset__ResizeSensorProps);
  static const String _$key__onInitialize__ResizeSensorProps =
      'ResizeSensorProps.onInitialize';
  static const String _$key__onResize__ResizeSensorProps =
      'ResizeSensorProps.onResize';
  static const String _$key__isFlexChild__ResizeSensorProps =
      'ResizeSensorProps.isFlexChild';
  static const String _$key__isFlexContainer__ResizeSensorProps =
      'ResizeSensorProps.isFlexContainer';
  static const String _$key__shrink__ResizeSensorProps =
      'ResizeSensorProps.shrink';
  static const String _$key__quickMount__ResizeSensorProps =
      'ResizeSensorProps.quickMount';
  static const String _$key__onDetachedMountCheck__ResizeSensorProps =
      'ResizeSensorProps.onDetachedMountCheck';
  static const String _$key__onDidReset__ResizeSensorProps =
      'ResizeSensorProps.onDidReset';

  static const List<PropDescriptor> $props = [
    _$prop__onInitialize__ResizeSensorProps,
    _$prop__onResize__ResizeSensorProps,
    _$prop__isFlexChild__ResizeSensorProps,
    _$prop__isFlexContainer__ResizeSensorProps,
    _$prop__shrink__ResizeSensorProps,
    _$prop__quickMount__ResizeSensorProps,
    _$prop__onDetachedMountCheck__ResizeSensorProps,
    _$prop__onDidReset__ResizeSensorProps
  ];
  static const List<String> $propKeys = [
    _$key__onInitialize__ResizeSensorProps,
    _$key__onResize__ResizeSensorProps,
    _$key__isFlexChild__ResizeSensorProps,
    _$key__isFlexContainer__ResizeSensorProps,
    _$key__shrink__ResizeSensorProps,
    _$key__quickMount__ResizeSensorProps,
    _$key__onDetachedMountCheck__ResizeSensorProps,
    _$key__onDidReset__ResizeSensorProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForResizeSensorProps = PropsMeta(
  fields: $ResizeSensorProps.$props,
  keys: $ResizeSensorProps.$propKeys,
);
