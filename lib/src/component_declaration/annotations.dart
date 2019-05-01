// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Dummy annotations that would be used by Pub code generator
library over_react.component_declaration.annotations;

/// Annotation used with the `over_react` builder to declare a [UiFactory] for a component.
///
///     @Factory()
///     UiFactory<FooProps> Foo = _$Foo;
///
/// Must be accompanied by a [Props] and [Component] declaration.
class Factory {
  const Factory();
}

/// Annotation used with the `over_react` builder to declare a [UiProps] class for a component.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @Props()
///     class _$FooProps extends UiProps {
///       String bar;
///     }
///
/// Must be accompanied by a [Factory] and [Component] declaration.
class Props implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  @override
  final String keyNamespace;
  const Props({this.keyNamespace});
}

/// Annotation used with the `over_react` builder to declare a [UiState] class for a component.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @State()
///     class _$FooState extends UiState {
///       bool baz;
///     }
///
/// Optional. Must be accompanied by a [Factory], [Props], and [Component] declaration.
class State implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  @override
  final String keyNamespace;
  const State({this.keyNamespace});
}

/// Annotation used with the `over_react` builder to declare a [UiComponent] class for a component.
///
///     @Component()
///     class FooComponent extends UiComponent<FooProps> {
///       render() => Dom.div()(props.bar);
///     }
///
/// Must be accompanied by a [Factory] and [Props] declaration.
///
/// __Deprecated.__ Use the [Component2] annotation alongside `UiComponent2` / `UiStatefulComponent2` instead.
///
/// TODO: 3.0.0-wip is it possible to ensure that this annotation is not used on a "V2" class instance at build time?
@Deprecated('4.0.0')
class Component {
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed in to [over_react.isComponentOfType].
  final bool isWrapper;

  /// The component class of this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in [isComponentOfType].
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`:
  ///
  ///     @Factory()
  ///     UiFactory<...> Foo = _$Foo;
  ///     ...
  ///     @Component()
  ///     class FooComponent ... {...}
  ///
  ///     @Factory()
  ///     UiFactory<...> Bar = _$Bar;
  ///     ...
  ///     @Component(subtypeOf: FooComponent)
  ///     class BarComponent ... {...}
  ///
  /// then:
  ///
  ///     isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  ///     isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  final Type subtypeOf;

  const Component({
      this.isWrapper: false,
      this.subtypeOf
  });
}

/// Annotation used with the `over_react` builder to declare a `UiComponent2` class for a component.
///
///     @Component2()
///     class FooComponent extends UiComponent2<FooProps> {
///       render() => Dom.div()(props.bar);
///     }
///
/// Must be accompanied by a [Factory] and [Props] declaration.
///
/// TODO: 3.0.0-wip is it possible to ensure that this annotation is not used on a "V1" class instance at build time?
class Component2 implements Component {
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed in to `isComponentOfType`.
  @override
  final bool isWrapper;

  /// The component class of this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in `isComponentOfType`.
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`:
  ///
  ///     @Factory()
  ///     UiFactory<...> Foo = _$Foo;
  ///     ...
  ///     @Component2()
  ///     class FooComponent ... {...}
  ///
  ///     @Factory()
  ///     UiFactory<...> Bar = _$Bar;
  ///     ...
  ///     @Component2(subtypeOf: FooComponent)
  ///     class BarComponent ... {...}
  ///
  /// then:
  ///
  ///     isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  ///     isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  @override
  final Type subtypeOf;

  const Component2({
      this.isWrapper: false,
      this.subtypeOf
  });
}

/// Annotation used with the `over_react` builder to declare an abstract [UiProps] class for an abstract component.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @AbstractProps()
///     abstract class _$QuxProps extends UiProps {
///       int quux;
///     }
class AbstractProps implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  @override
  final String keyNamespace;
  const AbstractProps({this.keyNamespace});
}

