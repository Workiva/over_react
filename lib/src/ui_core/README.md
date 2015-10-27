# Core Component Framework

web_skin_dart also provides a framework for building strongly-typed React components, on which all of web_skin_dart's reusable UI components are built.

* __[What makes a web_skin_dart component](#what-makes-a-web_skin_dart-component)__
  * __[`ComponentDefinition`](#componentdefinition)__
    * [As a props map](#as-a-props-map)
    * [As a builder](#as-a-builder)
  * __[`BaseComponent`](#basecomponent)__
    * [`TypedPropsGetter` and `TypedStateGetter`](#typedpropsgetter-and-typedstategetter)
* __[`DomProps` and `DomComponentDefinition`](#domprops-and-domcomponentdefinition)__
* __[Fluent-style component consumption](#fluent-style-component-consumption)__
* __[Building your own components](#building-your-own-components)__
  * [Stateless components](#stateless-components)
  * [Stateful components](#stateful-components)


## What makes a web_skin_dart component

### ComponentDefinition
The abstract `ComponentDefinition` class serves as the basis for implementing and consuming strongly-typed props.

(An abstract subclass `BaseComponentDefinition`, is also available, which mixes in `ReactProps` and `CssClassProps` for convenience.)

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
 
### BaseComponent

The abstract `BaseComponent` class extends `react.Component` with convenience methods relating to prop forwarding and CSS className merging, and also mixes in `TypedPropsGetter`, which makes it easy to use typed props within components. (`BaseComponentWithState` does the same thing, but also with `TypedStateGetter`.)
 
##### TypedPropsGetter and TypedStateGetter

These generic mixins make it easy to access typed props and state from within a component.
 
Each of them requires implementation of a factory (`typedPropsFactory`/`typedStateFactory`) that creates a typed "view" into the specified Map. 

This is used internally by the mixin so it can provide `tProps`/`tState` getters, which return typed views into the current `props`/`state` Maps.

This lets you access state and props using the same typed getters/setters defined in the component's `ComponentDefinition` subclass, or `MapView` state subclass. 

```dart
render() {
  assert(identical(tProps.children, props['children']);
}
```

`newState()` and `newProps()` are also exposed for convenience, and are useful for easily creating new typed Maps:
```dart
@override
getDefaultProps() => (newProps()
  ..isSelected = false
);

@override
getInitialState() => (newState()
  isExpanded = true
);

_toggleExpanded() => setState(newState()
  ..isExpanded = !tState.isExpanded
);
```

## DomProps and DomComponentDefinition
web_skin_dart also wraps each available React DOM component (`react.div`, `react.a`, etc.) with a convenience method that each returns an appropriate `DomComponentDefinition` instance.

The returned instances have getters/setters for all available DOM/attribute-related props available in React (`className`, `href`, `onClick`, etc.), for convenience.
 
## Fluent-style component consumption

In web_skin_dart, `ComponentDefinition` subclasses are used to consume components, and not the ReactComponentFactory functions directly.
 
Typically, components expose a factory to create new `ComponentDefinition` instances, which aids in consumption.
 
Note how you might render the same DOM in JSX, react-dart, and web_skin_dart:

* JSX:

    ```jsx
    <div className="container">
      <h1>Click the button!</h1>
      <button
        id="my_button"
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
        'id': 'my_button',
        'className': 'fancy-button',
        'tabIndex': 1,
        'onClick': _handleClick
      }, 'Click');
    ]);
    ```

* web_skin_dart fluent interface:

    ```dart
    (Dom.div()..className='container')([
      Dom.h1()('Click the button!'),
      (Dom.button()
        ..id = 'my_button'
        ..className = 'fancy-button'
        ..tabIndex = 1
        ..onClick = _handleClick
      )('Click')
    ]);
    ```
    
    A more verbose version of the `button` usage:
    ```dart
    (() {
      // Create a new ComponentDefinition that can render a button,
      // with props backed by the specified Map.
      var builder = new DomComponentDefinition(react.button, {});
      
      // Use typed setters to add key-value pairs to the props map.
      builder.id = 'my_button';             // builder['id'] = 'my_button';
      builder.className = 'fancy-button';   // builder['className'] = 'myButton';
      builder.tabIndex = 1;                 // builder['tabIndex'] = 1;
      builder.onClick = _handleClick;       // builder['onClick'] = _handleClick;
      
      // Invoke the builder to return a new JsObject React component.
      return builder.build(['Click']);
    })()
    ```

## Building your own components

#### Stateless components

1. Add the following lines to import the necessary core pieces:
    ```dart
    // Import web_skin_dart core component framework 
    import 'package:web_skin_dart/ui_core.dart';
    
    // Import code_generation annotations so we can use @GenerateProps
    import 'package:web_skin_dart/code_generation/annotations.dart';
    ```

2. Start with this template for a component:
    ```dart
    /// Returns a new builder for the Foo component.
    FooDefinition Foo() => new FooDefinition({});
    
    /// Builder for the Foo component, with typed getters/setters for each prop that the component accepts.
    /// Also functions as a MapView, for use internally by the Foo component, as well as for Button component prop manipulation.
    @GenerateProps(#FooProps)
    class FooDefinition extends BaseComponentDefinition with FooProps {
      FooDefinition(Map backingMap) : super(_FooComponentFactory, backingMap);
      
      // Add abstract prop getters, and run code_generation to update the 'FooProps' mixin
    }
    
    ReactComponentFactory _FooComponentFactory = react.registerComponent(() => new _Foo());
    class _Foo extends BaseComponent<FooDefinition> {
      @override
      Map getDefaultProps() => (newProps()
        // Use cascades (.. operator) to set default props here
      );
    
      @override
      render() {
        
      }
    
      @override
      FooDefinition typedPropsFactory(Map propsMap) => new FooDefinition(propsMap);
    }
    ```

3. Fill in props, set up the [code_generation][code-generation] tool, and run it.
 
4. Start consuming your component with strongly-typed props!

#### Stateful components

Making stateful components is similar, except you'll need to define a MapView subclass for your typed state and use it within the component:

```dart
/// Returns a new builder for the Foo component.
FooDefinition Foo() => new FooDefinition({});

/// Builder for the Foo component, with typed getters/setters for each prop that the component accepts.
/// Also functions as a MapView, for use internally by the Foo component, as well as for Button component prop manipulation.
@GenerateProps(#FooProps)
class FooDefinition extends BaseComponentDefinition with FooProps {
  FooDefinition(Map backingMap) : super(_FooComponentFactory, backingMap);
  
  // Add abstract prop getters, and run code_generation to update the 'FooProps' mixin
}

@GenerateState(#FooStateMixin)
class FooState extends MapView with FooStateMixin {
  FooState(Map backingMap) : super(backingMap);
  
  // Add abstract state getters, and run code_generation to update the 'FooStateMixin' mixin
}

ReactComponentFactory _FooComponentFactory = react.registerComponent(() => new _Foo());
class _Foo extends BaseComponentWithState<FooDefinition, FooState> {
  @override
  Map getDefaultProps() => (newProps()
    // Use cascades (.. operator) to set default props here
  );
  
  @override
  Map getInitialState() => (newState()
    // Use cascades (.. operator) to set initial state here
  );

  @override
  render() {
    
  }

  @override
  FooDefinition typedPropsFactory(Map propsMap) => new FooDefinition(propsMap);

  @override
  FooState typedStateFactory(Map stateMap) => new FooState(stateMap);
}
```


[code-generation]: /lib/src/code_generation/README.md
