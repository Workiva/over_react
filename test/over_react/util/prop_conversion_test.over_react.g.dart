// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'prop_conversion_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ClassComponentComponentFactory = registerComponent2(
  () => _$ClassComponentComponent(),
  builderFactory: _$ClassComponent,
  componentClass: ClassComponentComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ClassComponent',
);

_$$ClassComponentProps _$ClassComponent([Map backingProps]) =>
    backingProps == null
        ? _$$ClassComponentProps$JsMap(JsBackedMap())
        : _$$ClassComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ClassComponentProps extends UiProps
    with
        ClassComponentProps,
        $ClassComponentProps // If this generated mixin is undefined, it's likely because ClassComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentProps, and check that $ClassComponentProps is exported/imported properly.
{
  _$$ClassComponentProps._();

  factory _$$ClassComponentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ClassComponentProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ClassComponentProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ClassComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ClassComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentProps, and check that $ClassComponentProps is exported/imported properly.
        ClassComponentProps: $ClassComponentProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ClassComponentProps$PlainMap extends _$$ClassComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ClassComponentProps$PlainMap(Map backingMap)
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
class _$$ClassComponentProps$JsMap extends _$$ClassComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ClassComponentProps$JsMap(JsBackedMap backingMap)
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
class _$ClassComponentComponent extends ClassComponentComponent {
  _$$ClassComponentProps$JsMap _cachedTypedProps;

  @override
  _$$ClassComponentProps$JsMap get props => _cachedTypedProps;

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
  _$$ClassComponentProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ClassComponentProps$JsMap(backingMap);

  @override
  _$$ClassComponentProps typedPropsFactory(Map backingMap) =>
      _$$ClassComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ClassComponentProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ClassComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentProps, and check that $ClassComponentProps is exported/imported properly.
        ClassComponentProps: $ClassComponentProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ExpectsDartMapPropProps on ExpectsDartMapPropProps {
  static const PropsMeta meta = _$metaForExpectsDartMapPropProps;
  @override
  Map get dartMapProp =>
      (props[_$key__dartMapProp__ExpectsDartMapPropProps] ?? null) as Map;
  @override
  set dartMapProp(Map value) =>
      props[_$key__dartMapProp__ExpectsDartMapPropProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__dartMapProp__ExpectsDartMapPropProps =
      PropDescriptor(_$key__dartMapProp__ExpectsDartMapPropProps);
  static const String _$key__dartMapProp__ExpectsDartMapPropProps =
      'ExpectsDartMapPropProps.dartMapProp';

  static const List<PropDescriptor> $props = [
    _$prop__dartMapProp__ExpectsDartMapPropProps
  ];
  static const List<String> $propKeys = [
    _$key__dartMapProp__ExpectsDartMapPropProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForExpectsDartMapPropProps = PropsMeta(
  fields: $ExpectsDartMapPropProps.$props,
  keys: $ExpectsDartMapPropProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ExpectsDartStylePropProps on ExpectsDartStylePropProps {
  static const PropsMeta meta = _$metaForExpectsDartStylePropProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForExpectsDartStylePropProps = PropsMeta(
  fields: $ExpectsDartStylePropProps.$props,
  keys: $ExpectsDartStylePropProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ExpectsListChildrenPropProps on ExpectsListChildrenPropProps {
  static const PropsMeta meta = _$metaForExpectsListChildrenPropProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForExpectsListChildrenPropProps = PropsMeta(
  fields: $ExpectsListChildrenPropProps.$props,
  keys: $ExpectsListChildrenPropProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ClassComponentProps on ClassComponentProps {
  static const PropsMeta meta = _$metaForClassComponentProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForClassComponentProps = PropsMeta(
  fields: $ClassComponentProps.$props,
  keys: $ClassComponentProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicForwardRefProps on BasicForwardRefProps {
  static const PropsMeta meta = _$metaForBasicForwardRefProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicForwardRefProps = PropsMeta(
  fields: $BasicForwardRefProps.$props,
  keys: $BasicForwardRefProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $DartTestJsWrapperPropsMixin on DartTestJsWrapperPropsMixin {
  static const PropsMeta meta = _$metaForDartTestJsWrapperPropsMixin;
  @override
  void Function(DartTestJsWrapperProps props) get onRender =>
      (props[_$key__onRender__DartTestJsWrapperPropsMixin] ?? null) as void
          Function(DartTestJsWrapperProps props);
  @override
  set onRender(void Function(DartTestJsWrapperProps props) value) =>
      props[_$key__onRender__DartTestJsWrapperPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onRender__DartTestJsWrapperPropsMixin =
      PropDescriptor(_$key__onRender__DartTestJsWrapperPropsMixin);
  static const String _$key__onRender__DartTestJsWrapperPropsMixin =
      'DartTestJsWrapperPropsMixin.onRender';

  static const List<PropDescriptor> $props = [
    _$prop__onRender__DartTestJsWrapperPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__onRender__DartTestJsWrapperPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForDartTestJsWrapperPropsMixin = PropsMeta(
  fields: $DartTestJsWrapperPropsMixin.$props,
  keys: $DartTestJsWrapperPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestJsProps on TestJsProps {
  static const PropsMeta meta = _$metaForTestJsProps;
  @override
  @Accessor(key: 'buttonProps')
  JsMap get _$raw$buttonProps =>
      (props[_$key___$raw$buttonProps__TestJsProps] ?? null) as JsMap;
  @override
  @Accessor(key: 'buttonProps')
  set _$raw$buttonProps(JsMap value) =>
      props[_$key___$raw$buttonProps__TestJsProps] = value;
  @override
  @Accessor(key: 'inputRef')
  dynamic get _$raw$inputRef =>
      (props[_$key___$raw$inputRef__TestJsProps] ?? null) as dynamic;
  @override
  @Accessor(key: 'inputRef')
  set _$raw$inputRef(dynamic value) =>
      props[_$key___$raw$inputRef__TestJsProps] = value;
  @override
  dynamic get component =>
      (props[_$key__component__TestJsProps] ?? null) as dynamic;
  @override
  set component(dynamic value) => props[_$key__component__TestJsProps] = value;
  @override
  dynamic get inputComponent =>
      (props[_$key__inputComponent__TestJsProps] ?? null) as dynamic;
  @override
  set inputComponent(dynamic value) =>
      props[_$key__inputComponent__TestJsProps] = value;
  @override
  dynamic get buttonComponent =>
      (props[_$key__buttonComponent__TestJsProps] ?? null) as dynamic;
  @override
  set buttonComponent(dynamic value) =>
      props[_$key__buttonComponent__TestJsProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop___$raw$buttonProps__TestJsProps =
      PropDescriptor(_$key___$raw$buttonProps__TestJsProps);
  static const PropDescriptor _$prop___$raw$inputRef__TestJsProps =
      PropDescriptor(_$key___$raw$inputRef__TestJsProps);
  static const PropDescriptor _$prop__component__TestJsProps =
      PropDescriptor(_$key__component__TestJsProps);
  static const PropDescriptor _$prop__inputComponent__TestJsProps =
      PropDescriptor(_$key__inputComponent__TestJsProps);
  static const PropDescriptor _$prop__buttonComponent__TestJsProps =
      PropDescriptor(_$key__buttonComponent__TestJsProps);
  static const String _$key___$raw$buttonProps__TestJsProps = 'buttonProps';
  static const String _$key___$raw$inputRef__TestJsProps = 'inputRef';
  static const String _$key__component__TestJsProps = 'component';
  static const String _$key__inputComponent__TestJsProps = 'inputComponent';
  static const String _$key__buttonComponent__TestJsProps = 'buttonComponent';

  static const List<PropDescriptor> $props = [
    _$prop___$raw$buttonProps__TestJsProps,
    _$prop___$raw$inputRef__TestJsProps,
    _$prop__component__TestJsProps,
    _$prop__inputComponent__TestJsProps,
    _$prop__buttonComponent__TestJsProps
  ];
  static const List<String> $propKeys = [
    _$key___$raw$buttonProps__TestJsProps,
    _$key___$raw$inputRef__TestJsProps,
    _$key__component__TestJsProps,
    _$key__inputComponent__TestJsProps,
    _$key__buttonComponent__TestJsProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestJsProps = PropsMeta(
  fields: $TestJsProps.$props,
  keys: $TestJsProps.$propKeys,
);

final UiFactoryConfig<_$$ExpectsDartMapPropProps> _$ExpectsDartMapPropConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsDartMapPropProps(map),
          jsMap: (map) => _$$ExpectsDartMapPropProps$JsMap(map),
        ),
        displayName: 'ExpectsDartMapProp');

@Deprecated(r'Use the private variable, _$ExpectsDartMapPropConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ExpectsDartMapPropProps> $ExpectsDartMapPropConfig =
    _$ExpectsDartMapPropConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExpectsDartMapPropProps extends UiProps
    with
        ExpectsDartMapPropProps,
        $ExpectsDartMapPropProps // If this generated mixin is undefined, it's likely because ExpectsDartMapPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartMapPropProps, and check that $ExpectsDartMapPropProps is exported/imported properly.
{
  _$$ExpectsDartMapPropProps._();

  factory _$$ExpectsDartMapPropProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsDartMapPropProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ExpectsDartMapPropProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ExpectsDartMapPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartMapPropProps, and check that $ExpectsDartMapPropProps is exported/imported properly.
        ExpectsDartMapPropProps: $ExpectsDartMapPropProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsDartMapPropProps$PlainMap extends _$$ExpectsDartMapPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartMapPropProps$PlainMap(Map backingMap)
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
class _$$ExpectsDartMapPropProps$JsMap extends _$$ExpectsDartMapPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartMapPropProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$ExpectsDartStylePropProps>
    _$ExpectsDartStylePropConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsDartStylePropProps(map),
          jsMap: (map) => _$$ExpectsDartStylePropProps$JsMap(map),
        ),
        displayName: 'ExpectsDartStyleProp');

@Deprecated(r'Use the private variable, _$ExpectsDartStylePropConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ExpectsDartStylePropProps>
    $ExpectsDartStylePropConfig = _$ExpectsDartStylePropConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExpectsDartStylePropProps extends UiProps
    with
        ExpectsDartStylePropProps,
        $ExpectsDartStylePropProps // If this generated mixin is undefined, it's likely because ExpectsDartStylePropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartStylePropProps, and check that $ExpectsDartStylePropProps is exported/imported properly.
{
  _$$ExpectsDartStylePropProps._();

  factory _$$ExpectsDartStylePropProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsDartStylePropProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ExpectsDartStylePropProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ExpectsDartStylePropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartStylePropProps, and check that $ExpectsDartStylePropProps is exported/imported properly.
        ExpectsDartStylePropProps: $ExpectsDartStylePropProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsDartStylePropProps$PlainMap
    extends _$$ExpectsDartStylePropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartStylePropProps$PlainMap(Map backingMap)
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
class _$$ExpectsDartStylePropProps$JsMap extends _$$ExpectsDartStylePropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartStylePropProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$ExpectsListChildrenPropProps>
    _$ExpectsListChildrenPropConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsListChildrenPropProps(map),
          jsMap: (map) => _$$ExpectsListChildrenPropProps$JsMap(map),
        ),
        displayName: 'ExpectsListChildrenProp');

@Deprecated(
    r'Use the private variable, _$ExpectsListChildrenPropConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ExpectsListChildrenPropProps>
    $ExpectsListChildrenPropConfig = _$ExpectsListChildrenPropConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExpectsListChildrenPropProps extends UiProps
    with
        ExpectsListChildrenPropProps,
        $ExpectsListChildrenPropProps // If this generated mixin is undefined, it's likely because ExpectsListChildrenPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsListChildrenPropProps, and check that $ExpectsListChildrenPropProps is exported/imported properly.
{
  _$$ExpectsListChildrenPropProps._();

  factory _$$ExpectsListChildrenPropProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsListChildrenPropProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ExpectsListChildrenPropProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ExpectsListChildrenPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsListChildrenPropProps, and check that $ExpectsListChildrenPropProps is exported/imported properly.
        ExpectsListChildrenPropProps: $ExpectsListChildrenPropProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsListChildrenPropProps$PlainMap
    extends _$$ExpectsListChildrenPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsListChildrenPropProps$PlainMap(Map backingMap)
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
class _$$ExpectsListChildrenPropProps$JsMap
    extends _$$ExpectsListChildrenPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsListChildrenPropProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$BasicForwardRefProps> _$BasicForwardRefConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$BasicForwardRefProps(map),
          jsMap: (map) => _$$BasicForwardRefProps$JsMap(map),
        ),
        displayName: 'BasicForwardRef');

@Deprecated(r'Use the private variable, _$BasicForwardRefConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$BasicForwardRefProps> $BasicForwardRefConfig =
    _$BasicForwardRefConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicForwardRefProps extends UiProps
    with
        BasicForwardRefProps,
        $BasicForwardRefProps // If this generated mixin is undefined, it's likely because BasicForwardRefProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicForwardRefProps, and check that $BasicForwardRefProps is exported/imported properly.
{
  _$$BasicForwardRefProps._();

  factory _$$BasicForwardRefProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicForwardRefProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$BasicForwardRefProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because BasicForwardRefProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicForwardRefProps, and check that $BasicForwardRefProps is exported/imported properly.
        BasicForwardRefProps: $BasicForwardRefProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicForwardRefProps$PlainMap extends _$$BasicForwardRefProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicForwardRefProps$PlainMap(Map backingMap)
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
class _$$BasicForwardRefProps$JsMap extends _$$BasicForwardRefProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicForwardRefProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$DartTestJsWrapperProps> _$DartTestJsWrapperConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$DartTestJsWrapperProps(map),
          jsMap: (map) => _$$DartTestJsWrapperProps$JsMap(map),
        ),
        displayName: 'DartTestJsWrapper');

@Deprecated(r'Use the private variable, _$DartTestJsWrapperConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$DartTestJsWrapperProps> $DartTestJsWrapperConfig =
    _$DartTestJsWrapperConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$DartTestJsWrapperProps extends UiProps
    with
        TestJsProps,
        $TestJsProps, // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        DartTestJsWrapperPropsMixin,
        $DartTestJsWrapperPropsMixin // If this generated mixin is undefined, it's likely because DartTestJsWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DartTestJsWrapperPropsMixin, and check that $DartTestJsWrapperPropsMixin is exported/imported properly.
    implements
        DartTestJsWrapperProps {
  _$$DartTestJsWrapperProps._();

  factory _$$DartTestJsWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DartTestJsWrapperProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$DartTestJsWrapperProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        TestJsProps: $TestJsProps.meta,
        // If this generated mixin is undefined, it's likely because DartTestJsWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DartTestJsWrapperPropsMixin, and check that $DartTestJsWrapperPropsMixin is exported/imported properly.
        DartTestJsWrapperPropsMixin: $DartTestJsWrapperPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$DartTestJsWrapperProps$PlainMap extends _$$DartTestJsWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DartTestJsWrapperProps$PlainMap(Map backingMap)
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
class _$$DartTestJsWrapperProps$JsMap extends _$$DartTestJsWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DartTestJsWrapperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestJsProps> _$TestJsConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestJsProps(map),
      jsMap: (map) => _$$TestJsProps$JsMap(map),
    ),
    displayName: 'TestJs');

@Deprecated(r'Use the private variable, _$TestJsConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestJsProps> $TestJsConfig = _$TestJsConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestJsProps extends UiProps
    with
        TestJsProps,
        $TestJsProps // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
{
  _$$TestJsProps._();

  factory _$$TestJsProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestJsProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestJsProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        TestJsProps: $TestJsProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestJsProps$PlainMap extends _$$TestJsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestJsProps$PlainMap(Map backingMap)
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
class _$$TestJsProps$JsMap extends _$$TestJsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestJsProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
