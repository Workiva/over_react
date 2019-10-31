// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'dummy_composite_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestCompositeComponentComponentFactory = registerComponent(
    () => _$TestCompositeComponentComponent(),
    builderFactory: TestCompositeComponent,
    componentClass: TestCompositeComponentComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestCompositeComponent');

abstract class _$TestCompositeComponentPropsAccessorsMixin
    implements _$TestCompositeComponentProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidMount] -->
  @override
  Function get onComponentDidMount =>
      props[_$key__onComponentDidMount___$TestCompositeComponentProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidMount] -->
  @override
  set onComponentDidMount(Function value) =>
      props[_$key__onComponentDidMount___$TestCompositeComponentProps] = value;

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentWillUnmount] -->
  @override
  Function get onComponentWillUnmount =>
      props[_$key__onComponentWillUnmount___$TestCompositeComponentProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentWillUnmount] -->
  @override
  set onComponentWillUnmount(Function value) =>
      props[_$key__onComponentWillUnmount___$TestCompositeComponentProps] =
          value;

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidUpdate] -->
  @override
  Function get onComponentDidUpdate =>
      props[_$key__onComponentDidUpdate___$TestCompositeComponentProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidUpdate] -->
  @override
  set onComponentDidUpdate(Function value) =>
      props[_$key__onComponentDidUpdate___$TestCompositeComponentProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidMount___$TestCompositeComponentProps =
      PropDescriptor(_$key__onComponentDidMount___$TestCompositeComponentProps);
  static const PropDescriptor
      _$prop__onComponentWillUnmount___$TestCompositeComponentProps =
      PropDescriptor(
          _$key__onComponentWillUnmount___$TestCompositeComponentProps);
  static const PropDescriptor
      _$prop__onComponentDidUpdate___$TestCompositeComponentProps =
      PropDescriptor(
          _$key__onComponentDidUpdate___$TestCompositeComponentProps);
  static const String
      _$key__onComponentDidMount___$TestCompositeComponentProps =
      'TestCompositeComponentProps.onComponentDidMount';
  static const String
      _$key__onComponentWillUnmount___$TestCompositeComponentProps =
      'TestCompositeComponentProps.onComponentWillUnmount';
  static const String
      _$key__onComponentDidUpdate___$TestCompositeComponentProps =
      'TestCompositeComponentProps.onComponentDidUpdate';

  static const List<PropDescriptor> $props = [
    _$prop__onComponentDidMount___$TestCompositeComponentProps,
    _$prop__onComponentWillUnmount___$TestCompositeComponentProps,
    _$prop__onComponentDidUpdate___$TestCompositeComponentProps
  ];
  static const List<String> $propKeys = [
    _$key__onComponentDidMount___$TestCompositeComponentProps,
    _$key__onComponentWillUnmount___$TestCompositeComponentProps,
    _$key__onComponentDidUpdate___$TestCompositeComponentProps
  ];
}

const PropsMeta _$metaForTestCompositeComponentProps = PropsMeta(
  fields: _$TestCompositeComponentPropsAccessorsMixin.$props,
  keys: _$TestCompositeComponentPropsAccessorsMixin.$propKeys,
);

class TestCompositeComponentProps extends _$TestCompositeComponentProps
    with _$TestCompositeComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestCompositeComponentProps;
}

_$$TestCompositeComponentProps _$TestCompositeComponent([Map backingProps]) =>
    _$$TestCompositeComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestCompositeComponentProps extends _$TestCompositeComponentProps
    with _$TestCompositeComponentPropsAccessorsMixin
    implements TestCompositeComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestCompositeComponentProps(Map backingMap) : this._props = {} {
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
      $TestCompositeComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestCompositeComponentProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestCompositeComponentComponent
    extends TestCompositeComponentComponent {
  @override
  _$$TestCompositeComponentProps typedPropsFactory(Map backingMap) =>
      _$$TestCompositeComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestCompositeComponentProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestCompositeComponentProps
  ];
}
