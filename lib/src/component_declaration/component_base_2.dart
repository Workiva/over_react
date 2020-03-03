// Copyright 2019 Workiva Inc.
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

// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:js';

import 'package:meta/meta.dart';
import 'package:over_react/src/component/dummy_component2.dart';
import 'package:over_react/src/util/class_names.dart';
import 'package:over_react/src/util/map_util.dart';
import 'package:over_react/src/util/prop_errors.dart';
import 'package:over_react/src/util/prop_key_util.dart' as prop_key_util;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/bridge.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/react_interop.dart';

import 'builder_helpers.dart';
import 'component_type_checking.dart';
import 'disposable_manager_proxy.dart';

/// Helper function that wraps [registerComponent2], and allows an easier way to register abstract components with the
/// main purpose of type-checking against the abstract component.
///
/// __The result must be stored in a variable that is named very specifically:__
///
///     var $`AbstractComponentClassName`Factory = registerAbstractComponent2(`AbstractComponentClassName`);
///
ReactDartComponentFactoryProxy2 registerAbstractComponent2(Type abstractComponentClass, {ReactDartComponentFactoryProxy2 parentType}) =>
    registerComponent2(() => DummyComponent2(), componentClass: abstractComponentClass, parentType: parentType);

/// Helper function that wraps react.registerComponent2, and allows attachment of additional
/// component factory metadata.
///
/// * [isWrapper]: whether the component clones or passes through its children and needs to be
/// treated as if it were the wrapped component.
///
/// * [builderFactory]/[componentClass]: the [UiFactory] and [UiComponent2] members to be potentially
/// used as types for [isComponentOfType]/`getComponentFactory`.
///
/// * [displayName]: the name of the component for use when debugging.
ReactDartComponentFactoryProxy2 registerComponent2(react.Component2 Function() dartComponentFactory, {
    bool isWrapper = false,
    // This must remain typed in a way that both UiComponent and UiComponent2 classes can be passed as the `subtypeOf` value.
    ReactDartComponentFactoryProxy parentType,
    UiFactory builderFactory,
    Type componentClass,
    String displayName,
    Iterable<String> skipMethods = const ['getDerivedStateFromError', 'componentDidCatch'],
}) {
  final reactComponentFactory = react.registerComponent2(
    dartComponentFactory,
    skipMethods: skipMethods,
    bridgeFactory: UiComponent2BridgeImpl.bridgeFactory,
  );

  if (displayName != null) {
    reactComponentFactory.reactClass.displayName = displayName;
  }

  registerComponentTypeAlias(reactComponentFactory, builderFactory);
  registerComponentTypeAlias(reactComponentFactory, componentClass);

  setComponentTypeMeta(reactComponentFactory, isWrapper: isWrapper, parentType: parentType);

  return reactComponentFactory;
}

