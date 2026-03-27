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
    _$$TestDartClassProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestDartClassProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps,
        TestDartPropsMixin,
        // If this generated mixin is undefined, it's likely because TestDartPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestDartPropsMixin, and check that $TestDartPropsMixin is exported/imported properly.
        $TestDartPropsMixin
    implements
        TestDartClassProps {
  _$$TestDartClassProps([Map? backingMap])
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
      super.componentFactory ?? $TestDartClassComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        TestJsProps: $TestJsProps.meta,
        // If this generated mixin is undefined, it's likely because TestDartPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestDartPropsMixin, and check that $TestDartPropsMixin is exported/imported properly.
        TestDartPropsMixin: $TestDartPropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestDartClassProps(
          accessMap, (map) => _$$TestDartClassProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestDartClassProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$TestDartClassComponent extends TestDartClassComponent {
  late _$$TestDartClassProps _cachedTypedProps;

  @override
  _$$TestDartClassProps get props => _cachedTypedProps;

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
  _$$TestDartClassProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestDartClassProps(backingMap);

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
        // If this generated mixin is undefined, it's likely because TestDartPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestDartPropsMixin, and check that $TestDartPropsMixin is exported/imported properly.
        TestDartPropsMixin: $TestDartPropsMixin.meta,
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
    _$$ClassComponentTypeTesterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ClassComponentTypeTesterProps extends UiProps
    with
        ClassComponentTypeTesterProps,
        // If this generated mixin is undefined, it's likely because ClassComponentTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ClassComponentTypeTesterProps, and check that $ClassComponentTypeTesterProps is exported/imported properly.
        $ClassComponentTypeTesterProps {
  _$$ClassComponentTypeTesterProps([Map? backingMap])
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

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ClassComponentTypeTesterComponent
    extends ClassComponentTypeTesterComponent {
  late _$$ClassComponentTypeTesterProps _cachedTypedProps;

  @override
  _$$ClassComponentTypeTesterProps get props => _cachedTypedProps;

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
  _$$ClassComponentTypeTesterProps typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ClassComponentTypeTesterProps(backingMap);

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
mixin $TestDartPropsMixin on TestDartPropsMixin {
  static const PropsMeta meta = _$metaForTestDartPropsMixin;
  @override
  String? get stringProp =>
      (props[_$key__stringProp__TestDartPropsMixin] ?? null) as String?;
  @override
  set stringProp(String? value) =>
      props[_$key__stringProp__TestDartPropsMixin] = value;
  @override
  dynamic get forwardRef =>
      (props[_$key__forwardRef__TestDartPropsMixin] ?? null) as dynamic;
  @override
  set forwardRef(dynamic value) =>
      props[_$key__forwardRef__TestDartPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp__TestDartPropsMixin =
      PropDescriptor(_$key__stringProp__TestDartPropsMixin);
  static const PropDescriptor _$prop__forwardRef__TestDartPropsMixin =
      PropDescriptor(_$key__forwardRef__TestDartPropsMixin);
  static const String _$key__stringProp__TestDartPropsMixin = 'stringProp';
  static const String _$key__forwardRef__TestDartPropsMixin = 'forwardRef';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp__TestDartPropsMixin,
    _$prop__forwardRef__TestDartPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__stringProp__TestDartPropsMixin,
    _$key__forwardRef__TestDartPropsMixin
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestDartPropsMixin = PropsMeta(
  fields: $TestDartPropsMixin.$props,
  keys: $TestDartPropsMixin.$propKeys,
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
  String Function() get functionProp =>
      (props[_$key__functionProp__JsTypeTesterProps] ?? null) as String
          Function();
  @override
  set functionProp(String Function() value) =>
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
final UiFactoryConfig<_$$JsTypeTesterProps> _$JsTypeTesterConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$JsTypeTesterProps(map),
          jsMap: (map) => _$$JsTypeTesterProps(map),
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
class _$$JsTypeTesterProps extends UiProps
    with
        JsTypeTesterProps,
        // If this generated mixin is undefined, it's likely because JsTypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of JsTypeTesterProps, and check that $JsTypeTesterProps is exported/imported properly.
        $JsTypeTesterProps {
  _$$JsTypeTesterProps([Map? backingMap])
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
final UiFactoryConfig<_$$TestDartProps> _$TestDartConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestDartProps(map),
      jsMap: (map) => _$$TestDartProps(map),
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
class _$$TestDartProps extends UiProps
    with
        TestJsProps,
        // If this generated mixin is undefined, it's likely because TestJsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestJsProps, and check that $TestJsProps is exported/imported properly.
        $TestJsProps,
        TestDartPropsMixin,
        // If this generated mixin is undefined, it's likely because TestDartPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestDartPropsMixin, and check that $TestDartPropsMixin is exported/imported properly.
        $TestDartPropsMixin
    implements
        TestDartProps {
  _$$TestDartProps([Map? backingMap])
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
        // If this generated mixin is undefined, it's likely because TestDartPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestDartPropsMixin, and check that $TestDartPropsMixin is exported/imported properly.
        TestDartPropsMixin: $TestDartPropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestDartProps(accessMap, (map) => _$$TestDartProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestDartProps = getPropKey;
final UiFactoryConfig<_$$TypeTesterProps> _$UiForwardRefTypeTesterConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TypeTesterProps(map),
          jsMap: (map) => _$$TypeTesterProps(map),
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
class _$$TypeTesterProps extends UiProps
    with
        TypeTesterProps,
        // If this generated mixin is undefined, it's likely because TypeTesterProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TypeTesterProps, and check that $TypeTesterProps is exported/imported properly.
        $TypeTesterProps {
  _$$TypeTesterProps([Map? backingMap])
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
