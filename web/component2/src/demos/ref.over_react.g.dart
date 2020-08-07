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
    ? _$$FooProps$JsMap(JsBackedMap())
    : _$$FooProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$FooProps extends UiProps
    with
        FooProps,
        $FooProps // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FooProps.
{
  _$$FooProps._();

  factory _$$FooProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FooProps$JsMap(backingMap);
    } else {
      return _$$FooProps$PlainMap(backingMap);
    }
  }

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

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FooProps$PlainMap extends _$$FooProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps$PlainMap(Map backingMap)
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
class _$$FooProps$JsMap extends _$$FooProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps$JsMap(JsBackedMap backingMap)
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
class _$FooComponent extends FooComponent {
  _$$FooProps$JsMap _cachedTypedProps;

  @override
  _$$FooProps$JsMap get props => _cachedTypedProps;

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
  _$$FooProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FooProps$JsMap(backingMap);

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
final $_LogPropsComponentFactory = registerComponent2(
  () => _$_LogPropsComponent(),
  builderFactory: _$_LogProps,
  componentClass: _LogPropsComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_LogProps',
);

_$$LogPropsProps _$_LogProps([Map backingProps]) => backingProps == null
    ? _$$LogPropsProps$JsMap(JsBackedMap())
    : _$$LogPropsProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$LogPropsProps extends UiProps
    with
        LogPropsProps,
        $LogPropsProps // If this generated mixin is undefined, it's likely because LogPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogPropsProps.
{
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
      super.componentFactory ?? $_LogPropsComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$_LogPropsComponent extends _LogPropsComponent {
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

  /// The default consumed props, comprising all props mixins used by LogPropsProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because LogPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogPropsProps.
        LogPropsProps: $LogPropsProps.meta,
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
mixin $LogPropsProps on LogPropsProps {
  static const PropsMeta meta = _$metaForLogPropsProps;
  @override
  BuilderOnlyUiFactory<UiProps> get builder =>
      props[_$key__builder__LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set builder(BuilderOnlyUiFactory<UiProps> value) =>
      props[_$key__builder__LogPropsProps] = value;
  @override
  Ref get _forwardedRef =>
      props[_$key___forwardedRef__LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set _forwardedRef(Ref value) =>
      props[_$key___forwardedRef__LogPropsProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__builder__LogPropsProps =
      PropDescriptor(_$key__builder__LogPropsProps);
  static const PropDescriptor _$prop___forwardedRef__LogPropsProps =
      PropDescriptor(_$key___forwardedRef__LogPropsProps);
  static const String _$key__builder__LogPropsProps = 'LogPropsProps.builder';
  static const String _$key___forwardedRef__LogPropsProps =
      'LogPropsProps._forwardedRef';

  static const List<PropDescriptor> $props = [
    _$prop__builder__LogPropsProps,
    _$prop___forwardedRef__LogPropsProps
  ];
  static const List<String> $propKeys = [
    _$key__builder__LogPropsProps,
    _$key___forwardedRef__LogPropsProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForLogPropsProps = PropsMeta(
  fields: $LogPropsProps.$props,
  keys: $LogPropsProps.$propKeys,
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
  Ref get _forwardedRef =>
      props[_$key___forwardedRef__BazProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set _forwardedRef(Ref value) => props[_$key___forwardedRef__BazProps] = value;
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
      jsMap: (map) => _$$FancyButtonProps$JsMap(map),
    ),
    displayName: 'FancyButton');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$FancyButtonProps extends UiProps
    with
        FancyButtonProps,
        $FancyButtonProps // If this generated mixin is undefined, it's likely because FancyButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FancyButtonProps.
{
  _$$FancyButtonProps._();

  factory _$$FancyButtonProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FancyButtonProps$JsMap(backingMap);
    } else {
      return _$$FancyButtonProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FancyButtonProps$PlainMap extends _$$FancyButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FancyButtonProps$PlainMap(Map backingMap)
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
class _$$FancyButtonProps$JsMap extends _$$FancyButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FancyButtonProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$Foo2Props> $Foo2Config = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$Foo2Props(map),
      jsMap: (map) => _$$Foo2Props$JsMap(map),
    ),
    displayName: 'Foo2');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$Foo2Props extends UiProps
    with
        AnotherPropsMixin,
        $AnotherPropsMixin, // If this generated mixin is undefined, it's likely because AnotherPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of AnotherPropsMixin.
        FooProps,
        $FooProps // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FooProps.
    implements
        Foo2Props {
  _$$Foo2Props._();

  factory _$$Foo2Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$Foo2Props$JsMap(backingMap);
    } else {
      return _$$Foo2Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$Foo2Props$PlainMap extends _$$Foo2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Foo2Props$PlainMap(Map backingMap)
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
class _$$Foo2Props$JsMap extends _$$Foo2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Foo2Props$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$BazProps> $BazConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$BazProps(map),
      jsMap: (map) => _$$BazProps$JsMap(map),
    ),
    displayName: 'Baz');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BazProps extends UiProps
    with
        BazProps,
        $BazProps // If this generated mixin is undefined, it's likely because BazProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BazProps.
{
  _$$BazProps._();

  factory _$$BazProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BazProps$JsMap(backingMap);
    } else {
      return _$$BazProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BazProps$PlainMap extends _$$BazProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BazProps$PlainMap(Map backingMap)
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
class _$$BazProps$JsMap extends _$$BazProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BazProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$RefDemoProps> $RefDemoContainerConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$RefDemoProps(map),
          jsMap: (map) => _$$RefDemoProps$JsMap(map),
        ),
        displayName: 'RefDemoContainer');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$RefDemoProps extends UiProps
    with
        RefDemoProps,
        $RefDemoProps // If this generated mixin is undefined, it's likely because RefDemoProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoProps.
{
  _$$RefDemoProps._();

  factory _$$RefDemoProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RefDemoProps$JsMap(backingMap);
    } else {
      return _$$RefDemoProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoProps$PlainMap extends _$$RefDemoProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoProps$PlainMap(Map backingMap)
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
class _$$RefDemoProps$JsMap extends _$$RefDemoProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$RefDemoSectionProps> $RefDemoSectionConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$RefDemoSectionProps(map),
          jsMap: (map) => _$$RefDemoSectionProps$JsMap(map),
        ),
        displayName: 'RefDemoSection');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$RefDemoSectionProps extends UiProps
    with
        RefDemoSectionProps,
        $RefDemoSectionProps // If this generated mixin is undefined, it's likely because RefDemoSectionProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoSectionProps.
{
  _$$RefDemoSectionProps._();

  factory _$$RefDemoSectionProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RefDemoSectionProps$JsMap(backingMap);
    } else {
      return _$$RefDemoSectionProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoSectionProps$PlainMap extends _$$RefDemoSectionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoSectionProps$PlainMap(Map backingMap)
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
class _$$RefDemoSectionProps$JsMap extends _$$RefDemoSectionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoSectionProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$RefDemoHocProps> $RefDemoHocConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$RefDemoHocProps(map),
      jsMap: (map) => _$$RefDemoHocProps$JsMap(map),
    ),
    displayName: 'RefDemoHoc');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$RefDemoHocProps extends UiProps
    with
        RefDemoHocProps,
        $RefDemoHocProps // If this generated mixin is undefined, it's likely because RefDemoHocProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RefDemoHocProps.
{
  _$$RefDemoHocProps._();

  factory _$$RefDemoHocProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RefDemoHocProps$JsMap(backingMap);
    } else {
      return _$$RefDemoHocProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RefDemoHocProps$PlainMap extends _$$RefDemoHocProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoHocProps$PlainMap(Map backingMap)
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
class _$$RefDemoHocProps$JsMap extends _$$RefDemoHocProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RefDemoHocProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
