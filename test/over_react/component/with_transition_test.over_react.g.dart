// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'with_transition_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $WithTransitionTesterComponentFactory = registerComponent2(
  () => _$WithTransitionTesterComponent(),
  builderFactory: _$WithTransitionTester,
  componentClass: WithTransitionTesterComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'WithTransitionTester',
);

_$$WithTransitionTesterProps _$WithTransitionTester([Map backingProps]) =>
    backingProps == null
        ? _$$WithTransitionTesterProps$JsMap(JsBackedMap())
        : _$$WithTransitionTesterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$WithTransitionTesterProps extends UiProps
    with
        WithTransitionPropsMixin,
        $WithTransitionPropsMixin, // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
        TransitionPropsMixin,
        $TransitionPropsMixin // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
    implements
        WithTransitionTesterProps {
  _$$WithTransitionTesterProps._();

  factory _$$WithTransitionTesterProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$WithTransitionTesterProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$WithTransitionTesterProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $WithTransitionTesterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
        WithTransitionPropsMixin: $WithTransitionPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
        TransitionPropsMixin: $TransitionPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionTesterProps$PlainMap
    extends _$$WithTransitionTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionTesterProps$PlainMap(Map backingMap)
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
class _$$WithTransitionTesterProps$JsMap extends _$$WithTransitionTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionTesterProps$JsMap(JsBackedMap backingMap)
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
class _$WithTransitionTesterComponent extends WithTransitionTesterComponent {
  _$$WithTransitionTesterProps$JsMap _cachedTypedProps;

  @override
  _$$WithTransitionTesterProps$JsMap get props => _cachedTypedProps;

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
  _$$WithTransitionTesterProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$WithTransitionTesterProps$JsMap(backingMap);

  @override
  _$$WithTransitionTesterProps typedPropsFactory(Map backingMap) =>
      _$$WithTransitionTesterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by WithTransitionTesterProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
        WithTransitionPropsMixin: $WithTransitionPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
        TransitionPropsMixin: $TransitionPropsMixin.meta,
      });
}
