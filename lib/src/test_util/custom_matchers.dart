library test_util.custom_matchers;

import 'dart:html';

import 'package:matcher/matcher.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Match a list of class names on a component
class ClassNameMatcher extends Matcher {
  ClassNameMatcher.expected(_expectedClasses, {this.allowExtraneous: true}) :
    this.expectedClasses = getClassIterable(_expectedClasses).toSet(),
    this.unexpectedClasses = new Set();


  ClassNameMatcher.unexpected(_unexpectedClasses) :
    this.unexpectedClasses = getClassIterable(_unexpectedClasses).toSet(),
    this.allowExtraneous = true,
    this.expectedClasses = new Set();

  // Class names that are expected
  final Set expectedClasses;
  // Class names that we do not want
  final Set unexpectedClasses;
  /// Whether or not to allow extraneous classes (classes not specified in expectedClasses).
  final bool allowExtraneous;

  static Iterable getClassIterable(dynamic classNames) {
    Iterable classes;
    if (classNames is Iterable<String>) {
      classes = (classNames as Iterable).where((className) => className != null).expand(splitSpaceDelimitedString);
    } else if (classNames is String) {
      classes = splitSpaceDelimitedString(classNames);
    } else {
      throw new ArgumentError.value(classNames, 'Must be a list of classNames or a className string', 'classNames');
    }

    return classes;
  }

  @override
  bool matches(String className, Map matchState) {
    Iterable actualClasses = getClassIterable(className);
    Set missingClasses = expectedClasses.difference(actualClasses.toSet());
    Set unwantedClasses = unexpectedClasses.intersection(actualClasses.toSet());

    // Calculate extraneous classes with Lists instead of Sets, to catch duplicates in actualClasses.
    List expectedClassList = expectedClasses.toList();
    List extraneousClasses = actualClasses
                             .where((className) => !expectedClassList.remove(className))
                             .toList();

    matchState.addAll({
      'missingClasses': missingClasses,
      'unwantedClasses': unwantedClasses,
      'extraneousClasses': extraneousClasses
    });

    if (allowExtraneous) {
      return missingClasses.isEmpty && unwantedClasses.isEmpty;
    } else {
      return missingClasses.isEmpty && extraneousClasses.isEmpty;
    }
  }

  @override
  Description describe(Description description) {
    List<String> descriptionParts = [];
    if (allowExtraneous) {
      if (expectedClasses.isNotEmpty) {
        descriptionParts.add('has the classes: $expectedClasses');
      }
      if (unexpectedClasses.isNotEmpty) {
        descriptionParts.add('does not have the classes: $unexpectedClasses');
      }
    } else {
      descriptionParts.add('has ONLY the classes: $expectedClasses');
    }
    description.add(descriptionParts.join(' and '));

    return description;
  }

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    Set missingClasses = matchState['missingClasses'];
    Set unwantedClasses = matchState['unwantedClasses'];
    List extraneousClasses = matchState['extraneousClasses'];

    List<String> descriptionParts = [];
    if (allowExtraneous) {
      if (unwantedClasses.isNotEmpty) {
        descriptionParts.add('has unwanted classes: $unwantedClasses');
      }
    } else {
      if (extraneousClasses.isNotEmpty) {
        descriptionParts.add('has extraneous classes: $extraneousClasses');
      }
    }

    if (missingClasses.isNotEmpty) {
      descriptionParts.add('is missing classes: $missingClasses');
    }

    mismatchDescription.add(descriptionParts.join('; '));

    return mismatchDescription;
  }
}

class IsNode extends CustomMatcher {
  IsNode(matcher) : super("Element with nodeName that is", "nodeName", matcher);
  @override
  featureValueOf(actual) => actual.nodeName;
}

class _ElementClassNameMatcher extends CustomMatcher {
  _ElementClassNameMatcher(matcher) : super('Element that', 'className', matcher);
  @override
  featureValueOf(Element actual) => actual.className;
}
class _ElementAttributeMatcher extends CustomMatcher {
  String _attributeName;

  _ElementAttributeMatcher(String attributeName, matcher) :
      this._attributeName = attributeName,
      super('Element with "$attributeName" attribute that equals', 'attributes', matcher);

