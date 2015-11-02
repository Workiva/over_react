library test_util.custom_matchers;

import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Match a list of class names on a component
class ClassNameMatcher extends Matcher {
  // Class names that are expected
  final Set expectedClasses;
  // Class names that we do not want
  final Set unexpectedClasses;
  /// Whether or not to allow extraneous classes (classes not specified in expectedClasses).
  final bool allowExtraneous;

  static Iterable getClassIterable(dynamic classNames) {
    Iterable classes;
    if (classNames is Iterable<String>) {
      classes = (classNames as Iterable).where((className) => className != null).expand(splitClassName);
    } else if (classNames is String) {
      classes = splitClassName(classNames);
    } else {
      throw new ArgumentError.value(classNames, 'Must be a list of classNames or a className string', 'classNames');
    }

    return classes;
  }

  ClassNameMatcher.expected(_expectedClasses, {this.allowExtraneous: true}) :
    this.expectedClasses = getClassIterable(_expectedClasses).toSet(),
    this.unexpectedClasses = new Set();


  ClassNameMatcher.unexpected(_unexpectedClasses) :
    this.unexpectedClasses = getClassIterable(_unexpectedClasses).toSet(),
    this.allowExtraneous = true,
    this.expectedClasses = new Set();

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
    if (matchState == null) {
      mismatchDescription.add('what');
      return mismatchDescription;
    }

    Set missingClasses = matchState['missingClasses'];
    Set unwantedClasses = matchState['unwantedClasses'];
    List extraneousClasses = matchState['extraneousClasses'];

    List<String> descriptionParts = [];
    if (allowExtraneous) {
      if (missingClasses.isNotEmpty) {
        descriptionParts.add('is missing classes: $missingClasses');
      }
      if (unwantedClasses.isNotEmpty) {
        descriptionParts.add('has unwanted classes: $unwantedClasses');
      }
    } else {
      if (extraneousClasses.isNotEmpty) {
        descriptionParts.add('has extraneous classes: $extraneousClasses');
      }
    }
    mismatchDescription.add(descriptionParts.join('; '));

    return mismatchDescription;
  }
}

class IsNode extends CustomMatcher {
  IsNode(matcher) : super("Element with nodeName that is", "nodeName", matcher);
  featureValueOf(actual) => actual.nodeName;
}

class _ElementClassNameMatcher extends CustomMatcher {
  _ElementClassNameMatcher(matcher) : super('Element that', 'className', matcher);
  featureValueOf(Element actual) => actual.className;
}
class _ElementAttributeMatcher extends CustomMatcher {
  String _attributeName;

  _ElementAttributeMatcher(String attributeName, matcher) :
      this._attributeName = attributeName,
      super('Element with "$attributeName" attribute that equals', 'attributes', matcher);

  featureValueOf(Element element) => element.getAttribute(_attributeName);
}

Matcher hasClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.expected(classes));
Matcher hasExactClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.expected(classes, allowExtraneous: false));
Matcher excludesClasses(classes) => new _ElementClassNameMatcher(new ClassNameMatcher.unexpected(classes));
Matcher hasAttr(String attributeName, value) => new _ElementAttributeMatcher(attributeName, wrapMatcher(value));
Matcher hasNodeName(String nodeName) => new IsNode(equalsIgnoringCase(nodeName));
