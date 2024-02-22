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

// ignore_for_file: prefer_generic_function_type_aliases
library over_react.component_declaration.component_base;

import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:over_react/src/component/prop_mixins.dart';
import 'package:over_react/src/component_declaration/accessor_meta.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/component_declaration/typedefs.dart';
import 'package:over_react/src/component_declaration/util.dart';
import 'package:over_react/src/util/class_names.dart';
import 'package:over_react/src/util/map_util.dart';
import 'package:over_react/src/util/pretty_print.dart';
import 'package:over_react/src/util/string_util.dart';
import 'package:over_react/src/util/test_mode.dart';
import 'package:over_react/src/util/validation_util.dart';
import 'package:react/react_client.dart';


/// A `dart.collection.MapView`-like class with strongly-typed getters/setters for React state.
///
/// > Note: Implements [MapViewMixin] instead of extending it so that the abstract state declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiState extends Object with MapViewMixin, StateMapViewMixin {}

/// The string used by default for the key of the attribute added by [UiProps.addTestId].
const defaultTestIdKey = 'data-test-id';


/// A `dart.collection.MapView`-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Map]s, or as a builder to create new component
/// instances via a fluent-style interface.
///
/// > Note: Implements [MapViewMixin] instead of extending it so that the abstract `Props` declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiProps extends MapBase
    with
        MapViewMixin,
        PropsMapViewMixin,
        ReactPropsMixin,
        UbiquitousDomPropsMixin,
        CssClassPropsMixin
    implements Map {
  /// Adds an arbitrary [propKey]/[value] pair if [shouldAdd] is `true`.
  ///
  /// Is a noop if [shouldAdd] is `false`.
  ///
  /// > Related: [addProps]
  void addProp(propKey, value, [bool shouldAdd = true]) {
    if (!shouldAdd) return;

    this[propKey] = value;
  }

  /// Adds an arbitrary [propMap] of arbitrary props if [shouldAdd] is true.
  ///
  /// Is a noop if [shouldAdd] is `false` or [propMap] is `null`.
  ///
  /// > Related: [addProp], [modifyProps]
  void addProps(Map? propMap, [bool shouldAdd = true]) {
    if (!shouldAdd || propMap == null) return;

    this.addAll(propMap);
  }

  /// Allows [modifier] to alter the instance if [shouldModify] is true.
  ///
  /// Is a noop if [shouldModify] is `false` or [modifier] is `null`.
  ///
  /// > Related: [addProps]
  void modifyProps(PropsModifier? modifier, [bool shouldModify = true]) {
    if (!shouldModify || modifier == null) return;

    modifier(this);
  }

  /// Copies key-value pairs from the provided [props] map into this map,
  /// excluding those with keys found in [consumedProps].
  ///
  /// [consumedProps] should be a `Iterable<PropsMeta>` instance.
  /// This is the return type of [PropsMetaCollection]'s related APIs `forMixins`,
  /// `allExceptForMixins`, and `all`.
  ///
  /// __Example:__
  ///
  /// ```dart
  /// // within a functional component (wrapped in `uiFunction`)
  /// // Consider props in FooProps "consumed"...
  /// final consumedProps = props.staticMeta.forMixins({FooProps});
  /// // ...and filter them out when forwarding props to Bar.
  /// return (Bar()..addUnconsumedProps(props, consumedProps))();
  /// ```
  ///
  /// To only add DOM props, use [addUnconsumedDomProps].
  ///
  /// Related: `UiComponent2`'s `addUnconsumedProps`
  void addUnconsumedProps(Map props, Iterable<PropsMeta> consumedProps) {
    final consumedPropKeys = consumedProps.map((consumedProps) => consumedProps.keys);
    forwardUnconsumedPropsV2(props, propsToUpdate: this, keySetsToOmit: consumedPropKeys);
  }

  /// Copies DOM only key-value pairs from the provided [props] map into this map,
  /// excluding those with keys found in [consumedProps].
  ///
  /// [consumedProps] should be a `Iterable<PropsMeta>` instance.
  /// This is the return type of [PropsMetaCollection]'s related APIs `forMixins`,
  /// `allExceptForMixins`, and `all`.
  ///
  /// __Example:__
  ///
  /// ```dart
  /// // within a functional component (wrapped in `uiFunction`)
  /// // Consider props in FooProps "consumed"...
  /// final consumedProps = [PropsMeta.forSimpleKey('className')];
  /// // ...and filter them out when forwarding props to Bar.
  /// return (Bar()..addUnconsumedDomProps(props, consumedProps))();
  /// ```
  ///
  /// To add all unconsumed props, including DOM props, use [addUnconsumedProps].
  ///
  /// Related: `UiComponent2`'s `addUnconsumedDomProps`
  void addUnconsumedDomProps(Map props, Iterable<PropsMeta> consumedProps) {
    final consumedPropKeys = consumedProps.map((consumedProps) => consumedProps.keys);
    forwardUnconsumedPropsV2(props, propsToUpdate: this, keySetsToOmit: consumedPropKeys, onlyCopyDomProps: true);
  }

  /// Whether [UiProps] is in a testing environment.
  ///
  /// Do not set this directly; Call [enableTestMode] or [disableTestMode] instead.
  static bool testMode = false;

  /// Whether [UiProps] is in a testing environment at build time.
  static const bool _testModeFromEnvironment = bool.fromEnvironment('testing');

  /// Whether [UiProps] is in a testing environment at build time or otherwise.
  ///
  /// Used in [addTestId].
  ///
  /// TODO: Only use bool.fromEnvironment() when it is supported in Dartium.
  /// See: <https://github.com/dart-lang/pub/issues/798>.
  bool get _inTestMode => testMode || _testModeFromEnvironment;

  /// Adds [value] to the prop [key] _(delimited with a single space)_.
  ///
  /// Allows for an element to have multiple test IDs to prevent overwriting when cloning elements or components.
  ///
  /// > For use in a testing environment (when [testMode] is true).
  void addTestId(String? value, {String key = defaultTestIdKey}) {
    if (!_inTestMode || value == null) {
      return;
    }

    String? testId = getTestId(key: key);

    if (testId == null) {
      props[key] = value;
    } else {
      props[key] = getTestId(key: key)! + ' $value';
    }
  }

  /// Gets the [defaultTestIdKey] prop value, or one testId from the prop _(or custom [key] prop value)_.
  ///
  /// > For use in a testing environment (when [testMode] is true).
  String? getTestId({String key = defaultTestIdKey}) {
    return props[key] as String?;
  }

  /// Gets the `data-test-id` prop key for use in a testing environment.
  ///
  /// DEPRECATED. Use [getTestId] instead.
  @Deprecated('2.0.0')
  String? get testId {
    return getTestId();
  }

  /// Shared `assert` statements for use in [call] and [build].
  void _sharedAsserts() {
    assert(() {
      if (_shouldValidateRequiredProps) {
        validateRequiredProps();
      }
      return true;
    }());

    // This is an assert since we're in a performance-sensitive area of the code, and only need
    // to provide this error message during development; in prod, a null exception will be triggered
    // down the line instead.
    assert(
        componentFactory != null,
        'Most likely, another error occurred while initializing this component\'s declaration (via `\$${runtimeType}Factory`); '
        'to find the real issue, look for earlier errors in the console output.\n\n'
        'Other potential causes:'
        '1. This is a props map view factory (declared as just a factory and props), and should not be invoked.\n'
        '   This can also happen if your component didn\'t get grouped with your factory/props (e.g., if its name doesn\'t match).'
        '2. This is a function component factory that was set up improperly, not wrapping the generated function in `uiFunction`.\n'
        '3. componentFactory was erroneously assigned to null on this UiProps instance, potentially in an HOC function.');
  }

  /// Returns a new component with this builder's [props] and the specified [children].
  ReactElement build([dynamic children]) {
    assert(_validateChildren(children));
    _sharedAsserts();

    return componentFactory!(props, children);
  }

  /// Creates a new component with this builder's props and the specified [children].
  ///
  /// _(alias for [build] with support for variadic children)_
  ///
  /// This method actually takes any number of children as arguments ([c2], [c3], ...) via [noSuchMethod].
  ///
  /// Restricted statically to 40 arguments until the dart2js fix in
  /// <https://github.com/dart-lang/sdk/pull/26032> is released.
  ///
  ReactElement call([c1 = notSpecified, c2 = notSpecified, c3 = notSpecified, c4 = notSpecified, c5 = notSpecified, c6 = notSpecified, c7 = notSpecified, c8 = notSpecified, c9 = notSpecified, c10 = notSpecified, c11 = notSpecified, c12 = notSpecified, c13 = notSpecified, c14 = notSpecified, c15 = notSpecified, c16 = notSpecified, c17 = notSpecified, c18 = notSpecified, c19 = notSpecified, c20 = notSpecified, c21 = notSpecified, c22 = notSpecified, c23 = notSpecified, c24 = notSpecified, c25 = notSpecified, c26 = notSpecified, c27 = notSpecified, c28 = notSpecified, c29 = notSpecified, c30 = notSpecified, c31 = notSpecified, c32 = notSpecified, c33 = notSpecified, c34 = notSpecified, c35 = notSpecified, c36 = notSpecified, c37 = notSpecified, c38 = notSpecified, c39 = notSpecified, c40 = notSpecified]) {
    List childArguments;
    // Use `identical` since it compiles down to `===` in dart2js instead of calling equality helper functions,
    // and we don't want to allow any object overriding `operator==` to claim it's equal to `_notSpecified`.
    if (identical(c1, notSpecified)) {
      // Use a const list so that empty children prop values are always identical
      // in the JS props, resulting in JS libraries (e.g., react-redux) and Dart code alike
      // not marking props as having changed as a result of rerendering the ReactElement with a new list.
      childArguments = const [];
    } else if (identical(c2, notSpecified)) {
      childArguments = [c1];
    } else if (identical(c3, notSpecified)) {
      childArguments = [c1, c2];
    } else if (identical(c4, notSpecified)) {
      childArguments = [c1, c2, c3];
    } else if (identical(c5, notSpecified)) {
      childArguments = [c1, c2, c3, c4];
    } else if (identical(c6, notSpecified)) {
      childArguments = [c1, c2, c3, c4, c5];
    } else if (identical(c7, notSpecified)) {
      childArguments = [c1, c2, c3, c4, c5, c6];
    } else {
      childArguments = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]
        .takeWhile((child) => !identical(child, notSpecified))
        .toList();
    }

    // Ideally we'd put this assert into _sharedAsserts, but we want to make sure this conditional child logic
    // gets compiled out by directly nesting it within an `assert`.
    assert(_validateChildren(childArguments.length == 1 ? childArguments.single : childArguments));
    _sharedAsserts();

    // Use `build` instead of using emulated function behavior to work around DDC issue
    // https://github.com/dart-lang/sdk/issues/29904
    // Should have the benefit of better performance;
    return componentFactory!.build(props, childArguments);
  }

  /// Validates that no [children] are instances of [UiProps], and prints a helpful message for a better debugging
  /// experience.
  bool _validateChildren(dynamic children) {
    // Should not validate non-list iterables to avoid more than one iteration.
    if (children != null && (children is! Iterable || children is List)) {
      final childrenList = children is List ? children : [children];

      if (childrenList.any((child) => child is UiProps)) {
        var errorMessage = unindent(
            '''
            It looks like you are trying to use a non-invoked builder as a child. That is an invalid use of UiProps, try
            invoking the builder before passing it as a child.
            '''
        );

        // TODO: Remove ValidationUtil.warn call when https://github.com/dart-lang/sdk/issues/26093 is resolved.
        ValidationUtil.warn(errorMessage, this);
        throw ArgumentError(errorMessage);
      }
    }

    return true;
  }

  /// The react-dart factory associated with this props class's component,
  /// used to create a [ReactElement] with these props within [build]/[call].
  ///
  /// This will only be null for props that can't be invoked, such as props map views, or props for
  /// abstract components.
  ReactComponentFactoryProxy? componentFactory;

  /// An unmodifiable map view of the default props for this component brought
  /// in from the [componentFactory].
  // ignore: deprecated_member_use
  Map get componentDefaultProps {
    final componentFactory = this.componentFactory;
    // ignore: deprecated_member_use
    return componentFactory is ReactDartComponentFactoryProxy
      ? componentFactory.defaultProps
      : const {};
  }

  /// Validate at run-time that all required props are set.
  ///
  /// This method is overridden in generated files.
  @visibleForOverriding
  @mustCallSuper
  void validateRequiredProps() {}

  /// Whether [validateRequiredProps] should be run.
  var _shouldValidateRequiredProps = true;

  /// Disables all prop validation for this builder, both at runtime (skipping [validateRequiredProps])
  /// and within the OverReact analyzer plugin's required props lint.
  ///
  /// Allows validation to be skipped to support cases where required props are cloned onto an element.
  ///
  /// Prop validation for specific props can also be disabled via [annotations.disableRequiredPropValidation]
  /// or [annotations.Props.disableRequiredPropValidation].
  void disableRequiredPropValidation() {
    _shouldValidateRequiredProps = false;
  }

  /// Names of props to opt out of required prop validation for.
  ///
  /// Overridden in generated code, based on the value of `@Props(disableRequiredPropValidation: ...)`.
  @visibleForOverriding
  Set<String> get requiredPropNamesToSkipValidation => const {};
}

