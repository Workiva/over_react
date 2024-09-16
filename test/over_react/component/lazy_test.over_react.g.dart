// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'lazy_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $TestDartClassComponentFactory = registerComponent2(
  () => _$TestDartClassComponent(),
  builderFactory: _$TestDartClass,
  componentClass: TestDartClassComponent,
  isWrapper: false,
  parentType: null,
);

_$$TestDartClassProps _$TestDartClass([Map? backingProps]) =>
    backingProps == null
        ? _$$TestDartClassProps$JsMap(JsBackedMap())
        : _$$TestDartClassProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestDartClassProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps
    implements
        TestDartClassProps {
  _$$TestDartClassProps._();

  factory _$$TestDartClassProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestDartClassProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestDartClassProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestDartClassComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        TestJsProps: $TestJsProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestDartClassProps(
          accessMap, (map) => _$$TestDartClassProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestDartClassProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestDartClassProps$PlainMap extends _$$TestDartClassProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestDartClassProps$PlainMap(Map? backingMap)
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
class _$$TestDartClassProps$JsMap extends _$$TestDartClassProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestDartClassProps$JsMap(JsBackedMap? backingMap)
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
class _$TestDartClassComponent extends TestDartClassComponent {
  late _$$TestDartClassProps$JsMap _cachedTypedProps;

  @override
  _$$TestDartClassProps$JsMap get props => _cachedTypedProps;

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
  _$$TestDartClassProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestDartClassProps$JsMap(backingMap);

  @override
  _$$TestDartClassProps typedPropsFactory(Map? backingMap) =>
      _$$TestDartClassProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestDartClass';

  /// The default consumed props, comprising all props mixins used by TestDartClassProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        TestJsProps: $TestJsProps.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ClassComponentTypeTesterComponentFactory = registerComponent2(
  () => _$ClassComponentTypeTesterComponent(),
  builderFactory: _$ClassComponentTypeTester,
  componentClass: ClassComponentTypeTesterComponent,
  isWrapper: false,
  parentType: null,
);

_$$ClassComponentTypeTesterProps _$ClassComponentTypeTester(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$ClassComponentTypeTesterProps$JsMap(JsBackedMap())
        : _$$ClassComponentTypeTesterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ClassComponentTypeTesterProps extends UiProps
    with
        ClassComponentTypeTesterProps,
        // If this generated mixin is undefined, it's likely because ClassComponentTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentTypeTesterProps, and check that $ClassComponentTypeTesterProps is exported/imported properly.
        $ClassComponentTypeTesterProps {
  _$$ClassComponentTypeTesterProps._();

  factory _$$ClassComponentTypeTesterProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ClassComponentTypeTesterProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ClassComponentTypeTesterProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ClassComponentTypeTesterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ClassComponentTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentTypeTesterProps, and check that $ClassComponentTypeTesterProps is exported/imported properly.
        ClassComponentTypeTesterProps: $ClassComponentTypeTesterProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ClassComponentTypeTesterProps(
          accessMap, (map) => _$$ClassComponentTypeTesterProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ClassComponentTypeTesterProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ClassComponentTypeTesterProps$PlainMap
    extends _$$ClassComponentTypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ClassComponentTypeTesterProps$PlainMap(Map? backingMap)
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
class _$$ClassComponentTypeTesterProps$JsMap
    extends _$$ClassComponentTypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ClassComponentTypeTesterProps$JsMap(JsBackedMap? backingMap)
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
class _$ClassComponentTypeTesterComponent
    extends ClassComponentTypeTesterComponent {
  late _$$ClassComponentTypeTesterProps$JsMap _cachedTypedProps;

  @override
  _$$ClassComponentTypeTesterProps$JsMap get props => _cachedTypedProps;

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
  _$$ClassComponentTypeTesterProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ClassComponentTypeTesterProps$JsMap(backingMap);

  @override
  _$$ClassComponentTypeTesterProps typedPropsFactory(Map? backingMap) =>
      _$$ClassComponentTypeTesterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ClassComponentTypeTester';

  /// The default consumed props, comprising all props mixins used by ClassComponentTypeTesterProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ClassComponentTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentTypeTesterProps, and check that $ClassComponentTypeTesterProps is exported/imported properly.
        ClassComponentTypeTesterProps: $ClassComponentTypeTesterProps.meta,
      });
}

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
);

_$$ClassComponentProps _$ClassComponent([Map? backingProps]) =>
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
        // If this generated mixin is undefined, it's likely because ClassComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentProps, and check that $ClassComponentProps is exported/imported properly.
        $ClassComponentProps {
  _$$ClassComponentProps._();

  factory _$$ClassComponentProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ClassComponentProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ClassComponentProps(
          accessMap, (map) => _$$ClassComponentProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ClassComponentProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ClassComponentProps$PlainMap extends _$$ClassComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ClassComponentProps$PlainMap(Map? backingMap)
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
  _$$ClassComponentProps$JsMap(JsBackedMap? backingMap)
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
  late _$$ClassComponentProps$JsMap _cachedTypedProps;

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
  _$$ClassComponentProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ClassComponentProps$JsMap(backingMap);

  @override
  _$$ClassComponentProps typedPropsFactory(Map? backingMap) =>
      _$$ClassComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ClassComponent';

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
  Map? get dartMapProp =>
      (props[_$key__dartMapProp__ExpectsDartMapPropProps] ?? null) as Map?;
  @override
  set dartMapProp(Map? value) =>
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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
  void Function(DartTestJsWrapperProps props)? get onRender =>
      (props[_$key__onRender__DartTestJsWrapperPropsMixin] ?? null) as void
          Function(DartTestJsWrapperProps props)?;
  @override
  set onRender(void Function(DartTestJsWrapperProps props)? value) =>
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

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
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
  JsMap? get _$raw$buttonProps =>
      (props[_$key___$raw$buttonProps__TestJsProps] ?? null) as JsMap?;
  @override
  @Accessor(key: 'buttonProps')
  set _$raw$buttonProps(JsMap? value) =>
      props[_$key___$raw$buttonProps__TestJsProps] = value;
  @override
  @Accessor(key: 'listOfProps')
  List<dynamic>? get _$raw$listOfProps =>
      (props[_$key___$raw$listOfProps__TestJsProps] ?? null) as List<dynamic>?;
  @override
  @Accessor(key: 'listOfProps')
  set _$raw$listOfProps(List<dynamic>? value) =>
      props[_$key___$raw$listOfProps__TestJsProps] = value;
  @override
  @Accessor(key: 'inputRef')
  dynamic get _$raw$inputRef =>
      (props[_$key___$raw$inputRef__TestJsProps] ?? null) as dynamic;
  @override
  @Accessor(key: 'inputRef')
  set _$raw$inputRef(dynamic value) =>
      props[_$key___$raw$inputRef__TestJsProps] = value;
  @override
  @Accessor(key: 'messageContext')
  ReactContext? get _$raw$messageContext =>
      (props[_$key___$raw$messageContext__TestJsProps] ?? null)
          as ReactContext?;
  @override
  @Accessor(key: 'messageContext')
  set _$raw$messageContext(ReactContext? value) =>
      props[_$key___$raw$messageContext__TestJsProps] = value;
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
  @override
  dynamic get forwardRef =>
      (props[_$key__forwardRef__TestJsProps] ?? null) as dynamic;
  @override
  set forwardRef(dynamic value) =>
      props[_$key__forwardRef__TestJsProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop___$raw$buttonProps__TestJsProps =
      PropDescriptor(_$key___$raw$buttonProps__TestJsProps);
  static const PropDescriptor _$prop___$raw$listOfProps__TestJsProps =
      PropDescriptor(_$key___$raw$listOfProps__TestJsProps);
  static const PropDescriptor _$prop___$raw$inputRef__TestJsProps =
      PropDescriptor(_$key___$raw$inputRef__TestJsProps);
  static const PropDescriptor _$prop___$raw$messageContext__TestJsProps =
      PropDescriptor(_$key___$raw$messageContext__TestJsProps);
  static const PropDescriptor _$prop__component__TestJsProps =
      PropDescriptor(_$key__component__TestJsProps);
  static const PropDescriptor _$prop__inputComponent__TestJsProps =
      PropDescriptor(_$key__inputComponent__TestJsProps);
  static const PropDescriptor _$prop__buttonComponent__TestJsProps =
      PropDescriptor(_$key__buttonComponent__TestJsProps);
  static const PropDescriptor _$prop__forwardRef__TestJsProps =
      PropDescriptor(_$key__forwardRef__TestJsProps);
  static const String _$key___$raw$buttonProps__TestJsProps = 'buttonProps';
  static const String _$key___$raw$listOfProps__TestJsProps = 'listOfProps';
  static const String _$key___$raw$inputRef__TestJsProps = 'inputRef';
  static const String _$key___$raw$messageContext__TestJsProps =
      'messageContext';
  static const String _$key__component__TestJsProps = 'component';
  static const String _$key__inputComponent__TestJsProps = 'inputComponent';
  static const String _$key__buttonComponent__TestJsProps = 'buttonComponent';
  static const String _$key__forwardRef__TestJsProps = 'forwardRef';

  static const List<PropDescriptor> $props = [
    _$prop___$raw$buttonProps__TestJsProps,
    _$prop___$raw$listOfProps__TestJsProps,
    _$prop___$raw$inputRef__TestJsProps,
    _$prop___$raw$messageContext__TestJsProps,
    _$prop__component__TestJsProps,
    _$prop__inputComponent__TestJsProps,
    _$prop__buttonComponent__TestJsProps,
    _$prop__forwardRef__TestJsProps
  ];
  static const List<String> $propKeys = [
    _$key___$raw$buttonProps__TestJsProps,
    _$key___$raw$listOfProps__TestJsProps,
    _$key___$raw$inputRef__TestJsProps,
    _$key___$raw$messageContext__TestJsProps,
    _$key__component__TestJsProps,
    _$key__inputComponent__TestJsProps,
    _$key__buttonComponent__TestJsProps,
    _$key__forwardRef__TestJsProps
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestJsProps = PropsMeta(
  fields: $TestJsProps.$props,
  keys: $TestJsProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TypeTesterProps on TypeTesterProps {
  static const PropsMeta meta = _$metaForTypeTesterProps;
  @override
  Map get mapProp => (props[_$key__mapProp__TypeTesterProps] ?? null) as Map;
  @override
  set mapProp(Map value) => props[_$key__mapProp__TypeTesterProps] = value;
  @override
  Function get functionProp =>
      (props[_$key__functionProp__TypeTesterProps] ?? null) as Function;
  @override
  set functionProp(Function value) =>
      props[_$key__functionProp__TypeTesterProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__mapProp__TypeTesterProps = PropDescriptor(
      _$key__mapProp__TypeTesterProps,
      isRequired: true,
      isNullable: true,
      isLate: true);
  static const PropDescriptor _$prop__functionProp__TypeTesterProps =
      PropDescriptor(_$key__functionProp__TypeTesterProps,
          isRequired: true, isNullable: true, isLate: true);
  static const String _$key__mapProp__TypeTesterProps = 'mapProp';
  static const String _$key__functionProp__TypeTesterProps = 'functionProp';

  static const List<PropDescriptor> $props = [
    _$prop__mapProp__TypeTesterProps,
    _$prop__functionProp__TypeTesterProps
  ];
  static const List<String> $propKeys = [
    _$key__mapProp__TypeTesterProps,
    _$key__functionProp__TypeTesterProps
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('mapProp') &&
        !requiredPropNamesToSkipValidation.contains('mapProp')) {
      throw MissingRequiredPropsError('Required prop `mapProp` is missing.');
    }

    if (!props.containsKey('functionProp') &&
        !requiredPropNamesToSkipValidation.contains('functionProp')) {
      throw MissingRequiredPropsError(
          'Required prop `functionProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTypeTesterProps = PropsMeta(
  fields: $TypeTesterProps.$props,
  keys: $TypeTesterProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $JsTypeTesterProps on JsTypeTesterProps {
  static const PropsMeta meta = _$metaForJsTypeTesterProps;
  @override
  @Accessor(key: 'mapProp')
  JsMap? get _$raw$mapProp =>
      (props[_$key___$raw$mapProp__JsTypeTesterProps] ?? null) as JsMap?;
  @override
  @Accessor(key: 'mapProp')
  set _$raw$mapProp(JsMap? value) =>
      props[_$key___$raw$mapProp__JsTypeTesterProps] = value;
  @override
  Function get functionProp =>
      (props[_$key__functionProp__JsTypeTesterProps] ?? null) as Function;
  @override
  set functionProp(Function value) =>
      props[_$key__functionProp__JsTypeTesterProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop___$raw$mapProp__JsTypeTesterProps =
      PropDescriptor(_$key___$raw$mapProp__JsTypeTesterProps);
  static const PropDescriptor _$prop__functionProp__JsTypeTesterProps =
      PropDescriptor(_$key__functionProp__JsTypeTesterProps,
          isRequired: true, isNullable: true, isLate: true);
  static const String _$key___$raw$mapProp__JsTypeTesterProps = 'mapProp';
  static const String _$key__functionProp__JsTypeTesterProps = 'functionProp';

  static const List<PropDescriptor> $props = [
    _$prop___$raw$mapProp__JsTypeTesterProps,
    _$prop__functionProp__JsTypeTesterProps
  ];
  static const List<String> $propKeys = [
    _$key___$raw$mapProp__JsTypeTesterProps,
    _$key__functionProp__JsTypeTesterProps
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('functionProp') &&
        !requiredPropNamesToSkipValidation.contains('functionProp')) {
      throw MissingRequiredPropsError(
          'Required prop `functionProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForJsTypeTesterProps = PropsMeta(
  fields: $JsTypeTesterProps.$props,
  keys: $JsTypeTesterProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ClassComponentTypeTesterProps on ClassComponentTypeTesterProps {
  static const PropsMeta meta = _$metaForClassComponentTypeTesterProps;
  @override
  Map get mapProp =>
      (props[_$key__mapProp__ClassComponentTypeTesterProps] ?? null) as Map;
  @override
  set mapProp(Map value) =>
      props[_$key__mapProp__ClassComponentTypeTesterProps] = value;
  @override
  Function get functionProp =>
      (props[_$key__functionProp__ClassComponentTypeTesterProps] ?? null)
          as Function;
  @override
  set functionProp(Function value) =>
      props[_$key__functionProp__ClassComponentTypeTesterProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__mapProp__ClassComponentTypeTesterProps =
      PropDescriptor(_$key__mapProp__ClassComponentTypeTesterProps,
          isRequired: true, isNullable: true, isLate: true);
  static const PropDescriptor
      _$prop__functionProp__ClassComponentTypeTesterProps = PropDescriptor(
          _$key__functionProp__ClassComponentTypeTesterProps,
          isRequired: true,
          isNullable: true,
          isLate: true);
  static const String _$key__mapProp__ClassComponentTypeTesterProps = 'mapProp';
  static const String _$key__functionProp__ClassComponentTypeTesterProps =
      'functionProp';

  static const List<PropDescriptor> $props = [
    _$prop__mapProp__ClassComponentTypeTesterProps,
    _$prop__functionProp__ClassComponentTypeTesterProps
  ];
  static const List<String> $propKeys = [
    _$key__mapProp__ClassComponentTypeTesterProps,
    _$key__functionProp__ClassComponentTypeTesterProps
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('mapProp') &&
        !requiredPropNamesToSkipValidation.contains('mapProp')) {
      throw MissingRequiredPropsError('Required prop `mapProp` is missing.');
    }

    if (!props.containsKey('functionProp') &&
        !requiredPropNamesToSkipValidation.contains('functionProp')) {
      throw MissingRequiredPropsError(
          'Required prop `functionProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForClassComponentTypeTesterProps = PropsMeta(
  fields: $ClassComponentTypeTesterProps.$props,
  keys: $ClassComponentTypeTesterProps.$propKeys,
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
        // If this generated mixin is undefined, it's likely because ExpectsDartMapPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartMapPropProps, and check that $ExpectsDartMapPropProps is exported/imported properly.
        $ExpectsDartMapPropProps {
  _$$ExpectsDartMapPropProps._();

  factory _$$ExpectsDartMapPropProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsDartMapPropProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExpectsDartMapPropProps(
          accessMap, (map) => _$$ExpectsDartMapPropProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExpectsDartMapPropProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsDartMapPropProps$PlainMap extends _$$ExpectsDartMapPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartMapPropProps$PlainMap(Map? backingMap)
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
  _$$ExpectsDartMapPropProps$JsMap(JsBackedMap? backingMap)
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
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps {
  _$$TestJsProps._();

  factory _$$TestJsProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestJsProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestJsProps(accessMap, (map) => _$$TestJsProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestJsProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestJsProps$PlainMap extends _$$TestJsProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestJsProps$PlainMap(Map? backingMap)
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
  _$$TestJsProps$JsMap(JsBackedMap? backingMap)
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
        // If this generated mixin is undefined, it's likely because ExpectsDartStylePropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartStylePropProps, and check that $ExpectsDartStylePropProps is exported/imported properly.
        $ExpectsDartStylePropProps {
  _$$ExpectsDartStylePropProps._();

  factory _$$ExpectsDartStylePropProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsDartStylePropProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExpectsDartStylePropProps(
          accessMap, (map) => _$$ExpectsDartStylePropProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExpectsDartStylePropProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsDartStylePropProps$PlainMap
    extends _$$ExpectsDartStylePropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsDartStylePropProps$PlainMap(Map? backingMap)
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
  _$$ExpectsDartStylePropProps$JsMap(JsBackedMap? backingMap)
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
        // If this generated mixin is undefined, it's likely because ExpectsListChildrenPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsListChildrenPropProps, and check that $ExpectsListChildrenPropProps is exported/imported properly.
        $ExpectsListChildrenPropProps {
  _$$ExpectsListChildrenPropProps._();

  factory _$$ExpectsListChildrenPropProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExpectsListChildrenPropProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExpectsListChildrenPropProps(
          accessMap, (map) => _$$ExpectsListChildrenPropProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExpectsListChildrenPropProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExpectsListChildrenPropProps$PlainMap
    extends _$$ExpectsListChildrenPropProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExpectsListChildrenPropProps$PlainMap(Map? backingMap)
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
  _$$ExpectsListChildrenPropProps$JsMap(JsBackedMap? backingMap)
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
        // If this generated mixin is undefined, it's likely because BasicForwardRefProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicForwardRefProps, and check that $BasicForwardRefProps is exported/imported properly.
        $BasicForwardRefProps {
  _$$BasicForwardRefProps._();

  factory _$$BasicForwardRefProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicForwardRefProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$BasicForwardRefProps(
          accessMap, (map) => _$$BasicForwardRefProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$BasicForwardRefProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicForwardRefProps$PlainMap extends _$$BasicForwardRefProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicForwardRefProps$PlainMap(Map? backingMap)
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
  _$$BasicForwardRefProps$JsMap(JsBackedMap? backingMap)
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
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps,
        DartTestJsWrapperPropsMixin,
        // If this generated mixin is undefined, it's likely because DartTestJsWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DartTestJsWrapperPropsMixin, and check that $DartTestJsWrapperPropsMixin is exported/imported properly.
        $DartTestJsWrapperPropsMixin
    implements
        DartTestJsWrapperProps {
  _$$DartTestJsWrapperProps._();

  factory _$$DartTestJsWrapperProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DartTestJsWrapperProps$JsMap(backingMap as JsBackedMap?);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$DartTestJsWrapperProps(
          accessMap, (map) => _$$DartTestJsWrapperProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$DartTestJsWrapperProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$DartTestJsWrapperProps$PlainMap extends _$$DartTestJsWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DartTestJsWrapperProps$PlainMap(Map? backingMap)
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
  _$$DartTestJsWrapperProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestDartProps> _$TestDartConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestDartProps(map),
      jsMap: (map) => _$$TestDartProps$JsMap(map),
    ),
    displayName: 'TestDart');

@Deprecated(r'Use the private variable, _$TestDartConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestDartProps> $TestDartConfig = _$TestDartConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestDartProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps
    implements
        TestDartProps {
  _$$TestDartProps._();

  factory _$$TestDartProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestDartProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestDartProps$PlainMap(backingMap);
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestDartProps(accessMap, (map) => _$$TestDartProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestDartProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestDartProps$PlainMap extends _$$TestDartProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestDartProps$PlainMap(Map? backingMap)
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
class _$$TestDartProps$JsMap extends _$$TestDartProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestDartProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$JsTypeTesterProps> _$JsTypeTesterConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$JsTypeTesterProps(map),
          jsMap: (map) => _$$JsTypeTesterProps$JsMap(map),
        ),
        displayName: 'JsTypeTester');

@Deprecated(r'Use the private variable, _$JsTypeTesterConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$JsTypeTesterProps> $JsTypeTesterConfig =
    _$JsTypeTesterConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$JsTypeTesterProps extends UiProps
    with
        JsTypeTesterProps,
        // If this generated mixin is undefined, it's likely because JsTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of JsTypeTesterProps, and check that $JsTypeTesterProps is exported/imported properly.
        $JsTypeTesterProps {
  _$$JsTypeTesterProps._();

  factory _$$JsTypeTesterProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$JsTypeTesterProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$JsTypeTesterProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because JsTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of JsTypeTesterProps, and check that $JsTypeTesterProps is exported/imported properly.
        JsTypeTesterProps: $JsTypeTesterProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$JsTypeTesterProps(
          accessMap, (map) => _$$JsTypeTesterProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$JsTypeTesterProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$JsTypeTesterProps$PlainMap extends _$$JsTypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$JsTypeTesterProps$PlainMap(Map? backingMap)
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
class _$$JsTypeTesterProps$JsMap extends _$$JsTypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$JsTypeTesterProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TypeTesterProps> _$UiForwardRefTypeTesterConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TypeTesterProps(map),
          jsMap: (map) => _$$TypeTesterProps$JsMap(map),
        ),
        displayName: 'UiForwardRefTypeTester');

@Deprecated(
    r'Use the private variable, _$UiForwardRefTypeTesterConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TypeTesterProps> $UiForwardRefTypeTesterConfig =
    _$UiForwardRefTypeTesterConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TypeTesterProps extends UiProps
    with
        TypeTesterProps,
        // If this generated mixin is undefined, it's likely because TypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TypeTesterProps, and check that $TypeTesterProps is exported/imported properly.
        $TypeTesterProps {
  _$$TypeTesterProps._();

  factory _$$TypeTesterProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TypeTesterProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TypeTesterProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TypeTesterProps, and check that $TypeTesterProps is exported/imported properly.
        TypeTesterProps: $TypeTesterProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TypeTesterProps(
          accessMap, (map) => _$$TypeTesterProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TypeTesterProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TypeTesterProps$PlainMap extends _$$TypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypeTesterProps$PlainMap(Map? backingMap)
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
class _$$TypeTesterProps$JsMap extends _$$TypeTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypeTesterProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