/// Annotation used with the `over_react` builder to declare an abstract [UiProps] class for an abstract component.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @AbstractState()
///     abstract class _$QuxState extends UiState {
///       String corge;
///     }
class AbstractState implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  @override
  final String keyNamespace;
  const AbstractState({this.keyNamespace});
}

/// Annotation used with the `over_react` builder to declare an abstract [UiComponent] class for an abstract component.
///
///     @AbstractComponent()
///     abstract class QuxComponent<TProps extends QuxProps> extends UiComponent<TProps> {}
///
/// __Deprecated.__ Use the [AbstractComponent2] annotation alongside `UiComponent2` / `UiStatefulComponent2` instead.
@Deprecated('4.0.0')
class AbstractComponent {
  const AbstractComponent();
}

/// Annotation used with the `over_react` builder to declare an abstract `UiComponent2` class for an abstract component.
///
///     @AbstractComponent2()
///     abstract class FooComponent<TProps extends QuxProps> extends UiComponent2<TProps> {}
class AbstractComponent2 implements AbstractComponent {
  const AbstractComponent2();
}

/// Annotation used with the `over_react` builder to declare a mixin for use in a [UiProps] class.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @PropsMixin()
///     abstract class GraultPropsMixin {
///       Map get props;
///
///       Object garply;
///     }
///
/// Classes using this annotation must include the abstract `props` getter.
class PropsMixin implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  @override
  final String keyNamespace;
  const PropsMixin({this.keyNamespace});
}

/// Annotation used with the `over_react` builder to declare a mixin for use in a [UiState] class.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @StateMixin()
///     abstract class WaldoStateMixin {
///       Map get state;
///
///       dynamic fred;
///     }
///
/// Classes using this annotation must include the abstract `state` getter.
class StateMixin implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  @override
  final String keyNamespace;
  const StateMixin({this.keyNamespace});
}

/// Marks a `prop` as required to be set.
///
/// Validation occurs in `UiComponent.validateRequiredProps` which requires super calls into `componentWillMount` and
/// `componentWillReceiveProps`.
///
///     @Props()
///     abstract class _$FooProps {
///       @requiredProp
///       String requiredProp;
///     }
const Accessor requiredProp = const Accessor(isRequired: true);

/// Marks a `prop` as required to be set, but allowed to be set explicitly to `null`.
///
/// Validation occurs in `UiComponent.validateRequiredProps` which requires super calls into `componentWillMount` and
/// `componentWillReceiveProps`.
///
///     @Props()
///     abstract class _$FooProps {
///       @nullableRequiredProp
///       String nullableRequiredProp;
///     }
const Accessor nullableRequiredProp = const Accessor(isRequired: true, isNullable: true);

/// Annotation used with the `over_react` builder to customize individual accessors (props/state fields).
///
/// Validation occurs in `UiComponent.validateRequiredProps` which requires super calls into `componentWillMount` and
/// `componentWillReceiveProps`.
///
///     @Props()
///     abstract class _$FooProps {
///       @Accessor(keyNamespace: '', key: 'custom_key')
///       String bar;
///
///       @Accessor(isRequired: true)
///       String requiredProp;
///
///       @Accessor(isRequired: true, isNullable: true)
///       String nullableRequiredProp;
///     }
///
/// Related: [requiredProp], [nullableRequiredProp].
class Accessor {
  /// A key for the annotated accessor, overriding the default of the accessor's name.
  final String key;

  /// A custom namespace for the key namespace of the annotated accessor,
  /// overriding the default of `'${enclosingClassName}.'`.
  final String keyNamespace;

  /// Whether the accessor is required to be set.
  final bool isRequired;

  /// Whether setting a prop to null is allowed.
  final bool isNullable;

  /// The error message displayed when the accessor is not set.
  final String requiredErrorMessage;

  /// Whether to skip generating an accessor for this field.
  final bool doNotGenerate;

  const Accessor({
    this.key,
    this.keyNamespace,
    this.isRequired = false,
    this.isNullable = false,
    this.requiredErrorMessage,
    this.doNotGenerate = false,
  });
}

abstract class TypedMap {
  String get keyNamespace;
}
