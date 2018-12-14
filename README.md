# OverReact

[![Pub](https://img.shields.io/pub/v/over_react.svg)](https://pub.dartlang.org/packages/over_react)
[![Documentation](https://img.shields.io/badge/docs-over__react-blue.svg)](https://workiva.github.io/over_react)
[![Join the chat at https://gitter.im/over_react/Lobby](https://badges.gitter.im/over_react/Lobby.svg)](https://gitter.im/over_react/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/Workiva/over_react.svg?branch=master)](https://travis-ci.org/Workiva/over_react)
[![Test Coverage](https://codecov.io/github/Workiva/over_react/coverage.svg?branch=master)](https://codecov.io/github/Workiva/over_react?branch=master)
[![Strong Mode Compliant](https://img.shields.io/badge/strong_mode-on-brightgreen.svg)](https://github.com/Workiva/over_react/blob/master/analysis_options.yaml#L5)

> A library for building statically-typed React UI components using Dart.

---

> **Dart 2 Migration Guide**
>
> If you have existing over_react code written on Dart 1 and want to upgrade to
> Dart 2, please read the [**Dart 2 Migration Guide**](/doc/dart2_migration.md)

---


* __[Using it in your project](#using-it-in-your-project)__
    * [Running tests in your project](#running-tests-in-your-project)
* __[Anatomy of an OverReact component](#anatomy-of-an-overreact-component)__
    * [UiFactory](#uifactory)
    * [UiProps](#uiprops)
    * [UiState](#uistate)
    * [UiComponent](#uicomponent)
* __[Fluent-style component consumption](#fluent-style-component-consumption)__
* __[DOM components and props](#dom-components-and-props)__
* __[Component Formatting](#component-formatting)__
* __[Building custom components](#building-custom-components)__
    * __[Component Boilerplates](#component-boilerplate-templates)__
    * __[Component Best Practices](#component-best-practices)__
    * __[Common Pitfalls](#common-pitfalls)__
* __[Contributing](#contributing)__

[](#__START_EMBEDDED_README__)



## Using it in your project

> __If you are not familiar with React JS__
>
> Since OverReact is built atop React JS, we strongly encourage you to gain
> familiarity with it by reading this [React JS tutorial][react-js-tutorial] first.

1. Add the `over_react` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      over_react: ^1.29.0
    ```

2. Add the `over_react` [transformer] to your `pubspec.yaml`.

    ```yaml
    transformers:
      - over_react
      # Reminder: dart2js should come after any other transformers that touch Dart code
      - $dart2js
    ```

    _Our transformer uses code generation to wire up the different pieces of your
    component declarations - and to create typed getters/setters for `props` and `state`._

3. Include the native JavaScript `react` and `react_dom` libraries in your app’s `index.html` file,
and add an HTML element with a unique identifier where you’ll mount your OverReact UI component(s).

    ```html
    <html>
      <head>
       <!-- ... -->  
      </head>
      <body>
        <div id="react_mount_point">
          // OverReact component render() output will show up here.
        </div>

        <script src="packages/react/react.js"></script>
        <script src="packages/react/react_dom.js"></script>
        <script type="application/dart" src="your_app_name.dart"></script>
        <script src="packages/browser/dart.js"></script>
      </body>
    </html>
    ```

    > __Note:__ When serving your application in production, use `packages/react/react_with_react_dom_prod.js`
    file instead of the un-minified `react.js` / `react_dom.js` files shown in the example above.  

4. Import the `over_react` and `react_dom` libraries into `your_app_name.dart`, and initialize
React within your Dart application. Then [build a custom component](#building-custom-components) and
mount / render it into the HTML element you created in step 3.

    > Be sure to namespace the `react_dom.dart` import as `react_dom` to avoid collisions with `UiComponent.render`
      when [creating custom components](#building-custom-components). 

    ```dart
    import 'dart:html';
    import 'package:over_react/react_dom.dart' as react_dom;
    import 'package:over_react/over_react.dart';

    main() {
      // Initialize React within our Dart app
      setClientConfiguration();

      // Mount / render your component.
      react_dom.render(Foo()(), querySelector('#react_mount_point'));
    }    
    ```

5. Run `pub serve` in the root of your Dart project.

&nbsp;

### Running tests in your project

When running tests on code that uses our [transformer] _(or any code that imports `over_react`)_,
__you must run your tests using Pub__.

1. Add the `test/pub_serve` transformer to your `pubspec.yaml` _after_ the `over_react` transformer.

    ```yaml
    transformers:
      - over_react
      - test/pub_serve:
          $include: test/**_test{.*,}.dart
      - $dart2js
    ```

2. Use [the `--pub-serve` option](https://github.com/dart-lang/test#testing-with-barback) when running your tests:

    ```bash
    $ pub run test --pub-serve=8081 test/your_test_file.dart
    ```

    > __Note:__ `8081` is the default port used, but your project may use something different.  Be sure to take note
     of the output when running `pub serve` to ensure you are using the correct port.

&nbsp;
&nbsp;



## Anatomy of an OverReact component

> __If you are not familiar with React JS__
>
> Since OverReact is built atop React JS, we strongly encourage you to gain
> familiarity with it by reading this [React JS tutorial][react-js-tutorial] first.

The `over_react` library functions as an additional "layer" atop the [Dart react package][react-dart]
which handles the underlying JS interop that wraps around [React JS][react-js].

The library strives to maintain a 1:1 relationship with the React JS component class and API.
To do that, an OverReact component is comprised of four core pieces that are each wired up to our
Pub transformer using an analogous [annotation].

1. [UiFactory](#uifactory)
2. [UiProps](#uiprops)
3. _[UiState](#uistate) (optional)_
4. [UiComponent](#uicomponent)

&nbsp;

### UiFactory

__`UiFactory` is a function__ that returns a new instance of a
[`UiComponent`](#uicomponent)’s [`UiProps`](#uiprops) class.

```dart
@Factory()
UiFactory<FooProps> Foo;
```

* This factory is __the entry-point__ to consuming every OverReact component.
* The `UiProps` instance it returns can be used [as a component builder](#uiprops-as-a-builder),
or [as a typed view into an existing props map](#uiprops-as-a-map).

&nbsp;

### UiProps

__`UiProps` is a Map class__ that adds statically-typed getters and setters for each React component prop.
It can also be invoked as a function, serving as a builder for its analogous component.

```dart
@Props()
class FooProps extends UiProps {
  // ...
}
```

&nbsp;

#### UiProps as a Map

```dart
@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps {
  String color;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  // ...  
}

void bar() {
  FooProps props = Foo();

  props.color = '#66cc00';

  print(props.color); // #66cc00
  print(props);       // {FooProps.color: #66cc00}
}

/// You can use the factory to create a UiProps instance
/// backed by an existing Map.
void baz() {
  Map existingMap = {'FooProps.color': '#0094ff'};

  FooProps props = Foo(existingMap);

  print(props.color); // #0094ff
}
```

&nbsp;

#### UiProps as a builder

```dart
@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps {
  String color;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  ReactElement bar() {
    // Create a UiProps instance to serve as a builder
    FooProps builder = Foo();

    // Add props
    builder.id = 'the_best_foo';
    builder.color = '#ee2724';

    // Invoke as a function with the desired children
    // to return a new instance of the component.
    return builder('child1', 'child2');
  }

  /// Even better... do it inline! (a.k.a fluent)
  ReactElement baz() {
    return (Foo()
      ..id = 'the_best_foo'
      ..color = 'red'
    )(
      'child1',
      'child2'
    );
  }
}
```

> See [_fluent-style component consumption_](#fluent-style-component-consumption) for more examples on builder usage.

&nbsp;

### UiState

__`UiState` is a Map class__ _(just like `UiProps`)_ that adds statically-typed getters and setters
for each React component state property.

```dart
@State()
class FooState extends UiState {
  // ...
}
```

> UiState is optional, and won’t be used for every component.

&nbsp;

### UiComponent

__`UiComponent` is a subclass of [`react.Component`][react.component]__, containing lifecycle methods
and rendering logic for components.

```dart
@Component()
class FooComponent extends UiComponent<FooProps> {
  // ...
}
```

* This component provides statically-typed props via [`UiProps`](#uiprops), as well as utilities for
prop forwarding and CSS class merging.
* The `UiStatefulComponent` flavor augments `UiComponent` behavior with statically-typed state via
[`UiState`](#uistate).

&nbsp;

#### Accessing and manipulating props / state within UiComponent

* Within the `UiComponent` class, `props` and `state` are not just `Map`s.
They are instances of `UiProps` and `UiState`, __which means you don’t need String keys to access them!__
* `newProps()` and `newState()` are also exposed to conveniently create empty instances of `UiProps` and
`UiState` as needed.
* `typedPropsFactory()` and `typedStateFactory()` are also exposed to conveniently create typed `props` / `state` objects out of any provided backing map.

```dart
@Component()
class FooComponent extends UiStatefulComponent<FooProps, FooState> {
  @override
  getDefaultProps() => (newProps()
    ..color = '#66cc00'
  );

  @override
  getInitialState() => (newState()
    ..isActive = false
  );

  @override
  componentWillUpdate(Map newProps, Map newState) {
    var tNewState = typedStateFactory(newState);
    var tNewProps = typedPropsFactory(newProps);

    var becameActive = !state.isActive && tNewState.isActive;

    // Do something here!
  }

  @override
  render() {
    return (Dom.div()
      ..style = {
        'color': props.color,
        'fontWeight': state.isActive ? 'bold' : 'normal'
      }
    )(
      (Dom.button()..onClick = _handleButtonClick)('Toggle'),
      props.children
    );
  }

  void _handleButtonClick(SyntheticMouseEvent event) {
    _toggleActive();
  }

  void _toggleActive() {
    setState(newState()
      ..isActive = !state.isActive
    );
  }
}
```

&nbsp;
&nbsp;



## Fluent-style component consumption

In OverReact, components are consumed by invoking a `UiFactory` to return a new `UiProps` builder, which is then
modified and invoked to build a `ReactElement`.

This is done to make ["fluent-style"](#fluent-style-component-consumption) component consumption possible, so that
the OverReact consumer experience is very similar to the [React JS][react-js] / "vanilla" [react-dart]
experience.

To demonstrate the similarities, the example below shows a render method for JS, JSX, react-dart,
and over_react that will have the exact same HTML markup result.

* __React JS__:

  ```es6
  render() {
    return React.createElement('div', {className: 'container'},
      React.createElement('h1', null, 'Click the button!'),
      React.createElement('button', {
        id: 'main_button',
        onClick: _handleClick
      }, 'Click me')
    );
  }
  ```

* __React JS__ (JSX):

  ```jsx
  render() {
    return <div className="container">
      <h1>Click the button!</h1>
      <button
        id="main_button"
        onClick={_handleClick}
      >Click me</button>
    </div>;
  }
  ```

* __Vanilla react-dart__:

  ```dart
  render() {
    return react.div({'className': 'container'},
      react.h1({}, 'Click the button!'),
      react.button({
        'id': 'main_button',
        'onClick': _handleClick
      }, 'Click me')
    );
  }
  ```

* __OverReact__:

  ```dart
  render() {
    return (Dom.div()..className = 'container')(
      Dom.h1()('Click the button!'),
      (Dom.button()
        ..id = 'main_button'
        ..onClick = _handleClick
      )('Click me')
    );
  }
  ```

  Let’s break down the OverReact fluent-style shown above

  ```dart
  render() {
    // Create a builder for a <div>,
    // add a CSS class name by cascading a typed setter,
    // and invoke the builder with the HTML DOM <h1> and <button> children.
    return (Dom.div()..className = 'container')(

      // Create a builder for an <h1> and invoke it with children.
      // No need for wrapping parentheses, since no props are added.
      Dom.h1()('Click the button!'),

      // Create a builder for a <button>,
      (Dom.button()
        // add a ubiquitous DOM prop exposed on all components,
        // which Dom.button() forwards to its rendered DOM,
        ..id = 'main_button'
        // add another prop,
        ..onClick = _handleClick
      // and finally invoke the builder with children.
      )('Click me')
    );
  }
  ```

&nbsp;
&nbsp;



## DOM components and props

All [react-dart][react-dart] DOM components _(`react.div`, `react.a`, etc.)_ have a
corresponding `Dom` method _(`Dom.div()`, `Dom.a()`, etc.)_ in OverReact.

```dart
ReactElement renderLink() {
  return (Dom.a()
    ..id = 'home_link'
    ..href = '/home'
  )('Home');
}

ReactElement renderResizeHandle() {
  return (Dom.div()
    ..className = 'resize-handle'
    ..onMouseDown = _startDrag
  )();
}
```

* OverReact DOM components return a new `DomProps` builder, which can be used
to render them via our [fluent interface](#fluent-style-component-consumption)
as shown in the examples above.
* `DomProps` has statically-typed getters and setters for all "ubiquitous" HTML attribute props.
  * The `domProps()` function is also available to create a new typed Map or a typed view into an
  existing Map. Useful for manipulating DOM props and adding DOM props to components that don’t
  forward them directly.

&nbsp;
&nbsp;



## Component Formatting
> __A note on dart_style:__
>
> Currently, [dart_style (dartfmt)](https://github.com/dart-lang/dart_style) decreases the readability of components
> built using [OverReact's fluent-style](#fluent-style-component-consumption).
> See https://github.com/dart-lang/dart_style/issues/549 for more info.
>
> We're exploring some different ideas to improve automated formatting, but for the time being, we __do not recommend__ using dart_style with OverReact.
>
> However, if you do choose to use dart_style, you can greatly improve its output by using trailing commas in children argument lists:
>
> * dart_style formatting:
> ```dart
> return (Button()
>   ..id = 'flip'
>   ..skin =
>       ButtonSkin.vanilla)((Dom.span()
>   ..className = 'flip-container')((Dom.span()..className = 'flipper')(
>     (Dom.span()
>       ..className =
>           'front-side')((Icon()..glyph = IconGlyph.CHEVRON_DOUBLE_RIGHT)()),
>     (Dom.span()
>       ..className =
>           'back-side')((Icon()..glyph = IconGlyph.CHEVRON_DOUBLE_LEFT)()))));
> ```
> * dart_style formatting, when trailing commas are used:
> ```dart
> return (Button()
>   ..id = 'flip'
>   ..skin = ButtonSkin.vanilla)(
>   (Dom.span()..className = 'flip-container')(
>     (Dom.span()..className = 'flipper')(
>       (Dom.span()..className = 'front-side')(
>         (Icon()..glyph = IconGlyph.CHEVRON_DOUBLE_RIGHT)(),
>       ),
>       (Dom.span()..className = 'back-side')(
>         (Icon()..glyph = IconGlyph.CHEVRON_DOUBLE_LEFT)(),
>       ),
>     ),
>   ),
> );
> ```

### Guidelines

To help ensure your OverReact code is readable and consistent, we've arrived at the following formatting rules.

* __ALWAYS__ place the closing builder parent on a new line.

  _Good:_
    ```dart
    (Button()
      ..skin = ButtonSkin.SUCCESS
      ..isDisabled = true
    )('Submit')
    ```

  _Bad:_
    ```dart
    (Button()
      ..skin = ButtonSkin.SUCCESS
      ..isDisabled = true)('Submit')
    ```

* __ALWAYS__ pass component children on a new line with trailing commas and 2 space indentation.

  _Good:_
    ```dart
    Dom.div()(
      Dom.span()('nested component'),
    )
    ```

    ```dart
    Dom.div()(
      Dom.span()('nested component A'),
      Dom.span()('nested component B'),
    )
    ```

  _Bad:_
    ```dart
    // Children are not on a new line; in most cases,
    // this makes it difficult to quickly determine nesting.
    Dom.div()(Dom.span()('nested component'), Dom.span()('nested component'))
    ```

    ```dart
    // With nested hierarchies, continuation indents can quickly result
    // in a "pyramid of Doom"
    Dom.div()(
        Dom.ul()(
            Dom.li()(
                Dom.a()('A link!')
            )
        )
    )
    ```

    ```dart
    // Omitting trailing commas makes it a pain to rearrange lines
    Dom.div()(
      Dom.span()('nested component A'),
      Dom.span()('nested component B')
    )
    Dom.div()(
      Dom.span()('nested component B') // ugh, need to add a comma here...
      Dom.span()('nested component A'),
    )
    ```

* __AVOID__ passing children within lists; lists should only be used when the number/order of the children are dynamic.

  _Good:_
    ```dart
    Dom.div()(
      Dom.span()('nested component'),
      Dom.span()('nested component'),
    )
    ```

    ```dart
    var children = [
      Dom.div()('List of Items:'),
    ]..addAll(props.items.map(renderItem));

    return Dom.div()(children)
    ```

  _Bad:_
    ```dart
    Dom.div()([
      (Dom.span()..key = 'span1')('nested component'),
      (Dom.span()..key = 'span2')('nested component'),
    ])
    ```

* __AVOID__ specifying more than one cascading prop setter on the same line.

  _Good:_
    ```dart
    (Dom.div()
      ..id = 'my_div'
      ..className = 'my-class'
    )()
    ```

  _Bad:_
    ```dart
    (Dom.div()..id = 'my_div'..className = 'my-class')()
    ```


## Building custom components

Now that we’ve gone over how to [use the `over_react` package in your project](#using-it-in-your-project),
the [anatomy of a component](#anatomy-of-an-overreact-component) and the [DOM components](#dom-components-and-props)
that you get for free from OverReact, you're ready to start building your own custom React UI components.

1. Start with one of the [component boilerplate templates](#component-boilerplate-templates) below.
  * [Component](#component-boilerplate) _(props only)_
  * [Stateful Component](#stateful-component-boilerplate) _(props + state)_
  * [Flux Component](#flux-component-boilerplate) _(props + store + actions)_
  * [Stateful Flux Component](#stateful-flux-component-boilerplate) _(props + state + store + actions)_
2. Fill in your props and rendering/lifecycle logic.
3. Consume your component with the fluent interface.
4. Run [the app you’ve set up to consume `over_react`](#using-it-in-your-project)

    ```bash
    $ pub serve
    ```

    _That’s it! Code will be automatically generated on the fly by Pub!_


> __Check out some custom [component demos] to get a feel for what’s possible!__

&nbsp;

### Component Boilerplate Templates

* #### [VS Code Snippet Extension](https://marketplace.visualstudio.com/items?itemName=JaceHensley.over-react-snippets)

* #### Component Boilerplate

    ```dart
    import 'package:over_react/over_react.dart';

    @Factory()
    UiFactory<FooProps> Foo;

    @Props()
    class FooProps extends UiProps {
      // Props go here, declared as fields:
      bool isDisabled;
      Iterable<String> items;
    }

    @Component()
    class FooComponent extends UiComponent<FooProps> {
      @override
      Map getDefaultProps() => (newProps()
        // Cascade default props here
        ..isDisabled = false
        ..items = []
      );

      @override
      render() {
        // Return the rendered component contents here.
        // The `props` variable is typed; no need for string keys!
      }
    }
    ```

* #### Stateful Component Boilerplate

    ```dart
    import 'dart:html';
    import 'package:over_react/over_react.dart';

    @Factory()
    UiFactory<BarProps> Bar;

    @Props()
    class BarProps extends UiProps {
      // Props go here, declared as fields:
      bool isDisabled;
      Iterable<String> items;
    }

    @State()
    class BarState extends UiState {
      // State goes here, declared as fields:
      bool isShown;
    }

    @Component()
    class BarComponent extends UiStatefulComponent<BarProps, BarState> {
      @override
      Map getDefaultProps() => (newProps()
        // Cascade default props here
        ..isDisabled = false
        ..items = []
      );

      @override
      Map getInitialState() => (newState()
        // Cascade initial state here
        ..isShown = true
      );

      @override
      render() {
        // Return the rendered component contents here.
        // The `props` variable is typed; no need for string keys!
      }
    }
    ```

* #### Flux Component Boilerplate

    ```dart
    import 'dart:html';
    import 'package:over_react/over_react.dart';

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

      @override
      render() {
        // Return the rendered component contents here.
        // The `props` variables is typed; no need for string keys!
        // E.g., `props.actions`, `props.store`.
      }
    }
    ```

* #### Stateful Flux Component Boilerplate

    ```dart
    import 'dart:html';
    import 'package:over_react/over_react.dart';

    @Factory()
    UiFactory<BazProps> Baz;

    @Props()
    class BazProps extends FluxUiProps<BazActions, BazStore> {
      // Props go here, declared as fields.
      // `actions` and `store` are already defined for you!
    }

    @State()
    class BazState extends UiState {
      // State goes here, declared as fields.
    }

    @Component()
    class BazComponent extends FluxUiStatefulComponent<BazProps, BazState> {
      getDefaultProps() => (newProps()
        // Cascade default props here
      );

      @override
      Map getInitialState() => (newState()
        // Cascade initial state here
      );

      @override
      render() {
        // Return the rendered component contents here.
        // The `props` variables is typed; no need for string keys!
        // E.g., `props.actions`, `props.store`.
      }
    }
    ```

&nbsp;

### Component Best Practices


* __ALWAYS__ write informative comments for your component factories.
Include what the component relates to, relies on, or if it extends
another component.

  _Good:_
    ```dart
    /// Use the `DropdownButton` component to render a button
    /// that controls the visibility of a child [DropdownMenu].
    ///
    /// * Related to [Button].
    /// * Extends [DropdownTrigger].
    /// * Similar to [SplitButton].
    ///
    /// See: <https://link-to-any-relevant-documentation>.
    @Factory()
    UiFactory<DropdownButtonProps> DropdownButton;
    ```

  _Bad:_
    ```dart
    /// Component Factory for a dropdown button component.
    @Factory()
    UiFactory<DropdownButtonProps> DropdownButton;
    ```

&nbsp;

* __ALWAYS__ set a default / initial value for `props` / `state` fields,
and document that value in a comment.

  _Why?_ Without default prop values for bool fields, they could be
  `null` - which is extremely confusing and can lead to a lot of
  unnecessary null-checking in your business logic.

  _Good:_
    ```dart
    @Props()
    DropdownButtonProps extends UiProps {
      /// Whether the [DropdownButton] appears disabled.
      ///
      /// Default: `false`
      bool isDisabled;

      /// Whether the [DropdownButton]'s child [DropdownMenu] is open
      /// when the component is first mounted.
      ///
      /// Determines the initial value of [DropdownButtonState.isOpen].
      ///
      /// Default: `false`
      bool initiallyOpen;
    }

    @State()
    DropdownButtonState extends UiState {
      /// Whether the [DropdownButton]'s child [DropdownMenu] is open.
      ///
      /// Initial: [DropdownButtonProps.initiallyOpen]
      bool isOpen;
    }

    @Component()
    DropdownButtonComponent
        extends UiStatefulComponent<DropdownButtonProps, DropdownButtonState> {
      @override
      Map getDefaultProps() => (newProps()
        ..isDisabled = false
        ..initiallyOpen = false
      );

      @override
      Map getInitialState() => (newState()
        ..isOpen = props.initiallyOpen
      );
    }
    ```

  _Bad:_
    ```dart
    @Props()
    DropdownButtonProps extends UiProps {
      bool isDisabled;
      bool initiallyOpen;
    }

    @State()
    DropdownButtonState extends UiState {
      bool isOpen;
    }

    @Component()
    DropdownButtonComponent
        extends UiStatefulComponent<DropdownButtonProps, DropdownButtonState> {
      // Confusing stuff is gonna happen in here with
      // bool props that could be null.
    }
    ```

&nbsp;

* __AVOID__ adding `props` or `state` fields that don't have
an informative comment.

  _Good:_
    ```dart
    @Props()
    DropdownButtonProps extends UiProps {
      /// Whether the [DropdownButton] appears disabled.
      ///
      /// Default: `false`
      bool isDisabled;

      /// Whether the [DropdownButton]'s child [DropdownMenu] is open
      /// when the component is first mounted.
      ///
      /// Determines the initial value of [DropdownButtonState.isOpen].
      ///
      /// Default: `false`
      bool initiallyOpen;
    }

    @State()
    DropdownButtonState extends UiState {
      /// Whether the [DropdownButton]'s child [DropdownMenu] is open.
      ///
      /// Initial: [DropdownButtonProps.initiallyOpen]
      bool isOpen;
    }
    ```

  _Bad:_
    ```dart
    @Props()
    DropdownButtonProps extends UiProps {
      bool isDisabled;
      bool initiallyOpen;
    }

    @State()
    DropdownButtonState extends UiState {
      bool isOpen;
    }
    ```

&nbsp;

### Common Pitfalls

Below you’ll find some common errors / issues that new consumers run into when building custom components.

> Don’t see the issue you're having? [Tell us about it.][new-issue]

---

#### `null object does not have a method 'call'`

```
ⓧ Exception: The null object does not have a method 'call'.
```

This error is thrown when you call a `@Factory()` function that has not been initialized due to
the `over_react` [transformer] not running, you’ll get this error.

__Make sure you’ve followed the [setup instructions](#using-it-in-your-project).__

---

### 404 on `.dart` file

```
ⓧ GET http://localhost:8080/src/your_component.dart
ⓧ An error occurred loading file: http://localhost:8080/src/your_component.dart
```

When the `over_react` [transformer] finds something wrong with your file, it logs an error in Pub and causes the
invalid file to 404. This ensures that when the transformer breaks, `pub build` will break, and you’ll know about it.

__Check your `pub serve` output for errors.__

&nbsp;
&nbsp;



## Contributing

Yes please! ([__Please read our contributor guidelines first__][contributing-docs])

&nbsp;
&nbsp;



## Versioning

The `over_react` library adheres to [Semantic Versioning](http://semver.org/):

* Any API changes that are not backwards compatible will __bump the major version__ _(and reset the minor / patch)_.
* Any new functionality that is added in a backwards-compatible manner will __bump the minor version__
  _(and reset the patch)_.
* Any backwards-compatible bug fixes that are added will __bump the patch version__.



[component demos]: https://workiva.github.io/over_react/demos

[contributing-docs]: https://github.com/Workiva/over_react/blob/master/.github/CONTRIBUTING.md
[transformer]: https://github.com/Workiva/over_react/blob/master/lib/src/transformer/README.md
[annotations]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/annotations.dart
[annotation]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/annotations.dart
[component_base.dart]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/component_base.dart

[react-dart]: https://github.com/cleandart/react-dart
[react-js]: https://github.com/facebook/react
[react-js-tutorial]: https://facebook.github.io/react/docs/getting-started.html

[react.component]: https://www.dartdocs.org/documentation/react/latest/react/Component-class.html

[new-issue]: https://github.com/Workiva/over_react/issues/new
