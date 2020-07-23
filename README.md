# OverReact

[![Pub](https://img.shields.io/pub/v/over_react.svg)](https://pub.dartlang.org/packages/over_react)
[![Join the chat at https://gitter.im/over_react/Lobby](https://badges.gitter.im/over_react/Lobby.svg)](https://gitter.im/over_react/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Documentation](https://img.shields.io/badge/docs-over_react-blue.svg)](https://pub.dev/documentation/over_react/latest/)
[![OverReact Analyzer Plugin (beta)](https://img.shields.io/badge/docs-analyzer_plugin_(beta)-ff69b4.svg)](https://workiva.github.io/over_react/analyzer_plugin/)

[![Build Status](https://travis-ci.org/Workiva/over_react.svg?branch=master)](https://travis-ci.org/Workiva/over_react)
[![Test Coverage](https://codecov.io/github/Workiva/over_react/coverage.svg?branch=master)](https://codecov.io/github/Workiva/over_react?branch=master)

> A library for building statically-typed React UI components using Dart.
>
> This library also exposes _OverReact Redux_, which has [its own documentation](doc/over_react_redux_documentation.md).

---
 __UiComponent2 Migration Guide__
 
> For guidance on updating to `UiComponent2` from `UiComponent`, see the [UiComponent2 Transition Notes](doc/ui_component2_transition.md).

---

* __[Additional docs](#additional-docs)__
* __[Using it in your project](#using-it-in-your-project)__
    * [Running tests in your project](#running-tests-in-your-project)
* __[Anatomy of an OverReact component](#anatomy-of-an-overreact-component)__
    * [UiFactory](#uifactory)
    * [UiProps](#uiprops)
    * [UiState](#uistate)
    * [UiComponent2](#uicomponent2)
* __[Fluent-style component consumption](#fluent-style-component-consumption)__
* __[DOM components and props](#dom-components-and-props)__
* __[Component Formatting](#component-formatting)__
* __[Building custom components](#building-custom-components)__
    * __[Component Boilerplates](#component-boilerplate-templates)__
    * __[Component Best Practices](#component-best-practices)__
* __[Contributing](#contributing)__

[](#__START_EMBEDDED_README__)

## Additional docs
To further document APIs that can be found in OverReact, the [doc](doc) directory was created. The documentation found in that directory includes:
 - [OverReact Redux Documentation](doc/over_react_redux_documentation.md): The official documentation source for OverReact Redux, with an indepth description of `connect` and usage with `UiComponent2`.
    
    Migration guides from other state management libs:
    - [BuiltRedux to Redux](doc/built_redux_to_redux.md): A guide to transitioning to OverReact Redux from BuiltRedux.
    - [Flux to Redux](doc/flux_to_redux.md): A guide to how to transition from w_flux to OverReact Redux. This guide also introducers a new architecture, Influx, that can be used for incrementally refactoring.
- Migration guides from older versions of over_react:
    - [Dart2 Migration](doc/dart2_migration.md): Documentation on the Dart 2 builder updates and how to transition componentry to Dart 2.
    - [UiComponent2 Transition](doc/ui_component2_transition.md): A document discussing the changes between `UiComponent` and `UiComponent2`, as well as how to migrate.
    - [New Boilerplate Migration](doc/new_boilerplate_migration.md): Documentation on the changes to the component boilerplate, as well as how to migrate to the new boilerplate.

## Using it in your project

> __If you are not familiar with React JS__
>
> Since OverReact is built atop React JS, we strongly encourage you to gain
> familiarity with it by reading this [React JS tutorial][react-js-tutorial] first.

1. Add the `over_react` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      over_react: ^3.0.0
    ```
   
1. Enable the **[OverReact Analyzer Plugin (beta)](tools/analyzer_plugin/)**, which has many lints and assists to make authoring OverReact components easier!

1. Include the native JavaScript `react` and `react_dom` libraries in your app’s `index.html` file,
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

        <script type="application/javascript" defer src="your_app_entrypoint.dart.js"></script>
      </body>
    </html>
    ```

    > __Note:__ When serving your application in production, use `packages/react/react_with_react_dom_prod.js`
    file instead of the un-minified `react.js` / `react_dom.js` files shown in the example above.

1. Import the `over_react` and `react_dom` libraries into `your_app_name.dart`, and initialize
React within your Dart application. Then [build a custom component](#building-custom-components) and
mount / render it into the HTML element you created in step 3.

    > Be sure to namespace the `react_dom.dart` import as `react_dom` to avoid collisions with `UiComponent.render`
      when [creating custom components](#building-custom-components).

    ```dart
    import 'dart:html';
    import 'package:over_react/react_dom.dart' as react_dom;
    import 'package:over_react/over_react.dart';

    main() {
      // Mount / render your component.
      react_dom.render(Foo()(), querySelector('#react_mount_point'));
    }
    ```

1. Run `pub run build_runner serve` in the root of your Dart project.

> **Note:** After running a build, you'll have to restart your analysis server in your IDE for the built types to resolve
properly. Unfortunately, this is a known limitation in the analysis server at this time. See: https://github.com/dart-lang/sdk/issues/34344

&nbsp;

### Running tests in your project

When running tests on code that uses our [builder] _(or any code that imports `over_react`)_,
__you must run your tests using build_runner__.
>**Warning:** Do **_not_** run tests via `pub run build_runner test` in a package while another instance of `build_runner`
(e.g. `pub run build_runner serve`) is running in that same package. [This workflow is unsupported by build_runner](https://github.com/dart-lang/build/issues/352#issuecomment-461554316)

1. Run tests through build_runner, and specify the platform to be a browser platform. Example:

    ```bash
    $ pub run build_runner test -- -p chrome test/your_test_file.dart
    ```

1. When running tests in `over_react`, our `dart_test.yaml` specifies some handy presets for running tests in DDC and dart2js:
    > **Note:** These presets exist only in `over_react`.
    * To run tests in `over_react` compiled via DDC, run:
    ```bash
    $ pub run build_runner test -- -P dartdevc
    ```
    * To run tests in `over_react` compiled via dart2js, run:
    ```bash
    $ pub run build_runner test -r -- -P dart2js
    ```

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
To do that, an OverReact component is comprised of four core pieces that are each wired up
via our builder using an analogous [annotation].

1. [UiFactory](#uifactory)
2. [UiProps](#uiprops)
3. _[UiState](#uistate) (optional)_
4. [UiComponent](#uicomponent2)

&nbsp;

### UiFactory

__`UiFactory` is a function__ that returns a new instance of a
[`UiComponent`](#uicomponent2)’s [`UiProps`](#uiprops) class.

```dart
UiFactory<FooProps> Foo = _$Foo;
```

* This factory is __the entry-point__ to consuming every OverReact component.
* The `UiProps` instance it returns can be used [as a component builder](#uiprops-as-a-builder),
or [as a typed view into an existing props map](#uiprops-as-a-map).

&nbsp;

### UiProps

__`UiProps` is a Map class__ that adds statically-typed getters and setters for each React component prop.
It can also be invoked as a function, serving as a builder for its analogous component.

```dart
mixin FooProps on UiProps {
  // ...
}
```
* Note: The [builder] will make the concrete getters and setters available in a generated class. To mix props classes together, the mixin class should be used rather than the generated props class. See [With other mixins](#with-other-mixins) below for more information.

&nbsp;

#### With other mixins

__To compose props mixin classes__, create a class alias that uses `UiProps` as the base and mix in props mixins. The generated props implementation will then use it as the base class and implement the generated version of those props mixins.
```dart
UiFactory<FooProps> Foo = _$Foo;

mixin FooPropsMixin on UiProps {
  // ...
}

class FooProps = UiProps with FooPropsMixin, BarPropsMixin;

class FooComponent extends UiComponent2<FooProps> {
  // ...
}
```

&nbsp;

#### UiProps as a Map

```dart
UiFactory<FooProps> Foo = _$Foo;

mixin FooProps on UiProps {
  String color;
}

class FooComponent extends UiComponent2<FooProps> {
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
UiFactory<FooProps> Foo = _$Foo;

mixin FooProps on UiProps {
  String color;
}

@Component2()
class FooComponent extends UiComponent2<FooProps> {
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
mixin FooState on UiState {
  // ...
}
```

> UiState is optional, and won’t be used for every component.
* Note: The [builder] will make the concrete getters and setters available in a generated class. To mix state classes together, the mixin class should be used rather than the generated state class. See [With other mixins](#with-other-mixins) above for  more information.

&nbsp;

### UiComponent2
> For guidance on updating to `UiComponent2` from `UiComponent`, see [UiComponent2 Transition Notes](doc/ui_component2_transition.md).

__`UiComponent2` is a subclass of [`react.Component2`]__, containing lifecycle methods
and rendering logic for components.

```dart
class FooComponent extends UiComponent2<FooProps> {
  // ...
}
```

* This component provides statically-typed props via [`UiProps`](#uiprops), as well as utilities for
prop forwarding and CSS class merging.
* The `UiStatefulComponent` flavor augments `UiComponent` behavior with statically-typed state via
[`UiState`](#uistate).

&nbsp;

#### Accessing and manipulating props / state within UiComponent

* Within the `UiComponent2` class, `props` and `state` are not just `Map`s.
They are instances of `UiProps` and `UiState`, __which means you don’t need String keys to access them!__
* `newProps()` and `newState()` are also exposed to conveniently create empty instances of `UiProps` and
`UiState` as needed.
* `typedPropsFactory()` and `typedStateFactory()` are also exposed to conveniently create typed `props` / `state` objects out of any provided backing map.

```dart
class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
  @override
  get defaultProps => (newProps()
    ..color = '#66cc00'
  );

  @override
  get initialState => (newState()
    ..isActive = false
  );

  @override
  componentWillUpdate(Map newProps, Map newState, [dynamic snapshot]) {
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

> The **[OverReact analyzer plugin](tools/analyzer_plugin/)** has many lints and assists to make authoring OverReact components easier!

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

1. Start with one of the [component boilerplate templates](#component-boilerplate-templates) below
(Or, use OverReact's [code snippets for Intellij and Vs Code](https://github.com/Workiva/over_react/blob/master/snippets/README.md)).
  * [Component](#component-boilerplate) _(props only)_
  * [Stateful Component](#stateful-component-boilerplate) _(props + state)_
  * [Flux Component](#flux-component-boilerplate) _(props + store + actions)_
  * [Stateful Flux Component](#stateful-flux-component-boilerplate) _(props + state + store + actions)_
2. Fill in your props and rendering/lifecycle logic.
3. Consume your component with the fluent interface.
4. Run [the app you’ve set up to consume `over_react`](#using-it-in-your-project)

    ```bash
    $ pub run build_runner serve
    ```

    _That’s it! Code will be automatically generated on the fly by the builder!_


> __Check out some custom [component demos] to get a feel for what’s possible!__

&nbsp;

### Component Boilerplate Templates

* #### [VS Code and WebStorm/IntelliJ Snippets](https://github.com/Workiva/over_react/blob/master/snippets/README.md)

* #### Component Boilerplate

    ```dart
    import 'package:over_react/over_react.dart';
    part 'foo_component.over_react.g.dart';

    UiFactory<FooProps> Foo = _$Foo;

    mixin FooProps on UiProps {
      // Props go here, declared as fields:
      bool isDisabled;
      Iterable<String> items;
    }

    class FooComponent extends UiComponent2<FooProps> {
      @override
      get defaultProps => (newProps()
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
    part 'foo_component.over_react.g.dart';

    UiFactory<BarProps> Bar = _$Bar;

    mixin BarProps on UiProps {
      // Props go here, declared as fields:
      bool isDisabled;
      Iterable<String> items;
    }

    mixin BarState on UiState {
      // State goes here, declared as fields:
      bool isShown;
    }

    class BarComponent extends UiStatefulComponent2<BarProps, BarState> {
      @override
      get defaultProps => (newProps()
        // Cascade default props here
        ..isDisabled = false
        ..items = []
      );

      @override
      get initialState => (newState()
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
    part 'foo_component.over_react.g.dart';

    UiFactory<BazProps> Baz = _$Baz;

    mixin BazPropsMixin on UiProps {
      // Props go here, declared as fields.
      // `actions` and `store` are already defined for you!
    }

    class BazProps = UiProps with FluxUiPropsMixin<BazActions, BazStore>, BazPropsMixin;
  
    class BazComponent extends FluxUiComponent2<BazProps> {
      @override
      get defaultProps => (newProps()
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
    part 'foo_component.over_react.g.dart';

    UiFactory<BazProps> Baz = _$Baz;

  
    mixin BazPropsMixin on UiProps {
      // Props go here, declared as fields.
      // `actions` and `store` are already defined for you!
    }

    class BazProps = UiProps with FluxUiPropsMixin<BazActions, BazStore>, BazPropsMixin;

  
    mixin BazState on UiState {
      // State goes here, declared as fields.
    }

    class BazComponent extends FluxUiStatefulComponent2<BazProps, BazState> {
      @override
      get defaultProps => (newProps()
        // Cascade default props here
      );

      @override
      get initialState => (newState()
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
  
* #### Function Component Boilerplate

  ```dart
  import 'package:over_react/over_react.dart';
  part 'foo_component.over_react.g.dart';

  UiFactory<FooProps> Foo = uiFunction(
    (props) {
      // Set default props using null-aware operators.
      final isDisabled = props.isDisabled ?? false;
      final items = props.items ?? [];
  
      // Return the rendered component contents here.
      // The `props` variable is typed; no need for string keys!
    },
    // The generated props config will match the factory name.
    $FooConfig, // ignore: undefined_identifier
  );

  mixin FooProps on UiProps {
    // Props go here, declared as fields:
    bool isDisabled;
    Iterable<String> items;
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
    UiFactory<DropdownButtonProps> DropdownButton = _$DropdownButton;
    ```

  _Bad:_
    ```dart
    /// Component Factory for a dropdown button component.
    UiFactory<DropdownButtonProps> DropdownButton = _$DropdownButton;
    ```

&nbsp;

* __ALWAYS__ set a default / initial value for `props` / `state` fields,
and document that value in a comment.

  _Why?_ Without default prop values for bool fields, they could be
  `null` - which is extremely confusing and can lead to a lot of
  unnecessary null-checking in your business logic.

  _Good:_
    ```dart
    mixin DropdownButtonProps on UiProps {
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

    mixin DropdownButtonState on UiState {
      /// Whether the [DropdownButton]'s child [DropdownMenu] is open.
      ///
      /// Initial: [DropdownButtonProps.initiallyOpen]
      bool isOpen;
    }

    DropdownButtonComponent
        extends UiStatefulComponent2<DropdownButtonProps, DropdownButtonState> {
      @override
      get defaultProps => (newProps()
        ..isDisabled = false
        ..initiallyOpen = false
      );

      @override
      get initialState => (newState()
        ..isOpen = props.initiallyOpen
      );
    }
    ```

  _Bad:_
    ```dart
    mixin DropdownButtonProps on UiProps {
      bool isDisabled;
      bool initiallyOpen;
    }

    mixin DropdownButtonState on UiState {
      bool isOpen;
    }

    DropdownButtonComponent
        extends UiStatefulComponent2<DropdownButtonProps, DropdownButtonState> {
      // Confusing stuff is gonna happen in here with
      // bool props that could be null.
    }
    ```

&nbsp;

* __AVOID__ adding `props` or `state` fields that don't have
an informative comment.

  _Good:_
    ```dart
    mixin DropdownButtonProps on UiProps {
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

    mixin DropdownButtonState on UiState {
      /// Whether the [DropdownButton]'s child [DropdownMenu] is open.
      ///
      /// Initial: [DropdownButtonProps.initiallyOpen]
      bool isOpen;
    }
    ```

  _Bad:_
    ```dart
    mixin DropdownButtonProps on UiProps {
      bool isDisabled;
      bool initiallyOpen;
    }

    mixin DropdownButtonState on UiState {
      bool isOpen;
    }
    ```

&nbsp;

#### Ignore Ungenerated Warnings Project-Wide

To avoid having to add `// ignore: uri_has_not_been_generated` to each 
component library on the part/import that references generated code, 
ignore this warning globally within analysis_options.yaml:

```yaml
 analyzer:
   errors:
     uri_has_not_been_generated: ignore 
```

Alternatively, `include` [workiva_analysis_options](https://github.com/Workiva/workiva_analysis_options)
which ignores this warning by default.

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

[contributing-docs]: https://github.com/Workiva/over_react/blob/master/CONTRIBUTING.md
[builder]: https://github.com/Workiva/over_react/blob/master/lib/src/builder/README.md
[annotations]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/annotations.dart
[annotation]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/annotations.dart
[component_base.dart]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/component_base.dart

[react-dart]: https://github.com/cleandart/react-dart
[react-js]: https://github.com/facebook/react
[react-js-tutorial]: https://facebook.github.io/react/docs/getting-started.html

[react.component]: https://www.dartdocs.org/documentation/react/latest/react/Component-class.html

[new-issue]: https://github.com/Workiva/over_react/issues/new
