// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'components.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $DoNotReferenceThisFactoryExceptForInASingleTestComponentnFactory =
    registerComponent2(
  () => _$DoNotReferenceThisFactoryExceptForInASingleTestComponentn(),
  builderFactory: _$DoNotReferenceThisFactoryExceptForInASingleTest,
  componentClass: DoNotReferenceThisFactoryExceptForInASingleTestComponentn,
  isWrapper: false,
  parentType: $TestAbstract2ComponentFactory,
  /* from `subtypeOf: TestAbstract2Component` */
  displayName: 'DoNotReferenceThisFactoryExceptForInASingleTest',
);

_$$DoNotReferenceThisFactoryExceptForInASingleTestProps
    _$DoNotReferenceThisFactoryExceptForInASingleTest([Map? backingProps]) =>
        backingProps == null
            ? _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap(
                JsBackedMap())
            : _$$DoNotReferenceThisFactoryExceptForInASingleTestProps(
                backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$DoNotReferenceThisFactoryExceptForInASingleTestProps
    extends UiProps
    with
        DoNotReferenceThisFactoryExceptForInASingleTestProps,
        $DoNotReferenceThisFactoryExceptForInASingleTestProps // If this generated mixin is undefined, it's likely because DoNotReferenceThisFactoryExceptForInASingleTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DoNotReferenceThisFactoryExceptForInASingleTestProps, and check that $DoNotReferenceThisFactoryExceptForInASingleTestProps is exported/imported properly.
{
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps._();

  factory _$$DoNotReferenceThisFactoryExceptForInASingleTestProps(
      Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$PlainMap(
          backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ??
      $DoNotReferenceThisFactoryExceptForInASingleTestComponentnFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because DoNotReferenceThisFactoryExceptForInASingleTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DoNotReferenceThisFactoryExceptForInASingleTestProps, and check that $DoNotReferenceThisFactoryExceptForInASingleTestProps is exported/imported properly.
        DoNotReferenceThisFactoryExceptForInASingleTestProps:
            $DoNotReferenceThisFactoryExceptForInASingleTestProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$PlainMap
    extends _$$DoNotReferenceThisFactoryExceptForInASingleTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$PlainMap(
      Map? backingMap)
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
class _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap
    extends _$$DoNotReferenceThisFactoryExceptForInASingleTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap(
      JsBackedMap? backingMap)
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
class _$DoNotReferenceThisFactoryExceptForInASingleTestComponentn
    extends DoNotReferenceThisFactoryExceptForInASingleTestComponentn {
  late _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap
      _cachedTypedProps;

  @override
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap get props =>
      _cachedTypedProps;

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
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap
      typedPropsFactoryJs(JsBackedMap? backingMap) =>
          _$$DoNotReferenceThisFactoryExceptForInASingleTestProps$JsMap(
              backingMap);

  @override
  _$$DoNotReferenceThisFactoryExceptForInASingleTestProps typedPropsFactory(
          Map? backingMap) =>
      _$$DoNotReferenceThisFactoryExceptForInASingleTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by DoNotReferenceThisFactoryExceptForInASingleTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because DoNotReferenceThisFactoryExceptForInASingleTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DoNotReferenceThisFactoryExceptForInASingleTestProps, and check that $DoNotReferenceThisFactoryExceptForInASingleTestProps is exported/imported properly.
        DoNotReferenceThisFactoryExceptForInASingleTestProps:
            $DoNotReferenceThisFactoryExceptForInASingleTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestAProps on TestAProps {
  static const PropsMeta meta = _$metaForTestAProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestAProps = PropsMeta(
  fields: $TestAProps.$props,
  keys: $TestAProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestBProps on TestBProps {
  static const PropsMeta meta = _$metaForTestBProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestBProps = PropsMeta(
  fields: $TestBProps.$props,
  keys: $TestBProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestParentProps on TestParentProps {
  static const PropsMeta meta = _$metaForTestParentProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestParentProps = PropsMeta(
  fields: $TestParentProps.$props,
  keys: $TestParentProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestSubtypeProps on TestSubtypeProps {
  static const PropsMeta meta = _$metaForTestSubtypeProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestSubtypeProps = PropsMeta(
  fields: $TestSubtypeProps.$props,
  keys: $TestSubtypeProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestSubsubtypeProps on TestSubsubtypeProps {
  static const PropsMeta meta = _$metaForTestSubsubtypeProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestSubsubtypeProps = PropsMeta(
  fields: $TestSubsubtypeProps.$props,
  keys: $TestSubsubtypeProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestExtendtypeProps on TestExtendtypeProps {
  static const PropsMeta meta = _$metaForTestExtendtypeProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestExtendtypeProps = PropsMeta(
  fields: $TestExtendtypeProps.$props,
  keys: $TestExtendtypeProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $OneLevelWrapperProps on OneLevelWrapperProps {
  static const PropsMeta meta = _$metaForOneLevelWrapperProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForOneLevelWrapperProps = PropsMeta(
  fields: $OneLevelWrapperProps.$props,
  keys: $OneLevelWrapperProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TwoLevelWrapperProps on TwoLevelWrapperProps {
  static const PropsMeta meta = _$metaForTwoLevelWrapperProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTwoLevelWrapperProps = PropsMeta(
  fields: $TwoLevelWrapperProps.$props,
  keys: $TwoLevelWrapperProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $DoNotReferenceThisFactoryExceptForInASingleTestProps
    on DoNotReferenceThisFactoryExceptForInASingleTestProps {
  static const PropsMeta meta =
      _$metaForDoNotReferenceThisFactoryExceptForInASingleTestProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForDoNotReferenceThisFactoryExceptForInASingleTestProps =
    PropsMeta(
  fields: $DoNotReferenceThisFactoryExceptForInASingleTestProps.$props,
  keys: $DoNotReferenceThisFactoryExceptForInASingleTestProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestUninitializedParentProps on TestUninitializedParentProps {
  static const PropsMeta meta = _$metaForTestUninitializedParentProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestUninitializedParentProps = PropsMeta(
  fields: $TestUninitializedParentProps.$props,
  keys: $TestUninitializedParentProps.$propKeys,
);

final UiFactoryConfig<_$$TestAProps> _$TestAConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestAProps(map),
      jsMap: (map) => _$$TestAProps$JsMap(map),
    ),
    displayName: 'TestA');

@Deprecated(r'Use the private variable, _$TestAConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestAProps> $TestAConfig = _$TestAConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestAProps extends UiProps
    with
        TestAProps,
        $TestAProps // If this generated mixin is undefined, it's likely because TestAProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestAProps, and check that $TestAProps is exported/imported properly.
{
  _$$TestAProps._();

  factory _$$TestAProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestAProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestAProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestAProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestAProps, and check that $TestAProps is exported/imported properly.
        TestAProps: $TestAProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestAProps$PlainMap extends _$$TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestAProps$PlainMap(Map? backingMap)
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
class _$$TestAProps$JsMap extends _$$TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestAProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestBProps> _$TestBConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestBProps(map),
      jsMap: (map) => _$$TestBProps$JsMap(map),
    ),
    displayName: 'TestB');

@Deprecated(r'Use the private variable, _$TestBConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestBProps> $TestBConfig = _$TestBConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestBProps extends UiProps
    with
        TestBProps,
        $TestBProps // If this generated mixin is undefined, it's likely because TestBProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestBProps, and check that $TestBProps is exported/imported properly.
{
  _$$TestBProps._();

  factory _$$TestBProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestBProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestBProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestBProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestBProps, and check that $TestBProps is exported/imported properly.
        TestBProps: $TestBProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestBProps$PlainMap extends _$$TestBProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestBProps$PlainMap(Map? backingMap)
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
class _$$TestBProps$JsMap extends _$$TestBProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestBProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestParentProps> _$TestParentConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$TestParentProps(map),
      jsMap: (map) => _$$TestParentProps$JsMap(map),
    ),
    displayName: 'TestParent');

@Deprecated(r'Use the private variable, _$TestParentConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestParentProps> $TestParentConfig =
    _$TestParentConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestParentProps extends UiProps
    with
        TestParentProps,
        $TestParentProps // If this generated mixin is undefined, it's likely because TestParentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestParentProps, and check that $TestParentProps is exported/imported properly.
{
  _$$TestParentProps._();

  factory _$$TestParentProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestParentProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestParentProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestParentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestParentProps, and check that $TestParentProps is exported/imported properly.
        TestParentProps: $TestParentProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestParentProps$PlainMap extends _$$TestParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestParentProps$PlainMap(Map? backingMap)
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
class _$$TestParentProps$JsMap extends _$$TestParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestParentProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestSubtypeProps> _$TestSubtypeConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestSubtypeProps(map),
          jsMap: (map) => _$$TestSubtypeProps$JsMap(map),
        ),
        displayName: 'TestSubtype');

@Deprecated(r'Use the private variable, _$TestSubtypeConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestSubtypeProps> $TestSubtypeConfig =
    _$TestSubtypeConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestSubtypeProps extends UiProps
    with
        TestSubtypeProps,
        $TestSubtypeProps // If this generated mixin is undefined, it's likely because TestSubtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSubtypeProps, and check that $TestSubtypeProps is exported/imported properly.
{
  _$$TestSubtypeProps._();

  factory _$$TestSubtypeProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestSubtypeProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestSubtypeProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestSubtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSubtypeProps, and check that $TestSubtypeProps is exported/imported properly.
        TestSubtypeProps: $TestSubtypeProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestSubtypeProps$PlainMap extends _$$TestSubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubtypeProps$PlainMap(Map? backingMap)
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
class _$$TestSubtypeProps$JsMap extends _$$TestSubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubtypeProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestSubsubtypeProps> _$TestSubsubtypeConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestSubsubtypeProps(map),
          jsMap: (map) => _$$TestSubsubtypeProps$JsMap(map),
        ),
        displayName: 'TestSubsubtype');

@Deprecated(r'Use the private variable, _$TestSubsubtypeConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestSubsubtypeProps> $TestSubsubtypeConfig =
    _$TestSubsubtypeConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestSubsubtypeProps extends UiProps
    with
        TestSubsubtypeProps,
        $TestSubsubtypeProps // If this generated mixin is undefined, it's likely because TestSubsubtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSubsubtypeProps, and check that $TestSubsubtypeProps is exported/imported properly.
{
  _$$TestSubsubtypeProps._();

  factory _$$TestSubsubtypeProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestSubsubtypeProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestSubsubtypeProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestSubsubtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSubsubtypeProps, and check that $TestSubsubtypeProps is exported/imported properly.
        TestSubsubtypeProps: $TestSubsubtypeProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestSubsubtypeProps$PlainMap extends _$$TestSubsubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtypeProps$PlainMap(Map? backingMap)
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
class _$$TestSubsubtypeProps$JsMap extends _$$TestSubsubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtypeProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestExtendtypeProps> _$TestExtendtypeConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestExtendtypeProps(map),
          jsMap: (map) => _$$TestExtendtypeProps$JsMap(map),
        ),
        displayName: 'TestExtendtype');

@Deprecated(r'Use the private variable, _$TestExtendtypeConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestExtendtypeProps> $TestExtendtypeConfig =
    _$TestExtendtypeConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestExtendtypeProps extends UiProps
    with
        TestExtendtypeProps,
        $TestExtendtypeProps // If this generated mixin is undefined, it's likely because TestExtendtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestExtendtypeProps, and check that $TestExtendtypeProps is exported/imported properly.
{
  _$$TestExtendtypeProps._();

  factory _$$TestExtendtypeProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestExtendtypeProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestExtendtypeProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestExtendtypeProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestExtendtypeProps, and check that $TestExtendtypeProps is exported/imported properly.
        TestExtendtypeProps: $TestExtendtypeProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestExtendtypeProps$PlainMap extends _$$TestExtendtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestExtendtypeProps$PlainMap(Map? backingMap)
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
class _$$TestExtendtypeProps$JsMap extends _$$TestExtendtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestExtendtypeProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$OneLevelWrapperProps> _$OneLevelWrapperConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$OneLevelWrapperProps(map),
          jsMap: (map) => _$$OneLevelWrapperProps$JsMap(map),
        ),
        displayName: 'OneLevelWrapper');

@Deprecated(r'Use the private variable, _$OneLevelWrapperConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$OneLevelWrapperProps> $OneLevelWrapperConfig =
    _$OneLevelWrapperConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$OneLevelWrapperProps extends UiProps
    with
        OneLevelWrapperProps,
        $OneLevelWrapperProps // If this generated mixin is undefined, it's likely because OneLevelWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OneLevelWrapperProps, and check that $OneLevelWrapperProps is exported/imported properly.
{
  _$$OneLevelWrapperProps._();

  factory _$$OneLevelWrapperProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$OneLevelWrapperProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$OneLevelWrapperProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because OneLevelWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OneLevelWrapperProps, and check that $OneLevelWrapperProps is exported/imported properly.
        OneLevelWrapperProps: $OneLevelWrapperProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$OneLevelWrapperProps$PlainMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapperProps$PlainMap(Map? backingMap)
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
class _$$OneLevelWrapperProps$JsMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapperProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TwoLevelWrapperProps> _$TwoLevelWrapperConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TwoLevelWrapperProps(map),
          jsMap: (map) => _$$TwoLevelWrapperProps$JsMap(map),
        ),
        displayName: 'TwoLevelWrapper');

@Deprecated(r'Use the private variable, _$TwoLevelWrapperConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TwoLevelWrapperProps> $TwoLevelWrapperConfig =
    _$TwoLevelWrapperConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TwoLevelWrapperProps extends UiProps
    with
        TwoLevelWrapperProps,
        $TwoLevelWrapperProps // If this generated mixin is undefined, it's likely because TwoLevelWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TwoLevelWrapperProps, and check that $TwoLevelWrapperProps is exported/imported properly.
{
  _$$TwoLevelWrapperProps._();

  factory _$$TwoLevelWrapperProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TwoLevelWrapperProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TwoLevelWrapperProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TwoLevelWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TwoLevelWrapperProps, and check that $TwoLevelWrapperProps is exported/imported properly.
        TwoLevelWrapperProps: $TwoLevelWrapperProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TwoLevelWrapperProps$PlainMap extends _$$TwoLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapperProps$PlainMap(Map? backingMap)
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
class _$$TwoLevelWrapperProps$JsMap extends _$$TwoLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapperProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestUninitializedParentProps>
    _$TestUninitializedParentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestUninitializedParentProps(map),
          jsMap: (map) => _$$TestUninitializedParentProps$JsMap(map),
        ),
        displayName: 'TestUninitializedParent');

@Deprecated(
    r'Use the private variable, _$TestUninitializedParentConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestUninitializedParentProps>
    $TestUninitializedParentConfig = _$TestUninitializedParentConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestUninitializedParentProps extends UiProps
    with
        TestUninitializedParentProps,
        $TestUninitializedParentProps // If this generated mixin is undefined, it's likely because TestUninitializedParentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestUninitializedParentProps, and check that $TestUninitializedParentProps is exported/imported properly.
{
  _$$TestUninitializedParentProps._();

  factory _$$TestUninitializedParentProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestUninitializedParentProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestUninitializedParentProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because TestUninitializedParentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestUninitializedParentProps, and check that $TestUninitializedParentProps is exported/imported properly.
        TestUninitializedParentProps: $TestUninitializedParentProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestUninitializedParentProps$PlainMap
    extends _$$TestUninitializedParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestUninitializedParentProps$PlainMap(Map? backingMap)
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
class _$$TestUninitializedParentProps$JsMap
    extends _$$TestUninitializedParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestUninitializedParentProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
