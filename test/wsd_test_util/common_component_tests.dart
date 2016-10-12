library test_util.common_component_tests;

import 'dart:collection';
import 'dart:html';
// Tell dart2js that this library only needs to reflect types annotated with `Props`.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(metaTargets: const [
  'over_react.component_declaration.annotations.Props'
])
import 'dart:mirrors';

import 'package:browser_detect/browser_detect.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:over_react/src/over_react/component_declaration/component_base.dart' as component_base;
import '../test_util/test_util.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';

/// Returns all the prop keys available on a component definition, using reflection.
Set getComponentPropKeys(BuilderOnlyUiFactory factory) {
  var definition = factory();
  InstanceMirror definitionMirror = reflect(definition);

  // Use prop getters on the props class to infer the prop keys for the component.
  // Set all props to null to create key-value pairs for each prop, and then return those keys.
  definitionMirror.type.instanceMembers.values.forEach((MethodMirror decl) {
    // Filter out all members except concrete instance getters.
    if (!decl.isGetter || decl.isSynthetic || decl.isStatic) {
      return;
    }

    Type owner = (decl.owner as ClassMirror).reflectedType;
    if (owner != Object &&
        owner != component_base.UiProps &&
        owner != component_base.PropsMapViewMixin &&
        owner != component_base.MapViewMixin &&
        owner != MapView &&
        owner != ReactPropsMixin &&
        owner != DomPropsMixin &&
        owner != CssClassPropsMixin &&
        owner != UbiquitousDomPropsMixin
    ) {
      // Some of the getters won't correspond to props, and won't have setters.
      // Catch resultant exceptions and move on.
      try {
        definitionMirror.setField(decl.simpleName, null);
      } catch(_) {}
    }
  });

  return definition.keys.toSet();
}

/// Prop key for use in conjunction with [getForwardingTargets].
const String forwardedPropBeacon = 'data-forwarding-target';
/// Return the components to which props have been forwarded (identified using the [forwardedPropBeacon] prop).
List getForwardingTargets(reactInstance, {int expectedTargetCount: 1, shallowRendered: false}) {
  if (!forwardedPropBeacon.startsWith('data-')) {
    throw new Exception('forwardedPropBeacon must begin with "data-" so that is a valid HTML attribute.');
  }

  List forwardingTargets = [];

  if (shallowRendered) {
    getTargets(root) {
      var rootProps = getProps(root);
      if (rootProps.containsKey(forwardedPropBeacon)) {
        forwardingTargets.add(root);
      }

      final children = rootProps['children'];

      if (children is List) {
        flattenChildren(List _children) {
          _children.forEach((_child) {
            if (_child != null && isValidElement(_child)) {
              getTargets(_child);
            }  else if (_child is List) {
              flattenChildren(_child);
            }
          });
        }

        flattenChildren(children);
      } else if (isValidElement(children)) {
        getTargets(children);
      }
    }

    getTargets(reactInstance);
  } else {
    // Filter out non-DOM components (e.g., React.DOM.Button uses composite components to render)
    forwardingTargets = findDescendantsWithProp(reactInstance, forwardedPropBeacon);
    forwardingTargets = forwardingTargets.where(react_test_utils.isDOMComponent).toList();
  }

  if (forwardingTargets.length != expectedTargetCount) {
    throw 'Unexpected number of forwarding targets: ${forwardingTargets.length}.';
  }
  return forwardingTargets;
}

