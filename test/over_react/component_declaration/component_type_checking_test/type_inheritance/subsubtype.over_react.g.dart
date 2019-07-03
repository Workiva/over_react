// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subsubtype.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubsubtypeComponentFactory =
    registerComponent(() => new _$TestSubsubtypeComponent(),
        builderFactory: TestSubsubtype,
        componentClass: TestSubsubtypeComponent,
        isWrapper: false,
        parentType: $TestSubtypeComponentFactory,
        /* from `subtypeOf: TestSubtypeComponent` */
        displayName: 'TestSubsubtype');

abstract class _$TestSubsubtypePropsAccessorsMixin
    implements _$TestSubsubtypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestSubsubtypeProps = const PropsMeta(
  fields: _$TestSubsubtypePropsAccessorsMixin.$props,
  keys: _$TestSubsubtypePropsAccessorsMixin.$propKeys,
);

class TestSubsubtypeProps extends _$TestSubsubtypeProps
    with _$TestSubsubtypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubsubtypeProps;
}

_$$TestSubsubtypeProps _$TestSubsubtype([Map backingProps]) =>
    new _$$TestSubsubtypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubsubtypeProps extends _$TestSubsubtypeProps
    with _$TestSubsubtypePropsAccessorsMixin
    implements TestSubsubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestSubsubtypeProps(Map backingMap) : this._props = {} {
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
      _factoryOverride ?? $TestSubsubtypeComponentFactory;
  @override
  set componentFactory(ReactComponentFactoryProxy v) => _factoryOverride = v;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubsubtypeProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubsubtypeComponent extends TestSubsubtypeComponent {
  @override
  _$$TestSubsubtypeProps typedPropsFactory(Map backingMap) =>
      new _$$TestSubsubtypeProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubsubtypeProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubsubtypeProps
  ];
}
