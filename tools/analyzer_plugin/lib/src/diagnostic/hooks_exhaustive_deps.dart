// Adapted from https://github.com/facebook/react/blob/main@%7B2020-10-16%7D/packages/eslint-plugin-react-hooks/src/ExhaustiveDeps.js
//
// MIT License
//
// Copyright (c) Facebook, Inc. and its affiliates.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' show Location;
import 'package:collection/collection.dart' show IterableExtension;
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

// API reference for JS reference/scope APIs:
// https://eslint.org/docs/developer-guide/scope-manager-interface

//
// final _hookNamePattern = RegExp(r'^use[A-Z0-9].*$');
//
// /// Catch all identifiers that begin with "use" followed by an uppercase Latin
// /// character to exclude identifiers like "user".
// bool isHookName(String s) => _hookNamePattern.hasMatch(s);
//

class HooksExhaustiveDeps extends DiagnosticContributor {
  static const debugEnabled = false;

  @DocsMeta('Verifies the list of dependencies for React Hooks like useEffect and similar', details: '')
  static const code = DiagnosticCode(
    'over_react_hooks_exhaustive_deps',
    "{0}",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    url: 'https://reactjs.org/docs/hooks-rules.html',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 200, "{0}");

  final RegExp? additionalHooksPattern;

  HooksExhaustiveDeps({this.additionalHooksPattern});

  @override
  Future<void> computeErrors(result, collector) async {
    final helper = AnalyzerDebugHelper(result, collector, enabled: debugEnabled);
    result.unit!.accept(_ExhaustiveDepsVisitor(
      additionalHooks: additionalHooksPattern,
      result: result,
      diagnosticCollector: collector,
      getSource: (node) => result.content!.substring(node.offset, node.end),
      debug: (string, location) {
        if (!debugEnabled) return;
        Location _location;
        if (location is Location) {
          _location = location;
        } else if (location is AstNode) {
          _location = result.locationFor(location);
        } else if (location is int) {
          _location = result.location(offset: location);
        } else {
          throw ArgumentError.value(location, 'location');
        }
        helper.logWithLocation(string, _location);
      },
    ));
  }
}

class WeakSet<E extends Object> {
  final _isEntry = Expando<Object>();

  void add(E key) {
    _isEntry[key] = const Object();
  }

  bool has(E key) {
    return _isEntry[key] != null;
  }

  void remove(E key) {
    _isEntry[key] = null;
  }
}

class WeakMap<K extends Object, V extends Object> {
  final _keys = WeakSet<K>();
  final _valueFor = Expando<V>();

  V? get(K key) => has(key) ? _valueFor[key] : null;

  V? getNullableKey(K? key) => key == null ? null : get(key);

  void set(K key, V value) {
    _keys.add(key);
    _valueFor[key] = value;
  }

  bool has(K key) => _keys.has(key);

  void remove(K key) {
    _keys.remove(key);
    _valueFor[key] = null;
  }

  V putIfAbsent(K key, V Function() ifAbsent) {
    if (has(key)) return get(key)!;
    final value = ifAbsent();
    set(key, value);
    return value;
  }
}

extension<K extends Object, V extends Object> on V Function(K) {
  V Function(K) memoizeWithWeakMap(WeakMap<K, V> map) {
    return (key) => map.putIfAbsent(key, () => this(key));
  }
}

class _Dependency {
  final bool isStable;
  final List<Identifier> references;

  _Dependency({required this.isStable, required this.references});

  @override
  String toString() => prettyString({
        'isStable': isStable,
        'references': references,
      });
}

class _RefInEffectCleanup {
  final Identifier reference;

  /// [reference].staticElement, but stored as a separate non-nullable field.
  final Element referenceElement;

  final Identifier dependencyNode;

  _RefInEffectCleanup({required this.reference, required this.referenceElement, required this.dependencyNode});

  @override
  String toString() => prettyString({
        'reference': reference,
        'dependencyNode': dependencyNode,
      });
}

FunctionExpression? lookUpFunction(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is Identifier && node.staticElement == element) {
    final parent = node.parent;
    return parent.tryCast<FunctionDeclaration>()?.functionExpression ??
        parent.tryCast<VariableDeclaration>()?.initializer?.tryCast<FunctionExpression>();
  }

  return null;
}

Declaration? lookUpDeclaration(Element element, AstNode root) {
  // if (element is ExecutableElement) return null;
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  final declaration = node?.thisOrAncestorOfType<Declaration>();
  if (declaration?.declaredElement == element) {
    return declaration;
  }

  return null;
}

Iterable<Identifier> resolvedReferencesWithin(AstNode node) =>
    allDescendantsOfType<Identifier>(node).where((e) => e.staticElement != null);

enum HookTypeWithStableMethods { stateHook, reducerHook }

class StableHookMethodInfo {
  final Expression node;

  final Expression target;
  final Identifier property;
  final HookTypeWithStableMethods hookType;

  StableHookMethodInfo({
    required this.node,
    required this.target,
    required this.property,
    required this.hookType,
  }) : assert(target.parent == node && property.parent == node);

  bool get isStateSetterMethod =>
      hookType == HookTypeWithStableMethods.stateHook && stateHookSetMethods.contains(property.name);

  static const stateHookSetMethods = {'set', 'setWithUpdater'};
  static const stableStateHookMethods = {...stateHookSetMethods};
  static const stableReducerHookMethods = {'dispatch'};
// TODO uncomment once TransitionHook is implemented.
// static const stableTransitionHookMethods = {'startTransition'};
}

/// If [node] is an access of a stable hook method on a hook object (either a method call or a tearoff),
/// returns information about that usage. Otherwise, returns `null.
StableHookMethodInfo? getStableHookMethodInfo(AstNode node) {
  // This check is redundant with the if-else below, but allows for type promotion of `node`.
  if (node is! Expression) return null;

  Expression? target;
  Identifier property;
  if (node is MethodInvocation && !node.isCascaded) {
    target = node.target;
    property = node.methodName;
  } else if (node is PropertyAccess && !node.isCascaded) {
    target = node.target;
    property = node.propertyName;
  } else if (node is PrefixedIdentifier) {
    target = node.prefix;
    property = node.identifier;
  } else {
    return null;
  }

  if (target == null) return null;

  // Check whether this reference is only used to access the stable hook property.
  if ((target.staticType?.element?.isStateHook ?? false) &&
      StableHookMethodInfo.stableStateHookMethods.contains(property.name)) {
    return StableHookMethodInfo(
        node: node, target: target, property: property, hookType: HookTypeWithStableMethods.stateHook);
  }

  if ((target.staticType?.element?.isReducerHook ?? false) &&
      StableHookMethodInfo.stableReducerHookMethods.contains(property.name)) {
    return StableHookMethodInfo(
        node: node, target: target, property: property, hookType: HookTypeWithStableMethods.reducerHook);
  }

  // TODO uncomment once TransitionHook is implemented.
  // if ((target.staticType?.element?.isTransitionHook ?? false) &&
  //     stableTransitionHookMethods.contains(property.name)) {
  //   return Tuple2(HookTypeWithStableMethods.transitionHook, property.name);
  // }

  return null;
}

class _ExhaustiveDepsVisitor extends GeneralizingAstVisitor<void> {
  // Should be shared between visitors.
  /// A mapping from setState references to setState declarations
  final setStateCallSites = WeakMap<Identifier, VariableDeclaration>();
  final stateVariables = WeakSet<Identifier>();
  final stableKnownValueCache = WeakMap<Identifier, bool>();
  final functionWithoutCapturedValueCache = WeakMap<Element, bool>();

  DiagnosticCollector diagnosticCollector;

  void reportProblem({required AstNode node, String? message}) {
    diagnosticCollector.addError(HooksExhaustiveDeps.code, result.locationFor(node), errorMessageArgs: [
      message ?? '',
    ]);
  }

  final ResolvedUnitResult result;
  final String Function(SyntacticEntity entity) getSource;
  final RegExp? additionalHooks;
  final void Function(String string, Object? location) debug;

