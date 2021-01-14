// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'redux_big_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ReduxBigBlockComponentFactory = registerComponent2(
  () => _$ReduxBigBlockComponent(),
  builderFactory: _$ReduxBigBlock,
  componentClass: ReduxBigBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ReduxBigBlock',
);

_$$ReduxBigBlockProps _$ReduxBigBlock([Map backingProps]) =>
    backingProps == null
        ? _$$ReduxBigBlockProps$JsMap(JsBackedMap())
        : _$$ReduxBigBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ReduxBigBlockProps extends UiProps
    with
        ReduxBigBlockPropsMixin,
        $ReduxBigBlockPropsMixin, // If this generated mixin is undefined, it's likely because ReduxBigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ReduxBigBlockPropsMixin, and check that $ReduxBigBlockPropsMixin is exported/imported properly.
        ConnectPropsMixin,
        $ConnectPropsMixin // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ConnectPropsMixin, and check that $ConnectPropsMixin is exported/imported properly.
    implements
        ReduxBigBlockProps {
  _$$ReduxBigBlockProps._();

  factory _$$ReduxBigBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ReduxBigBlockProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ReduxBigBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ReduxBigBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ReduxBigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ReduxBigBlockPropsMixin, and check that $ReduxBigBlockPropsMixin is exported/imported properly.
        ReduxBigBlockPropsMixin: $ReduxBigBlockPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ConnectPropsMixin, and check that $ConnectPropsMixin is exported/imported properly.
        ConnectPropsMixin: $ConnectPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ReduxBigBlockProps$PlainMap extends _$$ReduxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxBigBlockProps$PlainMap(Map backingMap)
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
class _$$ReduxBigBlockProps$JsMap extends _$$ReduxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxBigBlockProps$JsMap(JsBackedMap backingMap)
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
class _$ReduxBigBlockComponent extends ReduxBigBlockComponent {
  _$$ReduxBigBlockProps$JsMap _cachedTypedProps;

  @override
  _$$ReduxBigBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$ReduxBigBlockProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ReduxBigBlockProps$JsMap(backingMap);

  @override
  _$$ReduxBigBlockProps typedPropsFactory(Map backingMap) =>
      _$$ReduxBigBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ReduxBigBlockProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ReduxBigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ReduxBigBlockPropsMixin, and check that $ReduxBigBlockPropsMixin is exported/imported properly.
        ReduxBigBlockPropsMixin: $ReduxBigBlockPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ConnectPropsMixin, and check that $ConnectPropsMixin is exported/imported properly.
        ConnectPropsMixin: $ConnectPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ReduxBigBlockPropsMixin on ReduxBigBlockPropsMixin {
  static const PropsMeta meta = _$metaForReduxBigBlockPropsMixin;
  @override
  String get backgroundColor =>
      (props[_$key__backgroundColor__ReduxBigBlockPropsMixin] ?? null)
          as String;
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor__ReduxBigBlockPropsMixin] = value;
  @override
  String get blockTwoBackgroundColor =>
      (props[_$key__blockTwoBackgroundColor__ReduxBigBlockPropsMixin] ?? null)
          as String;
  @override
  set blockTwoBackgroundColor(String value) =>
      props[_$key__blockTwoBackgroundColor__ReduxBigBlockPropsMixin] = value;
  @override
  String get blockThreeBackgroundColor =>
      (props[_$key__blockThreeBackgroundColor__ReduxBigBlockPropsMixin] ?? null)
          as String;
  @override
  set blockThreeBackgroundColor(String value) =>
      props[_$key__blockThreeBackgroundColor__ReduxBigBlockPropsMixin] = value;
  @override
  String get blockOneBackgroundColor =>
      (props[_$key__blockOneBackgroundColor__ReduxBigBlockPropsMixin] ?? null)
          as String;
  @override
  set blockOneBackgroundColor(String value) =>
      props[_$key__blockOneBackgroundColor__ReduxBigBlockPropsMixin] = value;
  @override
  void Function() get changeMainBackgroundColor =>
      (props[_$key__changeMainBackgroundColor__ReduxBigBlockPropsMixin] ?? null)
          as void Function();
  @override
  set changeMainBackgroundColor(void Function() value) =>
      props[_$key__changeMainBackgroundColor__ReduxBigBlockPropsMixin] = value;
  @override
  void Function() get changeBlockOneBackgroundColor =>
      (props[_$key__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin] ??
          null) as void Function();
  @override
  set changeBlockOneBackgroundColor(void Function() value) =>
      props[_$key__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin] =
          value;
  @override
  void Function() get changeBlockTwoBackgroundColor =>
      (props[_$key__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin] ??
          null) as void Function();
  @override
  set changeBlockTwoBackgroundColor(void Function() value) =>
      props[_$key__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin] =
          value;
  @override
  void Function() get changeBlockThreeBackgroundColor =>
      (props[_$key__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin] ??
          null) as void Function();
  @override
  set changeBlockThreeBackgroundColor(void Function() value) =>
      props[_$key__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(_$key__backgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__blockTwoBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(_$key__blockTwoBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__blockThreeBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(_$key__blockThreeBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__blockOneBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(_$key__blockOneBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__changeMainBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(_$key__changeMainBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(
          _$key__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(
          _$key__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin =
      PropDescriptor(
          _$key__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin);
  static const String _$key__backgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.backgroundColor';
  static const String _$key__blockTwoBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.blockTwoBackgroundColor';
  static const String
      _$key__blockThreeBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.blockThreeBackgroundColor';
  static const String _$key__blockOneBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.blockOneBackgroundColor';
  static const String
      _$key__changeMainBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.changeMainBackgroundColor';
  static const String
      _$key__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.changeBlockOneBackgroundColor';
  static const String
      _$key__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.changeBlockTwoBackgroundColor';
  static const String
      _$key__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin =
      'ReduxBigBlockPropsMixin.changeBlockThreeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor__ReduxBigBlockPropsMixin,
    _$prop__blockTwoBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__blockThreeBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__blockOneBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__changeMainBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin,
    _$prop__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor__ReduxBigBlockPropsMixin,
    _$key__blockTwoBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__blockThreeBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__blockOneBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__changeMainBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__changeBlockOneBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__changeBlockTwoBackgroundColor__ReduxBigBlockPropsMixin,
    _$key__changeBlockThreeBackgroundColor__ReduxBigBlockPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForReduxBigBlockPropsMixin = PropsMeta(
  fields: $ReduxBigBlockPropsMixin.$props,
  keys: $ReduxBigBlockPropsMixin.$propKeys,
);
