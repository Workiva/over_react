# The `ui_core` library

w_ui_platform also provides a framework for building strongly-typed React components, on which all of w_ui_platform's reusable UI components are built.

Core framework is available in `ui_core.dart`. You can include it in your own project with the following line:
```dart
import 'package:w_ui_platform/ui_core.dart';
```

* __[`ComponentDefinition`](#componentdefinition)__
  * [As a props map](#as-a-props-map)
  * [As a builder](#as-a-builder)
* __[Fluent-style component consumption](#fluent-style-component-consumption)__
* __[Using it in your own project](#using-it-in-your-own-project)__


### `ComponentDefinition`
The abstract `ComponentDefinition` class serves as the basis for implementing and consuming components with strongly-typed props.

##### As a props map
`ComponentDefinition` extends [`MapView`](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:collection.MapView), so each instance of it proxies the specified props `Map`. And, since `MapView` implements `Map`, you can use `ComponentDefinition` anywhere you can use a plain `Map`.

Subclasses of `ComponentDefinition` typically mix in typed getters/setters for a component's props, which proxy key-value pairs from a backing props `Map`.

In React, props are represented as key-value pairs, so continuing to representing them with something that implements `Map` makes it easy to utilize established React patterns with regards to defaults, merging, cloning, etc.

##### As a builder
`ComponentDefinition` instances also contain a reference to a ReactComponentFactory, so they can be used to render components in addition to setting props on them.
 
The `build()` method (or simply invoking the builder like a function) uses that factory to construct a component using the builder's backing props map, and the specified children.
  
Usage involves:
  1. Creating a new `ComponentDefinition` instance
  2. Setting props on it via the typed setters 
  3. Invoking the `build()` function to get a `JsObject` React component
  
See [Fluent-style component consumption](#fluent-style-component-consumption) for more examples on builder usage.
 
## Fluent-style component consumption

In w_ui_platform, `ComponentDefinition` subclasses are used to consume components, and not the ReactComponentFactory functions directly.
 
Typically, components expose a factory to create new `ComponentDefinition` instances, which aids in consumption.
 
Note how you might render the same DOM in JSX, react-dart, and w_ui_platform:

* JSX:

    ```jsx
    <div className="container">
      <h1>Click the button!</h1>
      <button
        id="myButton"
        className="fancy-button"
        tabIndex=1
        onClick={_handleClick}
      >Click</button>
    </div>
    ```

* Vanilla react-dart:

    ```dart
    div({'className': 'container'}, [
      h1({}, 'Click the button!'),
      button({
        'id': 'myButton',
        'className': 'fancy-button',
        'tabIndex': 1,
        'onClick': _handleClick
      }, 'Click');
    ]);
    ```

* w_ui_platform fluent interface:

    ```dart
    (div()..className='container')([
      h1()('Click the button!'),
      (button()
        ..id = 'myButton'
        ..className = 'fancy-button'
        ..tabIndex = 1
        ..onClick = _handleClick
      )('Click')
    ]);
    ```
    
    (A more verbose version:)
    ```dart
    JsObject verboseExample() {
      // Create a new ComponentDefinition that can render a button,
      // with props backed by the specified Map.
      var builder = new DomComponentDefinition(react.button, {});
      
      // Use typed setters to add key-value pairs to the props map.
      builder.id = 'myButton';              // builder['id'] = 'myButton';
      builder.className = 'fancy-button';   // builder['className'] = 'myButton';
      builder.tabIndex = 1;                 // builder['tabIndex'] = 1;
      builder.onClick = _handleClick;       // builder['onClick'] = _handleClick;
      
      // Invoke the builder to return a new JsObject React component.
      return builder.build(['Click']);
    }
    ```
