# OverReact Builder

[](#__START_EMBEDDED_README__)

OverReact components are declared using a set of "boilerplate" declarations which are 
picked up by the `over_react` builder.

This builder generates code, wiring up the different pieces of component 
declarations and creating typed getters/setters for props and state.

This allows boilerplate to be significantly reduced, making the code you write 
much cleaner and more _grokkable_.

> Check out some [component demos] to see the builder in action.

&nbsp;
&nbsp;

## Wiring it all up

__Be sure to familiarize yourself with the [OverReact library] first.__

The builder wires up your factory, props class, and component class so that you don't have to!


### The generation process

> All of this generation happens "under the hood", but you can see it in action for your 
own components by viewing the generated .over_react.g.dart file.

1. The builder parses files and looks for things to generate. Let's start with this component:

    ```dart
    UiFactory<FooProps> Foo = _$Foo; // undefined_identifier
    
    mixin FooProps on UiProps { 
      int foo;
    }
    
    class FooComponent extends UiComponent2<FooProps> {
      @override
      render() { 
        // ...
      }
    }
    ```

    In [parsing/members_from_ast.dart](parsing/members_from_ast.dart), the builder identifies for top-level declarations that could be part of a component declaration:
    - `UiFactory` variables
    - Mixins that are `on UiProps` and whose names end with `Props` or `PropsMixin` (same thing for state)
    - Classes that extend directly from `UiProps` and whose names end with `Props`
    - Classes whose names end with `Component`
    
    Then, in, [parsing/declarations_from_members.dart](parsing/declarations_from_members.dart), it uses the names of these declarations to group them together, and determines whether those groups are actually an over_react declaration that needs code generation (vs unrelated code that happens to look similar).
    
    In this case:
    1. The builder identifies the compilation unit members `Foo`, `FooProps`, `FooComponent`, which all look like pieces of over_react boilerplate.
    2. The builder sees that `FooProps` meets the requirements for declaring a props mixin, and thus  can confidently proceed with code generation for it.
        - Props mixins need code generation regardless of whether they're associated with a component, since they can be declared on their own.
    3. The builder starts with the factory, and looks for other members with matching names that it could use to create a complete group that forms a class component. It finds all the pieces it needs:
        - [x] a factory: ***Foo***
        - [x] either a props mixin or a concrete props class:  ***Foo***Props
        - [ ] either a state mixin or a concrete state class (optional)
        - [x] a component class: ***Foo***Component
    2. The builder checks to see if the group is really an over_react declaration that needs code generation. It sees that the factory is referencing a generated variable (`Foo = _$Foo`) and thus can confidently say that the factory needs code generation. Because of that, it proceeds with code generation for all the members in this group. 
   
   The builder has recognized our code as a class component that requires code generation! If it hadn't, the builder would have gone through similar logic to identify other types of declarations like function components and props map views, and perform similar code generation to wire them up.
   
   Next up, let's see what code generation looks like for our class component.
    
2. The builder generates a version of the props mixin which contains concrete 
getters/setters. 
    ```dart
   mixin $FooProps on FooProps {
     int get foo => props['FooProps.foo'];
     set foo(int value) => props['FooProps.foo'] = value;
   } 
    ```
       
2. The builder creates a concrete props implementation class, which mixes in the generated props mixin:
    ```dart
    class _$$FooProps extends UiProps with FooProps, $FooProps {
      ...   
    }
    ```
    This concrete class is what will be used everywhere for this component's typed props (returned from the `UiFactory`, available via `props` inside `render`).
   
    Note that in the above example, our component has props declared via just a props mixin, which is a shorthand syntax for when no additional props are needed from other mixins. For components with concrete props classes which mix in other props, the implementation is similar. The generated concrete props class mixes in all generated mixins corresponding to the props mixins used:
   
    ```dart
    // Authored code:
    UiFactory<BarProps> Bar = _$Bar;
    class BarProps = UiProps with BarPropsMixin, FooProps;
    class BarComponent extends UiComponent2<BarProps> { ... }
    
    // Generated code:
    class _$$BarProps extends UiProps 
        with 
            BarPropsMixin, $BarPropsMixin, 
            FooProps, $FooProps
        implements BarProps {
      ...   
    }
    ``` 
   
    It also overrides stubbed out `UiProps` members, and implements a constructor that delegates to other generated subclasses: one optimized for `JsBackedMap`, and one used for all other `Map`s. 
    ```dart
    class _$$FooProps extends UiProps with FooProps, $FooProps {
      factory _$$FooProps(Map backingMap) {
        if (backingMap == null || backingMap is JsBackedMap) {
          return _$$FooProps$JsMap(backingMap);
        } else {
          return _$$FooProps$PlainMap(backingMap);
        }
      }
    
      /// The backing props map proxied by this class.
      @override
      Map get props => _props;
      final Map _props;
    
      /// Let [UiProps] internals know that this class has been generated.
      @override
      bool get $isClassGenerated => true;
    
      /// The `ReactComponentFactory` associated with the component built by this class.
      @override
      ReactComponentFactoryProxy get componentFactory => $FooComponentFactory;   
    }
    ```

    Note that the `typedPropsFactory` variable is wired up to use the props implementation 
    class's constructor. This lets us get an instance of that class when we use the `props` 
    getter and the `newProps()` method, and is necessary since the code we wrote 
    doesn't have a proper constructor.

4. Our fully implemented component class is registered with the [react-dart] wrapper.

    ```dart
    // React component factory implementation.
    //
    // Registers component implementation and links type meta to builder factory.
    final $FooComponentFactory = registerComponent2(
      () => new _$FooComponent(),
      builderFactory: Foo,
      componentClass: FooComponent,
      isWrapper: false,
      parentType: null,
      displayName: 'Foo',
    );
    ```

5. Finally, the initializer for our factory (`_$Foo`) is generated with a function that returns a new instance of our 
private props implementation. This factory is __the entry-point__ to externally consuming our 
component and props class.

    ```dart
    _$$FooProps _$Foo([Map backingProps]) => backingProps == null
        ? _$$FooProps$JsMap(JsBackedMap())
        : _$$FooProps(backingProps);
    ```

&nbsp;
&nbsp;



## Props / State Getters and Setters

Writing a statically-typed prop / state API for React components in Dart proved to be a huge pain when we 
attempted to do it from scratch.

We found that the most straightforward way to adhere to React patterns was to use `Map`s for `props` and `state`. 

So we went about defining typed getters and setters on `MapView`-like classes which proxy Map key-value pairs. 
However, typing these getters and setters quickly became tedious 
_(especially if you need namespaced keys for platform scalability)_:

```dart
class FooProps extends UiProps {
  String get title               => props['FooProps.title'];
  set title(String value)        => props['FooProps.title'] = value;

  bool get isEnabled             => props['FooProps.isEnabled'];
  set isEnabled(bool value)      => props['FooProps.isEnabled'] = value;

  MouseEventCallback get onClick => props['FooProps.onClick'];
  set onClick(Callback value)    => props['FooProps.onClick'] = value;

  // Imagine a component with 20 of these... yuck.
}
```

With the builder, we cut down on repetition while preserving statically-typed getter and setters. 

Props and state are declared using _fields_, making the actual code you write much simpler - 
and much more like the React JS library intended:

```dart
mixin FooProps on UiProps {
  String title;

  bool isEnabled;

  MouseEventCallback onClick;

  // ...
}

mixin FooState on UiState {
  bool isShown;

  String currentText;

  // ...
}
```

> Check out some [component demos] for more info about using fields to define props and state values in the real world.

&nbsp;
&nbsp;


[OverReact library]: https://github.com/Workiva/over_react/blob/master/README.md
[annotations]: https://github.com/Workiva/over_react/blob/master/lib/src/component_declaration/annotations.dart
[component demos]: https://workiva.github.io/over_react/demos/
[react-dart]: https://github.com/cleandart/react-dart
