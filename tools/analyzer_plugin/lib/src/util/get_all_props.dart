import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

Iterable<FieldElement> getAllProps(InterfaceElement element) sync* {
  final allInterfaces = element.thisAndSupertypes.toList();

  final uiPropsElement = allInterfaces.singleWhereOrNull(
      (i) => i.name == 'UiProps' && i.library.name == 'over_react.component_declaration.component_base');
  if (uiPropsElement == null) return;

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

    late final isMixinBasedPropsMixin =
        c is MixinElement && c.superclassConstraints.any((s) => s.element.name == 'UiProps');
    late final isLegacyPropsOrPropsMixin = c.metadata.any((e) {
      final element = e.element;
      return element != null &&
          element.library?.name == 'over_react.component_declaration.annotations' &&
          const {'Props', 'PropsMixin'}.contains(element.tryCast<ConstructorElement>()?.enclosingElement.name);
    });

    if (!isMixinBasedPropsMixin && !isLegacyPropsOrPropsMixin) continue;

    for (final field in c.fields) {
      if (field.isStatic) continue;
      if (field.isSynthetic) continue;

      final accessorAnnotation = _getAccessorAnnotation(field.metadata);
      final isNoGenerate =
          accessorAnnotation?.computeConstantValue()?.getField('doNotGenerate')?.toBoolValue() ?? false;
      if (isNoGenerate) continue;

      yield field;
    }
  }
}

ElementAnnotation? _getAccessorAnnotation(List<ElementAnnotation> metadata) {
  return metadata.firstWhereOrNull((annotation) {
    final element = annotation.element;
    return element != null &&
        element.isDeclaredInPackage('over_react') &&
        // In our case, it's a constructor being referenced.
        // We could also compute the constant first and then check its type, but that's probably less efficient.
        element.tryCast<ConstructorElement>()?.enclosingElement.name == 'Accessor';
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
