// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extendedtype.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestExtendtypeComponentFactory =
    registerComponent(() => new _$TestExtendtypeComponent(),
        builderFactory: TestExtendtype,
        componentClass: TestExtendtypeComponent,
        isWrapper: false,
        parentType: $TestAbstractComponentFactory,
        /* from `subtypeOf: TestAbstractComponent` */
        displayName: 'TestExtendtype');

abstract class _$TestExtendtypePropsAccessorsMixin
    implements _$TestExtendtypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestExtendtypeProps = const PropsMeta(
  fields: _$TestExtendtypePropsAccessorsMixin.$props,
  keys: _$TestExtendtypePropsAccessorsMixin.$propKeys,
);

class TestExtendtypeProps extends _$TestExtendtypeProps
    with _$TestExtendtypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestExtendtypeProps;
}

_$$TestExtendtypeProps _$TestExtendtype([Map backingProps]) =>
    new _$$TestExtendtypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestExtendtypeProps extends _$TestExtendtypeProps
    with _$TestExtendtypePropsAccessorsMixin
    implements TestExtendtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestExtendtypeProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory =>
      $TestExtendtypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestExtendtypeProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestExtendtypeComponent extends TestExtendtypeComponent {
  @override
  _$$TestExtendtypeProps typedPropsFactory(Map backingMap) =>
      new _$$TestExtendtypeProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestExtendtypeProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestExtendtypeProps
  ];
}
