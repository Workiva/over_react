// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dom_util_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $DomTestComponentFactory = registerComponent(
    () => new _$DomTestComponent(),
    builderFactory: DomTest,
    componentClass: DomTestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'DomTest');

abstract class _$DomTestPropsAccessorsMixin implements _$DomTestProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForDomTestProps = const PropsMeta(
  fields: _$DomTestPropsAccessorsMixin.$props,
  keys: _$DomTestPropsAccessorsMixin.$propKeys,
);

class DomTestProps extends _$DomTestProps with _$DomTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForDomTestProps;
}

_$$DomTestProps _$DomTest([Map backingProps]) =>
    new _$$DomTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$DomTestProps extends _$DomTestProps
    with _$DomTestPropsAccessorsMixin
    implements DomTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$DomTestProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $DomTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'DomTestProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$DomTestComponent extends DomTestComponent {
  @override
  _$$DomTestProps typedPropsFactory(Map backingMap) =>
      new _$$DomTestProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$DomTestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForDomTestProps
  ];
}
