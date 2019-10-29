// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestComponentFactory = registerComponent(() => new _$TestComponent(),
    builderFactory: Test,
    componentClass: TestComponent,
    isWrapper: true,
    parentType: null,
    displayName: 'Test');

abstract class _$TestPropsAccessorsMixin implements _$TestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TestProps.onComponentDidMount] -->
  @override
  LifecycleCallback get onComponentDidMount =>
      props[_$key__onComponentDidMount___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onComponentDidMount] -->
  @override
  set onComponentDidMount(LifecycleCallback value) =>
      props[_$key__onComponentDidMount___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.onComponentWillUpdate] -->
  @override
  LifecycleCallback get onComponentWillUpdate =>
      props[_$key__onComponentWillUpdate___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onComponentWillUpdate] -->
  @override
  set onComponentWillUpdate(LifecycleCallback value) =>
      props[_$key__onComponentWillUpdate___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.onComponentWillReceiveProps] -->
  @override
  LifecycleCallback get onComponentWillReceiveProps =>
      props[_$key__onComponentWillReceiveProps___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onComponentWillReceiveProps] -->
  @override
  set onComponentWillReceiveProps(LifecycleCallback value) =>
      props[_$key__onComponentWillReceiveProps___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.onComponentDidUpdate] -->
  @override
  LifecycleCallback get onComponentDidUpdate =>
      props[_$key__onComponentDidUpdate___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onComponentDidUpdate] -->
  @override
  set onComponentDidUpdate(LifecycleCallback value) =>
      props[_$key__onComponentDidUpdate___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.onComponentWillUnmount] -->
  @override
  LifecycleCallback get onComponentWillUnmount =>
      props[_$key__onComponentWillUnmount___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onComponentWillUnmount] -->
  @override
  set onComponentWillUnmount(LifecycleCallback value) =>
      props[_$key__onComponentWillUnmount___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.onRender] -->
  @override
  LifecycleCallback get onRender =>
      props[_$key__onRender___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TestProps.onRender] -->
  @override
  set onRender(LifecycleCallback value) =>
      props[_$key__onRender___$TestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onComponentDidMount___$TestProps =
      const PropDescriptor(_$key__onComponentDidMount___$TestProps);
  static const PropDescriptor _$prop__onComponentWillUpdate___$TestProps =
      const PropDescriptor(_$key__onComponentWillUpdate___$TestProps);
  static const PropDescriptor _$prop__onComponentWillReceiveProps___$TestProps =
      const PropDescriptor(_$key__onComponentWillReceiveProps___$TestProps);
  static const PropDescriptor _$prop__onComponentDidUpdate___$TestProps =
      const PropDescriptor(_$key__onComponentDidUpdate___$TestProps);
  static const PropDescriptor _$prop__onComponentWillUnmount___$TestProps =
      const PropDescriptor(_$key__onComponentWillUnmount___$TestProps);
  static const PropDescriptor _$prop__onRender___$TestProps =
      const PropDescriptor(_$key__onRender___$TestProps);
  static const String _$key__onComponentDidMount___$TestProps =
      'TestProps.onComponentDidMount';
  static const String _$key__onComponentWillUpdate___$TestProps =
      'TestProps.onComponentWillUpdate';
  static const String _$key__onComponentWillReceiveProps___$TestProps =
      'TestProps.onComponentWillReceiveProps';
  static const String _$key__onComponentDidUpdate___$TestProps =
      'TestProps.onComponentDidUpdate';
  static const String _$key__onComponentWillUnmount___$TestProps =
      'TestProps.onComponentWillUnmount';
  static const String _$key__onRender___$TestProps = 'TestProps.onRender';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidMount___$TestProps,
    _$prop__onComponentWillUpdate___$TestProps,
    _$prop__onComponentWillReceiveProps___$TestProps,
    _$prop__onComponentDidUpdate___$TestProps,
    _$prop__onComponentWillUnmount___$TestProps,
    _$prop__onRender___$TestProps
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidMount___$TestProps,
    _$key__onComponentWillUpdate___$TestProps,
    _$key__onComponentWillReceiveProps___$TestProps,
    _$key__onComponentDidUpdate___$TestProps,
    _$key__onComponentWillUnmount___$TestProps,
    _$key__onRender___$TestProps
  ];
}

const PropsMeta _$metaForTestProps = const PropsMeta(
  fields: _$TestPropsAccessorsMixin.$props,
  keys: _$TestPropsAccessorsMixin.$propKeys,
);

class TestProps extends _$TestProps with _$TestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestProps;
}

_$$TestProps _$Test([Map backingProps]) => new _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestProps extends _$TestProps
    with _$TestPropsAccessorsMixin
    implements TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $TestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestComponent extends TestComponent {
  @override
  _$$TestProps typedPropsFactory(Map backingMap) =>
      new _$$TestProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestProps];
}