  _ExhaustiveDepsVisitor({
    required this.diagnosticCollector,
    required this.getSource,
    required this.result,
    required this.debug,
    this.additionalHooks,
  });

// Visitor for both function expressions and arrow function expressions.
  void visitFunctionWithDependencies({
    // FIXME(greg) rename this to something better like callbackBody
    required FunctionBody node,
    required AstNode? declaredDependenciesNode,
    required AstNode reactiveHook,
    required String reactiveHookName,
    required bool isEffect,
  }) {
    final rootNode = node.root;

    if (isEffect && node.isAsynchronous) {
      reportProblem(
        node: node,
        message: "Effect callbacks are synchronous to prevent race conditions. "
            "Put the async inside:\n\n"
            'useEffect(() {\n'
            '  fetchData() async {\n'
            '    // You can await here\n'
            '    final response = await myAPI.getData(someId);\n'
            '    // ...\n'
            '  }\n'
            '  fetchData();\n'
            "}, [someId]); // Or [] if effect doesn't need props or state\n\n"
            'Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching',
      );
    }

    // Find all our "pure scopes". On every re-render of a component these
    // pure scopes may have changes to the variables declared within. So all
    // variables used in our reactive hook callback but declared in a pure
    // scope need to be listed as dependencies of our reactive hook callback.
    //
    // According to the rules of React you can't read a mutable value in pure
    // scope. We can't enforce this in a lint so we trust that all variables
    // declared outside of pure scope are indeed frozen.

    // Pure scopes include all scopes from the parent scope of the callback
    // to the first function scope (which will be either the component/render function or a custom hook,
    // since hooks can only be called from the top level).

    final callbackFunctionElement = node.parentDeclaration?.declaredElement;

    // todo improve this
    final componentOrCustomHookFunctionBody = getClosestFunctionComponentOrHookBody(node);
    final componentOrCustomHookFunction = componentOrCustomHookFunctionBody?.parentExpression;
    assert(componentOrCustomHookFunction == null ||
        componentOrCustomHookFunction != node.thisOrAncestorOfType<FunctionExpression>());

    final componentOrCustomHookFunctionElement = componentOrCustomHookFunction?.declaredElement;

    debug('componentOrCustomHookFunctionElement: ${componentOrCustomHookFunctionElement?.debugString}',
        componentOrCustomHookFunction?.offset ?? 0);

    bool isDeclaredInPureScope(Element element) =>
        // todo(greg) is this function even valid when this is null?
        componentOrCustomHookFunctionElement != null &&
        element.thisOrAncestorOfType<ExecutableElement>() == componentOrCustomHookFunctionElement;

    // uiFunction((props), {
    //   // Pure scope 2
    //   var renderVar;
    //   {
    //     // Pure scope 1
    //     var blockVar;
    //
    //     useEffect(() {
    //       // This effect callback block is <node>, the function we're visiting
    //     });
    //   }
    // }, ...)

    // Next we'll define a few helpers that helps us
    // tell if some values don't have to be declared as deps.

    // Some are known to be stable based on Hook calls.
    // const [state, setState] = useState() / React.useState()
    //               ^^^ true for this reference
    // const [state, dispatch] = useReducer() / React.useReducer()
    //               ^^^ true for this reference
    // const ref = useRef()
    //       ^^^ true for this reference
    // False for everything else.
    bool isStableKnownHookValue(Identifier reference) {
      {
        // Check whether this reference is only used to access the stable hook property.
        final parent = reference.parent;
        final stableHookInfo = parent != null ? getStableHookMethodInfo(parent) : null;
        if (stableHookInfo != null && stableHookInfo.target == reference) {
          // FIXME(greg) what about edge cases here?
          if (stableHookInfo.isStateSetterMethod) {
            // TODO(greg) DRY up
            final referenceElement = reference.staticElement;
            final declaration = referenceElement == null
                ? null
                : lookUpDeclaration(referenceElement, reference.root)?.tryCast<VariableDeclaration>();
            if (declaration != null) {
              setStateCallSites.set(reference, declaration);
            }
          }

          return true;
        }
      }

      // FIXME what about function declarations? are those handled elsewhere
      final referenceElement = reference.staticElement;
      final declaration = referenceElement == null
          ? null
          : lookUpDeclaration(referenceElement, reference.root)?.tryCast<VariableDeclaration>();
      if (declaration == null) return false;

      var init = declaration.initializer;
      if (init == null) return false;

      Expression unwrap(Expression expr) {
        if (expr is AsExpression) return expr.expression;
        if (expr is ParenthesizedExpression) return expr.expression;
        return expr;
      }

      init = unwrap(init);

      // Detect primitive constants
      // const foo = 42

      // Note: in the JS version of this plugin, there was:
      // > This might happen if variable is declared after the callback.
      // but that isn't possible in Dart, so we can omit that logic.

      if (declaration.isConst || (declaration.isFinal && !declaration.isLate && isAConstantValue(init))) {
        // Definitely stable
        return true;
      }

      // Detect known Hook calls
      // const [_, setState] = useState()

      // Handle hook tearoffs
      // final setCount = useCount(1).set;
      if (init is PropertyAccess || init is PrefixedIdentifier) {
        final stableHookInfo = getStableHookMethodInfo(init);
        if (stableHookInfo != null) {
          if (stableHookInfo.isStateSetterMethod) {
            setStateCallSites.set(reference, declaration);
          }
          return true;
        }
      }

      if (init is! InvocationExpression) {
        return false;
      }

      // TODO do we need to check for direct invocations for other cases if typing is available?

      var callee = init.function;
      // fixme handle namespaced imports
      if (callee is! Identifier) {
        return false;
      }
      final name = callee.name;
      if (name == 'useRef') {
        // useRef() return value is stable.
        return true;
      }

      // By default assume it's dynamic.
      return false;
    }

    // Remember such values. Avoid re-running extra checks on them.
    final memoizedIsStableKnownHookValue = isStableKnownHookValue.memoizeWithWeakMap(stableKnownValueCache);

    // Some are just functions that don't reference anything dynamic.
    bool isFunctionWithoutCapturedValues(Element resolved) {
      final fnNode = lookUpFunction(resolved, rootNode);

      // It's couldn't be looked up, it's either:
      // - not a function, and we need to return false
      // - a function expression // todo return true for this case?
      // - not in the same file // todo return true for this case?
      if (fnNode == null) return false;

      // If it's outside the component, it also can't capture values.
      if (componentOrCustomHookFunction != null && !componentOrCustomHookFunction.containsRangeOf(fnNode)) return true;

      // Does this function capture any values
      // that are in pure scopes (aka render)?
      final referencedElements = resolvedReferencesWithin(fnNode.body);
      for (final ref in referencedElements) {
        if (isDeclaredInPureScope(ref.staticElement!) &&
            // Stable values are fine though,
            // although we won't check functions deeper.
            !memoizedIsStableKnownHookValue(ref)) {
          return false;
        }
      }
      // If we got here, this function doesn't capture anything
      // from render--or everything it captures is known stable.
      return true;
    }

    final memoizedIsFunctionWithoutCapturedValues =
        isFunctionWithoutCapturedValues.memoizeWithWeakMap(functionWithoutCapturedValueCache);

    // These are usually mistaken. Collect them.
    final currentRefsInEffectCleanup = <String, _RefInEffectCleanup>{};

    // Is this reference inside a cleanup function for this effect node?
    // We can check by traversing scopes upwards  from the reference, and checking
    // if the last "return () => " we encounter is located directly inside the effect.
    bool isInsideEffectCleanup(AstNode reference) {
      var isInReturnedFunction = false;
      reference.ancestors.whereType<FunctionBody>().takeWhile((ancestor) => ancestor != node).forEach((current) {
        // TODO why doesn't the original source just check the last one?
        isInReturnedFunction = current.parentOfType<FunctionExpression>()?.parentOfType<ReturnStatement>() != null;
      });
      return isInReturnedFunction;
    }

    // Get dependencies from all our resolved references in pure scopes.
    // Key is dependency string, value is whether it's stable.
    final dependencies = <String, _Dependency>{};
    final optionalChains = <String, bool>{};

    // The original implementation needs to recurse to process references in child scopes,
    // but we can process all descendant references regardless of scope in one go.
    for (final reference in resolvedReferencesWithin(node)) {
      // debug(
      //     'reference.staticElement.ancestors: \n${prettyString(reference.staticElement.ancestors.map(elementDebugString).toList())}',
      //     reference);

      // If this reference is not resolved or it is not declared in a pure
      // scope then we don't care about this reference.
      //
      // Note that with the implementation of `resolvedReferencesWithin`,
      // this is also necessary to filter out references to properties on object.

      // TODO follow up on this and see how dynamic calls are treated
      final referenceElement = reference.staticElement;
      if (referenceElement == null) continue;

      if (!isDeclaredInPureScope(referenceElement)) {
        continue;
      }

      // Narrow the scope of a dependency if it is, say, a member expression.
      // Then normalize the narrowed dependency.
      final dependencyNode = getDependency(reference);
      final dependency = analyzePropertyChain(
        dependencyNode,
        optionalChains,
      );
      debug(
          'dependency: $dependency, dependencyNode: ${dependencyNode.runtimeType} $dependencyNode, reference ${reference.runtimeType} $reference',
          dependencyNode);

      // Accessing ref.current inside effect cleanup is bad.
      if (
          // We're in an effect...
          isEffect &&
              // ... and this look like accessing .current...
              dependencyNode is Identifier &&
              getPropertyBeingAccessed(dependencyNode.parent)?.name == 'current' &&
              // ...in a cleanup function or below...
              isInsideEffectCleanup(reference)) {
        currentRefsInEffectCleanup[dependency] = _RefInEffectCleanup(
          reference: reference,
          referenceElement: referenceElement,
          dependencyNode: dependencyNode,
        );
      }

      // FIXME need to check more parents for GenericFunctionType case?
      if (node.parent is NamedType) {
        continue;
      }

      // FIXME add tests to ensure references to type parameters don't make it this far.

      // Add the dependency to a map so we can make sure it is referenced
      // again in our dependencies array. Remember whether it's stable.
      // ignore: avoid_single_cascade_in_expression_statements
      dependencies.putIfAbsent(dependency, () {
        return _Dependency(
          isStable: memoizedIsStableKnownHookValue(reference) ||
              // FIXME handle .call tearoffs
              memoizedIsFunctionWithoutCapturedValues(referenceElement),
          references: [],
        );
      })
        // Note that for the the `state.set` case, the reference is still `state`.
        ..references.add(reference);
    }

    // Warn about accessing .current in cleanup effects.
    currentRefsInEffectCleanup.forEach(
      (dependency, _entry) {
        final reference = _entry.reference;
        final dependencyNode = _entry.dependencyNode;

        // Is React managing this ref or us?
        // Let's see if we can find a .current assignment.
        var foundCurrentAssignment = false;
        // This only finds references in the same file, but that's okay for our purposes.
        for (final reference in findReferences(reference.staticElement!, reference.root)) {
          final parent = reference.parent;
          if (parent != null &&
              // ref.current
              getPropertyBeingAccessed(parent)?.name == 'current' &&
              // ref.current = <something>
              parent.parent?.tryCast<AssignmentExpression>()?.leftHandSide == parent) {
            foundCurrentAssignment = true;
            break;
          }
        }
        // We only want to warn about React-managed refs.
        if (foundCurrentAssignment) {
          return;
        }
        reportProblem(
          node: dependencyNode.parent!,
          message: "The ref value '$dependency.current' will likely have "
              "changed by the time this effect cleanup function runs. If "
              "this ref points to a node rendered by React, copy "
              "'$dependency.current' to a variable inside the effect, and "
              "use that variable in the cleanup function.",
        );
      },
    );

    // Warn about assigning to variables in the outer scope.
    // Those are usually bugs.
    final staleAssignments = <String>{};
    void reportStaleAssignment(Expression writeExpr, String key) {
      if (staleAssignments.contains(key)) {
        return;
      }
      staleAssignments.add(key);
      reportProblem(
        node: writeExpr,
        message: "Assignments to the '$key' variable from inside React Hook "
            "${getSource(reactiveHook)} will be lost after each "
            "render. To preserve the value over time, store it in a useRef "
            "Hook and keep the mutable value in the '.current' property. "
            "Otherwise, you can move this variable directly inside "
            "${getSource(reactiveHook)}.",
      );
    }

    // Remember which deps are stable and report bad usage first.
    final stableDependencies = <String>{};
    dependencies.forEach((key, dep) {
      if (dep.isStable) {
        stableDependencies.add(key);
      }
      for (final reference in dep.references) {
        final parent = reference.parent;
        // todo make a utility to check for assignments
        if (parent is AssignmentExpression && parent.leftHandSide == reference) {
          reportStaleAssignment(parent, key);
        }
      }
    });

    if (staleAssignments.isNotEmpty) {
      // The intent isn't clear so we'll wait until you fix those first.
      return;
    }

    if (declaredDependenciesNode == null) {
      // Check if there are any top-level setState() calls.
      // Those tend to lead to infinite loops.
      String? setStateInsideEffectWithoutDeps;
      dependencies.forEach((key, _entry) {
        final references = _entry.references;
        if (setStateInsideEffectWithoutDeps != null) {
          return;
        }
        references.forEach((reference) {
          if (setStateInsideEffectWithoutDeps != null) {
            return;
          }

          // FIXME should this use Dart element model to check this as opposed to WeakMap?
          final isSetState = setStateCallSites.has(reference);
          if (!isSetState) {
            return;
          }

          final isDirectlyInsideEffect = reference.thisOrAncestorOfType<FunctionBody>() == node;
          if (isDirectlyInsideEffect) {
            // TODO: we could potentially ignore early returns.
            setStateInsideEffectWithoutDeps = key;
          }
        });
      });
      if (setStateInsideEffectWithoutDeps != null) {
        final suggestedDependencies = collectRecommendations(
          dependencies: dependencies,
          declaredDependencies: [],
          stableDependencies: stableDependencies,
          externalDependencies: {},
          isEffect: true,
        ).suggestedDependencies;
        reportProblem(
          node: reactiveHook,
          message: "React Hook $reactiveHookName contains a call to '$setStateInsideEffectWithoutDeps'. "
              "Without a list of dependencies, this can lead to an infinite chain of updates. "
              "To fix this, pass ["
              "${suggestedDependencies.join(', ')}"
              "] as a second argument to the $reactiveHookName Hook.",
          // suggest: [
          //   {
          //     desc: "Add dependencies list: [${suggestedDependencies.join(
          //       ', ',
          //     )}]",
          //     fix(fixer) {
          //       return fixer.insertTextAfter(
          //         node,
          //         ", [${suggestedDependencies.join(', ')}]",
          //       );
          //     },
          //   },
          // ],
        );
      }
      return;
    }

    final declaredDependencies = <_DeclaredDependency>[];
    final externalDependencies = <String>{};
    final externalDependenciesDeclaredInCallback = <String>{};
    if (declaredDependenciesNode is! ListLiteral) {
      // If the declared dependencies are not an array expression then we
      // can't verify that the user provided the correct dependencies. Tell
      // the user this in an error.
      reportProblem(
        node: declaredDependenciesNode,
        message: "React Hook ${getSource(reactiveHook)} was passed a "
            'dependency list that is not a list literal. This means we '
            "can't statically verify whether you've passed the correct "
            'dependencies.',
      );
    } else {
      for (final _declaredDependencyNode in declaredDependenciesNode.elements) {
        String? invalidType;
        if (_declaredDependencyNode is SpreadElement) {
          invalidType = 'a spread element';
        } else if (_declaredDependencyNode is IfElement) {
          invalidType = "an 'if' element";
        } else if (_declaredDependencyNode is ForElement) {
          invalidType = "a 'for' element";
        } else if (_declaredDependencyNode is! Expression) {
          // This should be unreachable at the time of writing,
          // since all other CollectionElement subtypes are handled
          invalidType = "a non-expression (${_declaredDependencyNode.runtimeType})";
        }
        if (invalidType != null) {
          reportProblem(
            node: _declaredDependencyNode,
            message: "React Hook ${getSource(reactiveHook)} has $invalidType "
                "in its dependency list. This means we can't "
                "statically verify whether you've passed the "
                'correct dependencies.',
          );
          continue;
        }

        // new variable since breaks don't have type promition yet. TODO switch to the following when nnbd is enabled
        // if (declaredDependencyNode is! Expression) { ...  continue;}
        final declaredDependencyNode = _declaredDependencyNode as Expression;

        // FIXME check here or somewhere else to ensure whole hook (state, ref?) isn't passed in, provide quick fix; perhaps non-destructured hooks being passed in are accounted for alredy?

        // Special case for Dart: whole state hook passed in as dependency.
        if (declaredDependencyNode.staticType?.element?.isStateHook ?? false) {
          final dependencySource = getSource(declaredDependencyNode);
          final dependencySourceValue = '$dependencySource.value';
          // fixme(greg) conditionally suggest value or removing the dep based on whether count.value is used in hook? Also figure out why `useEffect(() => print(count.value), [count]);` triggers missing dependency case

          // FIXME(greg) this is async :/
          diagnosticCollector.addErrorWithFix(
            HooksExhaustiveDeps.code,
            result.locationFor(declaredDependencyNode),
            // todo(greg) better error and fix message
            errorMessageArgs: [
              "React Hook ${getSource(reactiveHook)} has a StateHook object '$dependencySource' in its dependency list, which will change every render and cause the effect to always run."
            ],
            fixKind: HooksExhaustiveDeps.fixKind,
            fixMessageArgs: ["Depend on '$dependencySourceValue' instead."],
            computeFix: () => buildGenericFileEdit(result, (builder) {
              builder.addSimpleReplacement(range.node(declaredDependencyNode), dependencySourceValue);
            }),
          );
          continue;
        }

        // Try to normalize the declared dependency. If we can't then an error
        // will be thrown. We will catch that error and report an error.
        String declaredDependency;
        try {
          declaredDependency = analyzePropertyChain(
            declaredDependencyNode,
            null,
          );
        } on UnsupportedNodeTypeException catch (_) {
          if (declaredDependencyNode is SimpleStringLiteral && dependencies.containsKey(declaredDependencyNode.value)) {
            reportProblem(
              node: declaredDependencyNode,
              message: "The ${declaredDependencyNode.toSource()} literal is not a valid dependency "
                  "because it never changes."
                  " Did you mean to include ${declaredDependencyNode.value} in the list instead?",
            );
          } else if (isAConstantValue(declaredDependencyNode)) {
            // Provide slightly improved wording in the case of literals.
            // Don't forget that literals aren't always constant, so this needs to stay inside a isConstantValue check.
            if (declaredDependencyNode is Literal) {
              reportProblem(
                node: declaredDependencyNode,
                message: "The ${declaredDependencyNode.toSource()} literal is not a valid dependency "
                    "because it never changes. You can safely remove it.",
              );
            } else {
              reportProblem(
                node: declaredDependencyNode,
                message: "The '${declaredDependencyNode.toSource()}' expression is not a valid dependency "
                    "because it never changes. You can safely remove it.",
              );
            }
          } else {
            reportProblem(
              node: declaredDependencyNode,
              message: "React Hook ${getSource(reactiveHook)} has a "
                  "complex expression in the dependency list. "
                  'Extract it to a separate variable so it can be statically checked.',
            );
          }

          continue;
        }

        // todo(greg) handle / warn about cascades?
        Expression? maybeID = declaredDependencyNode;
        while (maybeID is PropertyAccess || maybeID is PrefixedIdentifier) {
          if (maybeID is PropertyAccess) {
            maybeID = maybeID.target;
          } else {
            maybeID = (maybeID as PrefixedIdentifier).prefix;
          }
        }
        final enclosingElement = maybeID.tryCast<Identifier>()?.staticElement?.enclosingElement;
        final isDeclaredInComponent =
            enclosingElement != null && enclosingElement == componentOrCustomHookFunctionElement;
        final isDeclaredInCallback = enclosingElement != null && enclosingElement == callbackFunctionElement;

        // Add the dependency to our declared dependency map.
        declaredDependencies.add(_DeclaredDependency(
          declaredDependency,
          declaredDependencyNode,
          debugEnclosingElement: maybeID.tryCast<Identifier>()?.staticElement?.enclosingElement,
        ));

        if (!isDeclaredInComponent) {
          externalDependencies.add(declaredDependency);
        }
        if (!isDeclaredInCallback) {
          externalDependenciesDeclaredInCallback.add(declaredDependency);
        }
      }
    }

    debug(
        prettyString({
          'dependencies': dependencies,
          'declaredDependencies': declaredDependencies,
          'stableDependencies': stableDependencies,
          'externalDependencies': externalDependencies,
          'isEffect': isEffect,
        }),
        node.offset);

    final recommendations = collectRecommendations(
      dependencies: dependencies,
      declaredDependencies: declaredDependencies,
      stableDependencies: stableDependencies,
      externalDependencies: externalDependencies,
      isEffect: isEffect,
    );
    final duplicateDependencies = recommendations.duplicateDependencies;
    final missingDependencies = recommendations.missingDependencies;
    final unnecessaryDependencies = recommendations.unnecessaryDependencies;

    var suggestedDeps = recommendations.suggestedDependencies;

    final problemCount = duplicateDependencies.length + missingDependencies.length + unnecessaryDependencies.length;

    if (problemCount == 0) {
      // If nothing else to report, check if some dependencies would
      // invalidate on every render.
      final constructions = scanForConstructions(
        declaredDependencies: declaredDependencies,
        declaredDependenciesNode: declaredDependenciesNode,
      );
      constructions.forEach((_construction) {
        final construction = _construction.declaration;
        final constructionName = _construction.declarationElement.name;

        final isUsedOutsideOfHook = _construction.isUsedOutsideOfHook;
        final depType = _construction.depType;
        final wrapperHook = depType == 'function' ? 'useCallback' : 'useMemo';

        final constructionType = depType == 'function' ? 'definition' : 'initialization';

        final defaultAdvice = "wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook.";

        final advice = isUsedOutsideOfHook
            ? "To fix this, $defaultAdvice"
            : "Move it inside the $reactiveHookName callback. Alternatively, $defaultAdvice";

        final causation = depType == 'conditional' || depType == 'logical expression' ? 'could make' : 'makes';

        final message = "The '$constructionName' $depType $causation the dependencies of "
            "$reactiveHookName Hook (at line ${result.lineInfo.getLocation(declaredDependenciesNode.offset).lineNumber}) "
            "change on every render. $advice";

        // Only handle the simple case of variable assignments.
        // Wrapping function declarations can mess up hoisting.
        if (isUsedOutsideOfHook &&
            construction is VariableDeclaration &&
            // Objects may be mutated ater construction, which would make this
            // fix unsafe. Functions _probably_ won't be mutated, so we'll
            // allow this fix for them.
            depType == 'function') {
          // FIXME(greg) is it safe to assume this here?
          final constructionInitializer = construction.initializer!;

          // FIXME(greg) this is async :/
          diagnosticCollector.addErrorWithFix(
            HooksExhaustiveDeps.code,
            result.locationFor(construction),
            errorMessageArgs: [message],
            fixKind: HooksExhaustiveDeps.fixKind,
            fixMessageArgs: ["Wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook."],
            computeFix: () => buildGenericFileEdit(
              result,
              (builder) {
                // final parts = wrapperHook == 'useMemo' ? ['useMemo(() => ', ')'] : ['useCallback(', ')'];
                // TODO: ideally we'd gather deps here but it would require
                // restructuring the rule code. Note we're
                // not adding [] because would that changes semantics.

                if (wrapperHook == 'useMemo') {
                  builder.addSimpleInsertion(constructionInitializer.offset, '$wrapperHook(() => ');
                  builder.addSimpleInsertion(constructionInitializer.end, ')');
                } else {
                  builder.addSimpleInsertion(constructionInitializer.offset, '$wrapperHook(');
                  // Add a placeholder here so there isn't a static error about using useCallback with the wrong number of arguments.
                  // FIXME(greg) figure out if this is the right way to handle this.
                  builder.addSimpleInsertion(constructionInitializer.end, ', [/* FIXME add dependencies */])');
                }
              },
            ),
          );
        } else {
          // TODO: What if the function needs to change on every render anyway?
          // Should we suggest removing effect deps as an appropriate fix too?
          diagnosticCollector.addError(
            HooksExhaustiveDeps.code,
            result.locationFor(construction),
            errorMessageArgs: [message],
          );
        }
      });
      return;
    }

    // If we're going to report a missing dependency,
    // we might as well recalculate the list ignoring
    // the currently specified deps. This can result
    // in some extra deduplication. We can't do this
    // for effects though because those have legit
    // use cases for over-specifying deps.
    if (!isEffect && missingDependencies.isNotEmpty) {
      suggestedDeps = collectRecommendations(
        dependencies: dependencies,
        declaredDependencies: [],
        // Pretend we don't know
        stableDependencies: stableDependencies,
        externalDependencies: externalDependencies,
        isEffect: isEffect,
      ).suggestedDependencies;
    }

    // Alphabetize the suggestions, but only if deps were already alphabetized.
    if (declaredDependencies.map((dep) => dep.key).isSorted) {
      suggestedDeps.sort();
    }

    // Most of our algorithm deals with dependency paths with optional chaining stripped.
    // This function is the last step before printing a dependency, so now is a good time to
    // check whether any members in our path are always used as optional-only. In that case,
    // we will use ?. instead of . to concatenate those parts of the path.
    String formatDependency(String path) {
      final members = path.split('.');
      var finalPath = '';
      for (var i = 0; i < members.length; i++) {
        if (i != 0) {
          final pathSoFar = members.sublist(0, i + 1).join('.');
          final isOptional = optionalChains[pathSoFar] == true;
          finalPath += isOptional ? '?.' : '.';
        }
        finalPath += members[i];
      }
      return finalPath;
    }

    String? getWarningMessage(Iterable<String> deps, String singlePrefix, String label, String fixVerb) {
      if (deps.isEmpty) {
        return null;
      }
      return (deps.length > 1 ? '' : singlePrefix + ' ') +
          label +
          ' ' +
          (deps.length > 1 ? 'dependencies' : 'dependency') +
          ': ' +
          joinEnglish((deps.toList()..sort()).map((name) => "'" + formatDependency(name) + "'").toList()) +
          ". Either $fixVerb ${deps.length > 1 ? 'them' : 'it'} or remove the dependency list.";
    }

    String? extraWarning;
    if (unnecessaryDependencies.isNotEmpty) {
      final badRef = unnecessaryDependencies.firstWhereOrNull((key) => key.endsWith('.current'));
      if (badRef != null) {
        extraWarning = " Mutable values like '$badRef' aren't valid dependencies "
            "because mutating them doesn't re-render the component.";
      } else if (externalDependencies.isNotEmpty) {
        final dep = externalDependencies.first;
        // Don't show this warning for things that likely just got moved *inside* the callback
        // because in that case they're clearly not referring to globals.
        if (externalDependenciesDeclaredInCallback.contains(dep)) {
          extraWarning = " Outer scope values like '$dep' aren't valid dependencies "
              "because mutating them doesn't re-render the component.";
        }
      }
    }

    // FIXME(greg) change this behavior since tearoffs bind `this` in Dart, and also worrying about props being called with `this` isn't worth the confusion this messaging brings
    // "props.foo()" marks "props" as a dependency because it has
    // a "this" value. This warning can be confusing.
    // So if we're going to show it, append a clarification.
    if (extraWarning == null && missingDependencies.contains('props')) {
      final propDep = dependencies['props'];
      if (propDep == null) {
        return;
      }
      final refs = propDep.references;
      // FIXME(greg) was this null-check dead code in the original implementation?
      // if (refs == null) {
      //   return;
      // }
      var isPropsOnlyUsedInMembers = true;
      for (final ref in refs) {
        // FIXME(greg) was this null-check dead code in the original implementation?
        // if (ref == null) {
        //   isPropsOnlyUsedInMembers = false;
        //   break;
        // }
        final parent = ref.parent;
        if (parent == null) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
        if (parent is Expression && getSimpleTargetAndPropertyName(parent)?.item1 == ref) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
      }
      if (isPropsOnlyUsedInMembers) {
        extraWarning = " However, 'props' will change when *any* prop changes, so the "
            "preferred fix is to destructure the 'props' object outside of "
            "the $reactiveHookName call and refer to those specific props "
            "inside ${getSource(reactiveHook)}.";
      }
    }

    if (extraWarning == null && missingDependencies.isNotEmpty) {
      // See if the user is trying to avoid specifying a callable prop.
      // This usually means they're unaware of useCallback.
      String? missingCallbackDep;
      // FIXME make dependencies use identifiers and not just strings so we can resolve them
      // ignore_for_file: avoid_function_literals_in_foreach_calls
      // missingDependencies.forEach((missingDep) {
      //   if (missingCallbackDep != null) {
      //     return;
      //   }
      //   // Is this a variable from top scope?
      //   final topScopeRef = componentScope.set.get(missingDep);
      //   final usedDep = dependencies[missingDep];
      //   if (usedDep.references[0].resolved != topScopeRef) {
      //     return;
      //   }
      //   // Is this a destructured prop?
      //   final def = topScopeRef.defs[0];
      //   if (def == null || def.name == null || def.type != 'Parameter') {
      //     return;
      //   }
      //   // Was it called in at least one case? Then it's a function.
      //   var isFunctionCall = false;
      //   for (final id in usedDep.references) {
      //     if (id?.parent?.tryCast<InvocationExpression>()?.function == id) {
      //       isFunctionCall = true;
      //       break;
      //     }
      //   }
      //   if (!isFunctionCall) {
      //     return;
      //   }
      //   // If it's missing (i.e. in component scope) *and* it's a parameter
      //   // then it is definitely coming from props destructuring.
      //   // (It could also be props itself but we wouldn't be calling it then.)
      //   missingCallbackDep = missingDep;
      // });
      if (missingCallbackDep != null) {
        extraWarning = " If '$missingCallbackDep' changes too often, "
            "find the parent component that defines it "
            "and wrap that definition in useCallback.";
      }
    }

    if (extraWarning == null && missingDependencies.isNotEmpty) {
      _SetStateRecommendation? setStateRecommendation;
      for (final missingDep in missingDependencies) {
        if (setStateRecommendation != null) {
          break;
        }
        final usedDep = dependencies[missingDep]!;
        final references = usedDep.references;
        for (final id in references) {
          // Try to see if we have setState(someExpr(missingDep)).
          for (var maybeCall = id.parent;
              maybeCall != null && maybeCall != componentOrCustomHookFunction?.body;
              maybeCall = maybeCall.parent) {
            if (maybeCall is InvocationExpression) {
              final maybeCallFunction = maybeCall.function;
              final maybeCallFunctionName = (maybeCall is MethodInvocation && maybeCall.target != null
                      ? '${maybeCall.target!.toSource()}.${maybeCall.methodName.name}'
                      : null) ??
                  maybeCallFunction.tryCast<Identifier>()?.name ??
                  // TODO(greg) is there a better fallback than this?
                  maybeCallFunction.toSource();
              final correspondingStateVariable = setStateCallSites.getNullableKey(maybeCallFunction.tryCast()) ??
                  // This case is necessary for `stateVar.set` calls, since key for setStateCallSites is the `stateVar` identifier, not `set`.
                  setStateCallSites.getNullableKey(maybeCall.tryCast<MethodInvocation>()?.target.tryCast());
              if (correspondingStateVariable != null) {
                if ('${correspondingStateVariable.name.name}.value' == missingDep) {
                  // setCount(count + 1)
                  setStateRecommendation = _SetStateRecommendation(
                    missingDep: missingDep,
                    setter: maybeCallFunctionName,
                    form: _SetStateRecommendationForm.updater,
                  );
                } else if (stateVariables.has(id)) {
                  // setCount(count + increment)
                  setStateRecommendation = _SetStateRecommendation(
                    missingDep: missingDep,
                    setter: maybeCallFunctionName,
                    form: _SetStateRecommendationForm.reducer,
                  );
                } else {
                  // If it's a parameter *and* a missing dep,
                  // it must be a prop or something inside a prop.
                  // Therefore, recommend an inline reducer.
                  final def = id.staticElement;
                  if (def != null && def is ParameterElement) {
                    setStateRecommendation = _SetStateRecommendation(
                      missingDep: missingDep,
                      setter: maybeCallFunctionName,
                      form: _SetStateRecommendationForm.inlineReducer,
                    );
                  }
                }
                break;
              }
            }
          }
          if (setStateRecommendation != null) {
            break;
          }
        }
      }
      if (setStateRecommendation != null) {
        final setter = setStateRecommendation.setter;
        final missingDep = setStateRecommendation.missingDep;
        switch (setStateRecommendation.form) {
          case _SetStateRecommendationForm.reducer:
            extraWarning = " You can also replace multiple useState variables with useReducer "
                "if '$setter' needs the current value of '$missingDep'.";
            break;
          case _SetStateRecommendationForm.inlineReducer:
            extraWarning = " If '$setter' needs the current value of '$missingDep', "
                "you can also switch to useReducer instead of useState and "
                "read '$missingDep' in the reducer.";
            break;
          case _SetStateRecommendationForm.updater:
            final updaterArgumentName = missingDep.substring(0, 1);
            final functionalUpdateSetter = '${setter}WithUpdater';
            extraWarning = " You can also do a functional update"
                " '$functionalUpdateSetter(($updaterArgumentName) => ...)'"
                " if you only need '$missingDep' in the '$setter' call.";
            break;
        }
      }
    }

    // FIXME this is async :/
    diagnosticCollector.addErrorWithFix(
      HooksExhaustiveDeps.code,
      result.locationFor(declaredDependenciesNode),
      errorMessageArgs: [
        "React Hook ${getSource(reactiveHook)} has " +
            // To avoid a long message, show the next actionable item.
            (getWarningMessage(missingDependencies, 'a', 'missing', 'include') ??
                getWarningMessage(unnecessaryDependencies, 'an', 'unnecessary', 'exclude') ??
                getWarningMessage(duplicateDependencies, 'a', 'duplicate', 'omit') ??
                '<unexpected case when building warning message>') +
            (extraWarning ?? ''),
      ],
      fixKind: HooksExhaustiveDeps.fixKind,
      fixMessageArgs: ["Update the dependencies list to be: [${suggestedDeps.map(formatDependency).join(', ')}]"],
      computeFix: () => buildGenericFileEdit(result, (e) {
        e.addSimpleReplacement(
            range.node(declaredDependenciesNode), "[${suggestedDeps.map(formatDependency).join(', ')}]");
      }),
    );
  }