  @override
  featureValueOf(Element element) => element.getAttribute(_attributeName);
}

class _HasToStringValue extends CustomMatcher {
  _HasToStringValue(matcher) : super('Object with toString() value', 'toString()', matcher);

  @override
  featureValueOf(Object item) => item.toString();
}

class _HasPropMatcher extends CustomMatcher {
  final dynamic _propKey;

  _HasPropMatcher(propKey, propValue)
      : this._propKey = propKey,
        super('React instance with props that', 'props/attributes map', containsPair(propKey, propValue));

  static bool _useDomAttributes(item) => react_test_utils.isDOMComponent(item);

  static bool _isValidDomPropKey(propKey) => (
      const $PropKeys(DomPropsMixin).contains(propKey) ||
      const $PropKeys(SvgPropsMixin).contains(propKey) ||
      (propKey is String && (
          propKey.startsWith('data-') ||
          propKey.startsWith('aria-'))
      )
  );

  @override
  Map featureValueOf(item) {
    if (_useDomAttributes(item)) return findDomNode(item).attributes;
    if (item is react.Component) return item.props;

    return getProps(item);
  }

  @override
  bool matches(item, Map matchState) {
    /// Short-circuit null items to avoid errors in `containsPair`.
    if (item == null) return false;

    if (_useDomAttributes(item) && !_isValidDomPropKey(_propKey)) {
      matchState['unsupported'] =
          'Cannot verify whether the `$_propKey` prop is available on a DOM ReactComponent. '
          'Only props in `DomPropsMixin`/`SvgPropsMixin` or starting with "data-"/"aria-" are supported.';

      return false;
    }

    return super.matches(item, matchState);
  }

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    /// Short-circuit null items to avoid errors in `containsPair`.
    if (item == null) return mismatchDescription;

    if (matchState['unsupported'] != null) {
      return mismatchDescription..add(matchState['unsupported']);
    }

    return super.describeMismatch(item, mismatchDescription, matchState, verbose);
  }
}

/// Returns a matcher that matches an element that has [classes].
Matcher hasClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.expected(classes));
/// Returns a matcher that matches an element that has [classes], with no additional or duplicated classes.
Matcher hasExactClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.expected(classes, allowExtraneous: false));
/// Returns a matcher that matches an element that does not have [classes].
Matcher excludesClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.unexpected(classes));
/// Returns a matcher that matches an element that has [attributeName] set to [value].
Matcher hasAttr(String attributeName, value) => new _ElementAttributeMatcher(attributeName, wrapMatcher(value));
/// Returns a matcher that matches an element with the nodeName of [nodeName].
Matcher hasNodeName(String nodeName) => new IsNode(equalsIgnoringCase(nodeName));

/// Returns a matcher that matches Dart, JS composite, and DOM [ReactElement]s and [ReactComponent]s
/// that contain the prop pair ([propKey], propValue).
///
/// Since props of DOM [ReactComponent]s cannot be read directly, the element's attributes are matched instead.
///
/// This matcher will always fail when unsupported prop keys are tested against a DOM [ReactComponent].
///
/// TODO: add support for prop keys that aren't the same as their attribute keys
Matcher hasProp(dynamic propKey, dynamic propValue) => new _HasPropMatcher(propKey, propValue);

/// Returns a matcher that matches an object whose `toString` value matches [value].
Matcher hasToStringValue(value) => new _HasToStringValue(value);

class _IsFocused extends Matcher {
  const _IsFocused();

  @override
  Description describe(Description description) {
    return description
      ..add('is focused');
  }

  @override
  bool matches(item, Map matchState) {
    matchState['activeElement'] = document.activeElement;

    return item != null && item == document.activeElement;
  }

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Element) {
      return mismatchDescription
        ..add('is not a valid Element.');
    }

    if (!document.documentElement.contains(item)) {
      return mismatchDescription
        ..add('is not attached to the document, and thus cannot be focused.')
        ..add(' If testing with React, you can use `renderAttachedToDocument`.');
    }

    mismatchDescription.add('is not focused; ');

    final activeElement = matchState['activeElement'];
    if (activeElement is! Element || activeElement == document.body) {
      mismatchDescription.add('there is no element currently focused');
    } else {
      mismatchDescription
        ..add('the currently focused element is ')
        ..addDescriptionOf(activeElement);
    }

    return mismatchDescription;
  }
}

