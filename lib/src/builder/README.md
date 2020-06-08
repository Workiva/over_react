# NOTE: This content is outdated, and will be updated soon to reflect changes made to the builder when implementing the new mixin-based boilerplate 

---

# OverReact Builder

[](#__START_EMBEDDED_README__)

OverReact components are declared using a set of [annotations] which are 
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

1. A component is declared.

    ```dart
    @Factory()
    UiFactory<FooProps> Foo = _$Foo;
    
    @Props()
    class _$FooProps extends UiProps { 
      // ...
    }
    
    @Component2()
    class FooComponent extends UiComponent2<FooProps> {
      @override
      render() { 
        // ...
      }
    }
    ```

    Note that we've annotated our component pieces with `@Factory()`, `@Props()`, and `@Component2()`. 
    These are what the builder uses as "hooks" to find your component.

    Okay, so we've defined our component. Let's look at what the builder does.
    
2. The builder creates the consumable implementation of the props class. This is the class which contains concrete 
getters/setters (via the `_$FooPropsAccessorsMixin` class)
    ```dart
   class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
     static const PropsMeta meta = _$metaForFooProps;
   } 
    ```
    
3. The builder creates a concrete props implementation class
    ```dart
    // Concrete props implementation.
    //
    // Implements constructor and backing map, and links up to generated component factory.
    class _$$FooProps extends _$FooProps with _$FooPropsAccessorsMixin implements FooProps {
      _$$FooProps(Map backingMap) : this._props = backingMap ?? {};
    
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
    
      /// The default namespace for the prop getters/setters generated for this class.
      @override
      String get propKeyNamespace => 'FooProps.';
    }
    ```
    
    It does this since the class we defined in our code inherits pseudo-abstract stubbed 
    members and doesn't have the constructor we need.

3. A fully implemented component class which extends our component class.

    ```dart
    // Concrete component implementation.
    //
    // Implements typed props/state factories, defaults `consumedPropKeys` to the keys
    // generated for the associated props class.
    class _$FooComponent extends FooComponent {
      @override
      typedPropsFactory(Map backingMap) => new _$$FooProps(backingMap);
    
      /// Let `UiComponent` internals know that this class has been generated.
      @override
      bool get $isClassGenerated => true;
    
      /// The default consumed props, taken from _$FooProps.
      /// Used in `ConsumedProps` if [consumedProps] is not overridden.
      @override
      final List<ConsumedProps> $defaultConsumedProps = const [_$metaForFooProps];
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
    final $FooComponentFactory = registerComponent(() => new _$FooComponent(),
        builderFactory: Foo,
        componentClass: FooComponent,
        isWrapper: false,
        parentType: null,
        displayName: 'Foo');

    ```

5. Finally, the initializer for our factory (_$Foo) is generated with a function that returns a new instance of our 
private props implementation. This factory is __the entry-point__ to externally consuming our 
component and props class.

    ```dart
    _$$FooProps _$Foo([Map backingProps]) => new _$$FooProps(backingProps);
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
@Props()
class _$FooProps extends UiProps {
  String title;

  bool isEnabled;

  MouseEventCallback onClick;

  // ...
}

@State()
class _$FooState extends UiState {
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