  @override
  void visitInvocationExpression(InvocationExpression node) {
    super.visitInvocationExpression(node);

    final callbackIndex = getReactiveHookCallbackIndex(node.function, additionalHooks: additionalHooks);
    if (callbackIndex == -1) {
      // Not a React Hook call that needs deps.
      return;
    }
    final callback = node.argumentList.arguments.elementAtOrNull(callbackIndex);
    final reactiveHook = node.function;
    final reactiveHookName = getNodeWithoutReactNamespace(reactiveHook).toSource();
    final declaredDependenciesNode = node.argumentList.arguments.elementAtOrNull(callbackIndex + 1);
    final isEffect = RegExp(r'Effect($|[^a-z])').hasMatch(reactiveHookName);

    // Check the declared dependencies for this reactive hook. If there is no
    // second argument then the reactive callback will re-run on every render.
    // So no need to check for dependency inclusion.
    if (declaredDependenciesNode == null && !isEffect) {
      // These are only used for optimization.
      if (reactiveHookName == 'useMemo' || reactiveHookName == 'useCallback') {
        // TODO: Can this have a suggestion?
        reportProblem(
          node: reactiveHook,
          message: "React Hook $reactiveHookName does nothing when called with "
              "only one argument. Did you forget to pass a list of "
              "dependencies?",
        );
      }
      return;
    }

    if (callback is FunctionExpression) {
      visitFunctionWithDependencies(
        node: callback.body,
        declaredDependenciesNode: declaredDependenciesNode,
        reactiveHook: reactiveHook,
        reactiveHookName: reactiveHookName,
        isEffect: isEffect,
      );
      return; // Handled
    } else if (callback is Identifier) {
      if (declaredDependenciesNode == null) {
        // No deps, no problems.
        return; // Handled
      }
      // The function passed as a callback is not written inline.
      // But perhaps it's in the dependencies array?
      if (declaredDependenciesNode is ListLiteral &&
          declaredDependenciesNode.elements.whereType<Identifier>().any(
                (el) => el.name == callback.name,
              )) {
        // If it's already in the list of deps, we don't care because
        // this is valid regardless.
        return; // Handled
      }
      // We'll do our best effort to find it, complain otherwise.
      final declaration = callback.staticElement?.declaration;
      if (declaration == null) {
        // If it's not in scope, we don't care.
        return; // Handled
      }
      // The function passed as a callback is not written inline.
      // But it's defined somewhere in the render scope.
      // We'll do our best effort to find and check it, complain otherwise.
      final function = lookUpFunction(declaration, callback.root);
      if (function != null) {
        // effectBody() {...};
        // // or
        // final effectBody = () {...};
        // useEffect(() => { ... }, []);
        visitFunctionWithDependencies(
          node: function.body,
          declaredDependenciesNode: declaredDependenciesNode,
          reactiveHook: reactiveHook,
          reactiveHookName: reactiveHookName,
          isEffect: isEffect,
        );
        return; // Handled
      }
      // Unhandled
    } else {
      // useEffect(generateEffectBody(), []);
      reportProblem(
        node: reactiveHook,
        message: "React Hook $reactiveHookName received a whose dependencies "
            "are unknown. Pass an inline instead.",
      );
      return; // Handled
    }

    // Something unusual. Fall back to suggesting to add the body itself as a dep.
    final callbackName = callback.name;
    // FIXME this is async :/
    diagnosticCollector.addErrorWithFix(
      HooksExhaustiveDeps.code,
      result.locationFor(reactiveHook),
      errorMessageArgs: [
        // ignore: prefer_adjacent_string_concatenation
        "React Hook $reactiveHookName has a missing dependency: '$callbackName'. " +
            "Either include it or remove the dependency list."
      ],
      fixKind: HooksExhaustiveDeps.fixKind,
      fixMessageArgs: ["Update the dependencies list to be: [$callbackName]"],
      computeFix: () => buildGenericFileEdit(result, (e) {
        e.addSimpleReplacement(range.node(declaredDependenciesNode), "[$callbackName]");
      }),
    );
  }
}

