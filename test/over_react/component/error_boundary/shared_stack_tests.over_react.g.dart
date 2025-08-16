// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'shared_stack_tests.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ThrowingComponent2ComponentFactory = registerComponent2(
  () => _$ThrowingComponent2Component(),
  builderFactory: _$ThrowingComponent2,
  componentClass: ThrowingComponent2Component,
  isWrapper: false,
  parentType: null,
);

_$$ThrowingComponent2Props _$ThrowingComponent2([Map? backingProps]) =>
    _$$ThrowingComponent2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ThrowingComponent2Props extends UiProps
    with
        ThrowingComponent2Props,
        // If this generated mixin is undefined, it's likely because ThrowingComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingComponent2Props, and check that $ThrowingComponent2Props is exported/imported properly.
        $ThrowingComponent2Props {
  _$$ThrowingComponent2Props([Map? backingMap])
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
      super.componentFactory ?? $ThrowingComponent2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ThrowingComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingComponent2Props, and check that $ThrowingComponent2Props is exported/imported properly.
        ThrowingComponent2Props: $ThrowingComponent2Props.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ThrowingComponent2Props(
          accessMap, (map) => _$$ThrowingComponent2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ThrowingComponent2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ThrowingComponent2Component extends ThrowingComponent2Component {
  late _$$ThrowingComponent2Props _cachedTypedProps;

  @override
  _$$ThrowingComponent2Props get props => _cachedTypedProps;

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
  _$$ThrowingComponent2Props typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ThrowingComponent2Props(backingMap);

  @override
  _$$ThrowingComponent2Props typedPropsFactory(Map? backingMap) =>
      _$$ThrowingComponent2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ThrowingComponent2';

  /// The default consumed props, comprising all props mixins used by ThrowingComponent2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ThrowingComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingComponent2Props, and check that $ThrowingComponent2Props is exported/imported properly.
        ThrowingComponent2Props: $ThrowingComponent2Props.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ThrowingComponentComponentFactory = registerComponent(
  () => _$ThrowingComponentComponent(),
  builderFactory: _$ThrowingComponent,
  componentClass: ThrowingComponentComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$ThrowingComponentPropsAccessorsMixin
    implements _$ThrowingComponentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForThrowingComponentProps = PropsMeta(
  fields: _$ThrowingComponentPropsAccessorsMixin.$props,
  keys: _$ThrowingComponentPropsAccessorsMixin.$propKeys,
);

class ThrowingComponentProps extends _$ThrowingComponentProps
    with _$ThrowingComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForThrowingComponentProps;
}

_$$ThrowingComponentProps _$ThrowingComponent([Map? backingProps]) =>
    _$$ThrowingComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ThrowingComponentProps extends _$ThrowingComponentProps
    with _$ThrowingComponentPropsAccessorsMixin
    implements ThrowingComponentProps {
  _$$ThrowingComponentProps([Map? backingMap])
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
      super.componentFactory ?? $ThrowingComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ThrowingComponentProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ThrowingComponentProps(
          accessMap, (map) => _$$ThrowingComponentProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ThrowingComponentProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ThrowingComponentComponent extends ThrowingComponentComponent {
  @override
  _$$ThrowingComponentProps typedPropsFactory(Map? backingMap) =>
      _$$ThrowingComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ThrowingComponent';

  /// The default consumed props, taken from _$ThrowingComponentProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForThrowingComponentProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ThrowingComponent2Props on ThrowingComponent2Props {
  static const PropsMeta meta = _$metaForThrowingComponent2Props;
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
const PropsMeta _$metaForThrowingComponent2Props = PropsMeta(
  fields: $ThrowingComponent2Props.$props,
  keys: $ThrowingComponent2Props.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ThrowingFunctionComponentProps on ThrowingFunctionComponentProps {
  static const PropsMeta meta = _$metaForThrowingFunctionComponentProps;
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
const PropsMeta _$metaForThrowingFunctionComponentProps = PropsMeta(
  fields: $ThrowingFunctionComponentProps.$props,
  keys: $ThrowingFunctionComponentProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ThrowingForwardRefComponentProps on ThrowingForwardRefComponentProps {
  static const PropsMeta meta = _$metaForThrowingForwardRefComponentProps;
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
const PropsMeta _$metaForThrowingForwardRefComponentProps = PropsMeta(
  fields: $ThrowingForwardRefComponentProps.$props,
  keys: $ThrowingForwardRefComponentProps.$propKeys,
);

final UiFactoryConfig<_$$ThrowingFunctionComponentProps>
    _$ThrowingFunctionComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ThrowingFunctionComponentProps(map),
          jsMap: (map) => _$$ThrowingFunctionComponentProps(map),
        ),
        displayName: 'ThrowingFunctionComponent');

@Deprecated(
    r'Use the private variable, _$ThrowingFunctionComponentConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ThrowingFunctionComponentProps>
    $ThrowingFunctionComponentConfig = _$ThrowingFunctionComponentConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ThrowingFunctionComponentProps extends UiProps
    with
        ThrowingFunctionComponentProps,
        // If this generated mixin is undefined, it's likely because ThrowingFunctionComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingFunctionComponentProps, and check that $ThrowingFunctionComponentProps is exported/imported properly.
        $ThrowingFunctionComponentProps {
  _$$ThrowingFunctionComponentProps([Map? backingMap])
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
        // If this generated mixin is undefined, it's likely because ThrowingFunctionComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingFunctionComponentProps, and check that $ThrowingFunctionComponentProps is exported/imported properly.
        ThrowingFunctionComponentProps: $ThrowingFunctionComponentProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ThrowingFunctionComponentProps(
          accessMap, (map) => _$$ThrowingFunctionComponentProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ThrowingFunctionComponentProps = getPropKey;
final UiFactoryConfig<_$$ThrowingForwardRefComponentProps>
    _$ThrowingForwardRefComponentConfig = UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ThrowingForwardRefComponentProps(map),
          jsMap: (map) => _$$ThrowingForwardRefComponentProps(map),
        ),
        displayName: 'ThrowingForwardRefComponent');

@Deprecated(
    r'Use the private variable, _$ThrowingForwardRefComponentConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ThrowingForwardRefComponentProps>
    $ThrowingForwardRefComponentConfig = _$ThrowingForwardRefComponentConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ThrowingForwardRefComponentProps extends UiProps
    with
        ThrowingForwardRefComponentProps,
        // If this generated mixin is undefined, it's likely because ThrowingForwardRefComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingForwardRefComponentProps, and check that $ThrowingForwardRefComponentProps is exported/imported properly.
        $ThrowingForwardRefComponentProps {
  _$$ThrowingForwardRefComponentProps([Map? backingMap])
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
        // If this generated mixin is undefined, it's likely because ThrowingForwardRefComponentProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ThrowingForwardRefComponentProps, and check that $ThrowingForwardRefComponentProps is exported/imported properly.
        ThrowingForwardRefComponentProps:
            $ThrowingForwardRefComponentProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ThrowingForwardRefComponentProps(
          accessMap, (map) => _$$ThrowingForwardRefComponentProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ThrowingForwardRefComponentProps = getPropKey;
