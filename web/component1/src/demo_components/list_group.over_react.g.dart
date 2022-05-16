// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'list_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupComponentFactory = registerComponent(
  () => _$ListGroupComponent(),
  builderFactory: _$ListGroup,
  componentClass: ListGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ListGroup',
);

abstract class _$ListGroupPropsAccessorsMixin implements _$ListGroupProps {
  @override
  Map get props;

  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ///
  /// <!-- Generated from [_$ListGroupProps.elementType] -->
  @override
  ListGroupElementType get elementType =>
      (props[_$key__elementType___$ListGroupProps] ?? null)
          as ListGroupElementType;

  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ///
  /// <!-- Generated from [_$ListGroupProps.elementType] -->
  @override
  set elementType(ListGroupElementType value) =>
      props[_$key__elementType___$ListGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__elementType___$ListGroupProps =
      PropDescriptor(_$key__elementType___$ListGroupProps);
  static const String _$key__elementType___$ListGroupProps =
      'ListGroupProps.elementType';

  static const List<PropDescriptor> $props = [
    _$prop__elementType___$ListGroupProps
  ];
  static const List<String> $propKeys = [_$key__elementType___$ListGroupProps];
}

const PropsMeta _$metaForListGroupProps = PropsMeta(
  fields: _$ListGroupPropsAccessorsMixin.$props,
  keys: _$ListGroupPropsAccessorsMixin.$propKeys,
);

class ListGroupProps extends _$ListGroupProps
    with _$ListGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForListGroupProps;
}

_$$ListGroupProps _$ListGroup([Map backingProps]) =>
    _$$ListGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ListGroupProps extends _$ListGroupProps
    with _$ListGroupPropsAccessorsMixin
    implements ListGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ListGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ListGroupProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ListGroupComponent extends ListGroupComponent {
  @override
  _$$ListGroupProps typedPropsFactory(Map backingMap) =>
      _$$ListGroupProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ListGroupProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForListGroupProps
  ];
}