/// The basis for an over_react component that is compatible with ReactJS 16 ([react.Component2]).
///
/// Includes support for strongly-typed [UiProps] and utilities for prop and CSS classname forwarding.
///
/// __Prop and CSS className forwarding when your component renders a composite component:__
///
///     class YourComponent extends UiComponent2<YourProps> {
///       Map getDefaultProps() => (newProps()
///         ..aPropOnYourComponent = /* default value */
///       );
///
///       @override
///       render() {
///         var classes = forwardingClassNameBuilder()
///           ..add('your-component-base-class')
///           ..add('a-conditional-class', shouldApplyConditionalClass);
///
///         return (SomeChildComponent()
///           ..addProps(copyUnconsumedProps())
///           ..className = classes.toClassName()
///         )(props.children);
///       }
///     }
///
/// __Prop and CSS className forwarding when your component renders a DOM component:__
///
///     class YourComponent extends UiComponent2<YourProps> {
///       @override
///       render() {
///         var classes = forwardingClassNameBuilder()
///           ..add('your-component-base-class')
///           ..add('a-conditional-class', shouldApplyConditionalClass);
///
///         return (Dom.div()
///           ..addProps(copyUnconsumedDomProps())
///           ..className = classes.toClassName()
///         )(props.children);
///       }
///     }
///
/// > Related: [UiStatefulComponent2]
abstract class UiComponent2<TProps extends UiProps> extends react.Component2
    with DisposableManagerProxy, GeneratedClass
    implements UiComponent<TProps> {
  // ***************************************************************************
  //
  // Typed props
  //
  // ***************************************************************************

  /// A typed view into the component's current JS props object.
  ///
  /// Created using [typedPropsFactoryJs] and updated whenever props changes.
  @override
  @toBeGenerated
  TProps get props {
    // This needs to be a concrete implementation in Dart 2 for soundness;
    // without it, you get a confusing error. See: https://github.com/dart-lang/sdk/issues/36191
    throw UngeneratedError(member: #props,
        message: GeneratedErrorMessages.component1AnnotationOnComponent2);
  }

  /// The [contextType] property lets you consume the nearest current value of that context's Provider using [context].
  ///
  /// [contextType] is assigned as `Context.reactDartContext` after being created by `createContext`.
  ///
  /// __Example__:
  ///
  ///     Context MyContext = createContext('test');
  ///
  ///     class MyClass extends UiComponent2 {
  ///       @override
  ///       final contextType = MyContext.reactDartContext;
  ///
  ///       render() {
  ///         return Dom.span()(
  ///           '${this.context}', // Outputs: 'test'
  ///        );
  ///       }
  ///     }
  ///
  /// See: <https://reactjs.org/docs/context.html#classcontexttype>
  @override
  react.Context get contextType => super.contextType;

  /// Returns a typed props object backed by the specified [propsMap].
  ///
  /// Required to properly instantiate the generic [TProps] class.
  @override
  @toBeGenerated
  TProps typedPropsFactory(Map propsMap)=> throw UngeneratedError(member: #typedPropsFactory);

  /// Returns a typed props object backed by the specified [propsMap].
  ///
  /// Required to properly instantiate the generic [TProps] class.
  ///
  /// This should be used where possible over [typedPropsFactory] to allow for
  /// more efficient dart2js output.
  @toBeGenerated
  TProps typedPropsFactoryJs(JsBackedMap propsMap) => throw UngeneratedError(member: #typedPropsFactoryJs,
      message: GeneratedErrorMessages.component1AnnotationOnComponent2);

  /// Returns a typed props object backed by a Map.
  ///
  /// Convenient for use with [defaultProps].
  @override
  TProps newProps() => typedPropsFactoryJs(JsBackedMap());

  /// Allows usage of [react.PropValidator] functions to check the validity of a prop within the props passed to it.
  ///
  /// Override with a custom implementation to easily add validation.
  ///
  /// > For performance reasons, `propTypes` is only checked in development mode.
  ///
  /// __Example of enforcing the length of a prop value:__
  ///
  /// ```
  /// mixin MyProps on UiProps {
  ///   Object foo;
  /// }
  ///
  /// class MyComponent extends UiComponent2<MyProps> {
  ///   @override
  ///   get propTypes => {
  ///     keyForProp((p) => p.foo): (props, info) {
  ///       final length = props.foo?.length;
  ///       if (length != 2) {
  ///         return PropError.value(length, info.propName, 'must have a length of 2');
  ///       }
  ///       return null;
  ///     },
  ///   };
  /// }
  /// ```
  ///
  /// * [keyForProp] - as shown in the example above - is a statically typed helper to get the string key for a prop.
  /// * The second argument (`info`) of the function used to return a value for the key contains metadata about
  ///   the prop specified by the key.
  ///     * `propName`, `componentName`, `location` and `propFullName` are available.
  ///
  /// __Example of enforcing the relationship between two prop values:__
  ///
  /// ```
  /// mixin MyProps on UiProps {
  ///   bool mustHaveAnotherPropValue;
  ///   String anotherProp;
  /// }
  ///
  /// class MyComponent extends UiComponent2<MyProps> {
  ///   @override
  ///   get defaultProps => newProps()..someProp = false;
  ///
  ///   @override
  ///   get propTypes => {
  ///     keyForProp((p) => p.mustHaveAnotherPropValue): (props, info) {
  ///       if (props.mustHaveAnotherPropValue && props.anotherProp == null) {
  ///         return PropError.combination(info.propName, 'anotherProp',
  ///             'must have a non-null value when ${info.propName} is true.');
  ///       }
  ///       return null;
  ///     },
  ///   };
  /// }
  /// ```
  ///
  /// > See: <https://reactjs.org/docs/typechecking-with-proptypes.html#proptypes>
  @override
  Map<String, react.PropValidator<TProps>> get propTypes => {};

  /// Returns the string key of the [factory] prop accessed in [accessProp], including the namespace if one exists.
  ///
  /// __DEPRECATED__: This method had to be deprecated and replaced with [keyForProp] because of the way
  /// that shadowing works in Dart when a top-level function name matches the name of an instance method.
  @Deprecated('4.0.0')
  String getPropKey(void Function(TProps props) accessProp) => keyForProp(accessProp);

  /// Returns the string key of the [factory] prop accessed in [accessProp], including the namespace if one exists.
  ///
  /// Intended for use within [propTypes].
  ///
  /// __Example:__
  ///
  /// ```
  /// mixin MyProps on UiProps {
  ///   bool somePropKey;
  ///
  ///   @Accessor(keyNamespace: '')
  ///   @override
  ///   String id;
  /// }
  ///
  /// class MyComponent extends UiComponent2<MyProps> {
  ///   void someInstanceMethod() {
  ///     print(keyForProp((p) => p.somePropKey)); // Prints "MyProps.somePropKey"
  ///     print(keyForProp((p) => p.id)); // Prints "id"
  ///   }
  /// }
  /// ```
  String keyForProp(void Function(TProps props) accessProp) => prop_key_util.getPropKey(accessProp, typedPropsFactory);

  // ***************************************************************************
  //
  // Prop forwarding
  //
  // ***************************************************************************

  /// The default consumed props, taken from the keys generated in the associated [UiProps] class.
  @override
  @toBeGenerated
  Iterable<ConsumedProps> get $defaultConsumedProps => throw UngeneratedError(member: #$defaultConsumedProps);

  /// The non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated [UiProps] class
  /// if this getter is not overridden.
  @override
  Iterable<ConsumedProps> get consumedProps => $defaultConsumedProps;

  /// A prop modifier that passes a reference of a component's `props` to be updated with any unconsumed props.
  ///
  /// Call within `modifyProps` like so:
  ///
  ///     class SomeCompositeComponent extends UiComponent<SomeCompositeComponentProps> {
  ///       @override
  ///       render() {
  ///         return (SomeOtherWidget()..modifyProps(addUnconsumedProps))(
  ///           props.children,
  ///         );
  ///       }
  ///     }
  ///
  /// > Related [addUnconsumedDomProps]
  void addUnconsumedProps(Map props) {
    // TODO: cache this value to avoid unnecessary looping
    var consumedPropKeys = consumedProps?.map((consumedProps) => consumedProps.keys);

    forwardUnconsumedProps(this.props, propsToUpdate: props,
        keySetsToOmit: consumedPropKeys);
  }

  /// A prop modifier that passes a reference of a component's `props` to be updated with any unconsumed `DomProps`.
  ///
  /// Call within `modifyProps` like so:
  ///
  ///     class SomeCompositeComponent extends UiComponent<SomeCompositeComponentProps> {
  ///       @override
  ///       render() {
  ///         return (Dom.div()..modifyProps(addUnconsumedDomProps))(
  ///           props.children,
  ///         );
  ///       }
  ///     }
  ///
  /// > Related [addUnconsumedProps]
  void addUnconsumedDomProps(Map props) {
    var consumedPropKeys = consumedProps?.map((consumedProps) => consumedProps.keys);

    forwardUnconsumedProps(this.props, propsToUpdate: props, keySetsToOmit:
        consumedPropKeys, onlyCopyDomProps: true);
  }

  /// Returns a copy of this component's props with React props optionally omitted, and
  /// with the specified [keysToOmit] and [keySetsToOmit] omitted.
  @override
  Map copyProps(
      {bool omitReservedReactProps = true,
      bool onlyCopyDomProps = false,
      Iterable keysToOmit,
      Iterable<Iterable> keySetsToOmit}) {
    return getPropsToForward(this.props,
        omitReactProps: omitReservedReactProps,
        onlyCopyDomProps: onlyCopyDomProps,
        keysToOmit: keysToOmit,
        keySetsToOmit: keySetsToOmit);
  }

  /// Returns a ClassNameBuilder with className and blacklist values added from [CssClassPropsMixin.className] and
  /// [CssClassPropsMixin.classNameBlacklist], if they are specified.
  ///
  /// This method should be used as the basis for the classNames of components receiving forwarded props.
  ///
  /// > Should be used alongside [copyUnconsumedProps] or [copyUnconsumedDomProps].
  @override
  ClassNameBuilder forwardingClassNameBuilder() {
    return ClassNameBuilder.fromProps(this.props);
  }

  // ***************************************************************************
  //
  // Deprecated members
  //
  // ***************************************************************************

  /// Deprecated; do not use. Will be removed alongside UiComponent.
  @Deprecated('4.0.0')
  @override
  Map get unwrappedProps => super.props;

  /// Deprecated; do not use. Will be removed alongside UiComponent.
  @Deprecated('4.0.0')
  @override
  set unwrappedProps(Map value) => props = value;

  /// Returns a copy of this component's props with keys found in [consumedProps] omitted.
  ///
  /// > Should be used alongside [forwardingClassNameBuilder].
  ///
  /// > Related [copyUnconsumedDomProps]
  ///
  /// __Deprecated.__ Use [addUnconsumedProps] within
  /// `modifyProps` (rather than `addProps`) instead.
  ///
  /// Replace
  ///
  ///   ..addProps(copyUnconsumedProps())
  ///
  /// with
  ///
  ///   ..modifyProps(addUnconsumedProps)
  ///
  /// Will be removed in the `4.0.0` release.
  @override
  @Deprecated('4.0.0')
  Map copyUnconsumedProps() {
    var consumedPropKeys = consumedProps
            ?.map((consumedProps) => consumedProps.keys) ??
        const [];

    return copyProps(keySetsToOmit: consumedPropKeys);
  }

  /// Returns a copy of this component's props with keys found in [consumedProps] and non-DOM props omitted.
  ///
  /// > Should be used alongside [forwardingClassNameBuilder].
  ///
  /// > Related [copyUnconsumedProps]
  ///
  /// __Deprecated.__ Use [addUnconsumedDomProps] within
  /// `modifyProps` (rather than `addProps`) instead. Will be removed in the
  /// `4.0.0` release.
  @override
  @Deprecated('4.0.0')
  Map copyUnconsumedDomProps() {
    var consumedPropKeys = consumedProps
            ?.map((consumedProps) => consumedProps.keys) ??
        const [];

    return copyProps(onlyCopyDomProps: true, keySetsToOmit: consumedPropKeys);
  }

  @Deprecated('4.0.0')
  @override
  void redraw([Function() callback]) => super.redraw(callback);

  // ***************************************************************************
  //
  // Deprecated and unsupported members
  //
  // ***************************************************************************

  /// Throws a [PropError] if [appliedProps] are invalid.
  ///
  /// __Deprecated.__ Will be removed in the `4.0.0` release. Use [propTypes] instead.
  ///
  /// __Bad__
  ///
  /// ```
  /// mixin MyProps on UiProps {
  ///   List listThatMustHaveAnEvenNumberOfItems;
  /// }
  ///
  /// class MyComponent extends UiComponent2<MyProps> {
  ///   void validateProps(Map appliedProps) {
  ///     super.validateProps(appliedProps);
  ///
  ///     var tProps = typedPropsFactory(appliedProps);
  ///     if (tProps.items.length.isOdd) {
  ///       throw PropError.value(tProps.items, 'items', 'must have an even number of items, because reasons');
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// __Good__
  ///
  /// ```
  /// mixin MyProps on UiProps {
  ///   List listThatMustHaveAnEvenNumberOfItems;
  /// }
  ///
  /// class MyComponent extends UiComponent2<MyProps> {
  ///   @override
  ///   get propTypes => {
  ///     keyForProp((p) => p.listThatMustHaveAnEvenNumberOfItems): (props, info) {
  ///       if (props.listThatMustHaveAnEvenNumberOfItems?.length.isOdd) {
  ///         return PropError.value(
  ///             tProps.listThatMustHaveAnEvenNumberOfItems,
  ///             'listThatMustHaveAnEvenNumberOfItems',
  ///             'must have an even number of items, because reasons');
  ///       }
  ///       return null;
  ///     },
  ///   };
  /// }
  /// ```
  @Deprecated('4.0.0')
  @mustCallSuper
  @override
  void validateProps(Map appliedProps) {
    throw UnsupportedError('[validateProps] is not supported in UiComponent2, use [propTypes] instead.');
  }

  /// Validates that props with the `@requiredProp` annotation are present.
  /// __Deprecated.__ Will be removed in the `4.0.0` release.
  ///
  /// Props annotated with `@requiredProp` will automatically be validated in `UiComponent2` instances.
  @Deprecated('4.0.0')
  @mustCallSuper
  @override
  void validateRequiredProps(Map appliedProps) {
    throw UnsupportedError('[validateRequiredProps] is not supported in UiComponent2, use [propTypes] instead.');
  }
}

/// The basis for a _stateful_ over_react component that is compatible with ReactJS 16 ([react.Component2]).
///
/// Includes support for strongly-typed [UiState] in-addition-to the
/// strongly-typed props and utilities for prop and CSS classname forwarding provided by [UiComponent2].
///
/// __Initializing state:__
///
///     class YourComponent extends UiStatefulComponent2<YourProps, YourState> {
///       @override
///       get initialState => (newState()
///         ..aStateKeyWithinYourStateClass = /* default value */
///       );
///
///       @override
///       render() {
///         var classes = forwardingClassNameBuilder()
///           ..add('your-component-base-class')
///           ..add('a-conditional-class', state.aStateKeyWithinYourStateClass);
///
///         return (SomeChildComponent()
///           ..addProps(copyUnconsumedProps())
///           ..className = classes.toClassName()
///         )(props.children);
///       }
///     }
abstract class UiStatefulComponent2<TProps extends UiProps, TState extends UiState>
    extends UiComponent2<TProps>
    with UiStatefulMixin2<TProps, TState>
    // implementing UiStatefulComponent causes state to not be typed correctly in
    // in mixins `on UiStatefulComponent2`. TODO file Dart bug.
    // implements UiStatefulComponent<TProps, TState>
{}

/// A mixin that allows you to add typed state to a [UiComponent2].
///
/// Useful for when you're extending from another [UiComponent2] that doesn't extend from [UiStatefulComponent2].
///
/// Includes support for strongly-typed [UiState] in-addition-to the
/// strongly-typed props and utilities for prop and CSS classname forwarding provided by [UiComponent2].
///
/// __Initializing state:__
///
///     class YourComponent extends UiComponent2<YourProps> with UiStatefulMixin2<YourProps, YourState> {
///       @override
///       get initialState => (newState()
///         ..aStateKeyWithinYourStateClass = /* default value */
///       );
///
///       @override
///       render() {
///         var classes = forwardingClassNameBuilder()
///           ..add('your-component-base-class')
///           ..add('a-conditional-class', state.aStateKeyWithinYourStateClass);
///
///         return (SomeChildComponent()
///           ..addProps(copyUnconsumedProps())
///           ..className = classes.toClassName()
///         )(props.children);
///       }
///     }
mixin UiStatefulMixin2<TProps extends UiProps, TState extends UiState> on UiComponent2<TProps> {
  // ***************************************************************************
  //
  // Typed state
  //
  // ***************************************************************************

  /// A typed view into the component's current JS state object.
  ///
  /// Created using [typedStateFactoryJs] and updated whenever state changes.
  @override
  TState get state {
    // This needs to be a concrete implementation in Dart 2 for soundness;
    // without it, you get a confusing error. See: https://github.com/dart-lang/sdk/issues/36191
    throw UngeneratedError(member: #state,
        message: GeneratedErrorMessages.component1AnnotationOnComponent2);
  }

  /// Returns a typed state object backed by the specified [stateMap].
  ///
  /// Required to properly instantiate the generic [TState] class.
  @toBeGenerated
  TState typedStateFactory(Map stateMap) => throw UngeneratedError(member: #typedStateFactory,
      message: GeneratedErrorMessages.typedStateFactory);

  /// Returns a typed state object backed by the specified [stateMap].
  ///
  /// Required to properly instantiate the generic [TState] class.
  ///
  /// This should be used where possible over [typedStateFactory] to allow for
  /// more efficient dart2js output.
  TState typedStateFactoryJs(JsBackedMap stateMap) => throw UngeneratedError(member: #typedStateFactoryJs,
      message: '${GeneratedErrorMessages.typedStateFactory}${GeneratedErrorMessages.component1AnnotationOnComponent2}');

  /// Returns a typed state object backed by a Map.
  ///
  /// Convenient for use with [getInitialState] and [setState].
  TState newState() => typedStateFactoryJs(JsBackedMap());

  @override
  void setStateWithUpdater(covariant Map Function(TState prevState, TProps props) updater, [Function() callback]) {
    final bridge = Component2Bridge.forComponent(this) as UiComponent2BridgeImpl;
    bridge.setStateWithTypedUpdater(this, updater, callback);
  }

  // ***************************************************************************
  //
  // Deprecated members
  //
  // ***************************************************************************

  /// Deprecated; do not use. Will be removed alongside UiComponent.
  @Deprecated('4.0.0')
  Map get unwrappedState => super.state;

  /// Deprecated; do not use. Will be removed alongside UiComponent.
  @Deprecated('4.0.0')
  set unwrappedState(Map value) => state = value;
}

/// A bridge implementation that adds typing for [UiComponent2] props/state maps.
///
/// See [Component2Bridge] for more info.
class UiComponent2BridgeImpl extends Component2BridgeImpl {
  const UiComponent2BridgeImpl();

  /// Returns a const bridge instance suitable for use with any [UiComponent2].
  ///
  /// See [Component2BridgeFactory] for more info.
  // ignore: prefer_constructors_over_static_methods
  static UiComponent2BridgeImpl bridgeFactory(react.Component2 component) {
    assert(component is UiComponent2, 'should not be used with non-UiComponent2 components');
    return const UiComponent2BridgeImpl();
  }

  @override
  JsMap jsifyPropTypes(
      covariant UiComponent2 component, covariant Map<String,
      /*PropValidator<UiProps>*/Function> propTypes) {
    Error _getErrorFromConsumerValidator(
      /*PropValidator<UiProps>*/Function _validator,
      JsBackedMap _props,
      react.PropValidatorInfo _info,
    ) {
      var convertedProps = component.typedPropsFactoryJs(_props);
      return _validator(convertedProps, _info);
    }

    // Add [PropValidator]s for props annotated as required.
    final newPropTypes = Map.of(propTypes);
    component.consumedProps?.forEach((consumedProps) {
      consumedProps.props.forEach((prop) {
        if (!prop.isRequired) return;

        Error requiredPropValidator(
          Map _props,
          react.PropValidatorInfo _info,
        ) {
          Error consumerError;
          // Check if the consumer has specified a propType for this key.
          if (propTypes[prop.key] != null) {
            consumerError = _getErrorFromConsumerValidator(
              propTypes[prop.key],
              JsBackedMap.from(_props),
              _info,
            );
          }

          if (consumerError != null) return consumerError;

          if (prop.isNullable && _props.containsKey(prop.key)) return null;
          if (!prop.isNullable && _props[prop.key] != null) return null;

          if (_props[_info.propName] == null) {
            return PropError.required(_info.propName, prop.errorMessage);
          }

          return null;
        }

        newPropTypes[prop.key] = requiredPropValidator;
      });
    });

    // Wrap consumer-provided and required validators with ones that convert plain props maps into typed ones.
    return JsBackedMap.from(newPropTypes.map((_propKey, _validator) {
        // ignore: prefer_function_declarations_over_variables
        JsPropValidator handlePropValidator = (
          JsMap _props, // ignore: avoid_types_on_closure_parameters
          String _propName, // ignore: avoid_types_on_closure_parameters
          String _componentName, // ignore: avoid_types_on_closure_parameters
          String _location, // ignore: avoid_types_on_closure_parameters
          String _propFullName, // ignore: avoid_types_on_closure_parameters
          // This is a required argument of PropTypes validators but is hidden from the JS consumer.
          String secret, // ignore: avoid_types_on_closure_parameters
        ) {
          final error = _getErrorFromConsumerValidator(
            _validator,
            JsBackedMap.fromJs(_props),
            react.PropValidatorInfo(
                propName: _propName, componentName: _componentName, location: _location, propFullName: _propFullName),
          );
          return error == null ? null : JsError(error.toString());
        };

        return MapEntry(_propKey, allowInterop(handlePropValidator));
      })).jsObject;
  }

  /// A version of [setStateWithTypedUpdater] whose updater is passed typed views
  /// into the `prevState` and `props` arguments, allowing them to be typed automatically
  /// within [UiStatefulComponent2.setStateWithUpdater].
  void setStateWithTypedUpdater<TState extends UiState, TProps extends UiProps>(
    UiStatefulMixin2<TProps, TState> component,
    Map Function(TState prevState, TProps props) updater,
    Function() callback,
  ) {
    Map typedUpdater(Map prevState, Map props) {
      return updater(
        component.typedStateFactoryJs(prevState as JsBackedMap),
        component.typedPropsFactoryJs(props as JsBackedMap),
      );
    }
    setStateWithUpdater(component, typedUpdater, callback);
  }
}
