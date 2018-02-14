part of 'foo.dart';

_$FooPropsImpl $Foo([Map backingProps]) => new _$FooPropsImpl(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$FooPropsImpl extends FooProps {
  @override
  String get fooProp => props[_$key__fooProp__FooProps];
  @override
  set fooProp(String value) => props[_$key__fooProp__FooProps] = value;

  /* GENERATED CONSTANTS */
  static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys);
  static const PropDescriptor _$prop__fooProp__FooProps = const PropDescriptor(_$key__fooProp__FooProps);
  static const List<PropDescriptor> $props = const [_$prop__fooProp__FooProps];
  static const String _$key__fooProp__FooProps = 'FooProps.fooProp';
  static const List<String> $propKeys = const [_$key__fooProp__FooProps];

  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$FooPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $FooComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FooProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}


// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FooComponentImpl extends FooComponent {
  @override
  _$FooPropsImpl typedPropsFactory(Map backingMap) => new _$FooPropsImpl(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from FooProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$FooPropsImpl.$consumedProps];
}


// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FooComponentFactory = registerComponent(() => new _$FooComponentImpl(),
    builderFactory: Foo,
    componentClass: FooComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Foo'
);