/// Common test for verifying that unconsumed props are forwarded as expected.
void testPropForwarding(BuilderOnlyUiFactory factory, dynamic childrenFactory(), {
    List unconsumedPropKeys: const [],
    bool ignoreDomProps: true,
    List skippedPropKeys: const [],
    Map nonDefaultForwardingTestProps: const {}
}) {
  test('forwards unconsumed props as expected', () {
    const Map extraProps = const {
      // Add this so we find the right component(s) with [getForwardingTargets] later.
      forwardedPropBeacon: true,

      'data-true': true,
      'aria-true': true,

      'data-null': null,
      'aria-null': null
    };

    const Map otherProps = const {
      'other-true': true,
      'other-null': null
    };

    const String key = 'testKeyThatShouldNotBeForwarded';
    const String ref = 'testRefThatShouldNotBeForwarded';

    /// Get defaults from a ReactElement to account for default props and any props added by the factory.
    Map defaultProps = new Map.from(getProps(factory()()))
      ..remove('children');

    // TODO: Account for alias components.
    Map propsThatShouldNotGetForwarded = {}
      ..addAll(new Map.fromIterable(getComponentPropKeys(factory), value: (_) => null))
      // Add defaults afterwards so that components don't blow up when they have unexpected null props.
      ..addAll(defaultProps)
      ..addAll(nonDefaultForwardingTestProps);

      unconsumedPropKeys.forEach(propsThatShouldNotGetForwarded.remove);

      if (ignoreDomProps) {
        // Remove DomProps because they should be forwarded.
        const $PropKeys(DomPropsMixin).forEach(propsThatShouldNotGetForwarded.remove);
      }

    var shallowRenderer = react_test_utils.createRenderer();

    var instance = (factory()
      ..addProps(propsThatShouldNotGetForwarded)
      ..addProps(extraProps)
      ..addProps(otherProps)
      ..key = key
      ..ref = ref
    )(childrenFactory());

    shallowRenderer.render(instance);
    var result = shallowRenderer.getRenderOutput();

    var forwardingTargets = getForwardingTargets(result, shallowRendered: true);

    for (var forwardingTarget in forwardingTargets) {
      Map actualProps = getProps(forwardingTarget);

      // If the forwarding target is a DOM element it will should not have invalid DOM props forwared to it.
      if (isDomElement(forwardingTarget)) {
        otherProps.forEach((key, value) {
          expect(actualProps, isNot(containsPair(key, value)));
        });
      } else {
        otherProps.forEach((key, value) {
          expect(actualProps, containsPair(key, value));
        });
      }

      // Expect the target to have all forwarded props.
      extraProps.forEach((key, value) {
        expect(actualProps, containsPair(key, value));
      });

      var ambiguousProps = {};

      Set propKeysThatShouldNotGetForwarded = propsThatShouldNotGetForwarded.keys.toSet();
      // Don't test any keys specified by skippedPropKeys.
      propKeysThatShouldNotGetForwarded.removeAll(skippedPropKeys);

      Set unexpectedKeys = actualProps.keys.toSet().intersection(propKeysThatShouldNotGetForwarded);

      /// Test for prop keys that both are forwarded and exist on the forwarding target's default props.
      if (isDartComponent(forwardingTarget)) {
        var forwardingTargetDefaults = ((forwardingTarget as ReactElement).type as ReactClass).dartDefaultProps;

        var commonForwardedAndDefaults = propKeysThatShouldNotGetForwarded
            .intersection(forwardingTargetDefaults.keys.toSet());

        /// Don't count these as unexpected keys in later assertions; we'll verify them within this block.
        unexpectedKeys.removeAll(commonForwardedAndDefaults);

        commonForwardedAndDefaults.forEach((propKey) {
          var defaultTargetValue = forwardingTargetDefaults[propKey];
          var potentiallyForwardedValue = propsThatShouldNotGetForwarded[propKey];

          if (defaultTargetValue != potentiallyForwardedValue) {
            /// If the potentially forwarded value and the default are different,
            /// we can tell whether it was forwarded.
            expect(actualProps, isNot(containsPair(propKey, potentiallyForwardedValue)),
                reason: 'The `$propKey` prop was forwarded when it should not have been');
          } else {
            /// ...otherwise, we can't be certain that the value isn't being forwarded.
            ambiguousProps[propKey] = defaultTargetValue;
          }
        });
      }

      expect(unexpectedKeys, isEmpty, reason: 'Should filter out all consumed props');

      if (ambiguousProps.isNotEmpty) {
        fail(unindent(
            '''
            Encountered ambiguous forwarded props; some unconsumed props coincide with defaults on the forwarding target, and cannot be automatically tested.

            Try either:
              - specifying `nonDefaultForwardingTestProps` as a Map with valid prop values that are different than the following: $ambiguousProps
              - specifying `skippedPropKeys` with the following prop keys and testing their forwarding manually: ${ambiguousProps.keys.toList()}
            '''
        ));
      }
    }
  });
}

