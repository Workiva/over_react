// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_a.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestAComponentFactory = registerComponent(() => new _$TestAComponent(),
    builderFactory: TestA,
    componentClass: TestAComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestA');

abstract class _$TestAPropsAccessorsMixin implements _$TestAProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestAProps = const PropsMeta(
  fields: _$TestAPropsAccessorsMixin.$props,
  keys: _$TestAPropsAccessorsMixin.$propKeys,
);

class TestAProps extends _$TestAProps with _$TestAPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestAProps;
}

_$$TestAProps _$TestA([Map backingProps]) => new _$$TestAProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestAProps extends _$TestAProps
    with _$TestAPropsAccessorsMixin
    implements TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestAProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  ReactComponentFactoryProxy _factoryOverride;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      _factoryOverride ?? $TestAComponentFactory;
  @override
  set componentFactory(ReactComponentFactoryProxy v) => _factoryOverride = v;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestAProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestAComponent extends TestAComponent {
  @override
  _$$TestAProps typedPropsFactory(Map backingMap) =>
      new _$$TestAProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestAProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestAProps];
}
