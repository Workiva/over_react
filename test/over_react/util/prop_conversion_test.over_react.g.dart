// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
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
);

_$$ClassComponentProps _$ClassComponent([Map? backingProps]) =>
    _$$ClassComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ClassComponentProps extends UiProps
    with
        ClassComponentProps,
        // If this generated mixin is undefined, it's likely because ClassComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentProps, and check that $ClassComponentProps is exported/imported properly.
        $ClassComponentProps {
  _$$ClassComponentProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ClassComponentComponent extends ClassComponentComponent {
  late _$$ClassComponentProps _cachedTypedProps;

  @override
  _$$ClassComponentProps get props => _cachedTypedProps;

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
  _$$ClassComponentProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ClassComponentProps(backingMap);

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
  @convertJsMapProp
  Map? get buttonProps => unjsifyMapProp(
      (props[_$key__buttonProps__TestJsProps] ?? null) as JsMap?);
  @override
  @convertJsMapProp
  set buttonProps(Map? value) =>
      props[_$key__buttonProps__TestJsProps] = jsifyMapProp(value);
  @override
  @ConvertProp<List<dynamic>?, List<Map?>?>(
      jsifyMapListProp, unjsifyMapListProp)
  List<Map?>? get listOfProps => unjsifyMapListProp(
      (props[_$key__listOfProps__TestJsProps] ?? null) as List<dynamic>?);
  @override
  @ConvertProp<List<dynamic>?, List<Map?>?>(
      jsifyMapListProp, unjsifyMapListProp)
  set listOfProps(List<Map?>? value) =>
      props[_$key__listOfProps__TestJsProps] = jsifyMapListProp(value);
  @override
  @convertJsRefProp
  dynamic get inputRef =>
      unjsifyRefProp((props[_$key__inputRef__TestJsProps] ?? null) as dynamic);
  @override
  @convertJsRefProp
  set inputRef(dynamic value) =>
      props[_$key__inputRef__TestJsProps] = jsifyRefProp(value);
  @override
  @ConvertProp<ReactContext?, Context<String?>?>(
      jsifyContextProp, unjsifyContextProp)
  Context<String?>? get messageContext => unjsifyContextProp(
      (props[_$key__messageContext__TestJsProps] ?? null) as ReactContext?);
  @override
  @ConvertProp<ReactContext?, Context<String?>?>(
      jsifyContextProp, unjsifyContextProp)
  set messageContext(Context<String?>? value) =>
      props[_$key__messageContext__TestJsProps] = jsifyContextProp(value);
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
  static const PropDescriptor _$prop__buttonProps__TestJsProps =
      PropDescriptor(_$key__buttonProps__TestJsProps);
  static const PropDescriptor _$prop__listOfProps__TestJsProps =
      PropDescriptor(_$key__listOfProps__TestJsProps);
  static const PropDescriptor _$prop__inputRef__TestJsProps =
      PropDescriptor(_$key__inputRef__TestJsProps);
  static const PropDescriptor _$prop__messageContext__TestJsProps =
      PropDescriptor(_$key__messageContext__TestJsProps);
  static const PropDescriptor _$prop__component__TestJsProps =
      PropDescriptor(_$key__component__TestJsProps);
  static const PropDescriptor _$prop__inputComponent__TestJsProps =
      PropDescriptor(_$key__inputComponent__TestJsProps);
  static const PropDescriptor _$prop__buttonComponent__TestJsProps =
      PropDescriptor(_$key__buttonComponent__TestJsProps);
  static const String _$key__buttonProps__TestJsProps = 'buttonProps';
  static const String _$key__listOfProps__TestJsProps = 'listOfProps';
  static const String _$key__inputRef__TestJsProps = 'inputRef';
  static const String _$key__messageContext__TestJsProps = 'messageContext';
  static const String _$key__component__TestJsProps = 'component';
  static const String _$key__inputComponent__TestJsProps = 'inputComponent';
  static const String _$key__buttonComponent__TestJsProps = 'buttonComponent';

  static const List<PropDescriptor> $props = [
    _$prop__buttonProps__TestJsProps,
    _$prop__listOfProps__TestJsProps,
    _$prop__inputRef__TestJsProps,
    _$prop__messageContext__TestJsProps,
    _$prop__component__TestJsProps,
    _$prop__inputComponent__TestJsProps,
    _$prop__buttonComponent__TestJsProps
  ];
  static const List<String> $propKeys = [
    _$key__buttonProps__TestJsProps,
    _$key__listOfProps__TestJsProps,
    _$key__inputRef__TestJsProps,
    _$key__messageContext__TestJsProps,
    _$key__component__TestJsProps,
    _$key__inputComponent__TestJsProps,
    _$key__buttonComponent__TestJsProps
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

final UiFactoryConfig<_$$ExpectsDartMapPropProps> _$ExpectsDartMapPropConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsDartMapPropProps(map),
          jsMap: (map) => _$$ExpectsDartMapPropProps(map),
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
class _$$ExpectsDartMapPropProps extends UiProps
    with
        ExpectsDartMapPropProps,
        // If this generated mixin is undefined, it's likely because ExpectsDartMapPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartMapPropProps, and check that $ExpectsDartMapPropProps is exported/imported properly.
        $ExpectsDartMapPropProps {
  _$$ExpectsDartMapPropProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
final UiFactoryConfig<_$$ExpectsDartStylePropProps>
    _$ExpectsDartStylePropConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsDartStylePropProps(map),
          jsMap: (map) => _$$ExpectsDartStylePropProps(map),
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
class _$$ExpectsDartStylePropProps extends UiProps
    with
        ExpectsDartStylePropProps,
        // If this generated mixin is undefined, it's likely because ExpectsDartStylePropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsDartStylePropProps, and check that $ExpectsDartStylePropProps is exported/imported properly.
        $ExpectsDartStylePropProps {
  _$$ExpectsDartStylePropProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
final UiFactoryConfig<_$$ExpectsListChildrenPropProps>
    _$ExpectsListChildrenPropConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ExpectsListChildrenPropProps(map),
          jsMap: (map) => _$$ExpectsListChildrenPropProps(map),
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
class _$$ExpectsListChildrenPropProps extends UiProps
    with
        ExpectsListChildrenPropProps,
        // If this generated mixin is undefined, it's likely because ExpectsListChildrenPropProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExpectsListChildrenPropProps, and check that $ExpectsListChildrenPropProps is exported/imported properly.
        $ExpectsListChildrenPropProps {
  _$$ExpectsListChildrenPropProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
final UiFactoryConfig<_$$BasicForwardRefProps> _$BasicForwardRefConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$BasicForwardRefProps(map),
          jsMap: (map) => _$$BasicForwardRefProps(map),
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
class _$$BasicForwardRefProps extends UiProps
    with
        BasicForwardRefProps,
        // If this generated mixin is undefined, it's likely because BasicForwardRefProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicForwardRefProps, and check that $BasicForwardRefProps is exported/imported properly.
        $BasicForwardRefProps {
  _$$BasicForwardRefProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
final UiFactoryConfig<_$$DartTestJsWrapperProps> _$DartTestJsWrapperConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$DartTestJsWrapperProps(map),
          jsMap: (map) => _$$DartTestJsWrapperProps(map),
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
class _$$DartTestJsWrapperProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps,
        DartTestJsWrapperPropsMixin,
        // If this generated mixin is undefined, it's likely because DartTestJsWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DartTestJsWrapperPropsMixin, and check that $DartTestJsWrapperPropsMixin is exported/imported properly.
        $DartTestJsWrapperPropsMixin
    implements
        DartTestJsWrapperProps {
  _$$DartTestJsWrapperProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
final UiFactoryConfig<_$$TestJsProps> _$TestJsConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestJsProps(map),
      jsMap: (map) => _$$TestJsProps(map),
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
class _$$TestJsProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps {
  _$$TestJsProps([Map? backingMap]) : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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