/// Common test for verifying that classNames are merged/blacklisted as expected.
void testClassNameMerging(BuilderOnlyUiFactory factory, dynamic childrenFactory()) {
  test('merges classes as expected', () {
    var builder = factory()
      ..addProp(forwardedPropBeacon, true)
      ..className = 'custom-class-1 blacklisted-class-1 custom-class-2 blacklisted-class-2'
      ..classNameBlacklist = 'blacklisted-class-1 blacklisted-class-2';

    var renderedInstance = render(builder(childrenFactory()));
    Iterable<Element> forwardingTargetNodes = getForwardingTargets(renderedInstance).map(findDomNode);

    expect(forwardingTargetNodes, everyElement(
        allOf(
            hasClasses('custom-class-1 custom-class-2'),
            excludesClasses('blacklisted-class-1 blacklisted-class-2')
        )
    ));

    unmount(renderedInstance);
  });

  test('adds custom classes to one and only one element', () {
    const customClass = 'custom-class';

    var renderedInstance = render(
        (factory()..className = customClass)(childrenFactory())
    );
    var descendantsWithCustomClass = react_test_utils.scryRenderedDOMComponentsWithClass(renderedInstance, customClass);

    expect(descendantsWithCustomClass, hasLength(1));

    unmount(renderedInstance);
  });
}

/// Common test for verifying that CSS classes added by the component can be blacklisted by the consumer.
void testClassNameOverrides(BuilderOnlyUiFactory factory, dynamic childrenFactory()) {
  /// Render a component without any overrides to get the classes added by the component.
  var reactInstanceWithoutOverrides = render(
      (factory()
        ..addProp(forwardedPropBeacon, true)
      )(childrenFactory())
  );

  Set<String> classesToOverride;
  var error;

  // Catch and rethrow getForwardingTargets-related errors so we can use classesToOverride in the test description,
  // but still fail the test if something goes wrong.
  try {
    classesToOverride = getForwardingTargets(reactInstanceWithoutOverrides)
        .map((target) => findDomNode(target).classes)
        .expand((CssClassSet classSet) => classSet)
        .toSet();
  } catch(e) {
    error = e;
  }

  unmount(reactInstanceWithoutOverrides);

  test('can override added class names: $classesToOverride', () {
    if (error != null) {
      throw error;
    }

    // Override any added classes and verify that they are blacklisted properly.
    var reactInstance = render(
        (factory()
          ..addProp(forwardedPropBeacon, true)
          ..classNameBlacklist = classesToOverride.join(' ')
        )(childrenFactory())
    );

    Iterable<Element> forwardingTargetNodes = getForwardingTargets(reactInstance).map(findDomNode);
    expect(forwardingTargetNodes, everyElement(
        hasExactClasses('')
    ));

    unmount(reactInstance);
  });
}

/// Common test for verifying that required props are validated correctly.
void testRequiredProps(BuilderOnlyUiFactory factory, dynamic childrenFactory()) {
  var component = renderAndGetComponent(factory()(childrenFactory()));
  var consumedProps = component.consumedProps;
  var requiredProps = [];
  var nullableProps = [];
  var keyToErrorMessage = {};

  consumedProps.forEach((ConsumedProps consumedProps) {
    consumedProps.props.forEach((PropDescriptor prop) {
      if (prop.isRequired) {
        requiredProps.add(prop.key);
      } else if (prop.isNullable) {
        nullableProps.add(prop.key);
      }

      keyToErrorMessage[prop.key] = prop.errorMessage ?? '';
    });
  });

  group('throws when the required prop', () {
    requiredProps.forEach((String propKey) {
      // Props that are defined in the default props map will never not be set.
      if (!factory().componentFactory.defaultProps.containsKey(propKey)) {
        test('$propKey is not set', () {
          var badRenderer = () => render((factory()
            ..remove(propKey)
          )(childrenFactory()));

          expect(badRenderer, throwsPropError_Required(propKey, keyToErrorMessage[propKey]));
        });
      }

      test('$propKey is set to null', () {
        var propsToAdd = {propKey: null};
        var badRenderer = () => render((factory()
          ..addAll(propsToAdd)
        )(childrenFactory()));

        expect(badRenderer, throwsPropError_Required(propKey, keyToErrorMessage[propKey]));
      });
    });
  });

  nullableProps.forEach((String propKey) {
    test('throws when the the required, nullable prop $propKey is not set', () {
      var badRenderer = () => render((factory()..remove(propKey)(childrenFactory())));

      expect(badRenderer, throwsPropError_Required(propKey, keyToErrorMessage[propKey]));
    });

    test('does not throw when the required, nullable prop $propKey is set to null', () {
      var propsToAdd = {propKey: null};
      var badRenderer = () => render((factory()
        ..addAll(propsToAdd)
      )(childrenFactory()));

      expect(badRenderer, returnsNormally);
    });
  });
}