enum _SetStateRecommendationForm {
  reducer,
  inlineReducer,
  updater,
}

class _SetStateRecommendation {
  final String missingDep;
  final String setter;
  final _SetStateRecommendationForm form;

  _SetStateRecommendation({required this.missingDep, required this.setter, required this.form});
}

extension on AstNode {
  T? parentOfType<T extends AstNode>() {
    final parent = this.parent;
    return parent is T ? parent : null;
  }
}

class _Recommendations {
  final List<String> suggestedDependencies;
  final Set<String> unnecessaryDependencies;
  final Set<String> missingDependencies;
  final Set<String> duplicateDependencies;

  _Recommendations({
    required this.suggestedDependencies,
    required this.unnecessaryDependencies,
    required this.missingDependencies,
    required this.duplicateDependencies,
  });
}

class _DepTree {
  /// True if used in code
  bool isUsed;

  /// True if specified in deps
  bool isSatisfiedRecursively;

  /// True if something deeper is used by code
  bool isSubtreeUsed;

  // Nodes for properties
  final Map<String, _DepTree> children;

  _DepTree(
      {required this.isUsed,
      required this.isSatisfiedRecursively,
      required this.isSubtreeUsed,
      required this.children});
}

class _DeclaredDependency {
  final String key;
  final Expression node;

