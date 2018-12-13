import 'package:over_react/src/component_declaration/component_base.dart';

/// Returns the default component props for a factory as a typed props object.
///
///     // Component Declaration
///     @Factory()
///     UiFactory<FooProps> Foo;
///
///     @Props()
///     class FooProps extends UiProps {
///       String bar;
///     }
///
///     @Component()
///     class FooComponent extends UiComponent<FooProps> {
///       @override
///       getDefaultProps() => newProps()..bar = 'baz';
///     }
///
///     // Example Usage
///     final defaultFooProps = typedDefaultPropsFor(Foo);
///     print(defaultFooProps.bar); // "baz"
T typedDefaultPropsFor<T extends UiProps>(UiFactory<T> factory) =>
    factory(factory().componentDefaultProps);