/// By default, render components without children.
dynamic _defaultChildrenFactory() => [];

/// Run common component tests around default props, prop forwarding, class name merging, and class name overrides.
///
/// Best used within a group() within a component's test suite.
///
/// [unconsumedPropKeys] should be used when a component has props as part of it's definition that ARE forwarded
/// to its children (ie, a smart component wrapping a primitive and forwarding some props to it). By default [testPropForwarding]
/// tests that all consumed props are not forwarded, so you can specify forwarding props in [unconsumedPropKeys]
/// (which gets flattened into a 1D array of strings).
///
/// When the forwarding of certain props is ambiguous (see error message in [testPropForwarding]), you can resolve this
/// by specifying [nonDefaultForwardingTestProps], a map of prop values that aren't the same as the forwarding target's defaults.
///
/// If [nonDefaultForwardingTestProps] can't be used for some reason, you can skip prop forwarding tests altogether for
/// certain props by specifying their keys in [skippedPropKeys] (which gets flattened into a 1D array of strings).
///
/// [childrenFactory] returns children to be used when rendering components.
/// This is necessary for components that need children to render properly.
void commonComponentTests(BuilderOnlyUiFactory factory, {
  bool shouldTestPropForwarding: true,
  List unconsumedPropKeys: const [],
  List skippedPropKeys: const [],
  Map nonDefaultForwardingTestProps: const {},
  bool shouldTestClassNameMerging: true,
  bool shouldTestClassNameOverrides: true,
  bool ignoreDomProps: true,
  bool shouldTestRequiredProps: true,
  dynamic childrenFactory()
}) {
  childrenFactory ??= _defaultChildrenFactory;

  Iterable flatten(Iterable iterable) =>
      iterable.expand((item) => item is Iterable ? flatten(item) : [item]);

  unconsumedPropKeys = flatten(unconsumedPropKeys).toList();
  skippedPropKeys = flatten(skippedPropKeys).toList();

  // TODO: Remove this short-circuit when UIP-1125.
  if (browser.isIe && browser.version <= '10') return;

  if (shouldTestPropForwarding) {
    testPropForwarding(factory, childrenFactory,
        unconsumedPropKeys: unconsumedPropKeys,
        ignoreDomProps: ignoreDomProps,
        skippedPropKeys: skippedPropKeys,
        nonDefaultForwardingTestProps: nonDefaultForwardingTestProps
    );
  }
  if (shouldTestClassNameMerging) {
    testClassNameMerging(factory, childrenFactory);
  }
  if (shouldTestClassNameOverrides) {
    testClassNameOverrides(factory, childrenFactory);
  }
  if (shouldTestRequiredProps) {
    testRequiredProps(factory, childrenFactory);
  }
}

/// Adds a [setUpAll] and [tearDownAll] pair to the current group that verifies that
/// no new elements exist on the test surface after everything is done running.
void expectCleanTestSurfaceAtEnd() {
  Set<Element> nodesBefore;

  setUpAll(() {
    nodesBefore = document.body.children.toSet();
  });

  tearDownAll(() {
    Set<Element> nodesAfter = document.body.children.toSet();
    var nodesAdded = nodesAfter.difference(nodesBefore).map((element) => element.outerHtml).toList();

    expect(nodesAdded, isEmpty, reason: 'tests should leave the test surface clean.');
  });
}
