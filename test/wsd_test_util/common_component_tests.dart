library test_util.common_component_tests;

import 'dart:collection';
import 'dart:html';
// Tell dart2js that this library only needs to reflect types annotated with `Props`.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(metaTargets: const [
  'web_skin_dart.component_declaration.annotations.Props'
])
import 'dart:mirrors';

import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_base.dart' as component_base;
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';
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
        owner != ComponentDefinition &&
        owner != BaseComponentDefinition &&
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
      if (root['props'][forwardedPropBeacon] == true || getProps(root)?.containsKey(forwardedPropBeacon) == true) {
        forwardingTargets.add(root);
      }

      final children = root['props']['children'];

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
void testPropForwarding(BuilderOnlyUiFactory factory, dynamic childrenFactory(), {List unconsumedPropKeys: const []}) {
  test('forwards unconsumed props as expected', () {
    const Map extraProps = const {
      // Add this so we find the right component(s) with [getForwardingTargets] later.
      forwardedPropBeacon: true,

      'data-true': true,
      'aria-true': true,
      'other-true': true,

      'data-null': null,
      'aria-null': null,
      'other-null': null
    };

    const String key = 'testKeyThatShouldNotBeForwarded';
    const String ref = 'testRefThatShouldNotBeForwarded';

    var defaultPropsHelperInstance = render(factory()(childrenFactory()));
    Map defaultProps = getDartComponent(defaultPropsHelperInstance).getDefaultProps();
    unmount(defaultPropsHelperInstance);

    // TODO: Account for alias components.
    Map propsThatShouldNotGetForwarded = {}
      ..addAll(new Map.fromIterable(getComponentPropKeys(factory), value: (_) => null))
      ..addAll(defaultProps)
      // Account for any props added by the factory
      ..addAll(factory().props);

      unconsumedPropKeys.forEach((key) => propsThatShouldNotGetForwarded.remove(key));

    var shallowRenderer = react_test_utils.createRenderer();

    // Use RenderingContainerComponentFactory so we can set ref on our test component
    var instance = (factory()
          ..addProps(propsThatShouldNotGetForwarded)
          ..addProps(extraProps)
          ..key = key
          ..ref = ref
        )(childrenFactory());

    shallowRenderer.render(instance);
    var result = shallowRenderer.getRenderOutput();

    var forwardingTargets = getForwardingTargets(result, shallowRendered: true);

    for (var forwardingTarget in forwardingTargets) {
      Map actualProps = getProps(forwardingTarget);

      // Expect the target to have all forwarded props.
      extraProps.forEach((key, value) {
        expect(actualProps, containsPair(key, value));
      });

      Set unexpectedKeys = actualProps.keys.toSet().intersection(propsThatShouldNotGetForwarded.keys.toSet());
      expect(unexpectedKeys, isEmpty, reason: 'Should filter out all consumed props');
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

  test('can override added class names: ${classesToOverride}', () {
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

/// By default, render components without children.
dynamic _defaultChildrenFactory() => [];

/// Run common component tests around default props, prop forwarding, class name merging, and class name overrides.
///
/// Best used within a group() within a component's test suite.
///
/// [unconsumedPropKeys] should be used when a component has props as part of it's definition that ARE forwarded
/// to its children (ie, a smart component wrapping a primitive and forwarding some props to it). By default [testPropForwarding]
/// tests that all consumed props are not forwarded, so you can specify forwarding props in [unconsumedPropKeys].
///
/// [childrenFactory] returns children to be used when rendering components.
/// This is necessary for components that need children to render properly.
void commonComponentTests(BuilderOnlyUiFactory factory, {
  bool shouldTestPropForwarding: true,
  List<String> unconsumedPropKeys: const <String>[],
  bool shouldTestClassNameMerging: true,
  bool shouldTestClassNameOverrides: true,
  dynamic childrenFactory()
}) {
  childrenFactory ??= _defaultChildrenFactory;

  if (shouldTestPropForwarding) {
    testPropForwarding(factory, childrenFactory, unconsumedPropKeys: unconsumedPropKeys);
  }
  if (shouldTestClassNameMerging) {
    testClassNameMerging(factory, childrenFactory);
  }
  if (shouldTestClassNameOverrides) {
    testClassNameOverrides(factory, childrenFactory);
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
