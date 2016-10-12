# Core Component Framework

web_skin_dart also provides a framework for building strongly-typed React components, on which all of web_skin_dart's reusable UI components are built.

* __[What makes a Web Skin Dart component](#what-makes-a-web-skin-dart-component)__

    * [`UiFactory`](#uifactory)
    * [`UiProps`](#uiprops)

        * [UiProps as a Map](#uiprops-as-a-map)
        * [UiProps as a builder](#uiprops-as-a-builder)

    * [`UiState`](#uistate)
    * [`UiComponent`](#uicomponent)

* __[`Dom.*` and `domProps()`](#dom-and-domprops)__
* __[Fluent-style component consumption](#fluent-style-component-consumption)__
* __[Building your own components](#building-your-own-components)__

    * __[Setting it up](#setting-it-up)__
    * __[Component Boilerplate](#boilerplate-templates)__

        * [Component](#boilerplate-component)
        * [Stateful Component](#boilerplate-stateful-component)
        * [Flux Component](#boilerplate-flux-component)

    * __[Common Pitfalls](#common-pitfalls)__


[](#__START_EMBEDDED_README__)


## What makes a Web Skin Dart component

* [`UiFactory`](#uifactory)
* [`UiProps`](#uiprops) (and sometimes [`UiState`](#uistate))
* [`UiComponent`](#uicomponent)

These pieces, annotated with component [annotations], work together with the `web_skin_dart` [transformer] to make it easy to define strongly-typed React components in Dart.

_Note: if you really need to use these base classes without the transformer, unstubbed versions are available by importing [component_base.dart] directly._

### `UiFactory`
A __function__ that returns a new instance of a component's `UiProps` class.

This factory is __the entrypoint__ to consuming each component.

The `UiProps` instance it returns can be used as a component builder (component fluent interface), or as a typed view into an existing props map.
(See examples of this in the [`UiProps`](#uiprops) section.)  

### `UiProps`
A __Map__ class for representing React props that adds __strongly-typed getters and setters__ for each prop.

Can also be invoked as a function, serving as a __builder__ for its associated component.

#### `UiProps` as a Map
```dart
FooProps props = Foo();
props.color = 'green';
print(props.color); // green
print(props);       // {FooProps.color: green}
```

```dart
Map existingMap = {'FooProps.color': 'blue'};
FooProps props = Foo(existingMap);
print(props.color); // blue
```

#### `UiProps` as a builder
```dart
// Create a UiProps instance to serve as a builder
FooProps builder = Foo();
// Add props
builder.id = 'the_best_foo';
builder.color = 'red';
// Invoke as a function with the desired children
// to return a new instance of the component.
return builder('child1', 'child2');

// Do it inline!
return (Foo()
  ..id = 'the_best_foo'
  ..color = 'red'
)('child1', 'child2')
```

See [Fluent-style component consumption](#fluent-style-component-consumption) for more examples on builder usage.

### `UiState`
A __Map__ class for representing React state that adds __strongly-typed getters and setters__ for each state property.

It's optional, and won't be used for every component.

### `UiComponent`
A subclass of `react.Component`, containing lifecycle methods and rendering logic for components.

Provides __strongly-typed props__ via `UiProps` , as well as utilities for prop forwarding and CSS class merging.

A variation of this, `UiStatefulComponent`, augments this behavior with __strongly-typed state__ via `UiState`.

Within the component class, `props` and `state` aren't just `Map`s, but instances of `UiProps` and `UiState`. That means you don't need String keys to access them!

```dart
render() {
  print(props.color);
  print(props.model);
  print(state.isActive);
}
```

`newProps()` and `newState()` are also exposed to conveniently create empty instances of `UiProps` and `UiState` as needed:
```dart
@override
getDefaultProps() => (newProps()
  ..isSelected = false
);

@override
getInitialState() => (newState()
  ..isExpanded = true
);

_toggleExpanded() => setState(newState()
  ..isExpanded = !state.isExpanded
);
```


## `Dom.*` and `domProps()`
All React DOM components (`react.div`, `react.a`, etc.) have a corresponding `Dom` method (`Dom.div()`, `Dom.a()`, etc.) that returns a new `DomProps` builder, which can be used to render DOM components via the [fluent interface](#fluent-style-component-consumption).

`DomProps` has getters/setters for all DOM attribute props available in React.

```dart
(Dom.a()
  ..id = 'home_link'
  ..href = '/home'
)('Home');

(Dom.div()
  ..className = 'resize-handle'
  ..onMouseDown = _startDrag
)();
```

The `domProps()` function is also available to create a new typed Map or a typed view into an existing Map. Useful for manipulating DOM props and adding DOM props to components that don't forward them directly.

## Fluent-style component consumption

In web_skin_dart, `UiProps` subclasses are used to consume components, and not the `ReactComponentFactory` functions directly.

Each Component expose `UiFactory` to create new `UiProps` instances, which aids in consumption.

Note how you might render the same DOM and components in JSX, react-dart, and web_skin_dart:

* JSX:

    ```jsx
    <div className="container">
      <h1>Click the button!</h1>
      <Button
        id="main_button"
        wsSize="small"
        onClick={_handleClick}
      >Click me</Button>
    </div>
    ```

* Vanilla react-dart:

    ```dart
    react.div({'className': 'container'}, [
      react.h1({}, 'Click the button!'),
      wsr.Button({
        'id': 'main_button',
        'wsSize': 'small',
        'onClick': _handleClick
      }, 'Click me');
    ]);
    ```

* web_skin_dart fluent interface:

    ```dart
    (Dom.div()..className = 'container')(
      Dom.h1()('Click the button!'),
      (Button()
        ..id = 'main_button'
        ..size = ButtonSize.SMALL
        ..onClick = _handleClick
      )('Click me')
    );
    ```

    Breakdown:

    ```dart
    // Create a builder for a <div>,
    // add a CSS class name by cascading a typed setter,
    // and invoke the builder with the <h1> and Button() children.
    (Dom.div()..className = 'container')(

      // Create a builder for an <h1> and invoke it with children.
      // No need for wrapping parens, since no props are added.
      Dom.h1()('Click the button!'),

      // Create a builder for a Web Skin Button,
      (Button()
        // add a ubiquitous DOM prop exposed on all components,
        // which Button() forwards to its rendered DOM,
        ..id = 'main_button'
        // add a Button-specific prop,
        ..size = ButtonSize.SMALL
        // add another prop,
        ..onClick = _handleClick
      // and finally invoke the builder with children.
      )('Click me')

    );
    ```

## Building your own components

### Setting it up
1. Add the `web_skin_dart` [transformer] to your `pubspec.yaml`.

    ```yaml
    transformers:
    - web_skin_dart
    ```

    This transformer uses code generation to wire up the different pieces of your component declarations and to create typed getters/setters for props and state.

2. When running tests on code that uses this transformer (or any code that imports `web_skin_dart`) you'll also need to __run your tests using Pub__.

    1. First, you'll need to add the `test/pub_serve` transformer to your `pubspec.yaml`.
Make sure to put it _after_ the `web_skin_dart` transformer.

        ```yaml
        transformers:
        - web_skin_dart
        - test/pub_serve:
            $include: test/**_test{.*,}.dart
        ```

    2. If you're using `dart_dev`, you can set the `pubServe` [configuration option](https://github.com/Workiva/dart_dev#project-configuration)
to `true` for the `test` and `coverage` tasks.

        If not, you can use the `--pub-serve` option in the `test` package (<https://github.com/dart-lang/test#testing-with-barback>).

### Boilerplate templates

1. Start with one of the component boilerplate templates below

2. Fill in props and rendering/lifecycle logic.

3. Consume your component with the fluent interface.

4. Run your app; that's it! Code will be automatically generated on the fly by Pub!


##### Boilerplate: Component
```dart
import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps {
  // Props go here, declared as fields:
  var color;
  Iterable<String> items;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  getDefaultProps() => (newProps()
    // Cascade default props here
  );

  render() {
    // Return the rendered component contents here.
    // The `props` variable is typed; no need for string keys!
  }
}
```
```dart
// Example consumption
(Foo()
  ..color = 'red'
  ..items = ['one', 'two']
)('I\'m a Foo!')
```

##### Boilerplate: Stateful Component
```dart    
import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<BarProps> Bar;

@Props()
class BarProps extends UiProps {
  // Props go here, declared as fields.
}

@State()
class BarState extends UiState {
  // State goes here, declared as fields:
  bool shown;
  int count;
}

@Component()
class BarComponent extends UiStatefulComponent<BarProps, BarState> {
  getDefaultProps() => (newProps()
    // Cascade default props here
  );

  getInitialState() => (newState()
    // Cascade initial state here
  );

  render() {
    // Return the rendered component contents here.
    // The `props` and `state` variables are typed; no need for string keys!
  }
}
```
```dart
// Example consumption
Bar()('I\'m a Bar!')
```

##### Boilerplate: Flux Component
```dart
import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<BazProps> Baz;

@Props()
class BazProps extends FluxUiProps<BazActions, BazStore> {
  // Props go here, declared as fields.
  // `actions` and `store` are already defined for you!
}

@Component()
class BazComponent extends FluxUiComponent<BazProps> {
  getDefaultProps() => (newProps()
    // Cascade default props here
  );

  render() {
    // Return the rendered component contents here.
    // The `props` variables is typed; no need for string keys!
    // E.g., `props.actions`, `props.store`.
  }
}
```
```dart
// Example consumption
var bazActions = new BazActions();
var bazStore = new BazStore(actions);
(Baz()
  ..actions = bazActions
  ..store = bazStore
)('I\'m a Baz!')
```

### Common Pitfalls
#### `null object does not have a method 'call'`

```
ⓧ Exception: The null object does not have a method 'call'.
```

If you call a `@Factory()` function that has not been initialized due to the transformer not running, you'll get this error.

__Make sure you've followed the [setup instructions](#setting-it-up).__

### 404 on `.dart` file

```
ⓧ GET http://localhost:8080/src/your_component.dart
ⓧ An error occurred loading file: http://localhost:8080/src/your_component.dart
```
When the transformer finds something wrong with your file, it logs an error in Pub and causes the invalid file to 404.

This ensures that when the transformer breaks, `pub build` will break, and you'll know about it.

__Check your `pub serve` output for errors.__



[examples]: /example/component_declaration/
[transformer]: /lib/src/transformer/README.md
[annotations]: /lib/src/ui_core/component_declaration/annotations.dart
[component_base.dart]: /lib/src/ui_core/component_declaration/component_base.dart
