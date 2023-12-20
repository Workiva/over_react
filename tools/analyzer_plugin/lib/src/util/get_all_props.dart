import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

// Performance optimization notes:
// [1] Building a list here is slightly more optimal than using a generator.
//
// [2] Ideally we'd check the library/package here,
//     but for some reason accessing `.library` is pretty inefficient.
//     Possibly due to the `LibraryElementImpl? get library => thisOrAncestorOfType();` impl,
//     and an inefficient `thisOrAncestorOfType` impl: https://github.com/dart-lang/sdk/issues/53255

List<FieldElement> getAllProps(InterfaceElement element) {
  final allProps = <FieldElement>[]; // [1]

  // final allInterfaces = element.thisAndSupertypes;
  final allInterfaces = element.thisAndSupertypes.toList();

  final uiPropsElement = allInterfaces.singleWhereOrNull(
      (i) => i.name == 'UiProps' && i.library.name == 'over_react.component_declaration.component_base');
  if (uiPropsElement == null) return allProps;
  final uiPropsInterfaces = uiPropsElement.thisAndSupertypes.toSet();
  for (final c in allInterfaces) {
    // Don't process UiProps or its supertypes (Object, Map, MapBase, MapViewMixin, PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin, ...)
    if (uiPropsInterfaces.contains(c)) continue;

    // Filter out:
    // - generated accessors mixins for legacy concrete props classes
    // - generated mixins for mixin-based code
    // - FIXME Dart2-only mixins?
    late final isInGeneratedFile = c.source.uri.path.endsWith('.over_react.g.dart');
    if (c.name.endsWith('AccessorsMixin') && isInGeneratedFile) {
      continue;
    }

    switch (c.name) {
      case 'DomProps':
      case 'DomPropsMixin':
      case 'SvgProps':
      case 'SvgPropsMixin':
        continue;
    }

    final isMixinBasedPropsMixin = c is MixinElement && c.superclassConstraints.any((s) => s.element.name == 'UiProps');
    late final isLegacyPropsOrPropsMixinConsumerClass =
        c.name.startsWith(r'_$') && c.metadata.any(_isPropsOrPropsMixinAnnotation);

    if (!isMixinBasedPropsMixin && !isLegacyPropsOrPropsMixinConsumerClass) {
      continue;
    }

    for (final field in c.fields) {
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
  final element = e.element; // [2]
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
    final element = annotation.element; // [2]
    return element is ConstructorElement && element.enclosingElement.name == 'Accessor';
  });
}

extension on InterfaceElement {
  Iterable<InterfaceElement> get thisAndSupertypes sync* {
    yield this;
    for (final s in allSupertypes) {
      yield s.element;
    }
  }
}
