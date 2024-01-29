import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

import 'defaulted_props.dart';
import 'get_all_props.dart';

/// Returns info about the requiredness of all props declared in a given props class [element] and its supertypes.
///
/// Like [getAllProps], but with aggregated info about required props.
RequiredPropInfo getAllRequiredProps(InterfaceElement element) {
  final ignoredRequiredPropNames = getIgnoredRequiredPropNames(element);

  final shouldIgnoreDefaultPropNames = getDisableValidationForClassDefaultProps(element);
  final ignoredDefaultPropNames =
      shouldIgnoreDefaultPropNames ? getDefaultedPropsForComponentWithPropsClass(element) : null;

  final requiredFieldsByName = <String, FieldElement>{};
  final propRequirednessByName = <String, PropRequiredness>{};
  for (final propField in getAllProps(element)) {
    final name = propField.name;

    if (ignoredRequiredPropNames?.contains(name) ?? false) {
      // Even if this prop is declared as required, the consuming class wants to ignore it.
      propRequirednessByName[name] = PropRequiredness.ignoredByConsumingClass;
      continue;
    }

    if (ignoredDefaultPropNames?.contains(name) ?? false) {
      // Even if this prop is declared as required, the consuming class wants to ignore it.
      propRequirednessByName[name] = PropRequiredness.ignoredViaDefault;
      continue;
    }

    // If there's an existing entry, we're dealing with a redeclared prop in a different mixin
    // (either an explicit override or not) that we processed in a previous iteration.
    // Since it could have a different requiredness, use the maximum requiredness between the two.
    final requiredness = maxRequiredness(_getPropRequiredness(propField), propRequirednessByName[name]);

    propRequirednessByName[name] = requiredness;
    if (requiredness.isRequired) {
      requiredFieldsByName[name] = propField;
    }
  }
  return RequiredPropInfo._(requiredFieldsByName, propRequirednessByName);
}

/// A collection of all props declared in a given props class and its supertypes,
/// and whether each prop is required.
///
/// Returned by [getAllRequiredProps].
class RequiredPropInfo {
  /// A mapping of prop field names to the fields that declare them, containing only required props.
  final Map<String, FieldElement> requiredFieldsByName;

  /// A mapping of all prop field names to their requiredness.
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
    if (annotation.element?.library?.name != 'over_react.component_declaration.annotations') {
      return false;
    }
    // It's almost always going to be `requiredProp` or `Accessor`;
    // skip more checks and just try to pull the bool field `isRequired` off of the constant value.
    // If it fails, it's not the annotation we're interested in anyways.
    return annotation.computeConstantValue()?.getField('isRequired')?.toBoolValue() ?? false;
  })) {
    return PropRequiredness.annotation;
  }

  return PropRequiredness.none;
}

/// A value representing whether a prop is required, and how it's required.
enum PropRequiredness {
  /// Represents a prop required via late keyword (only available in null-safe language versions).
  ///
  /// When missing, throws upon UiProps invocation when asserts are enabled when invoking a builder (new boilerplate only).
  late(isRequired: true),

  /// Represents a prop required via annotations: `@requiredProp`, `@requiredNullableProp`, or `@Accessor(isRequired: true)`.
  ///
  /// When missing, will either throw, warn, or do nothing at component render, depending on the component boilerplate.
  ///
  /// Deprecated in favor of [late].
  annotation(isRequired: true),

  /// Represents a prop that was considered required in its declaration,
  /// but is automatically ignored because the class component provides a default for it.
  ignoredViaDefault(isRequired: false),

  /// Represents a prop that was considered required in its declaration,
  /// but is ignored by the consuming class via `@Props(disableRequiredPropValidation: {…})`.
  ignoredByConsumingClass(isRequired: false),

  /// Represents a prop that is not required.
  none(isRequired: false);

  const PropRequiredness({required this.isRequired});

  /// Whether this value is considered at all required.
  final bool isRequired;

  /// An ordered list of values from "most" to "least" required.
  ///
  /// Used by [maxRequiredness] to determine the relative requiredness of values.
  static const _mostToLeastRequired = [
    PropRequiredness.late,
    PropRequiredness.annotation,
    PropRequiredness.ignoredViaDefault,
    PropRequiredness.ignoredByConsumingClass,
    PropRequiredness.none,
  ];
}

/// Returns the most required value between [a] and [b].
///
/// For convenience, returns [a] when [b] is null.
PropRequiredness maxRequiredness(PropRequiredness a, PropRequiredness? b) {
  if (b == null) return a;

  final aIndex = PropRequiredness._mostToLeastRequired.indexOf(a);
  final bIndex = PropRequiredness._mostToLeastRequired.indexOf(b);

  assert(aIndex != -1);
  assert(bIndex != -1);

  return aIndex < bIndex ? a : b;
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

/// Returns whether validation should be automatically disabled for defaulted class component props,
/// from the `@Props(disableValidationForClassDefaultProps: …)` annotation if present.
bool getDisableValidationForClassDefaultProps(InterfaceElement element) =>
    _getPropsAnnotation(element)?.getField('disableValidationForClassDefaultProps')?.toBoolValue() ?? true;

/// Returns the prop names that should not be considered required for a given concrete props class,
/// from the `@Props(disableRequiredPropValidation: {…})` annotation.
Set<String>? getIgnoredRequiredPropNames(InterfaceElement element) {
  final ignoredNamesValue = _getPropsAnnotation(element)?.getField('disableRequiredPropValidation')?.toSetValue();
  return ignoredNamesValue?.map((v) => v.toStringValue()).whereNotNull().toSet();
}

DartObject? _getPropsAnnotation(InterfaceElement element) => element.metadata
    .firstWhereOrNull((m) => m.element.tryCast<ConstructorElement>()?.enclosingElement.name == 'Props')
    ?.computeConstantValue();