  final Element? debugEnclosingElement;

  _DeclaredDependency(this.key, this.node, {this.debugEnclosingElement});

  @override
  String toString() => prettyString({
        'key': key,
        'node': node,
        'debugEnclosingElement': debugEnclosingElement?.debugString,
      });
}

extension on Element {
  String get debugString => '$runtimeType<$id, ${getDisplayString(withNullability: false)}>';
}

// The meat of the logic.
_Recommendations collectRecommendations({
  required Map<String, _Dependency> dependencies,
  required List<_DeclaredDependency> declaredDependencies,
  required Iterable<String> stableDependencies,
  required Set<String> externalDependencies,
  required bool isEffect,
}) {
  // Our primary data structure.
  // It is a logical representation of property chains:
  // "props" -> "props.foo" -> "props.foo.bar" -> "props.foo.bar.baz"
  //         -> "props.lol"
  //         -> "props.huh" -> "props.huh.okay"
  //         -> "props.wow"
  // We'll use it to mark nodes that are *used* by the programmer,
  // and the nodes that were *declared* as deps. Then we will
  // traverse it to learn which deps are missing or unnecessary.
  _DepTree createDepTree() {
    return _DepTree(
      isUsed: false, // True if used in code
      isSatisfiedRecursively: false, // True if specified in deps
      isSubtreeUsed: false, // True if something deeper is used by code
      children: {}, // Nodes for properties
    );
  }

  final depTree = createDepTree();

  // Tree manipulation helpers.
  _DepTree getOrCreateNodeByPath(_DepTree rootNode, String path) {
    final keys = path.split('.');
    var node = rootNode;
    for (final key in keys) {
      var child = node.children[key];
      if (child == null) {
        child = createDepTree();
        node.children[key] = child;
      }
      node = child;
    }
    return node;
  }

  void markAllParentsByPath(_DepTree rootNode, String path, void Function(_DepTree) fn) {
    final keys = path.split('.');
    var node = rootNode;
    for (final key in keys) {
      final child = node.children[key];
      if (child == null) {
        return;
      }
      fn(child);
      node = child;
    }
  }

  // Mark all required nodes first.
  // Imagine exclamation marks next to each used deep property.
  dependencies.forEach((key, _) {
    final node = getOrCreateNodeByPath(depTree, key);
    node.isUsed = true;
    markAllParentsByPath(depTree, key, (parent) {
      parent.isSubtreeUsed = true;
    });
  });

  // Mark all satisfied nodes.
  // Imagine checkmarks next to each declared dependency.
  declaredDependencies.forEach((_entry) {
    final key = _entry.key;
    final node = getOrCreateNodeByPath(depTree, key);
    node.isSatisfiedRecursively = true;
  });
  stableDependencies.forEach((key) {
    final node = getOrCreateNodeByPath(depTree, key);
    node.isSatisfiedRecursively = true;
  });

  // Now we can learn which dependencies are missing or necessary.
  final missingDependencies = <String>{};
  final satisfyingDependencies = <String>{};
  void scanTreeRecursively(
      _DepTree node, Set<String> missingPaths, Set<String> satisfyingPaths, String Function(String) keyToPath) {
    node.children.forEach((key, child) {
      final path = keyToPath(key);
      if (child.isSatisfiedRecursively) {
        if (child.isSubtreeUsed) {
          // Remember this dep actually satisfied something.
          satisfyingPaths.add(path);
        }
        // It doesn't matter if there's something deeper.
        // It would be transitively satisfied since we assume immutability.
        // "props.foo" is enough if you read "props.foo.id".
        return;
      }
      if (child.isUsed) {
        // Remember that no declared deps satisfied this node.
        missingPaths.add(path);
        // If we got here, nothing in its subtree was satisfied.
        // No need to search further.
        return;
      }
      scanTreeRecursively(
        child,
        missingPaths,
        satisfyingPaths,
        (childKey) => path + '.' + childKey,
      );
    });
  }

  scanTreeRecursively(
    depTree,
    missingDependencies,
    satisfyingDependencies,
    (key) => key,
  );

  // Collect suggestions in the order they were originally specified.
  final suggestedDependencies = <String>[];
  final unnecessaryDependencies = <String>{};
  final duplicateDependencies = <String>{};
  declaredDependencies.forEach((_entry) {
    final key = _entry.key;
    // Does this declared dep satisfy a real need?
    if (satisfyingDependencies.contains(key)) {
      if (!suggestedDependencies.contains(key)) {
        // Good one.
        suggestedDependencies.add(key);
      } else {
        // Duplicate.
        duplicateDependencies.add(key);
      }
    } else {
      if (isEffect && !key.endsWith('.current') && !externalDependencies.contains(key)) {
        // Effects are allowed extra "unnecessary" deps.
        // Such as resetting scroll when ID changes.
        // Consider them legit.
        // The exception is ref.current which is always wrong.
        if (!suggestedDependencies.contains(key)) {
          suggestedDependencies.add(key);
        }
      } else {
        // It's definitely not needed.
        unnecessaryDependencies.add(key);
      }
    }
  });

  // Then add the missing ones at the end.
  suggestedDependencies.addAll(missingDependencies);

  return _Recommendations(
    suggestedDependencies: suggestedDependencies,
    unnecessaryDependencies: unnecessaryDependencies,
    duplicateDependencies: duplicateDependencies,
    missingDependencies: missingDependencies,
  );
}

