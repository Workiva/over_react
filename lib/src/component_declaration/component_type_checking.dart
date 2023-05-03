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

/// Provides utilities around component type-checking.
library over_react.component_declaration.component_type_checking;

import 'dart:js_util';

import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/component_base.dart'
    show UiFactory;
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/annotations.dart'
    as annotations show Component2;
import 'package:over_react/src/util/react_wrappers.dart';
import 'package:over_react/src/util/string_util.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart';

// ----------------------------------------------------------------------
//   Component type registration and internal type metadata management
// ----------------------------------------------------------------------

/// Extensions to allow setting type-checking-related metadata on components.
extension UiFactoryTypeMeta on UiFactory {
  /// Sets metadata for the underlying component class/type associated with this
  /// factory, functionally equivalent to the [annotations.Component2] annotation.
  ///
  /// However, unlike the annotation, this can be used for function components.
  ///
  /// ## subtypeOf arguments: [subtypeOfFactory]/[subtypeOfRaw]
  ///
  /// The raw JS component type that is this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in [isComponentOfType].
  ///
  /// [subtypeOfRaw] accepts the raw underlying type, and
  /// [subtypeOfFactory] accepts a factory, for convenience.
  ///
  /// For example, the following are equivalent:
  /// ```dart
  /// subtypeOfFactory: Foo,
  /// subtypeOfRaw: Foo().componentFactory.type,
  /// subtypeOfRaw: $FooComponentFactory.type,
  /// ```
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`:
  ///
  /// ```dart
  /// // Class component example:
  /// class FooComponent ... {...}
  ///
  /// @Component2(subtypeOf: FooComponent)
  /// class BarComponent ... {...}
  /// ```
  /// ```dart
  /// // Function component example:
  /// UiFactory<FooProps> Foo = uiFunction(...);
  ///
  /// UiFactory<FooProps> Bar = uiFunction(...)
  ///   ..setComponentMeta(subtypeOfFactory: Foo);
  /// ```
  ///
  /// then:
  /// ```dart
  /// isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  /// isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  /// ```
  ///
  /// ## [isWrapper]
  ///
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed in to [isComponentOfType].
  ///
  /// ```
  /// // Class component
  /// @Component2(isWrapper: true)
  /// class FooComponent extends UiComponent2<FooProps> { ... }
  ///
  /// // Function component
  /// UiFactory<FooProps> Foo = uiFunction(...)
  ///   ..setComponentMeta(isWrapper: true);
  /// ```
  void setTypeMeta({
    // These are separate arguments because it's very difficult to tell
    // the difference between a UiFactory and a ReactClass at runtime.
    UiFactory subtypeOfFactory,
    dynamic /*ReactClass|JS component function|string*/ subtypeOfRaw,
    bool isWrapper = false,
  }) {
    if (subtypeOfFactory != null && subtypeOfRaw != null) {
      throw ArgumentError('subtypeOfFactory and subtypeOfRawJsType cannot both be specified.');
    }
    final parentType = subtypeOfFactory != null
        // Get the type directly as opposed to using getComponentTypeFromAlias
        // because the alias might not have been registered yet
        // due to lazy-initialization of generated component factories.
        ? subtypeOfFactory().componentFactory.type
        : subtypeOfRaw;

    final type = this().componentFactory.type;
    setComponentTypeMeta(
      type,
      parentType: parentType,
      isWrapper: isWrapper,
      // Fetch the old meta and preserve the value of isHoc for now.
      // isHoc's implementation/usage seems incomplete and may be removed,
      // so we won't expose it as an argument, at least for now.
      isHoc: getComponentTypeMeta(type).isHoc,
    );
  }
}

// ignore: deprecated_member_use
Expando<ReactComponentFactoryProxy> _typeAliasToFactory =
    Expando<ReactComponentFactoryProxy>();

/// Registers a type alias for the specified factory, so that [getComponentTypeFromAlias] can be
/// called with [typeAlias] to retrieve [factory]'s [ReactClass] type.
// ignore: deprecated_member_use
void registerComponentTypeAlias(
    ReactComponentFactoryProxy factory, dynamic typeAlias) {
  if (typeAlias != null) {
    _typeAliasToFactory[typeAlias] = factory;
  }
}

/// Key used to store/retrieve [ComponentTypeMeta] on a [ReactClass] component type by
/// [setComponentTypeMeta] and [getComponentTypeMeta].
const String _componentTypeMetaKey = '_componentTypeMeta';

