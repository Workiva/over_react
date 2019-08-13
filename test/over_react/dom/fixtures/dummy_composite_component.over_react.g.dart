// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_composite_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestCompositeComponentComponentFactory = registerComponent(
    () => new _$TestCompositeComponentComponent(),
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
      props[_$key__onComponentDidMount___$TestCompositeComponentProps];

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidMount] -->
  @override
  set onComponentDidMount(Function value) =>
      props[_$key__onComponentDidMount___$TestCompositeComponentProps] = value;

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentWillUnmount] -->
  @override
  Function get onComponentWillUnmount =>
      props[_$key__onComponentWillUnmount___$TestCompositeComponentProps];

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentWillUnmount] -->
  @override
  set onComponentWillUnmount(Function value) =>
      props[_$key__onComponentWillUnmount___$TestCompositeComponentProps] =
          value;

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidUpdate] -->
  @override
  Function get onComponentDidUpdate =>
      props[_$key__onComponentDidUpdate___$TestCompositeComponentProps];

  /// <!-- Generated from [_$TestCompositeComponentProps.onComponentDidUpdate] -->
  @override
  set onComponentDidUpdate(Function value) =>
      props[_$key__onComponentDidUpdate___$TestCompositeComponentProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidMount___$TestCompositeComponentProps =
      const PropDescriptor(
          _$key__onComponentDidMount___$TestCompositeComponentProps);
  static const PropDescriptor
      _$prop__onComponentWillUnmount___$TestCompositeComponentProps =
      const PropDescriptor(
          _$key__onComponentWillUnmount___$TestCompositeComponentProps);
  static const PropDescriptor
      _$prop__onComponentDidUpdate___$TestCompositeComponentProps =
      const PropDescriptor(
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

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidMount___$TestCompositeComponentProps,
    _$prop__onComponentWillUnmount___$TestCompositeComponentProps,
    _$prop__onComponentDidUpdate___$TestCompositeComponentProps
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidMount___$TestCompositeComponentProps,
    _$key__onComponentWillUnmount___$TestCompositeComponentProps,
    _$key__onComponentDidUpdate___$TestCompositeComponentProps
  ];
}

const PropsMeta _$metaForTestCompositeComponentProps = const PropsMeta(
  fields: _$TestCompositeComponentPropsAccessorsMixin.$props,
  keys: _$TestCompositeComponentPropsAccessorsMixin.$propKeys,
);

class TestCompositeComponentProps extends _$TestCompositeComponentProps
    with _$TestCompositeComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestCompositeComponentProps;
}

_$$TestCompositeComponentProps _$TestCompositeComponent([Map backingProps]) =>
    new _$$TestCompositeComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestCompositeComponentProps extends _$TestCompositeComponentProps
    with _$TestCompositeComponentPropsAccessorsMixin
    implements TestCompositeComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestCompositeComponentProps(Map backingMap)
      : this.props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestCompositeComponentComponentFactory;

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
      new _$$TestCompositeComponentProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestCompositeComponentProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestCompositeComponentProps
  ];
}