/// A matcher that matches the currently focused element (`document.activeElement`).
const Matcher isFocused = const _IsFocused();

/// A matcher to verify that a [RequiredPropError] is thrown with a provided `RequiredPropError.message`
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
///
///  Deprecated: Use [throwsPropError_Required].
@Deprecated('2.0.0')
Matcher throwsRequiredPropError(String message) {
  return throwsA(predicate(
      (error) => error == 'V8 Exception' /* workaround for https://github.com/dart-lang/sdk/issues/26093 */ ||
          error.toString().contains('RequiredPropError: $message'), 'Should have message $message'
  ));
}

/// A matcher to verify that a [InvalidPropCombinationError] is thrown with a provided `InvalidPropCombinationError.prop1`,
/// `InvalidPropCombinationError.prop2`, and `InvalidPropCombinationError.message`.
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
///
///  Deprecated: Use [throwsPropError_Combination].
@Deprecated('2.0.0')
Matcher throwsInvalidPropCombinationError(String prop1, String prop2, String message) {
  return throwsA(predicate(
      (error) => error == 'V8 Exception' /* workaround for https://github.com/dart-lang/sdk/issues/26093 */ ||
          error.toString().contains(
              'InvalidPropCombinationError: Prop $prop1 and prop $prop2 are set to incompatible values: $message'
          )
  ));
}

/// A matcher to verify that the [InvalidPropValueError] is thrown with a provided `InvalidPropValueError.message`
///
///  Deprecated: Use [throwsPropError_Value].
@Deprecated('2.0.0')
Matcher throwsInvalidPropError(dynamic value, String name, String message){
  return throwsA(predicate(
      (error) => error == 'V8 Exception' /* workaround for https://github.com/dart-lang/sdk/issues/26093 */ ||
          error.toString().contains('InvalidPropValueError: Prop $name set to ${Error.safeToString(value)}: $message'),
          'Should have message $message'
  ));
}

/// A matcher to verify that a [PropError] is thrown with a provided `propName` and `message`.
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
Matcher throwsPropError(String propName, [String message = '']) {
  return throwsA(anyOf(
      hasToStringValue('V8 Exception'), /* workaround for https://github.com/dart-lang/sdk/issues/26093 */
      hasToStringValue(contains('PropError: Prop $propName. $message'.trim()))
  ));
}

/// A matcher to verify that a [PropError].required is thrown with a provided `propName` and `message`.
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
Matcher throwsPropError_Required(String propName, [String message = '']) {
  return throwsA(anyOf(
      hasToStringValue('V8 Exception'), /* workaround for https://github.com/dart-lang/sdk/issues/26093 */
      hasToStringValue(contains('RequiredPropError: Prop $propName is required. $message'.trim()))
  ));
}

/// A matcher to verify that a [PropError].value is thrown with a provided `invalidValue`, `propName`, and `message`.
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
Matcher throwsPropError_Value(dynamic invalidValue, String propName, [String message = '']) {
  return throwsA(anyOf(
      hasToStringValue('V8 Exception'), /* workaround for https://github.com/dart-lang/sdk/issues/26093 */
      hasToStringValue(contains('InvalidPropValueError: Prop $propName set to ${Error.safeToString(invalidValue)}. '
          '$message'.trim()
      ))
  ));
}

/// A matcher to verify that a [PropError] is thrown with a provided `propName`, `prop2Name`, and `message`.
///
/// __Note__: The message is matched rather than the [Error] instance due to Dart's wrapping of all `throw`
///  as a [DomException]
Matcher throwsPropError_Combination(String propName, String prop2Name, [String message = '']) {
  return throwsA(anyOf(
      hasToStringValue('V8 Exception'), /* workaround for https://github.com/dart-lang/sdk/issues/26093 */
      hasToStringValue(contains('InvalidPropCombinationError: Prop $propName and prop $prop2Name are set to '
          'incompatible values. $message'.trim()
      ))
  ));
}