// If the node will result in constructing a referentially unique value, return
// its human readable type name, else return null.
String? getConstructionExpressionType(Expression node) {
  if (node is InstanceCreationExpression) {
    if (node.isConst) return null;
    return node.constructorName.type.name.name;
  } else if (node is ListLiteral) {
    return 'List';
  } else if (node is SetOrMapLiteral) {
    return node.isMap ? 'Map' : 'Set';
  } else if (node is FunctionExpression) {
    return 'function';
  } else if (node is ConditionalExpression) {
    if (getConstructionExpressionType(node.thenExpression) != null ||
        getConstructionExpressionType(node.elseExpression) != null) {
      return 'conditional';
    }
    return null;
  } else if (node is BinaryExpression) {
    if (getConstructionExpressionType(node.leftOperand) != null ||
        getConstructionExpressionType(node.rightOperand) != null) {
      return 'binary expression';
    }
    return null;
  } else if (node is AssignmentExpression) {
    if (getConstructionExpressionType(node.rightHandSide) != null) {
      return 'assignment expression';
    }
    return null;
  } else if (node is AsExpression) {
    return getConstructionExpressionType(node.expression);
  } else if (node is InvocationExpression && (node.staticType?.isReactElement ?? false)) {
    return 'ReactElement';
  } else {
    return null;
  }
  // todo what about function calls...?
}