/// A class that declares the `_map` getter shared by [PropsMapViewMixin]/[StateMapViewMixin] and [MapViewMixin].
///
/// Necessary in order to work around Dart 1.23 strong mode change that disallows conflicting private members
/// in mixins: <https://github.com/dart-lang/sdk/issues/28809>.
abstract class _OverReactMapViewBase<K, V> {
  Map<K, V> get _map;
}

/// Works in conjunction with [MapViewMixin] to provide `dart.collection.MapView`-like
/// functionality to [UiProps] subclasses.
///
/// > Related: [StateMapViewMixin]
abstract class PropsMapViewMixin implements _OverReactMapViewBase {
  /// The props maintained by this builder and used passed into the component when built.
  /// In this case, it's the current MapView object.
  Map get props;

  @override
  Map get _map => this.props;

  @override
  String toString() => '$runtimeType: ${prettyPrintMap(_map)}';
}

/// Works in conjunction with [MapViewMixin] to provide `dart.collection.MapView`-like
/// functionality to [UiState] subclasses.
///
/// > Related: [PropsMapViewMixin]
abstract class StateMapViewMixin implements _OverReactMapViewBase {
  Map get state;

  @override
  Map get _map => this.state;

  @override
  String toString() => '$runtimeType: ${prettyPrintMap(_map)}';
}

