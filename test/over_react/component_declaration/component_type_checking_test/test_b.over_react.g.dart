// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_b.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestBComponentFactory = registerComponent(() => new _$TestBComponent(),
    builderFactory: TestB,
    componentClass: TestBComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestB');

abstract class _$TestBPropsAccessorsMixin implements _$TestBProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestBProps = const PropsMeta(
  fields: _$TestBPropsAccessorsMixin.$props,
  keys: _$TestBPropsAccessorsMixin.$propKeys,
);

class TestBProps extends _$TestBProps with _$TestBPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestBProps;
}

_$$TestBProps _$TestB([Map backingProps]) => new _$$TestBProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestBProps extends _$TestBProps
    with _$TestBPropsAccessorsMixin
    implements TestBProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestBProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  var _factoryOverride;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      _factoryOverride ?? $TestBComponentFactory;
  @override
  set componentFactory(ReactComponentFactoryProxy v) => _factoryOverride = v;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestBProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestBComponent extends TestBComponent {
  @override
  _$$TestBProps typedPropsFactory(Map backingMap) =>
      new _$$TestBProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestBProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestBProps];
}
