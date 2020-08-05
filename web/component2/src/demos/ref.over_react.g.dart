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
final $LogPropsComponentFactory = registerComponent2(
  () => _$LogPropsComponent(),
  builderFactory: _$_LogProps,
  componentClass: LogPropsComponent,
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
      super.componentFactory ?? $LogPropsComponentFactory;

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
class _$LogPropsComponent extends LogPropsComponent {
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
mixin $UiForwardRefLogsFunctionComponentProps
    on UiForwardRefLogsFunctionComponentProps {
  static const PropsMeta meta = _$metaForUiForwardRefLogsFunctionComponentProps;
  @override
  BuilderOnlyUiFactory<DomProps> get builder =>
      props[_$key__builder__UiForwardRefLogsFunctionComponentProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set builder(BuilderOnlyUiFactory<DomProps> value) =>
      props[_$key__builder__UiForwardRefLogsFunctionComponentProps] = value;
  @override
  Ref<Element> get lastClickedButton =>
      props[_$key__lastClickedButton__UiForwardRefLogsFunctionComponentProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set lastClickedButton(Ref<Element> value) =>
      props[_$key__lastClickedButton__UiForwardRefLogsFunctionComponentProps] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__builder__UiForwardRefLogsFunctionComponentProps =
      PropDescriptor(_$key__builder__UiForwardRefLogsFunctionComponentProps);
  static const PropDescriptor
      _$prop__lastClickedButton__UiForwardRefLogsFunctionComponentProps =
      PropDescriptor(
          _$key__lastClickedButton__UiForwardRefLogsFunctionComponentProps);
  static const String _$key__builder__UiForwardRefLogsFunctionComponentProps =
      'UiForwardRefLogsFunctionComponentProps.builder';
  static const String
      _$key__lastClickedButton__UiForwardRefLogsFunctionComponentProps =
      'UiForwardRefLogsFunctionComponentProps.lastClickedButton';

  static const List<PropDescriptor> $props = [
    _$prop__builder__UiForwardRefLogsFunctionComponentProps,
    _$prop__lastClickedButton__UiForwardRefLogsFunctionComponentProps
  ];
  static const List<String> $propKeys = [
    _$key__builder__UiForwardRefLogsFunctionComponentProps,
    _$key__lastClickedButton__UiForwardRefLogsFunctionComponentProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUiForwardRefLogsFunctionComponentProps = PropsMeta(
  fields: $UiForwardRefLogsFunctionComponentProps.$props,
  keys: $UiForwardRefLogsFunctionComponentProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UiForwardRefLogsPropsComplexFunctionComponentPropsMixin
    on UiForwardRefLogsPropsComplexFunctionComponentPropsMixin {
  static const PropsMeta meta =
      _$metaForUiForwardRefLogsPropsComplexFunctionComponentPropsMixin;
  @override
  String get buttonDescription =>
      props[
          _$key__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set buttonDescription(String value) => props[
          _$key__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin =
      PropDescriptor(
          _$key__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin);
  static const String
      _$key__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin =
      'UiForwardRefLogsPropsComplexFunctionComponentPropsMixin.buttonDescription';

  static const List<PropDescriptor> $props = [
    _$prop__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__buttonDescription__UiForwardRefLogsPropsComplexFunctionComponentPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta
    _$metaForUiForwardRefLogsPropsComplexFunctionComponentPropsMixin =
    PropsMeta(
  fields: $UiForwardRefLogsPropsComplexFunctionComponentPropsMixin.$props,
  keys: $UiForwardRefLogsPropsComplexFunctionComponentPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UiForwardRefLogsPropsComplexComponentPropsMixin
    on UiForwardRefLogsPropsComplexComponentPropsMixin {
  static const PropsMeta meta =
      _$metaForUiForwardRefLogsPropsComplexComponentPropsMixin;
  @override
  String get buttonDescription =>
      props[
          _$key__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set buttonDescription(String value) => props[
          _$key__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin =
      PropDescriptor(
          _$key__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin);
  static const String
      _$key__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin =
      'UiForwardRefLogsPropsComplexComponentPropsMixin.buttonDescription';

  static const List<PropDescriptor> $props = [
    _$prop__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__buttonDescription__UiForwardRefLogsPropsComplexComponentPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUiForwardRefLogsPropsComplexComponentPropsMixin =
    PropsMeta(
  fields: $UiForwardRefLogsPropsComplexComponentPropsMixin.$props,
  keys: $UiForwardRefLogsPropsComplexComponentPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $LogPropsProps on LogPropsProps {
  static const PropsMeta meta = _$metaForLogPropsProps;
  @override
  BuilderOnlyUiFactory<DomProps> get builder =>
      props[_$key__builder__LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set builder(BuilderOnlyUiFactory<DomProps> value) =>
      props[_$key__builder__LogPropsProps] = value;
  @override
  Ref get lastClickedButton =>
      props[_$key__lastClickedButton__LogPropsProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set lastClickedButton(Ref value) =>
      props[_$key__lastClickedButton__LogPropsProps] = value;
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
  static const PropDescriptor _$prop__lastClickedButton__LogPropsProps =
      PropDescriptor(_$key__lastClickedButton__LogPropsProps);
  static const PropDescriptor _$prop___forwardedRef__LogPropsProps =
      PropDescriptor(_$key___forwardedRef__LogPropsProps);
  static const String _$key__builder__LogPropsProps = 'LogPropsProps.builder';
  static const String _$key__lastClickedButton__LogPropsProps =
      'LogPropsProps.lastClickedButton';
  static const String _$key___forwardedRef__LogPropsProps =
      'LogPropsProps._forwardedRef';

  static const List<PropDescriptor> $props = [
    _$prop__builder__LogPropsProps,
    _$prop__lastClickedButton__LogPropsProps,
    _$prop___forwardedRef__LogPropsProps
  ];
  static const List<String> $propKeys = [
    _$key__builder__LogPropsProps,
    _$key__lastClickedButton__LogPropsProps,
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

final UiFactoryConfig<_$$UiForwardRefLogsFunctionComponentProps>
    $UiForwardRefLogsFunctionComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UiForwardRefLogsFunctionComponentProps(map),
          jsMap: (map) => _$$UiForwardRefLogsFunctionComponentProps$JsMap(map),
        ),
        displayName: 'UiForwardRefLogsFunctionComponent');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UiForwardRefLogsFunctionComponentProps extends UiProps
    with
        UiForwardRefLogsFunctionComponentProps,
        $UiForwardRefLogsFunctionComponentProps // If this generated mixin is undefined, it's likely because UiForwardRefLogsFunctionComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UiForwardRefLogsFunctionComponentProps.
{
  _$$UiForwardRefLogsFunctionComponentProps._();

  factory _$$UiForwardRefLogsFunctionComponentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UiForwardRefLogsFunctionComponentProps$JsMap(backingMap);
    } else {
      return _$$UiForwardRefLogsFunctionComponentProps$PlainMap(backingMap);
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
class _$$UiForwardRefLogsFunctionComponentProps$PlainMap
    extends _$$UiForwardRefLogsFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsFunctionComponentProps$PlainMap(Map backingMap)
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
class _$$UiForwardRefLogsFunctionComponentProps$JsMap
    extends _$$UiForwardRefLogsFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsFunctionComponentProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$UiForwardRefLogsPropsComplexFunctionComponentProps>
    $UiForwardRefLogsPropsComplexFunctionComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) =>
              _$$UiForwardRefLogsPropsComplexFunctionComponentProps(map),
          jsMap: (map) =>
              _$$UiForwardRefLogsPropsComplexFunctionComponentProps$JsMap(map),
        ),
        displayName: 'UiForwardRefLogsPropsComplexFunctionComponent');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UiForwardRefLogsPropsComplexFunctionComponentProps
    extends UiProps
    with
        UiForwardRefLogsPropsComplexFunctionComponentPropsMixin,
        $UiForwardRefLogsPropsComplexFunctionComponentPropsMixin, // If this generated mixin is undefined, it's likely because UiForwardRefLogsPropsComplexFunctionComponentPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UiForwardRefLogsPropsComplexFunctionComponentPropsMixin.
        UiForwardRefLogsFunctionComponentProps,
        $UiForwardRefLogsFunctionComponentProps // If this generated mixin is undefined, it's likely because UiForwardRefLogsFunctionComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UiForwardRefLogsFunctionComponentProps.
    implements
        UiForwardRefLogsPropsComplexFunctionComponentProps {
  _$$UiForwardRefLogsPropsComplexFunctionComponentProps._();

  factory _$$UiForwardRefLogsPropsComplexFunctionComponentProps(
      Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UiForwardRefLogsPropsComplexFunctionComponentProps$JsMap(
          backingMap);
    } else {
      return _$$UiForwardRefLogsPropsComplexFunctionComponentProps$PlainMap(
          backingMap);
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
class _$$UiForwardRefLogsPropsComplexFunctionComponentProps$PlainMap
    extends _$$UiForwardRefLogsPropsComplexFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsPropsComplexFunctionComponentProps$PlainMap(Map backingMap)
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
class _$$UiForwardRefLogsPropsComplexFunctionComponentProps$JsMap
    extends _$$UiForwardRefLogsPropsComplexFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsPropsComplexFunctionComponentProps$JsMap(
      JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$UiForwardRefLogsPropsComplexComponentProps>
    $UiForwardRefLogsPropsComplexComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UiForwardRefLogsPropsComplexComponentProps(map),
          jsMap: (map) =>
              _$$UiForwardRefLogsPropsComplexComponentProps$JsMap(map),
        ),
        displayName: 'UiForwardRefLogsPropsComplexComponent');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UiForwardRefLogsPropsComplexComponentProps extends UiProps
    with
        UiForwardRefLogsPropsComplexComponentPropsMixin,
        $UiForwardRefLogsPropsComplexComponentPropsMixin, // If this generated mixin is undefined, it's likely because UiForwardRefLogsPropsComplexComponentPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UiForwardRefLogsPropsComplexComponentPropsMixin.
        LogPropsProps,
        $LogPropsProps // If this generated mixin is undefined, it's likely because LogPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogPropsProps.
    implements
        UiForwardRefLogsPropsComplexComponentProps {
  _$$UiForwardRefLogsPropsComplexComponentProps._();

  factory _$$UiForwardRefLogsPropsComplexComponentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UiForwardRefLogsPropsComplexComponentProps$JsMap(backingMap);
    } else {
      return _$$UiForwardRefLogsPropsComplexComponentProps$PlainMap(backingMap);
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
class _$$UiForwardRefLogsPropsComplexComponentProps$PlainMap
    extends _$$UiForwardRefLogsPropsComplexComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsPropsComplexComponentProps$PlainMap(Map backingMap)
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
class _$$UiForwardRefLogsPropsComplexComponentProps$JsMap
    extends _$$UiForwardRefLogsPropsComplexComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UiForwardRefLogsPropsComplexComponentProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$_LogsPropsFunctionComponentProps>
    $_LogsPropsFunctionComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$_LogsPropsFunctionComponentProps(map),
          jsMap: (map) => _$$_LogsPropsFunctionComponentProps$JsMap(map),
        ),
        displayName: '_LogsPropsFunctionComponent');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$_LogsPropsFunctionComponentProps extends UiProps
    with
        LogPropsProps,
        $LogPropsProps // If this generated mixin is undefined, it's likely because LogPropsProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LogPropsProps.
    implements
        _LogsPropsFunctionComponentProps {
  _$$_LogsPropsFunctionComponentProps._();

  factory _$$_LogsPropsFunctionComponentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$_LogsPropsFunctionComponentProps$JsMap(backingMap);
    } else {
      return _$$_LogsPropsFunctionComponentProps$PlainMap(backingMap);
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
class _$$_LogsPropsFunctionComponentProps$PlainMap
    extends _$$_LogsPropsFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_LogsPropsFunctionComponentProps$PlainMap(Map backingMap)
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
class _$$_LogsPropsFunctionComponentProps$JsMap
    extends _$$_LogsPropsFunctionComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_LogsPropsFunctionComponentProps$JsMap(JsBackedMap backingMap)
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