// Finds variables declared as dependencies
// that would invalidate on every render.
List<_Construction> scanForConstructions({
  required Iterable<_DeclaredDependency> declaredDependencies,
  required AstNode declaredDependenciesNode,
}) {
  final constructions = declaredDependencies.map<Tuple3<Declaration, Element, String>?>((dep) {
    // FIXME this should be equivalent, but need to figure out how chained properties work... I'm not sure how that would work with analyzePropertyChain being used with the existing code to look up identifiers
    // final ref = componentScope.variables.firstWhere((v) => v.name == key, orElse: () => null);
    final refElement = dep.node.tryCast<Identifier>()?.staticElement;
    if (refElement == null) return null;

    final declaration = lookUpDeclaration(refElement, dep.node.root);
    if (declaration == null) {
      return null;
    }
    // TODO(greg) are these the same?
    final declarationElement = declaration.declaredElement ?? refElement;

    // final handleChange = () {};
    // final foo = {};
    // final foo = [];
    // etc.
    if (declaration is VariableDeclaration) {
      // Const variables never change
      if (declaration.isConst) return null;
      final initializer = declaration.initializer;
      if (initializer != null) {
        // todo should this be stricter in Dart?
        final constantExpressionType = getConstructionExpressionType(
          initializer,
        );
        if (constantExpressionType != null) {
          return Tuple3(declaration, declarationElement, constantExpressionType);
        }
      }
      return null;
    }
    // handleChange() {}
    if (declaration is FunctionDeclaration) {
      return Tuple3(declaration, declarationElement, _DepType.function);
    }

    return null;
  }).whereNotNull();

  bool isUsedOutsideOfHook(Declaration declaration, Element declarationElement) {
    for (final reference in findReferences(declarationElement, declaration.root)) {
      // TODO better implementation of this
      // Crude implementation of ignoring initializer
      if (declaration.containsRangeOf(reference)) {
        continue;
      }

      final parent = reference.parent;
      if (parent is AssignmentExpression && parent.leftHandSide == reference) {
        return true;
      }

      // This reference is outside the Hook callback.
      // It can only be legit if it's the deps array.
      if (!declaredDependenciesNode.containsRangeOf(reference)) {
        return true;
      }
    }
    return false;
  }

  return constructions.map((tuple) {
    final declaration = tuple.item1;
    final declarationElement = tuple.item2;
    final depType = tuple.item3;
    return _Construction(
      declaration: declaration,
      declarationElement: declarationElement,
      depType: depType,
      isUsedOutsideOfHook: isUsedOutsideOfHook(declaration, declarationElement),
    );
  }).toList();
}

class _Construction {
  final Declaration declaration;
  final Element declarationElement;
  final String depType;
  final bool isUsedOutsideOfHook;

  _Construction(
      {required this.declaration,
      required this.declarationElement,
      required this.depType,
      required this.isUsedOutsideOfHook});
}

abstract class _DepType {
  // static const classDep = 'class';
  static const function = 'function';
}

// fixme Greg this doc comment has to be incorrect for some cases, right?
/// Assuming () means the passed/returned node:
/// (props) => (props)
/// props.(foo) => (props.foo)
/// props.foo.(bar) => (props).foo.bar
/// props.foo.bar.(baz) => (props).foo.bar.baz
AstNode getDependency(AstNode node) {
  final parent = node.parent!;
  final grandparent = parent.parent;

  if (parent is PropertyAccess &&
      parent.target == node &&
      parent.propertyName.name != 'current' && // FIXME only test for ref/dynamic values?
      !(grandparent is InvocationExpression &&
          // fixme is this right?
          grandparent.function == parent)) {
    return getDependency(parent);
  }
  if (parent is PrefixedIdentifier &&
      parent.prefix == node &&
      parent.identifier.name != 'current' && // FIXME only test for ref/dynamic values?
      !(grandparent is InvocationExpression &&
          // fixme is this right?
          grandparent.function == parent)) {
    return getDependency(parent);
  }

  // This MethodInvocation check deviates from the JS, and is necessary to handle stable hook methods.
  if (parent is MethodInvocation && parent.target == node && getStableHookMethodInfo(parent) != null) {
    return getDependency(parent);
  }

  // TODO(greg) use getSimpleTargetAndPropertyName here?
  if (node is PropertyAccess && parent is AssignmentExpression && parent.leftHandSide == node) {
    final target = node.target;
    // This can be null if cascaded.
    // FIXME(greg) we should probably have better cascaded checks above
    if (target != null) {
      return target;
    }
  }
  if (node is PrefixedIdentifier && parent is AssignmentExpression && parent.leftHandSide == node) {
    return node.prefix;
  }

  return node;
}

List<Identifier> findReferences(Element element, AstNode root) {
  final visitor = ReferenceVisitor(element);
  root.accept(visitor);
  return visitor.references;
}

class ReferenceVisitor extends RecursiveAstVisitor<void> {
  final Element _targetElement;

  final List<Identifier> references = [];

  ReferenceVisitor(this._targetElement);

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    super.visitSimpleIdentifier(node);

    if (node.staticElement == _targetElement) {
      references.add(node);
    }
  }
}