/// Associates a new [ComponentTypeMeta] instance instantiated from [isWrapper]/[parentType] with
/// the component type of the specified [factory].
///
/// This meta is retrievable via [getComponentTypeMeta].
void setComponentTypeMeta(
  dynamic /* ReactClass|JS component function|string */ type, {
  @required dynamic  /* ReactClass|JS component function|string */ parentType,
  bool isWrapper = false,
  bool isHoc = false,
}) {
  assert(!isTypeAlias(type) && isPotentiallyValidComponentType(type), 'must pass in the raw JS component type');
  assert(type is! String, 'cannot set type metadata on strings');

  setProperty(
      type,
      _componentTypeMetaKey,
      ComponentTypeMeta(
        parentType: parentType,
        isWrapper: isWrapper,
        isHoc: isHoc,
      ));
}

bool isTypeAlias(dynamic type) {
  final alias = getComponentTypeFromAlias(type);
  return alias != null && alias != type;
}

/// Returns the [ComponentTypeMeta] associated with the component type [type] in [setComponentTypeMeta],
/// or `const ComponentTypeMeta.none()` if there is no associated meta.
ComponentTypeMeta getComponentTypeMeta(dynamic type) {
  assert(isPotentiallyValidComponentType(type) &&
      '`type` should be a valid component type (and not null or a type alias).'
          is String);

  if (type is! String) {
    return getProperty(type, _componentTypeMetaKey) as ComponentTypeMeta ??
        const ComponentTypeMeta.none();
  }

  return const ComponentTypeMeta.none();
}

class ComponentTypeMeta {
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed into [isComponentOfType].
  final bool isWrapper;

  /// Whether the component is a higher-order component that wraps [parentType].
  final bool isHoc;

