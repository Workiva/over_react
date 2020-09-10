// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'ref.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $FooComponentFactory = registerComponent2(
  () => _$FooComponent(),
  builderFactory: _$_Foo,
  componentClass: FooComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_Foo',
);

_$$FooProps _$_Foo([Map backingProps]) => backingProps == null
    ? _$$FooProps(JsBackedMap())
    : _$$FooProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FooProps extends UiProps
    with
        FooProps,
        $FooProps // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FooProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FooComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$FooComponent extends FooComponent {
  _$$FooProps _cachedTypedProps;

  @override
  _$$FooProps get props => _cachedTypedProps;

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
  _$$FooProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FooProps(backingMap);

  @override
  _$$FooProps typedPropsFactory(Map backingMap) => _$$FooProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by FooProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FooProps.
        FooProps: $FooProps.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $_LogComponentFactory = registerComponent2(
  () => _$_LogComponent(),
  builderFactory: _$_Log,
  componentClass: _LogComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_Log',
);

_$$LogProps _$_Log([Map backingProps]) => backingProps == null
    ? _$$LogProps(JsBackedMap())
    : _$$LogProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$LogProps extends UiProps
    with
        LogProps,
        $LogProps // If this generated mixin is undefined, it's likely because LogProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LogProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $_LogComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$_LogComponent extends _LogComponent {
  _$$LogProps _cachedTypedProps;

  @override
  _$$LogProps get props => _cachedTypedProps;

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
  _$$LogProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$LogProps(backingMap);

  @override
  _$$LogProps typedPropsFactory(Map backingMap) => _$$LogProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by LogProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because LogProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogProps.
        LogProps: $LogProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FancyButtonProps on FancyButtonProps {
  static const PropsMeta meta = _$metaForFancyButtonProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFancyButtonProps = PropsMeta(
  fields: $FancyButtonProps.$props,
  keys: $FancyButtonProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FooProps on FooProps {
  static const PropsMeta meta = _$metaForFooProps;
  @override
  dynamic get _inputRef =>
      props[_$key___inputRef__FooProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set _inputRef(dynamic value) => props[_$key___inputRef__FooProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop___inputRef__FooProps =
      PropDescriptor(_$key___inputRef__FooProps);
  static const String _$key___inputRef__FooProps = 'FooProps._inputRef';

  static const List<PropDescriptor> $props = [_$prop___inputRef__FooProps];
  static const List<String> $propKeys = [_$key___inputRef__FooProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFooProps = PropsMeta(
  fields: $FooProps.$props,
  keys: $FooProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $AnotherPropsMixin on AnotherPropsMixin {
  static const PropsMeta meta = _$metaForAnotherPropsMixin;
  @override
  String get anExampleAdditionalProp =>
      props[_$key__anExampleAdditionalProp__AnotherPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set anExampleAdditionalProp(String value) =>
      props[_$key__anExampleAdditionalProp__AnotherPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__anExampleAdditionalProp__AnotherPropsMixin =
      PropDescriptor(_$key__anExampleAdditionalProp__AnotherPropsMixin);
  static const String _$key__anExampleAdditionalProp__AnotherPropsMixin =
      'AnotherPropsMixin.anExampleAdditionalProp';

  static const List<PropDescriptor> $props = [
    _$prop__anExampleAdditionalProp__AnotherPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__anExampleAdditionalProp__AnotherPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForAnotherPropsMixin = PropsMeta(
  fields: $AnotherPropsMixin.$props,
  keys: $AnotherPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $LogProps on LogProps {
  static const PropsMeta meta = _$metaForLogProps;
  @override
  BuilderOnlyUiFactory<UiProps> get builder =>
      props[_$key__builder__LogProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set builder(BuilderOnlyUiFactory<UiProps> value) =>
      props[_$key__builder__LogProps] = value;
  @override
  dynamic get _forwardedRef =>
      props[_$key___forwardedRef__LogProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set _forwardedRef(dynamic value) =>
      props[_$key___forwardedRef__LogProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__builder__LogProps =
      PropDescriptor(_$key__builder__LogProps);
  static const PropDescriptor _$prop___forwardedRef__LogProps =
      PropDescriptor(_$key___forwardedRef__LogProps);
  static const String _$key__builder__LogProps = 'LogProps.builder';
  static const String _$key___forwardedRef__LogProps = 'LogProps._forwardedRef';

  static const List<PropDescriptor> $props = [
    _$prop__builder__LogProps,
    _$prop___forwardedRef__LogProps
  ];
  static const List<String> $propKeys = [
    _$key__builder__LogProps,
    _$key___forwardedRef__LogProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForLogProps = PropsMeta(
  fields: $LogProps.$props,
  keys: $LogProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BazProps on BazProps {
  static const PropsMeta meta = _$metaForBazProps;
  @override
  BuilderOnlyUiFactory<UiProps> get builder =>
      props[_$key__builder__BazProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set builder(BuilderOnlyUiFactory<UiProps> value) =>
      props[_$key__builder__BazProps] = value;
  @override
  dynamic get _forwardedRef =>
      props[_$key___forwardedRef__BazProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set _forwardedRef(dynamic value) =>
      props[_$key___forwardedRef__BazProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__builder__BazProps =
      PropDescriptor(_$key__builder__BazProps);
  static const PropDescriptor _$prop___forwardedRef__BazProps =
      PropDescriptor(_$key___forwardedRef__BazProps);
  static const String _$key__builder__BazProps = 'BazProps.builder';
  static const String _$key___forwardedRef__BazProps = 'BazProps._forwardedRef';

  static const List<PropDescriptor> $props = [
    _$prop__builder__BazProps,
    _$prop___forwardedRef__BazProps
  ];
  static const List<String> $propKeys = [
    _$key__builder__BazProps,
    _$key___forwardedRef__BazProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBazProps = PropsMeta(
  fields: $BazProps.$props,
  keys: $BazProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $RefDemoProps on RefDemoProps {
  static const PropsMeta meta = _$metaForRefDemoProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForRefDemoProps = PropsMeta(
  fields: $RefDemoProps.$props,
  keys: $RefDemoProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $RefDemoSectionProps on RefDemoSectionProps {
  static const PropsMeta meta = _$metaForRefDemoSectionProps;
  @override
  String get sectionTitle =>
      props[_$key__sectionTitle__RefDemoSectionProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set sectionTitle(String value) =>
      props[_$key__sectionTitle__RefDemoSectionProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__sectionTitle__RefDemoSectionProps =
      PropDescriptor(_$key__sectionTitle__RefDemoSectionProps);
  static const String _$key__sectionTitle__RefDemoSectionProps =
      'RefDemoSectionProps.sectionTitle';

  static const List<PropDescriptor> $props = [
    _$prop__sectionTitle__RefDemoSectionProps
  ];
  static const List<String> $propKeys = [
    _$key__sectionTitle__RefDemoSectionProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForRefDemoSectionProps = PropsMeta(
  fields: $RefDemoSectionProps.$props,
  keys: $RefDemoSectionProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $RefDemoHocProps on RefDemoHocProps {
  static const PropsMeta meta = _$metaForRefDemoHocProps;
  @override
  String get demoTitle =>
      props[_$key__demoTitle__RefDemoHocProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set demoTitle(String value) =>
      props[_$key__demoTitle__RefDemoHocProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__demoTitle__RefDemoHocProps =
      PropDescriptor(_$key__demoTitle__RefDemoHocProps);
  static const String _$key__demoTitle__RefDemoHocProps =
      'RefDemoHocProps.demoTitle';

  static const List<PropDescriptor> $props = [
    _$prop__demoTitle__RefDemoHocProps
  ];
  static const List<String> $propKeys = [_$key__demoTitle__RefDemoHocProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForRefDemoHocProps = PropsMeta(
  fields: $RefDemoHocProps.$props,
  keys: $RefDemoHocProps.$propKeys,
);

final UiFactoryConfig<_$$FancyButtonProps> $FancyButtonConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$FancyButtonProps(map),
      jsMap: (map) => _$$FancyButtonProps(map),
    ),
    displayName: 'FancyButton');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FancyButtonProps extends UiProps
    with
        FancyButtonProps,
        $FancyButtonProps // If this generated mixin is undefined, it's likely because FancyButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FancyButtonProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FancyButtonProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

final UiFactoryConfig<_$$Foo2Props> $Foo2Config = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$Foo2Props(map),
      jsMap: (map) => _$$Foo2Props(map),
    ),
    displayName: 'Foo2');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$Foo2Props extends UiProps
    with
        AnotherPropsMixin,
        $AnotherPropsMixin, // If this generated mixin is undefined, it's likely because AnotherPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of AnotherPropsMixin.
        FooProps,
        $FooProps // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FooProps.
    implements
        Foo2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Foo2Props(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

final UiFactoryConfig<_$$BazProps> $BazConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$BazProps(map),
      jsMap: (map) => _$$BazProps(map),
    ),
    displayName: 'Baz');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BazProps extends UiProps
    with
        BazProps,
        $BazProps // If this generated mixin is undefined, it's likely because BazProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BazProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BazProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

final UiFactoryConfig<_$$RefDemoProps> $RefDemoContainerConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$RefDemoProps(map),
          jsMap: (map) => _$$RefDemoProps(map),
        ),
        displayName: 'RefDemoContainer');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoProps extends UiProps
    with
        RefDemoProps,
        $RefDemoProps // If this generated mixin is undefined, it's likely because RefDemoProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

final UiFactoryConfig<_$$RefDemoSectionProps> $RefDemoSectionConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$RefDemoSectionProps(map),
          jsMap: (map) => _$$RefDemoSectionProps(map),
        ),
        displayName: 'RefDemoSection');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoSectionProps extends UiProps
    with
        RefDemoSectionProps,
        $RefDemoSectionProps // If this generated mixin is undefined, it's likely because RefDemoSectionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoSectionProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoSectionProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

final UiFactoryConfig<_$$RefDemoHocProps> $RefDemoHocConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$RefDemoHocProps(map),
      jsMap: (map) => _$$RefDemoHocProps(map),
    ),
    displayName: 'RefDemoHoc');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoHocProps extends UiProps
    with
        RefDemoHocProps,
        $RefDemoHocProps // If this generated mixin is undefined, it's likely because RefDemoHocProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoHocProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoHocProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}