/// Mark a node as either optional or required.
/// Note: If the node argument is an OptionalMemberExpression, it doesn't necessarily mean it is optional.
/// It just means there is an optional member somewhere inside.
/// This particular node might still represent a required member, so check .optional field.
void markNode(AstNode node, Map<String, bool>? optionalChains, String result, {required bool? isOptional}) {
  if (optionalChains != null && isOptional == null) {
    throw ArgumentError('isOptional must be specified when optionalChains is');
  }

  if (optionalChains != null) {
    if (isOptional!) {
      // We only want to consider it optional if *all* usages were optional.
      if (!optionalChains.containsKey(result)) {
        // Mark as (maybe) optional. If there's a required usage, this will be overridden.
        optionalChains[result] = true;
      }
    } else {
      // Mark as required.
      optionalChains[result] = false;
    }
  }
}

/// Assuming () means the passed node.
/// (foo) -> 'foo'
/// foo(.)bar -> 'foo.bar'
/// foo.bar(.)baz -> 'foo.bar.baz'
/// Otherwise throw.
String analyzePropertyChain(AstNode node, Map<String, bool>? optionalChains) {
  if (node is SimpleIdentifier) {
    final result = node.name;
    if (optionalChains != null) {
      // Mark as required.
      optionalChains[result] = false;
    }
    return result;
  } else if (node is PropertyAccess) {
    // FIXME(greg) look into this more and clean this up
    assert(!node.isCascaded, 'cascaded members are unexpected here');
    final object = analyzePropertyChain(node.target!, optionalChains);
    final property = analyzePropertyChain(node.propertyName, null);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: node.isNullAware);
    return result;
  } else if (node is PrefixedIdentifier) {
    final object = analyzePropertyChain(node.prefix, optionalChains);
    final property = analyzePropertyChain(node.identifier, null);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: false);
    return result;
    // rule out cascades and implicit this // fixme greg update other locations to use this pattern
  } else if (node is MethodInvocation && node.target != null && getStableHookMethodInfo(node) != null) {
    // This MethodInvocation check deviates from the JS, and is necessary to handle stable hook methods.
    // FIXME(greg) look into this more and clean this up
    assert(!node.isCascaded, 'cascaded members are unexpected here');
    final object = analyzePropertyChain(node.target!, optionalChains);
    final property = analyzePropertyChain(node.methodName, null);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: false);
    return result;
  } else {
    throw UnsupportedNodeTypeException(node);
  }
}

class UnsupportedNodeTypeException implements Exception {
  AstNode node;

  UnsupportedNodeTypeException(this.node);

  @override
  String toString() => '$runtimeType: ${node.runtimeType} (source: ${node.toSource()})';
}

// todo(greg) unit test this and remove extraneous cases
AstNode getNodeWithoutReactNamespace(Expression node) {
  bool isPrefixedOverReactApi({required Identifier prefix, required Identifier identifier}) {
    return prefix.staticElement is PrefixElement &&
        (identifier.staticElement?.isDeclaredInPackage('over_react') ?? false);
  }

  if (node is PrefixedIdentifier) {
    if (isPrefixedOverReactApi(prefix: node.prefix, identifier: node.identifier)) {
      return node.identifier;
    }
  } else if (node is PropertyAccess) {
    final realTarget = node.realTarget;
    if (realTarget is Identifier && isPrefixedOverReactApi(prefix: realTarget, identifier: node.propertyName)) {
      return node.propertyName;
    }
  }
  return node;
}

// What's the index of callback that needs to be analyzed for a given Hook?
// -1 if it's not a Hook we care about (e.g. useState).
// 0 for useEffect/useMemo/useCallback(fn).
// 1 for useImperativeHandle(ref, fn).
// For additionally configured Hooks, assume that they're like useEffect (0).
int getReactiveHookCallbackIndex(Expression calleeNode, {RegExp? additionalHooks}) {
  final node = getNodeWithoutReactNamespace(calleeNode);
  if (node is! Identifier) {
    return -1;
  }
  switch (node.name) {
    case 'useEffect':
    case 'useLayoutEffect':
    case 'useCallback':
    case 'useMemo':
      // useEffect(fn)
      return 0;
    case 'useImperativeHandle':
      // useImperativeHandle(ref, fn)
      return 1;
    default:
      // FIXME(greg) should we strip prefix before passing it into additionalHooks?
      if (node == calleeNode && additionalHooks != null) {
        // Allow the user to provide a regular expression which enables the lint to
        // target custom reactive hooks.
        String name;
        try {
          name = analyzePropertyChain(node, null);
        } on UnsupportedNodeTypeException catch (_) {
          return 0;
        }
        return additionalHooks.hasMatch(name) ? 0 : -1;
      } else {
        return -1;
      }
  }
}

String joinEnglish(List<String> arr) {
  var s = '';
  for (var i = 0; i < arr.length; i++) {
    s += arr[i];
    if (i == 0 && arr.length == 2) {
      s += ' and ';
    } else if (i == arr.length - 2 && arr.length > 2) {
      s += ', and ';
    } else if (i < arr.length - 1) {
      s += ', ';
    }
  }
  return s;
}

extension<E extends Comparable<dynamic>> on Iterable<E> {
  /// Whether the elements in this collection are already sorted.
  bool get isSorted {
    var isFirst = true;
    late E prev;
    for (final element in this) {
      if (isFirst) {
        isFirst = false;
      } else if (prev.compareTo(element) > 0) {
        return false;
      }
      prev = element;
    }
    return true;
  }
}

extension on Element {
  // ignore: unused_element
  Iterable<Element> get ancestors sync* {
    final enclosingElement = this.enclosingElement;
    if (enclosingElement != null) {
      yield enclosingElement;
      yield* enclosingElement.ancestors;
    }
  }
}

extension<E> on List<E> {
  /// Returns the element at [index], or `null` if the index is greater than the length of the list.
  E? elementAtOrNull(int index) => index < length ? this[index] : null;
}

// Adapted from over_react's prettyPrintMap

const String nonBreakingSpace = '\u00a0';
// Use non-breaking spaces so leading spaces show up in IDE tooltips.
const String _indent = '$nonBreakingSpace$nonBreakingSpace';
const int _maxKeyValuePairsPerLine = 2;
const int _maxListItemsPerLine = 4;
const int _maxSingleLineListOrMapLength = 50;

const namespaceThreshold = 2;
const namespaceSeparator = '.';

/// Indents [str] by [_indent], trimming any trailing whitespace.
String _indentString(String str) {
  return str.split('\n').map((line) => (_indent + line).trimRight()).join('\n');
}

String prettyString(Object? obj) {
  if (obj is List) {
    var items = obj.map(prettyString).toList();

    final singleLineInner = items.join(', ');
    if (items.length > _maxListItemsPerLine ||
        items.any((items) => items.contains('\n')) ||
        singleLineInner.length > _maxSingleLineListOrMapLength) {
      var inner = _indentString(items.join(',\n'));
      return '[\n$inner\n]';
    } else {
      return '[$singleLineInner]';
    }
  } else if (obj is Map) {
    final namespacedKeys = <String, List<String>>{};
    final otherKeys = <dynamic>[];

    final shouldNamespace = obj.keys
        .whereType<String>()
        .where((key) => key.contains(namespaceSeparator))
        .hasLengthOfAtLeast(namespaceThreshold);

    obj.keys.forEach((dynamic key) {
      if (shouldNamespace && key is String && key.contains(namespaceSeparator)) {
        var index = key.indexOf(namespaceSeparator);
        var namespace = key.substring(0, index);
        var subkey = key.substring(index);

        (namespacedKeys[namespace] ??= []).add(subkey);
      } else {
        otherKeys.add(key);
      }
    });

    final pairs = <String>[];

    pairs.addAll(namespacedKeys.entries.map((entry) {
      final namespace = entry.key;
      final subkeys = entry.value;

      String renderSubKey(String subkey) {
        var key = '$namespace$subkey';
        dynamic value = obj[key];

        return '$subkey: ' + prettyString(value);
      }

      return '$namespace…\n' + _indentString(subkeys.map(renderSubKey).map((pair) => pair + ',\n').join());
    }));

    pairs.addAll(otherKeys.map((dynamic key) {
      return '$key: ' + prettyString(obj[key]) + ',';
    }));

    final trailingComma = RegExp(r'\s*,\s*$');

    final singleLineInner = pairs.join(' ').replaceFirst(trailingComma, '');

    if (pairs.length > _maxKeyValuePairsPerLine ||
        pairs.any((pair) => pair.contains('\n')) ||
        singleLineInner.length > _maxSingleLineListOrMapLength) {
      var inner = _indentString(pairs.join('\n')).replaceFirst(trailingComma, '');
      return '{\n$inner\n}';
    } else {
      return '{$singleLineInner}';
    }
  } else {
    return obj.toString();
  }
}

extension on Iterable {
  bool hasLengthOfAtLeast(int length) => take(length).length == length;
}
