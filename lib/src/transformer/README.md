# `web_skin_dart` Transformer

[](#__START_EMBEDDED_README__)

Web Skin Dart components are declared using a set of [annotations] which are picked up by a Pub transformer.

This transformer generates code, wiring up the different pieces of component declarations and creating typed getters/setters for props and state.

This allows boilerplate to be significantly reduced, making the code you right much cleaner and more grokkable.

Comprehensive component declaration [examples] are available in the `examples/` directory.

## Wiring it all up
__Be sure to familiarize yourself with the [core component framework] first.__

The transformer wires up your factory, props class, and component class so that you don't have to!

Let's walk through the transformation process for a component.

First, let's declare a component.

```dart
@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps { ... }

@Component()
class FooComponent extends UiStatefulComponent<FooProps, FooState> {
  @override
  render() { ... }
}
```

Note that we've annotated our component pieces with `@Factory()`, `@Props()`, and `@Component()`. These are what the transformer uses as hooks to find your component.

Okay, so we've defined our component. Let's look at what the transformer does.

First, an implementation of the props class is generated, since the class we defined in our code inherits pseudo-abstract stubbed members and doesn't have the constructor we need.

```dart
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$FooPropsImpl extends FooProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$FooPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => _$FooComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FooProps.';
}
```

Next, a mixin that implements the pseudo-abstract stubbed members of our component class is generated and mixed in to our existing component class.

```dart
// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FooComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed prop keys, taken from FooProps.
  /// Used in [UiProps.consumedPropKeys] if [consumedPropKeys] is not overridden.
  @override
  final List<List<String>> $defaultConsumedPropKeys = const [FooProps.$propKeys];

  @override
  FooProps typedPropsFactory(Map backingMap) => new _$FooPropsImpl(backingMap);
}
```

```diff
@Component()
-class FooComponent extends UiStatefulComponent<FooProps, FooState> {
+class FooComponent extends UiStatefulComponent<FooProps, FooState> with _$FooComponentImplMixin {
```

Note that the `typedPropsFactory` variable is wired up to use the props implementation class's constructor. This lets us get an instance of that class when we use the `props` getter and the `newProps()` method, and is necessary since the code we wrote doesn't have a proper constructor.

Now that our component class is fully implemented, it's registered with the React Dart wrapper.

```dart
// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final _$FooComponentFactory = registerComponent(() => new FooComponent(),
    builderFactory: Foo,
    componentClass: FooComponent,
    isWrapper: false,
    displayName: 'Foo'
);
```

Finally, it initializes the factory variable with a function that returns a new instance of our private props implementation. This factory is the __the entrypoint__ to externally consuming our component and props class.

```diff
@Factory()
-UiFactory<FooProps> Foo;
+UiFactory<FooProps> Foo = ([Map backingProps]) => new _$FooPropsImpl(backingProps);
```


Again, this all goes on under the hood, but you can see it in action for your own components using the [transformer diff view](#debugging-with-the-diff-view).

## Props and state Getters/Setters

Writing a strongly-typed prop API for React components in Dart can be a pain if you do it from scratch.

The most straightforward way to adhere to React patterns is to use Maps for `props` and `state`. One way of accomplishing that is defining typed getters and setters on `MapView`-like classes which proxy Map key-value pairs.

Typing these getters/setters (especially if you namespace the keys), however, can be tedious:

```dart
class FooProps extends UiProps {
  String get title               => props['FooProps.title'];
  set title(String value)        => props['FooProps.title'] = value;

  bool get isEnabled             => props['FooProps.isEnabled'];
  set isEnabled(bool value)      => props['FooProps.isEnabled'] = value;

  MouseEventCallback get onClick => props['FooProps.onClick'];
  set onClick(Callback value)    => props['FooProps.onClick'] = value;

  // ...
}
```

With the transformer, you can cut down on that repetitive code. Props/state are declared using fields, leaving the actual code you write much simpler:

```dart
@Props()
class FooProps extends UiProps {
  String title;

  bool isEnabled;

  MouseEventCallback onClick;

  // ...
}
```

The same can be done for state:

```dart
@State()
class FooState extends UiState {
  bool isShown;

  String currentText;

  // ...
}
```

For more info, see the component declaration [examples].

## Debugging with the diff view
The `web_skin_dart` transformer provides a diff view for each transformed file, which you can use to see how exactly your source files are modified.

When in debug mode (`pub serve`, not `pub build`), this diff is accessible by appending `.diff.html` to the URL of your Dart file.

The easiest way to view it:

1. Open the Dartium developer tools.
2. In the "Source" tab, open the desired file (you can use `⌘P` to search).
3. Right-click in the file's text and select "Open Link in New Tab".
4. Append `.diff.html` to the url in the newly opened tab.



[core component framework]: /lib/src/ui_core/README.md
[annotations]: /lib/src/ui_core/component_declaration/annotations.dart
[examples]: /example/component_declaration/