/// Provides `dart.collection.MapView`-like behavior by proxying an internal map.
///
/// Works in conjunction with [PropsMapViewMixin] and [StateMapViewMixin] to implement [Map]
/// in [UiProps] and [UiState] subclasses.
///
/// For use by concrete [UiProps] and [UiState] implementations (either generated or manual),
/// and thus must remain public.
abstract class MapViewMixin<K, V> implements _OverReactMapViewBase<K, V>, Map<K, V> {
  @override Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) f) => _map.map<K2, V2>(f);
  @override Iterable<MapEntry<K, V>> get entries => _map.entries;
  @override void addEntries(Iterable<MapEntry<K, V>> newEntries) => _map.addEntries(newEntries);
  @override void removeWhere(bool Function(K key, V value) predicate) => _map.removeWhere(predicate);
  @override V update(K key, V Function(V value) update, {V Function()? ifAbsent}) => _map.update(key, update, ifAbsent: ifAbsent);
  @override void updateAll(V Function(K key, V value) update) => _map.updateAll(update);
  @override Map<RK, RV> cast<RK, RV>() => _map.cast<RK, RV>();
  @override V? operator [](Object? key) => _map[key];
  @override void operator []=(K key, V value) { _map[key] = value; }
  @override void addAll(Map<K, V> other) { _map.addAll(other); }
  @override void clear() { _map.clear(); }
  @override V putIfAbsent(K key, V Function() ifAbsent) => _map.putIfAbsent(key, ifAbsent);
  @override bool containsKey(Object? key) => _map.containsKey(key);
  @override bool containsValue(Object? value) => _map.containsValue(value);
  @override void forEach(void Function(K key, V value) action) { _map.forEach(action); }
  @override bool get isEmpty => _map.isEmpty;
  @override bool get isNotEmpty => _map.isNotEmpty;
  @override int get length => _map.length;
  @override Iterable<K> get keys => _map.keys;
  @override V? remove(Object? key) => _map.remove(key);
  @override Iterable<V> get values => _map.values;
}
