import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

/// Returns all props defined in a props class/mixin [element] as well as all of its supertypes,
/// except for those shared by all UiProps instances by default (e.g., ReactPropsMixin, UbiquitousDomPropsMixin,
/// and CssClassPropsMixin's key, ref, children, className, id, onClick, etc.).
///
/// Each returned field will be the consumer-declared prop field, and the list will not contain overrides
/// from generated over_react parts.
///
/// Excludes any fields annotated with `@doNotGenerate`.
List<FieldElement> getAllProps(InterfaceElement element) {
  // Performance optimization notes:
  // [1] Building a list here is slightly more optimal than using a generator.
  //
  // [2] Ideally we'd check the library and package here,
  //     but for some reason accessing `.library` is pretty inefficient.
  //     Possibly due to the `LibraryElementImpl? get library => thisOrAncestorOfType();` impl,
  //     and an inefficient `thisOrAncestorOfType` impl: https://github.com/dart-lang/sdk/issues/53255

  final allProps = <FieldElement>[]; // [1]

  final allInterfaces = element.thisAndSupertypesList;

  // There are two UiProps; one in component_base, and one in builder_helpers that extends from it.
  // Use the component_base one, since there are some edge-cases of props that don't extend from the
  // builder_helpers version.
  final uiPropsElement = allInterfaces.firstWhereOrNull(
      (i) => i.name == 'UiProps' && i.library.name == 'over_react.component_declaration.component_base');
  // `element` does not inherit from from UiProps.
  if (uiPropsElement == null) return allProps;

  final uiPropsInterfaces = uiPropsElement.thisAndSupertypesSet;
  for (final interface in allInterfaces) {
    // Don't process UiProps or its supertypes
    // (Object, Map, MapBase, MapViewMixin, PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin, ...)
    if (uiPropsInterfaces.contains(interface)) continue;

    // Filter out:
    // - generated accessors mixins for legacy concrete props classes
    // - generated mixins for mixin-based code
    // - FIXME Dart2-only mixins?
    late final isFromGeneratedFile = interface.source.uri.path.endsWith('.over_react.g.dart');
    if (interface.name.endsWith('AccessorsMixin') && isFromGeneratedFile) {
      continue;
    }

    final isMixinBasedPropsMixin =
        interface is MixinElement && interface.superclassConstraints.any((s) => s.element.name == 'UiProps');
    late final isLegacyPropsOrPropsMixinConsumerClass =
        interface.name.startsWith(r'_$') && interface.metadata.any(_isPropsOrPropsMixinAnnotation);

    if (!isMixinBasedPropsMixin && !isLegacyPropsOrPropsMixinConsumerClass) {
      continue;
    }

    for (final field in interface.fields) {
      if (field.isStatic) continue;
      if (field.isSynthetic) continue;

      final accessorAnnotation = _getAccessorAnnotation(field.metadata);
      final isNoGenerate =
          accessorAnnotation?.computeConstantValue()?.getField('doNotGenerate')?.toBoolValue() ?? false;
      if (isNoGenerate) continue;

      allProps.add(field);
    }
  }

  return allProps;
}

bool _isPropsOrPropsMixinAnnotation(ElementAnnotation e) {
  // [2]
  final element = e.element;
  if (element is ConstructorElement) {
    switch (element.enclosingElement.name) {
      case 'Props':
      case 'PropsMixin':
        return true;
    }
  }
  return false;
}

ElementAnnotation? _getAccessorAnnotation(List<ElementAnnotation> metadata) {
  return metadata.firstWhereOrNull((annotation) {
    // [2]
    final element = annotation.element;
    return element is ConstructorElement && element.enclosingElement.name == 'Accessor';
  });
}

extension on InterfaceElement {
  // Two separate collection implementations to micro-optimize collection creation/iteration based on usage.

  Set<InterfaceElement> get thisAndSupertypesSet => {this, for (final s in allSupertypes) s.element};

  List<InterfaceElement> get thisAndSupertypesList => [this, for (final s in allSupertypes) s.element];
}
