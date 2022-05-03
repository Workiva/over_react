// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'element_type_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $CustomTestComponentFactory = registerComponent2(
  () => _$CustomTestComponent(),
  builderFactory: _$CustomTest,
  componentClass: CustomTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'CustomTest',
);

_$$CustomTestProps _$CustomTest([Map backingProps]) =>
    _$$CustomTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$CustomTestProps extends UiProps with CustomTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomTestProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CustomTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because CustomTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of CustomTestProps, and check that $CustomTestProps is exported/imported properly.
        CustomTestProps: $CustomTestProps.meta,
      });
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$CustomTestComponent extends CustomTestComponent {
  _$$CustomTestProps _cachedTypedProps;

  @override
  _$$CustomTestProps get props => _cachedTypedProps;

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
  _$$CustomTestProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$CustomTestProps(backingMap);

  @override
  _$$CustomTestProps typedPropsFactory(Map backingMap) =>
      _$$CustomTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by CustomTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because CustomTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of CustomTestProps, and check that $CustomTestProps is exported/imported properly.
        CustomTestProps: $CustomTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $CustomTestProps on CustomTestProps {
  static const PropsMeta meta = _$metaForCustomTestProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForCustomTestProps = PropsMeta(
  fields: $CustomTestProps.$props,
  keys: $CustomTestProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $CustomFnTestProps on CustomFnTestProps {
  static const PropsMeta meta = _$metaForCustomFnTestProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForCustomFnTestProps = PropsMeta(
  fields: $CustomFnTestProps.$props,
  keys: $CustomFnTestProps.$propKeys,
);

final UiFactoryConfig<_$$CustomFnTestProps> _$CustomFnTestConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$CustomFnTestProps(map),
          jsMap: (map) => _$$CustomFnTestProps(map),
        ),
        displayName: 'CustomFnTest');

@Deprecated(r'Use the private variable, _$CustomFnTestConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$CustomFnTestProps> $CustomFnTestConfig =
    _$CustomFnTestConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$CustomFnTestProps extends UiProps with CustomFnTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomFnTestProps(Map backingMap) : this.props = backingMap ?? ({});

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
        // If this generated mixin is undefined, it's likely because CustomFnTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of CustomFnTestProps, and check that $CustomFnTestProps is exported/imported properly.
        CustomFnTestProps: $CustomFnTestProps.meta,
      });
}
