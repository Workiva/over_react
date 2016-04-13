/// Provides utilities around component type-checking.
library web_skin_dart.component_declaration.component_type_checking;

import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_base.dart' show UiFactory;
import 'package:web_skin_dart/src/ui_core/util/react_wrappers.dart';

// ----------------------------------------------------------------------
//   Component type registration and internal type metadata management
// ----------------------------------------------------------------------


Expando<ReactDartComponentFactoryProxy> _typeAliasToFactory = new Expando<ReactDartComponentFactoryProxy>();

/// Registers a type alias for the specified factory, so that [getComponentTypeFromAlias] can be
/// called with [typeAlias] to retrieve [factory]'s [ReactClass] type.
void registerComponentTypeAlias(ReactDartComponentFactoryProxy factory, dynamic typeAlias) {
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
void setComponentTypeMeta(ReactDartComponentFactoryProxy factory, {
    bool isWrapper,
    ReactDartComponentFactoryProxy parentType
}) {
  setProperty(factory.type, _componentTypeMetaKey, new ComponentTypeMeta(isWrapper, parentType));
}

/// Returns the [ComponentTypeMeta] associated with the component type [type] in [setComponentTypeMeta],
/// or `const ComponentTypeMeta.none()` if there is no associated meta.
ComponentTypeMeta getComponentTypeMeta(dynamic type) {
  assert(isPotentiallyValidComponentType(type) &&
      '`type` should be a valid component type (and not null or a type alias).' is String);

  if (type is! String) {
    return getProperty(type, _componentTypeMetaKey) ?? const ComponentTypeMeta.none();
  }

  return const ComponentTypeMeta.none();
}


class ComponentTypeMeta {
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed into [isComponentOfType].
  final bool isWrapper;

  /// The factory of this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in [isComponentOfType].
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`, then:
  ///
  ///     isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  ///     isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  final ReactDartComponentFactoryProxy parentType;

  ComponentTypeMeta(bool this.isWrapper, ReactDartComponentFactoryProxy this.parentType);

  const ComponentTypeMeta.none() :
      this.isWrapper = false,
      this.parentType = null;
}


// ----------------------------------------------------------------------
//   Internal component type utilities
// ----------------------------------------------------------------------


/// Returns the canonical "type" for a component ([ReactClass] or [String] `tagName`)
/// associated with [typeAlias], which can be a component's:
///
/// * [UiFactory] (Dart components only)
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
/// __CAVEAT:__ Due to type-checking limitations on JS-interop types, when [typeAlias] is a [Function],
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
/// * [Function] ([ReactClass]) factory (Dart/JS composite components)
///
///     Note: It's impossible to determine know whether something is a ReactClass due to type-checking restrictions
///         for JS-interop classes, so a Function type-check is the best we can do.
bool isPotentiallyValidComponentType(dynamic type) {
  return type is Function || type is String;
}

/// Returns an [Iterable] of all component types that are ancestors of [typeAlias].
///
/// For example, given components A, B, and C, where B subtypes A and C subtypes B:
///
///     getParentTypes(getTypeFromAlias(A)); // []
///     getParentTypes(getTypeFromAlias(B)); // [A].map(getTypeFromAlias)
///     getParentTypes(getTypeFromAlias(C)); // [B, A].map(getTypeFromAlias)
Iterable<dynamic> getParentTypes(dynamic type) sync* {
  assert(isPotentiallyValidComponentType(type) &&
      '`type` should be a valid component type (and not null or a type alias).' is String);

  var currentType = type;
  var parentType;

  while ((parentType = getComponentTypeMeta(currentType).parentType) != null) {
    currentType = getComponentTypeFromAlias(parentType);
    yield currentType ?? parentType;
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
bool isComponentOfType(ReactElement instance, dynamic typeAlias, {
    bool traverseWrappers: true,
    bool matchParentTypes: true
}) {
  if (instance == null) {
    return false;
  }

  var type = getComponentTypeFromAlias(typeAlias);
  if (type == null) {
    return false;
  }

  var instanceType = instance.type;
  var instanceTypeMeta = getComponentTypeMeta(instanceType);

  // Type-check instance wrappers.
  if (traverseWrappers && instanceTypeMeta.isWrapper) {
    assert(isDartComponent(instance) &&
       'Non-Dart components should not be wrappers' is String);

    List children = getProps(instance)['children'];
    if (children == null || children.isEmpty) {
      return false;
    }

    return isComponentOfType(children.first, type, traverseWrappers: true,
        matchParentTypes: matchParentTypes);
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
bool isValidElementOfType(dynamic instance, dynamic typeAlias) {
  return isValidElement(instance) && isComponentOfType(instance, typeAlias);
}
