import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

Iterable<FieldElement> getAllProps(InterfaceElement element) sync* {
  for (final c in element.thisAndSupertypes) {
    // FIXME(null-safety) FED-1720 handle legacy boilerplate prop mixins if it's not too much effort to implement.
    //   If so, we'll probably need something different than the `isPropsMixin` check below,
    //   and may need to more aggressively filter out supertypes up front to avoid performance issues and false positives,
    //   like UiProps and its supertypes (Map, MapBase, MapViewMixin, PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin)
    final isPropsMixin = c is MixinElement && c.superclassConstraints.any((s) => s.element.name == 'UiProps');
    if (!isPropsMixin) continue;
    if (c.source.uri.path.endsWith('.over_react.g.dart')) continue;

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
