# Null safety and required props

<!-- TOC -->
* [Null safety and required props](#null-safety-and-required-props)
    * [Introduction](#introduction)
      * [Required prop syntax - quick reference](#required-prop-syntax---quick-reference)
  * [Required prop validation](#required-prop-validation)
    * [Exception: defaulted class component props](#exception-defaulted-class-component-props)
    * [Disabling required prop validation for certain props](#disabling-required-prop-validation-for-certain-props)
      * [Disabling validation use-case: wrapper components](#disabling-validation-use-case-wrapper-components)
      * [Disabling validation use-case: cloned props](#disabling-validation-use-case-cloned-props)
  * [Prop defaulting](#prop-defaulting)
    * [Defaulting non-nullable props: class components](#defaulting-non-nullable-props-class-components)
    * [Defaulting nullable props using `??`](#defaulting-nullable-props-using-)
  * [Unsafe required prop reads](#unsafe-required-prop-reads)
<!-- TOC -->


### Introduction

fixme organize intro vs more detailed sections?

> [!WARNING]
> When rendering components with required props, make sure you're getting [required prop validation](#required-prop-validation), by either:
> - Enabling the [analyzer plugin][analyzer-plugin] during development, if possible
> - Running tests with asserts enabled (e.g., using DDC) to help catch missing required props

> [!WARNING]
> Just like any `late` variable, reading required props when they're not guaranteed to be present can lead to errors and bad behavior.
> 
> Required props are only validated to be present on props a component was rendered with, and not on other props objects.
> 
> To safely read required props, see more info [here](#unsafe-required-prop-reads). We also recommend enabling the [analyzer plugin][analyzer-plugin] during development, if possible, which lints for unsafe prop accesses.

Starting in over_react 5.0.0, you can declare non-nullable required props, using the `late` keyword. 

Throughout the documentation, we refer to these as "late required props" or just "required props".

As an example, take the following TypeScript code that declares a required `user` prop and an optional `isSelected` prop.

```ts
interface UserChipProps {
  user: User;
  isSelected?: boolean;
}
```

In OverReact, we'd declare those props like so:

```dart
mixin UserChipProps on UiProps {
  late User user;
  bool? isSelected;
}
```

The `user` prop is non-nullable (typed as `User` and not `User?`), and OverReact interprets the `late` keyword as "required".

The `isSelected` prop is nullable, and is considered optional because it doesn't have `late`.

Similar to other [late variables](https://dart.dev/language/variables#late-variables) in Dart, `late` required props must be assigned before they're accessed, or they'll throw. To help guard against these issues, OverReact validates that all required props are set before rendering a component, similar to how all ['required' parameters](https://dart.dev/language/functions#named-parameters)  must be provided when calling a function. More on that in [Required prop validation](#required-prop-validation).

FIXME mention unsafe required prop reads, tie into warnings.

#### Required prop syntax - quick reference

| Requiredness | Nullability              | OverReact           | Typescript                             | 
|--------------|--------------------------|---------------------|----------------------------------------|
| Required     | Non-nullable             | `late String foo;`  | <code>foo: string;</code>              |
| Required     | Nullable                 | `late String? foo;` | <code>foo: string &#124; null;</code>  |
| Optional     | Non-nullable<sup>1</sup> | _Not supported_     | <code>foo?: string;</code>             |
| Optional     | Nullable                 | `String? foo;`      | <code>foo?: string &#124; null;</code> |

_1. While you can't explicitly set a nullable value, `props.foo` is still `undefined` (`null` in Dart) if not specified_

## Required prop validation

To avoid null errors, required props must always be specified when rendering a component.

over_react provides two mechanisms to help enforce that:
1. Runtime checks using [assert](https://dart.dev/language/error-handling#assert)s (enabled by default in DDC, and available in dart2js with `--enable-asserts`)
1. Static [analyzer plugin][analyzer-plugin] lints (note: the analyzer plugin is opt-in)


Taking our example from above:
```dart
mixin UserChipProps on UiProps {
  late User user;
  bool? isSelected;
}

UiFactory<UserChip> UserChip = uiFunction((props) {
  // ...
}, _$UserChipConfig);
```

Whenever we render `UserChip`, we must always provide the required `user` prop.
```dart
(UserChip()..user = user)()
```

If we don't, we'll get a static warning from the analyzer plugin (if we have it enabled):
```dart
   UserChip()()
// ^^^^^^^^^^
// warning: Missing required late prop 'required1' from 'WithLateRequiredProps'.
// (over_react_late_required_prop)
```

and that code will also throw a runtime error when `assert`s are enabled:
```
Uncaught Error: RequiredPropsError: Required prop `requiredProp` is missing.
   at Object.throw_ [as throw]
   at _$$UserChipProps$JsMap.new.validateRequiredProps
```

### Exception: defaulted class component props

One case where consumers of a component don't need to set required props is when they're defaulted directly within a class component's `defaultProps`. 

Those defaulted props are automatically opted out of required prop validation by the over_react builder and analyzer plugin.

This allows consumers to declare defaulted props as non-nullable in a way that's safe and convenient, preventing the need for more invasive refactors to how defaulted props work when migrating to null safety.

For more information on what this looks like, see: [Defaulting non-nullable props: class components](#defaulting-non-nullable-props-class-components)

This mechanism does not apply to function components, which use a different prop defaulting mechanism in over_react. See [Prop defaulting](#prop-defaulting) for more info.

### Disabling required prop validation for certain props

Sometimes, you want to declare a prop as non-nullable and required, but not enforce that consumers explicitly set it.

There are two ways to opt out of prop validation for certain props, targeted toward to main use-cases:
- [wrapper components](#disabling-validation-use-case-wrapper-components)
- [cloned props](#disabling-validation-use-case-cloned-props)

#### Disabling validation use-case: wrapper components

Sometimes, a component wraps another component and mixes in its props, but sets some or all of the required props internally.

For example:

```dart
mixin FooProps on UiProps {
  late String requiredPropAlwaysSetInWrapper;
  late String requiredPropNotSetInWrapper;
}

UiFactory<FooProps> Foo = uiFunction((props) {
  // ...
}, _$FooConfig);

mixin WrapperPropsMixin on FooProps {}
class WrapperProps = UiProps with FooProps, WrapperPropsMixin;

UiFactory<WrapperProps> Wrapper = uiForwardRef((props, ref) {
  return (Foo()
    ..requiredPropAlwaysSetInWrapper = 'foo'
    ..addProps(props.getPropsToForward(exclude: {WrapperPropsMixin}))
    ..ref = ref
  )();
}, _$WrapperConfig);
```

In the above case, the `Wrapper` component renders a `Foo` component, and sets a required prop `requiredPropAlwaysSetInWrapper`.

But, if we go to render `Wrapper`, the analyzer plugin and runtime validation will complain if we're missing `requiredPropAlwaysSetInWrapper`, since it's a required prop that's mixed into `WrapperProps`, even though we don't need to set it.

```dart
// Error: missing required prop `requiredPropAlwaysSetInWrapper`.
(Wrapper()..requiredPropNotSetInWrapper = '')()
```


To work around this issue, we can use an annotation to indicate that certain props shouldn't be treated as required for the component associated with that specific props class.

```dart
@Props(disableRequiredPropValidation: {'requiredPropAlwaysSetInWrapper'})
class WrapperProps = UiProps with FooProps, WrapperPropsMixin;
```

```dart
// No more error!
(Wrapper()..requiredPropNotSetInWrapper = '')()
```

> [!WARNING] 
> As a result, these props are unsafe to access within that component's render.
> 
> See the [unsafe required prop reads](#unsafe-required-prop-reads) section for more info 


#### Disabling validation use-case: cloned props

Sometimes, you want to declare a prop that's always cloned onto it by a parent component. 

> [!INFO]
> React considers `cloneElement` an antipattern; see [their documentation](https://react.dev/reference/react/cloneElement) for alternatives.

For example:
```dart
mixin ChildPropsMixin on UiProps {
  late String alwaysSetByParent;
}

UiFactory<ChildPropsMixin> Child = uiFunction((props) {
  // ...
}, _$ChildConfig);

mixin ParentProps on UiProps {} 

UiFactory<ParentProps> Parent = uiFunction((props) {
  return props.children.mapIndexed((child, index) {
    return cloneElement(child, (Child()
      ..key = child.key ?? index
      ..alwaysSetByParent = 'some value'
    ));
  }
}. _$ParentConfig);
```

When rendering this component as-is, we'd get missing required prop errors:
```dart
Parent()(
  Child()(), // Error: missing required prop alwaysSetByParent
  Child()(), // Error: missing required prop alwaysSetByParent
)
```

In cases like this where it's not valid to render `Child` outside of a `Parent`, we can use an annotation to disable required prop validation for that prop: 

```dart
mixin ChildPropsMixin on UiProps {
  @disableRequiredPropValidation
  late String alwaysSetByParent;
}
```

```dart
Parent()( 
  // No errors now!
  Child()(),
  Child()(),
)
```

Unlike the `@Props` annotation described in [wrapper components](#disabling-validation-use-case-wrapper-components), 
this disables validation for that prop regardless of where those props are mixed in, and cannot be applied on a
component-by-component basis.

As a result, any wrapper components of `Child` would also benefit from that disabled validation.
```dart
class ChildWrapperProps = UiProps with ChildPropsMixin;

UiFactory<ChildWrapperProps> ChildWrapper = uiFunction((props) {
  return (Child()..addProps(props))()
}, _$ChildWrapperConfig);
```
```dart
Parent()( 
  // Still no errors:
  ChildWrapper()(),
  ChildWrapper()(),
)
```

## Prop defaulting

OverReact supports providing defaults for optional props in the following cases:

| Nullability  | Class Component | Function component | 
|--------------|-----------------|--------------------|
| Non-nullable | Yes<sup>1</sup> | No                 | 
| Nullable     | Yes             | Yes<sup>2</sup>    |

1. _Props are declared the same way required props are_
2. _Easiest when `null` is treated the same as the default_

### Defaulting non-nullable props: class components

In class components, any props defaulted directly in `defaultProps` are automatically opted out of required prop validation by the over_react builder and analyzer plugin.

For example, in the following component, even though `defaultedProp` is declared as `late` and non-nullable, it is not considered required because it has a default.
```dart
UiFactory<FooProps> Foo = castUiFactory(_$Foo);

mixin FooProps on UiProps {
  late bool defaultedProp;
  late String requiredProp;
}

class FooComponent extends UiComponent2<FooProps> {
  get defaultProps => (newProps()..defaultedProp = true);

  render() {}
}

example() => Fragment()(
  // Has static and runtime errors about missing `requiredProp`
  Foo()(), 
  // Has no errors.
  (Foo()..requiredProp = true)(),
);
```

### Defaulting nullable props using `??`

In over_react function components, prop defaulting for nullable props is typically implemented using null-aware `??` operators. As a result, unspecified props and explicit `null` values are treated the same.

For example,
```dart
mixin FooProps on UiProps {
  String? optional;
}

UiFactory<FooProps> Foo = uiFunction((props) {
  final optional = props.optional ?? 'default';
  return 'optional: $optional';
}, _$FooConfig);

example() => Fragment()(
  Foo()(),                     // Renders `optional: default`
  (Foo()..optional = null)(),  // Renders `optional: default`
  (Foo()..optional = 'bar')(), // Renders `optional: bar`
);
```

If you want specific behavior for explicit null, you can use the `containsProp` utility to detect that case:
```dart
mixin FooProps on UiProps {
  String? optional;
}

UiFactory<FooProps> Foo = uiFunction((props) {
  final optional = props.containsProp((p) => p.optional)
      ? props.optional 
      : 'default';
  
  return 'optional: $optional';
}, _$FooConfig);

example() => Fragment()(
  Foo()(),                     // Renders `optional: default`
  (Foo()..optional = null)(),  // Renders `optional: null`
  (Foo()..optional = 'bar')(), // Renders `optional: bar`
);
```


For example,
```dart
mixin FooProps {
  late String requiredNonNullable;
  late String? requiredNullable;
  String? optional;
}

UiFactory<FooProps> Foo = uiFunction((props) {
  final requiredNonNullable = props.requiredNonNullable;
  final requiredNullable = props.requiredNullable ?? 'default';
  final optional = props.optional ?? 'default';
}, _$FooConfig);
```

## Unsafe required prop reads

> [!IMPORTANT] 
> We recommend enabling the OverReact [analyzer plugin][analyzer-plugin] during development, if possible, which provides a lint to prevent unsafe prop reads.

Just like any `late` variable, accessing required props when they're not guaranteed to be set can lead to errors and bad behavior.

Required props are only validated to be present on props a component was rendered with (as discussed in the previous section), and not on other props objects.

For example, given props:
```dart
mixin FooProps {
  late int requiredProp;
}

example() {
  final props = Foo(); // Create an empty props object.
   
  // Throws because the map is empty, and the value `null`
  // is not an `int`.
  props.requiredProp;
}
```

Instead, use utility methods `getRequiredProp`, `getRequiredPropOrNull`, or `containsProp` checks to safely access the prop.

```dart
mixin BarProps {
  late String requiredProp1;
  late String requiredProp2;
  late String requiredProp3;
}

renderBar([Map? _additionalBarProps]) {
  final barProps = Bar({...?_additionalBarProps});
  
  // Safe access via `.getRequiredProp`
  final requiredProp1 = barProps.getRequiredProp((p) => p.requiredProp1),
      orElse: () => 'custom default');
      
  // Safe access via `.getRequiredPropOrNull`
  final requiredProp2Uppercase = barProps
      .getRequiredPropOrNull((p) => requiredProp2)
      ?.toUpperCase();
    
  // Safe access via if-check with `.containsProp`
  final otherPropsToAdd = Bar();
  if (barProps.containsProp((p) => p.requiredProp3)) {
    otherPropsToAdd.aria.label = barProps.requiredProp3;
  }
}
```

[analyzer-plugin]: ../tools/analyzer_plugin
