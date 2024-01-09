import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

import 'get_all_props.dart';

/// Computes all required props declared in a given props class [element] and its supertypes.
RequiredPropInfo getRequiredPropInfo(InterfaceElement element) {
  final requiredFieldsByName = <String, FieldElement>{};
  final propRequirednessByName = <String, PropRequiredness>{};
  for (final propField in getAllProps(element)) {
    if (requiredFieldsByName.containsKey(propField.name)) {
      // Short-circuit if we've already identified this field as required.
      // There might be duplicates if props are overridden, and there will
      // definitely be duplicates in the builder-generated code.
      continue;
    }

    final requiredness = _getPropRequiredness(propField);
    propRequirednessByName[propField.name] = requiredness;
    if (requiredness.isRequired) {
      requiredFieldsByName[propField.name] = propField;
    }
  }
  return RequiredPropInfo._(requiredFieldsByName, propRequirednessByName);
}

/// A collection of information about all required props declared in a given props class and its supertypes,
/// returned by [getRequiredPropInfo].
class RequiredPropInfo {
  /// A mapping of prop field names to the fields that declare them, containing only required props.
  final Map<String, FieldElement> requiredFieldsByName;

  /// A mapping of prop field names to their requiredness, containing only required props.
  final Map<String, PropRequiredness> propRequirednessByName;

  RequiredPropInfo._(this.requiredFieldsByName, this.propRequirednessByName);

  /// The prop field names of all required props.
  Iterable<String> get requiredPropNames => requiredFieldsByName.keys;
}

/// Returns the requiredness for a given prop field declared by [propField].
PropRequiredness _getPropRequiredness(FieldElement propField) {
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

/// A value representing whether a prop is required, and how it's required.
enum PropRequiredness {
  /// Represents a prop required via annotations: `@requiredProp`, `@requiredNullableProp`, or `@Accessor(isRequired: true)`.
  ///
  /// When missing, will either throw, warn, or do nothing at component render, depending on the component boilerplate.
  ///
  /// Deprecated in favor of [late].
  annotation(isRequired: true),

  /// Represents a prop required via late keyword (only available in null-safe language versions).
  ///
  /// When missing, throws upon UiProps invocation when asserts are enabled when invoking a builder (new boilerplate only).
  late(isRequired: true),

  /// Represents a prop that is not required.
  none(isRequired: false);

  const PropRequiredness({required this.isRequired});

  /// Whether this value is considered at all required.
  final bool isRequired;
}

/// Returns whether required prop validation is disabled for a given prop declared via [propField],
/// via the `@disableRequiredPropValidation` annotation.
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