  /// The raw JS type of this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in [isComponentOfType].
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`:
  ///
  ///     //
  ///     // foo.dart
  ///     //
  ///
  ///     UiFactory<FooProps> Foo = $Foo;
  ///
  ///     class FooComponent extends UiComponent2<FooProps> {
  ///       // ...
  ///     }
  ///
  ///     //
  ///     // bar.dart
  ///     //
  ///
  ///     UiFactory<FooProps> Foo = $Foo;
  ///
  ///     @Component2(subtypeOf: FooComponent)
  ///     class BarComponent extends UiComponent2<BarProps> {
  ///       // ...
  ///     }
  ///
  ///     //
  ///     // app.dart
  ///     //
  ///
  ///     isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  ///     isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  ///
  /// > See: `subtypeOf` (within [annotations.Component2])
  // ignore: deprecated_member_use
  final dynamic /*ReactClass|JS component function|string*/ parentType;

  ComponentTypeMeta(
      {this.parentType, this.isWrapper = false, this.isHoc = false})
        : assert(parentType == null || (!isTypeAlias(parentType) && isPotentiallyValidComponentType(parentType)), 'must pass in the raw JS component type');

  const ComponentTypeMeta.none()
      : this.isWrapper = false,
        this.isHoc = false,
        this.parentType = null;
}

// ----------------------------------------------------------------------
//   Internal component type utilities
// ----------------------------------------------------------------------

/// Returns the canonical "type" for a component ([ReactClass] or [String] `tagName`)
/// associated with [typeAlias], which can be a component's:
///
/// * [UiFactory]
/// * [UiComponent] [Type] (Dart components only)
/// * [ReactComponentFactoryProxy]
/// * [ReactClass] component factory
/// * [String] tag name (DOM components only)
///
/// If there is no type associated with [typeAlias], then `null` is returned.
///
/// This may be the case if [typeAlias] is invalid, or if the associated component hasn't been
/// registered yet due to lazy-instantiation of the [ReactComponentFactoryProxy] variables.
///
/// Consumers of this function should be sure to take the latter case into consideration.
///
/// > __CAVEAT:__ Due to type-checking limitations on JS-interop types, when [typeAlias] is a [Function],
/// and it is not found to be an alias for another type, it will be returned as if it were a valid type.
dynamic getComponentTypeFromAlias(dynamic typeAlias) {
  /// If `typeAlias` is a factory, return its type.
  if (typeAlias is ReactComponentFactoryProxy) {
    return typeAlias.type;
  }

  /// Check the to see if any factories are associated with `typeAlias`.
  /// Type-check it so we don't pass an illegal type to Expando's `operator[]` method.
  if (typeAlias != null &&
      typeAlias is! num &&
      typeAlias is! String &&
      typeAlias is! bool) {
    var aliasedType = _typeAliasToFactory[typeAlias]?.type;
    if (aliasedType != null) {
      return aliasedType;
    }
  }

  if (typeAlias is UiFactory) {
    // We need a try-catch and explicit test for UiProps here since type-checking
    // JS functions with `is UiFactory` returns `true`, and we may not actually
    // be invoking a UiFactory.
    try {
      final builder = typeAlias();
      if (builder is component_base.UiProps) {
        return builder.componentFactory?.type;
      }
    } catch (_) {}
  }

  /// If `typeAlias` is an actual type, return it.
  if (isPotentiallyValidComponentType(typeAlias)) {
    return typeAlias;
  }

  return null;
}

/// Returns whether [type] potentially represents a valid component type.
///
/// Valid types:
///
/// * [String] tag name (DOM components)
/// * [Function] factory (Dart components)
/// * [ReactClass] component type (JS composite component classes, JS function component functions, Dart component JS classes)
bool isPotentiallyValidComponentType(dynamic type) {
  return type is Function || type is ReactClass || type is String;
}

/// Returns an [Iterable] of all component types that are ancestors of [type].
///
/// For example, given components A, B, and C, where B subtypes A and C subtypes B:
///
///     getParentTypes(getComponentTypeFromAlias(A)); // []
///     getParentTypes(getComponentTypeFromAlias(B)); // [A].map(getTypeFromAlias)
///     getParentTypes(getComponentTypeFromAlias(C)); // [B, A].map(getTypeFromAlias)
Iterable<dynamic> getParentTypes(dynamic type) sync* {
  assert(isPotentiallyValidComponentType(type) &&
      '`type` should be a valid component type (and not null or a type alias).'
          is String);

  var currentType = type;
  while ((currentType = getComponentTypeMeta(currentType).parentType) != null) {
    yield currentType;
  }
}

// ----------------------------------------------------------------------
//   Consumer-facing component type-checking methods
// ----------------------------------------------------------------------

/// Returns whether [instance] is of the type associated with [typeAlias], which can be a component's:
///
/// * [UiFactory] (Dart components only)
/// * [UiComponent] [Type] (Dart components only)
/// * [ReactComponentFactoryProxy]
/// * [ReactClass] component factory
/// * [String] tag name (DOM components only)
///
/// > Related: [isValidElementOfType]
bool isComponentOfType(ReactElement instance, dynamic typeAlias,
    {bool traverseWrappers = true, bool matchParentTypes = true}) {
  if (instance == null) {
    return false;
  }

  var instanceType = instance.type;

  var type = getComponentTypeFromAlias(typeAlias);
  if (type == null) {
    return false;
  }

  var instanceTypeMeta = getComponentTypeMeta(instanceType);

  // Type-check instance wrappers.
  if (traverseWrappers && instanceTypeMeta.isWrapper) {
    assert(isDartComponent(instance) &&
        'Non-Dart components should not be wrappers' is String);

    final children = getProps(instance)['children'] as List;
    if (children == null || children.isEmpty) {
      return false;
    }

    return isComponentOfType(children.first as ReactElement, type,
        traverseWrappers: true, matchParentTypes: matchParentTypes);
  }

  // Check parent types.
  if (matchParentTypes && instanceTypeMeta.parentType != null) {
    return instanceType == type || getParentTypes(instanceType).contains(type);
  }

  return instanceType == type;
}

/// Returns whether [instance] is a valid ReactElement of the type associated with
/// [typeAlias], which can be a component's:
///
/// * [UiFactory] (Dart components only)
/// * [UiComponent] [Type] (Dart components only)
/// * [ReactComponentFactoryProxy]
/// * [ReactClass] component factory
/// * [String] tag name (DOM components only)
///
/// > Related: [isComponentOfType]
bool isValidElementOfType(dynamic instance, dynamic typeAlias) {
  return isValidElement(instance) && isComponentOfType(instance as ReactElement, typeAlias);
}

/// Validates that a [ReactComponentFactoryProxy]'s component is not `Component`
/// or `UiComponent`.
void enforceMinimumComponentVersionFor(ReactComponentFactoryProxy component) {
  if (component.type is String) return;

  // ignore: invalid_use_of_protected_member
  if (component.type.dartComponentVersion == '1') {
    throw ArgumentError(unindent('''
        The UiFactory provided should not be for a UiComponent or Component.
        
        Instead, use a different factory (such as UiComponent2 or Component2).
        '''));
  }
}

/// Validates that a [ReactComponentFactoryProxy]'s component is a function component.
void enforceFunctionComponent(ReactComponentFactoryProxy component) {
  if (component is ReactDartFunctionComponentFactoryProxy || component is ReactDartWrappedComponentFactoryProxy) return;

  throw ArgumentError(unindent('''
        The UiFactory provided should be for a function component.
        '''));
}
