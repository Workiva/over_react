import 'package:over_react/src/component_declaration/component_base.dart';

/// Returns a typed view into the unmodifiable default props map for the
/// component associated with [factory].
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
