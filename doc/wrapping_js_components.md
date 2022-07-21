# Wrapping JS Components

- **[Intro](#intro)**
- **[Theoretical Explanation](#theoretical-explanation)**
  - [Dart Level](#level-3-the-dart-level)
  - [Interop Level](#level-2-interop-level)
  - [JS Level](#level-1-javascript-land)
- **[Implementation](#implementation)**
  - [Adding Directives](#adding-directives)
  - [Adding the JS Variable](#adding-the-js-variable)
    - [Creating the Getter](#creating-the-getter)
    - [Creating the Annotation](#creating-the-annotation)
  - [Adding Prop Typings](#adding-prop-typings)
    - [Manually Processing Prop Data](#manually-processing-prop-data)
    - [Props Conversion Tables](#props-conversion-tables)
      - [Standard Types](#standard-types)
      - [Exotic Types](#exotic-types)
      - [Supplemental Explanations](#supplemental-explanations)
        - [Converting Maps](#converting-maps)
        - [Converting Refs](#converting-refs)
        - [Converting Conflicting Function Props](#converting-conflicting-function-props)
      - [Props Conversion Example](#props-conversion-example)
  - [Using uiJsComponent](#using-uijscomponent)
  - [Testing Your Dart Component](#testing-your-dart-component)
    - [Test to Verify Component Mount](#test-to-verify-component-mount)
    - [Testing Function Props](#testing-function-props)
- **[Conclusion](#conclusion)**

## Intro

The JavaScript community is full of great open source libraries that export React components. These JavaScript components can be consumed in Dart by using JS interop to wrap the component and expose a Dart API for it. This process ultimately looks like writing a new Dart OverReact component, with the exception that the Dart component is linked to a JS implementation instead of a Dart one.

This guide as a whole walks through how to do that linking process and helps make developers aware of the pitfalls that can cause trouble. This section in particular includes a high level description of that whole process. Future sections dive deeper into each step to explain why steps happen as they do or explain things to watch out for.

```dart
@JS() /* [1] */
library some_library.path.to.component;

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';

part 'arbitrary_component.over_react.g.dart'; /* [2] */

/* [3] */ UiFactory<ArbitraryComponentProps> ArbitraryComponent = uiJsComponent(
  ReactJsComponentFactoryProxy(_jsArbitraryComponent), /* [4] */
  _$ArbitraryComponentConfig, // ignore: undefined_identifier
);

@Props(keyNamespace: '') /* [5] */
mixin ArbitraryComponentProps on UiProps {
  String aProp; /* [6] */
 }

@JS('MagicalJsPackage.ArbitraryComponent') /* [7] */
external ReactClass get _jsArbitraryComponent; /* [8] */
```

Below are more detailed explanations of each part of the code. These points are ordered from top to bottom and are not necessarily in the order it makes sense to write the actual code. Each of these points correlates to a more thorough section later in the guide.

1. Add the `JS()` annotation and a library directive. Because this is a file implementing JS interop, it is necessary to use the `JS()` annotation. When using a `JS()` annotation, it is also necessary to have a library directive. The actual library name is not important as far as the wrapping and interop go, but it should be unique to the file.
1. Add the `part` directive. Just like any other OverReact component, the file needs to have a `part` that matches the file's name. Nothing special needs to be done here as far as wrapping the JS component goes.
1. Invoke `uiJsComponent`. Note that the left hand side of the declaration looks exactly like a standard, all-Dart functional component declaration. However, on the right hand side, instead of using `uiFunction`, the API being use is `uiJsComponent`.
1. Wrap the JS interop variable with `ReactJsComponentFactoryProxy`. The JS variable (`_jsArbitraryComponent` in this case) is defined below. `ReactJsComponentFactoryProxy` is a wrapper that understands how to create a React element (in Dart) from the JS component.
1. Set the prop's namespace to be empty. JS components do not have a key namespace like OverReact components do. Therefore, in order to set props as expected using Dart, there should be no namespace.
1. Add types for the props. In the cases where types map one-to-one from JS to Dart, this is really straightforward. There are more challenging cases to watch out for, though. For more information, see the [Adding Prop Typings](#adding-prop-typings) section.
1. Annotate the JS variable. This annotation should match the component's name on the JS side, including any namespacing that's happening on the JS side.

   For example, in this case, the component comes from a library called `MagicalJsPackage`. The component's name is `ArbitraryComponent`, and in the JS world, could be used in JSX like:

   ```jsx
   <ArbitraryComponent />
   ```

   Together, that means that the reference needs to be `MagicalJsPackage.ArbitraryComponent`. If this is not done correctly, a runtime error will fire. Depending on the JS package setup, this could be one of the more complicated steps. For more information, see the [Adding a JS Variable](#adding-the-js-variable) section.

1. Create the JS variable. This step is very straightforward, with elaboration only necessary to note that the name of the variable can be anything. Our norm is `js{ComponentName}` to both tie it to and contrast it from the Dart `UiFactory`, but as far as Dart interop goes, the name isn't significant.

> **REMINDER** that these steps are just a _high level_ view of the process. Even if it feels like everything makes perfect sense, it is **highly** recommended to read the entirety of this guide to avoid insidious pitfalls and runtime errors.

## Theoretical Explanation

As a whole, this guide gives tangible steps to wrap a JS component. Those steps are important to make implementation clear, but they are the enactment of an underlying theory that deserves its own explanation.

Wrapping your JS component involves several levels of code working together. These are the same levels that OverReact uses to allow developers to use React in Dart. Because wrapping a JS component involves interaction with the lower levels, it's helpful to have a mental model for what those levels are and what they're doing.

### Level 3: the Dart level

We'll start at the top where you may be familiar with most of the concepts. The Dart level is all about using `OverReact`. OverReact is powered by the concept of a "props" instance. Props in OverReact, which are backed by the `UiProps` class, are ultimately the API used to create UI. To create new instances of your props class, a `UiFactory` is invoked.

Once you invoke a `UiFactory`, you have a props instance. For example, take the component created in the [Intro](#intro). Invoking the `UiFactory` would look like:

```dart
final propsInstance = ArbitraryComponent();
```

Now `propsInstance` can be used to customize the element's props or to _build_ the `ReactElement`. To "build" the element is to get the `ReactElement` for the specific props instance. React can use that `ReactElement` to add UI to the DOM. Building is done by invoking the props instance.

```dart
final ReactElement = propsInstance();
```

Usually, invoking the `UiFactory` and props instance are done in immediate succession.

```dart
return (
  ArbitraryComponent()()
);
```

This is important context because whether the component backing the `ReactElement` comes from Dart or JavaScript, it must have a `UiFactory` that can return a props instance capable of building a `ReactElement`. The API that enables this for JS components is `uiJsComponent`. `uiJsComponent` can take in a JavaScript component and give back a `UiFactory`.

### Level 2: Interop Level

[react-dart][react-dart] is responsible for the interop level, which connects Dart with JavaScript Land. Usually it's just an implementation detail of OverReact, but it comes to the surface in this process because the `uiJsComponent` relies on a react-dart API.

When `uiJsComponent` takes in the JS component, the JS component must be wrapped in a `ReactJsComponentFactoryProxy`. react-dart has multiple proxies that extend from a class called [ReactComponentFactoryProxy](https://github.com/Workiva/react-dart/blob/bcc05cd110e7a72b0161558581cd4d07c1c68d89/lib/react.dart#L1311). The proxy important here, `ReactJsComponentFactoryProxy`, exists specifically for interacting with JS components.

A proxy's job is to know how to convert Dart props to JS and create a JS `ReactElement`. Recall that for OverReact to work, a `UiFactory` must create a props instance that can _build a `ReactElement`_. This proxy is the piece that enables the _building of a `ReactElement`_.

Usually OverReact uses APIs that obfuscate the need to create a factory proxy, but in this process it is a manual step. However, all it means is that when you invoke `uiJsComponent`, you'll pass in a `ReactJsComponentFactoryProxy` that wraps a raw JS component.

```dart
UiFactory<ArbitraryComponentProps> ArbitraryComponent = uiJsComponent(
  ReactJsComponentFactoryProxy(_jsArbitraryComponent),
  _$ArbitraryComponentConfig,
);
```

### Level 1: JavaScript Land

To use `ReactJsComponentFactoryProxy` to wrap a JS component though, you need to be able to access your JS component in Dart. You will do this by using JS interop APIs to create a Dart getter that references the JS implementation.

```dart
@JS('MagicalJsPackage.ArbitraryComponent')
external ReactClass get _jsArbitraryComponent;
```

That getter can then be used whenever it's necessary to reference the raw JS component, such as when instantiating `ReactJsComponentFactoryProxy`.

In order for that getter to be valid though, it must be pointing to tangible JavaScript somewhere. The interop APIs look for that JavaScript as a property of the `Window` object. In order to add the JavaScript to the `Window`, you must:

1. Have a JavaScript bundle. This bundle should wrap its contents in a namespace (like it's package name) and export the JS component.
1. Attach the bundle to the html page loading the application, similar to how [React is added][react-script].

If you are wrapping a JS library without any customizations, it's likely the bundle already exists as a [UMD module](https://jameshfisher.com/2020/10/04/what-are-umd-modules/). If you need to write your own JS or make customizations, it's necessary to create your own bundle. If you have any questions around bundling, let us know in [Slack][slack]!

### Conclusion

This section gave a high level view of how wrapping a JS component works in theory. You must wrap the JS component in such a way that it follows OverReact's pattern of using `UiFactory` to create a props instance capable of building a `ReactElement`. This is possible with `uiJsComponent`, which takes in a `ReactJsComponentFactoryProxy` that points to a raw JS component attached to the `Window`.

The rest of this guide will reference this same concepts as it implements the code step-by-step.

### Implementation

The `ReactJsComponentFactoryProxy` is a wrapper for the JS component that understands how to create, within Dart, a React element from the JS component. As far as what's necessary to know for wrapping JS components, that's it. The syntax is basically boilerplate that can be copy and pasted from component to component, just changing the JS variable to match the new component.

That being said, for those wanting some deeper context, `ReactJsComponentFactoryProxy` is the tip of a larger iceberg. When instantiating `ReactJsComponentFactoryProxy`, you may notice some optional parameters on the constructor. Those parameters are used to effect how the component handles certain interop cases for the component. They exist because `ReactJsComponentFactoryProxy` is used under the hood in several different contexts (like powering `uiForwardRef`), some of which require unique behaviors when it comes to interop.

It is unlikely that you will hit scenarios where settings these parameters is necessary, and therefore, it is generally discouraged to change them away from the default. If the wrapped component is not behaving as expected, reach out to us on [Slack][slack] so we can help!

### Adding Directives

The important directives for this process are:

1. The JS annotation and a library directive
1. Imports
1. Part directive

Altogether they look like:

```dart
@JS()
library some_library.path.to.component;

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';

part 'some_js_component.over_react.g.dart';
```

Imports are standard (the `js.dart` import provides the `JS()` annotation), and the `part` is the same as you would expect in any OverReact component.

Something that may be new is the usage of the `JS()` annotation. This is necessary in files performing interop operations and therefore is required in this file. A library directive is also required here because the `JS()` annotation must be attached to a library. The name of the library can be anything, with the main limitation being that it should be unique to the file.

### Adding the JS Variable

To a Dart API, a Dart component must wrap the JS version. This means that the JS version must be accessible in Dart. The way to do that is to use interop to create a reference to the JS API. That looks like:

```dart
@JS('MagicalJsPackage.ArbitraryComponent')
external ReactClass get _jsArbitraryComponent;
```

There are two pieces here. The first piece is creating a getter and the second is adding an annotation.

#### Creating the Getter

Creating the getter is very simple. The code here can basically be copied and pasted from the code found in this doc, just changing the name of the getter to be something more specific than `_jsArbitraryComponent`. However, the name can really be anything. We have the norm of using `_js{ComponentName}` because:

- It's private, which is preferred because the use case for the JS variable itself is limited
- It makes it clear it's the _JS_ version of the component, while also including the component's name and thereby coupling it with the Dart API

You may wonder why the name doesn't need to match the name of the JS component. For example, a component named `ArbitraryComponent` can have a Dart interop getter called `foofoocuddlypoops`. This is possible because the actual link between Dart and JS is created [with the annotation](#creating-the-annotation).

#### Creating the Annotation

The annotation is how Dart knows what JS API needs to be linked to the Dart getter. In other words, if you do:

```dart
@JS('ArbitraryComponent')
```

Dart will expect to find a property on the `Window`, in the browser, called `ArbitraryComponent`. Future references to the Dart getter will be linked directly to that JS property on the window. This can get complicated because the exact name of the API will likely include the name of the library and any namespacing on the JS side. Ultimately, it depends on how the JavaScript is bundled and how the API is exported from that bundle.

For example, imagine our package is called `MagicalJsPackage`. The bundle for the package is namespaced by the package name, and therefore when it's attached to the page, its members are nested within the namespace. We want to access the component `ArbitraryComponent`. Putting it all together, we'd expect the annotation to be:

```dart
@JS('MagicalJsPackage.ArbitraryComponent')
```

> Reminder: The JavaScript bundle for the JS must be added to the HTML page as a script, [similar to how React is added][react-script], or else this interop step will always fail at runtime.

To check that the correct name is, you can use the browser devtools to attempt to access the property on the `Window`. If the property is valid and generally where you expect it to be then it's likely correct.

<img src='./images/ui_js_component/interop_ref.gif' alt='Accessing the property in the devtools' />

If the annotation does not have the correct name, rendering the component will fail with a runtime error that looks like:

<img src='./images/ui_js_component/interop_reference_error.png' alt='Accessing the property in the devtools' />

> **NOTE** if after correctly creating the annotation, you find that it does not have a library prefix and only requires the component name (i.e. `JS('ArbitraryComponent')` and not something like `JS('MagicalJsPackage.ArbitraryComponent')`), you should **heavily** consider configuring your bundle to have at least a package namespace (i.e. the 'MagicalJsPackage' prefix). Attaching components to the global namespace both pollutes that namespace as well as risks naming collisions.

### Adding Prop Typings

The last step is creating a props mixin for the component. In its simplest form, this props mixin is purely to add type safety when using the component in Dart. In other words, in simple cases, you're just adding a property to the props mixin that lines up with a prop on the JS side, and [react-dart][react-dart] will handle converting that data from Dart to JavaScript.

However, there are special cases that require processing the data more manually. These are cases that can cause runtime errors if not handled correctly.

#### Manually Processing Prop Data

While most Dart and JS types get converted nicely by [react-dart][react-dart]'s interop handling, some cases require manual intervention in order to be handled correctly. These cases are:

- Any JS type that translates to a Dart `Map` type
- React `ref` types

Props with those types require special utilities (such as `jsifyMapProp`) in order to behave correctly. These utilities were built, and have [exhaustive test coverage](https://github.com/Workiva/over_react/blob/master/test/over_react/util/prop_conversion_test.dart), to be sure that the data is handled precisely. While these circumstances are documented further in the [Supplemental Explanations section](#supplemental-explanations), it bears repeating that props with these types should be watched for and handled carefully.

#### Props Conversion Tables

These are tables that helps illustrate the typing of a prop in TypeScript and Dart. If the library you're wrapping does not have explicit types in TypeScript for the components, it may have `PropTypes` that are fairly similar. If no types are available, erroring on the safe side is best as Dart can throw runtime errors if the type is incorrect. Some conversions are explained further in the [Supplemental Explanations section](#supplemental-explanations).

> **NOTE** that these tables are not exhaustive. They cover the major types that are likely to come up but don't include every type and variation that TS allows.

##### Standard Types

| TypeScript                   | Dart                        | Notes                                                                                                                                                                                      |
| ---------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `number`                     | `num`                       |                                                                                                                                                                                            |
| `string`                     | `String`                    |                                                                                                                                                                                            |
| `boolean`                    | `bool`                      |                                                                                                                                                                                            |
| `Array<T>` or `T[]`          | `List<T>`                   | For example, `Array<string>` and `string[]` would both translate to `List<String>`.                                                                                                        |
| `unknown`                    | `dynamic`                   |                                                                                                                                                                                            |
| `any`                        | `dynamic`                   |                                                                                                                                                                                            |
| `null`                       | `null`                      |                                                                                                                                                                                            |
| `undefined`                  | `null`                      |                                                                                                                                                                                            |
| `void`                       | `void`                      |                                                                                                                                                                                            |
| any union of different types | `dynamic`                   | The exception is if the union is something like `null \| boolean`. TS is non-nullable by default, so they must specify `null`, whereas interop will work fine just typing it as `boolean`. |
| union of `T` literals        | T                           | For example, a union like `'foo' \| 'bar' \| 'baz'` is a union of all strings. In that case, the prop type would be `String`.                                                              |
| `(foo: string) => boolean`   | `bool Function(String foo)` |                                                                                                                                                                                            |

##### Exotic Types

Some TS types are complex, either mapping directly to an existing React type or requiring more intricate getters and setters.

| TypeScript                                                              | TypeScript Example                                                                                                | Dart                                                             | Dart Example                                                                                                            |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `React.ReactElement`                                                    | [MUI Chip's avatar][example_ts_reactelement]                                                                      | `ReactElement`                                                   | [RMUI Chip's avatar][example_dart_reactelement]                                                                         |
| `React.ReactNode`                                                       | [MUI Chip's label][example_ts_reactnode]                                                                          | dynamic                                                          | [RMUI Chip's label][example_dart_reactnode]                                                                             |
| anything that translates to a Dart `Map` (`interfaces`, `objects`, etc) | [MUI Autocomplete's ChipProps][example_ts_interface], [MUI Autocomplete's componentsProps][example_ts_anonobject] | See examples and the [Converting Maps section](#converting-maps) | [RMUI Autocomplete's ChipProps][example_dart_interface], [RMUI Autocomplete's componentsProps][example_dart_anonobject] |
| refs (`React.ForwardedRef`, `React.RefObject`, `React.Ref`)             | [MUI TextField inputRef][example_ts_ref]                                                                          | See example and the [Converting Refs section](#converting-refs)  | [RMUI TextField inputRef][example_dart_ref]                                                                             |

##### Supplemental Explanations

Some of the conversations above require additional explanation to clarify why the conversion looks the way it does.

###### Converting Maps

Props are commonly typed as something that's shaped like a Dart `Map`. Anything with keys and values fall into that category, which in TS, can be things that looks like:

```ts
// Each prop here is a different form of an object type
interface ArbitraryComponentProps {
  aDifferenceInterface: AnotherInterface;
  aType: AnotherType;
  anonObjectType: {
    propA: string;
    propB: string;
  };
}

interface AnotherInterface {
  propA: string;
}

type AnotherType = {
  propA: string;
};
```

JavaScript `object`s and Dart `Map`s do not convert automatically like primitives do. In order to allow the data to be passed from Dart to JavaScript, interop utilities must be used. Converting any one of those map props looks like:

```dart
@Props(keyNamespace: '')
mixin ArbitraryComponentProps on UiProps {
  Map get aMapProp => unjsifyMapProp(_aMapProp$rawJs);

  set aMapProp(Map value) => _aMapProp$rawJs = jsifyMapProp(value);

  @Accessor(key: 'aMapProp')
  JsMap _aMapProp$rawJs;
}
```

The steps are:

1. Create a `JsMap` property that will represent the raw JS data for the component. This is necessary because the raw JS is not in a consumable form and should not be accessed directly.
1. Add an `@Accessor` annotation to the property with a key that matches the prop name. This will link the `JsMap` property to the JS prop.
1. Add `Map` getters and setters named the same as the prop.
   - The getter should use `unjsifyMapProp` to convert the JS property to a Dart `Map`
   - The setter should use `jsifyMapProp` to convert the Dart `Map` to JS.

###### Converting Refs

If you read [Converting Maps](#converting-maps), this section will be very similar (just with different interop utilities). Say you have props that look like:

```ts
interface ArbitraryComponentProps {
  aRef: React.Ref<any>;
  anotherRef: React.RefObject<any>;
  aForwardedRef: React.ForwardedRef<any>;
}
```

Refs are special JS object types that need to be converted to and from Dart using interop utilities. Converting any one of those ref types looks like:

```dart
@Props(keyNamespace: '')
mixin ArbitraryComponentProps on UiProps {
  dynamic get someRef => unjsifyRefProp(_someRef$rawJs);

  set someRef(dynamic value) => _someRef$rawJs = jsifyRefProp(value);

  @Accessor(key: 'someRef')
  dynamic _someRef$rawJs;
}
```

The steps are:

1. Create a `dynamic` property that will represent the raw JS ref property for the component. This is necessary because the raw JS is not in a consumable form and should not be accessed directly.
1. Add an `@Accessor` annotation to the property with a key that matches the prop name. This will link the Dart ref property to the JS prop.
1. Add ref getters and setters named the same as the prop.
   - The getter should use `unjsifyRefProp` to convert the JS property to a Dart `Map`
   - The setter should use `jsifyRefProp` to convert the Dart map to JS.

###### Converting Conflicting Function Props

Some function props may conflict with the `UbiquitousDomPropsMixin`. This will happen if:

1. The component specifies a function that is typically reserved for `UbiquitousDomPropsMixin`. These are typically fundamental event handlers on HTML elements, such as `onClick`, `onChange`, etc.
1. The prop's function signature is not the same as the version on `UbiquitousDomPropsMixin`. This typically takes the form of adding extra parameters that the standard event handlers do not have.

This causes problems in Dart because if the type of the function signature does not match what Dart expects, it will throw a runtime error. Here's what that could look like in TS:

```ts
interface ArbitraryComponentProps {
  // note that the `id` parameter isn't usually part of the `onClick` handler signature
  onClick: (e: React.MouseEvent, id: string) => void;
}
```

In Dart, to work around that, you would do something like:

```dart
@Props(keyNamespace: '')
mixin ArbitraryComponentProps on UiProps {
  @Accessor(key: 'onClick')
  void Function(SyntheticMouseEvent event, String id) onClick_ArbitraryComponent;

  @Deprecated('Use onClick_ArbitraryComponent for proper typing')
  @override
  get onClick;

  @Deprecated('Use onClick_ArbitraryComponent for proper typing')
  @override
  set onClick(value);
}
```

The steps are:

1. Add overridden getters and setters for the prop. Overriding is necessary because `UiProps` already contributes the property.
1. Deprecate those getters and setters. This isn't necessary to avoid runtime errors, but it's an important step because those properties should not be accessed by devs.
1. Add a new property that has the correct type for the function. We recommend using the original prop name and adding a namespace suffix (i.e. `onClick` becomes `onClick_ArbitraryComponent`). That way, even though the property can't be the same name as the original prop itself (i.e. `onClick`), it allows developers to begin typing the name of the original prop and use autocomplete from there.
1. Add an `Accessor()` annotation with a key matching the name of the original prop. This links the namespaced prop to the JS property it is replacing.

#### Props Conversion Example

Say you are given a props interface (or type) that looks like:

```ts
interface ArbitraryComponentProps {
  childRef: React.Ref<any>;
  content: string;
  onClick: (e: React.MouseEvent, id: string) => void;
  size: 2 | 4 | 6 | 8;
}
```

In Dart, that would look like:

```dart
@Props(keyNamespace: '')
mixin ArbitraryComponentProps on UiProps {
  // START REF PROP
  dynamic get childRef => unjsifyRefProp(_childRef$rawJs);

  set childRef(dynamic value) => _childRef$rawJs = jsifyRefProp(value);

  @Accessor(key: 'childRef')
  dynamic _childRef$rawJs;
  // END REF PROP

  String content;

  // START ONCLICK
  @Accessor(key: 'onClick')
  void Function(SyntheticMouseEvent event, String id) onClick_ArbitraryComponent;

  @Deprecated('Use onClick_ArbitraryComponent for proper typing')
  @override
  get onClick;

  @Deprecated('Use onClick_ArbitraryComponent for proper typing')
  @override
  set onClick(value);
  // END ONCLICK

  num size;
}
```

### Using `uiJsComponent`

`uiJsComponent` is used to create the Dart `UiFactory` attached to the JS component. In other words, after using `uiJsComponent`, you will have a Dart `UiFactory` that can be used like a factory that was written entirely in Dart. Invoking `uiJsComponent` itself is actually one of the simplest parts of the wrapping process and is ultimately the culmination of other steps. However, because it's the heart of the everything, we wanted to introduce it early as the cornerstone that will tie upcoming sections together. If you want to walk through this guide step by step though, then adding the code from this section should be the last block to be added in the component file.

Invoking the API looks like:

```dart
UiFactory<ArbitraryComponentProps> ArbitraryComponent = uiJsComponent(
  ReactJsComponentFactoryProxy(_jsArbitraryComponent),
  _$ArbitraryComponentConfig, // ignore: undefined_identifier
);
```

Areas of similarity between this and a functional component declaration are:

1. The typing on the left hand side of the declaration is created the same way (`UiFactory<ArbitraryComponentProps>`)
1. A generated config (`_$ArbitraryComponentConfig` here) is necessary and ignored by the analyzer

The differences are:

1. The correct API is `uiJsComponent` instead of `uiFunction`
1. `ReactJsComponentFactoryProxy(_jsArbitraryComponent)` is passed in instead of a function

The most notable difference is number 2. `_jsArbitraryComponent` is a JS interop variable created to reference the JS component itself. That JS variable is something we'll dive deeper into in the [Adding the JS Variable section](#adding-the-js-variable).

### Testing Your Dart Component

Now that you have a fully-fledged Dart wrapper for your JS component, you'll want to add some tests! Hopefully the library exporting the JS component has adequate tests for the actual functionality, so the tests to be added on the Dart side are those that exercise the interop. We highly recommend two different tests:

1. A test to verify the component mounts without errors
1. Tests for any function props

More test cases may be necessary, or simply preferred, but those should be considered the baseline to start from.

#### Test to Verify Component Mount

This is largely a sanity check to be sure interop is working as expected. It's ultimately verifying that:

- the JS component is found on the window. See the [Creating the Annotation section](#creating-the-annotation) for more information
- the Dart component can build (i.e. no boilerplate errors)
- any default logic the component runs on mount is compatible with the Dart interop

This test may look something like:

```dart
test('ArbitraryComponent renders without error', () {
  final errors = [];
  rtl.render(
    (ErrorBoundary()
      ..onComponentDidCatch = (error, _) {
        errors.add(error);
      }
    )(
      ArbitraryComponent()(),
    ),
    wrapper: StrictMode,
  );
  expect(errors, isEmpty);
});
```

The breakdown of this test is:

1. Wrap the component in a basic error boundary that will catch potential errors
   - Be sure to use the `StrictMode` component to catch errors that will only show in that context
1. Render the component
1. Verify the list of errors is empty

#### Testing Function Props

Function props can be deceptively tricky to wrap correctly. Fundamentally it's important to check that all the parameters can get converted from Dart to JS as expected, but explicitly testing it via UI interactions also ensures that the JS component invokes it as expected. JavaScript is not strict on the arity of functions. A JS package may advertise that a function has a specific type but then actually invoke it with parameters that Dart does not expect. This will cause a runtime error in Dart.

To guard against that, it is recommended to write a test for every function prop that was wrapped. One of these tests may look like:

```dart
test('onClick', () {
  final events = [];
  final view = rtl.render(
    (Button()..onClick = (e) => events.add(e))(),
    wrapper: StrictMode,
  );
  UserEvent.click(view.getByRole('button'));
  expect(events, [isA<SyntheticMouseEvent>()]);
});
```

This test is:

1. Rendering the component in a strict mode wrapper
1. Clicking the component
1. Checking that an event of the specific type was fired

Most function prop tests can be that simple because typically the most important thing is just that the function fires as expected without dismounting the React tree.

### Conclusion

Hopefully wrapping your JS component goes smoothly! However, even simple components can have highly unique situations that cause challenges. If you encounter any of those challenges, please reach out to us in [Slack][slack]!

[slack]: https://workiva.slack.com/archives/CEFTMBPAA
[example_ts_reactelement]: https://github.com/mui/material-ui/blob/d73fadbb12cc48a981a39d4ccaeacd8021ab9efa/packages/mui-material/src/Chip/Chip.d.ts#L19
[example_dart_reactelement]: https://github.com/Workiva/react_material_ui/blob/4fc41fe8393b424beac513ec99a98be5f09bd1ab/lib/src/components/custom/wsd/chip/chip.dart#L36
[example_ts_reactnode]: https://github.com/mui/material-ui/blob/d73fadbb12cc48a981a39d4ccaeacd8021ab9efa/packages/mui-material/src/Chip/Chip.d.ts#L64
[example_dart_reactnode]: https://github.com/Workiva/react_material_ui/blob/4fc41fe8393b424beac513ec99a98be5f09bd1ab/lib/src/components/custom/wsd/chip/chip.dart#L69
[example_ts_interface]: https://github.com/mui/material-ui/blob/d73fadbb12cc48a981a39d4ccaeacd8021ab9efa/packages/mui-material/src/Autocomplete/Autocomplete.d.ts#L92
[example_ts_anonobject]: https://github.com/mui/material-ui/blob/d73fadbb12cc48a981a39d4ccaeacd8021ab9efa/packages/mui-material/src/Autocomplete/Autocomplete.d.ts#L120-L125
[example_dart_interface]: https://github.com/Workiva/react_material_ui/blob/4fc41fe8393b424beac513ec99a98be5f09bd1ab/lib/src/components/mui_material/autocomplete/autocomplete.dart#L75-L83
[example_dart_anonobject]: https://github.com/Workiva/react_material_ui/blob/4fc41fe8393b424beac513ec99a98be5f09bd1ab/lib/src/components/mui_material/autocomplete/autocomplete.dart#L120-L132
[example_ts_ref]: https://github.com/mui/material-ui/blob/d73fadbb12cc48a981a39d4ccaeacd8021ab9efa/packages/mui-material/src/TextField/TextField.d.ts#L98
[example_dart_ref]: https://github.com/Workiva/react_material_ui/blob/4fc41fe8393b424beac513ec99a98be5f09bd1ab/lib/src/components/custom/wsd/text_field/text_field.dart#L175-L187
[react-dart]: https://github.com/Workiva/react-dart
[react-script]: https://github.com/Workiva/over_react/blob/82cacd3c12ab99b7a6fd9ddb0698a0cc844aa8a8/example/builder/index.html#L36-L37
