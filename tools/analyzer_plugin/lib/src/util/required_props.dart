import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

PropRequiredness getPropRequiredness(FieldElement propField) {
  if (propField.isLate) {
    return PropRequiredness.late;
  }

  if (propField.metadata.any((annotation) {
    // Common case, might be good to short circuit here for perf
    if (annotation.isOverride) return false;
    if (annotation.element?.library?.name != 'over_react.component_declaration.annotations') {
      return false;
    }
    // It's almost always going to be `requiredProp` or `Accessor`;
    // skip more checks an just try to pull `isRequired` prop off of them.
    // If it fails, it's not the annotation we're interested in anyways.
    return annotation.computeConstantValue()?.getField('isRequired')?.toBoolValue() ?? false;
  })) {
    return PropRequiredness.annotation;
  }

  return PropRequiredness.none;
}


enum PropRequiredness {
  annotation,
  late,
  none,
}

extension PropRequirednessExtension on PropRequiredness {
  bool get isRequired {
    switch (this) {
      case PropRequiredness.annotation:
      case PropRequiredness.late:
        return true;
      case PropRequiredness.none:
        return false;
    }
  }
}

bool isRequiredPropValidationDisabled(FieldElement propField) {
  return propField.metadata.any((annotation) {
    return annotation
            .computeConstantValue()
            ?.type
            ?.element
            ?.isElementFromPackage('_DisableRequiredPropValidation', 'over_react') ??
        false;
  });
}
