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
import 'package:over_react_analyzer_plugin/src/util/pretty_print.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/weak_collections.dart';

// ignore_for_file: avoid_function_literals_in_foreach_calls

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
  static final _debugFlagPattern = RegExp(r'debug:.*\bover_react_hooks_exhaustive_deps\b');

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

  // Should be shared between visitors.
  /// A mapping from setState references to setState declarations
  final setStateCallSites = WeakMap<Identifier, VariableDeclaration>();
  final stableKnownValueCache = WeakMap<Identifier, bool>();
  final functionWithoutCapturedValueCache = WeakMap<Element, bool>();

  // Variables referenced in helper methods, which are easier to temporarily set on the class than pass around.
  // Since these variables can't be non-nullable, expose non-nullable getters so that we don't have to use `!` everywhere,
  // and so that we get better error messages if they're ever null.
  ResolvedUnitResult? _result;
  DiagnosticCollector? _collector;
  AnalyzerDebugHelper? _debugHelper;

  StateError _uninitializedError(String name) =>
      StateError('$name is null. Check computeErrors to make sure it is initialized.');

  ResolvedUnitResult get result => _result ?? (throw _uninitializedError('result'));

  DiagnosticCollector get collector => _collector ?? (throw _uninitializedError('collector'));

  AnalyzerDebugHelper get debugHelper => _debugHelper ?? (throw _uninitializedError('debugHelper'));

  @override
  Future<void> computeErrors(result, collector) async {
    try {
      _result = result;
      _collector = collector;
      _debugHelper = AnalyzerDebugHelper(result, collector, enabled: _debugFlagPattern.hasMatch(result.content!));

      final reactiveHookCallbacks = <ReactiveHookCallbackInfo>[];
      result.unit!.accept(_ExhaustiveDepsVisitor(
        additionalHooks: additionalHooksPattern,
        onReactiveHookCallback: reactiveHookCallbacks.add,
      ));

      for (final callback in reactiveHookCallbacks) {
        await _handleReactiveHookCallback(callback);
      }
    } finally {
      _result = null;
      _collector = null;
      _debugHelper = null;
    }
  }

  void debug(String string, dynamic location) {
    if (!debugHelper.enabled) return;
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
    debugHelper.logWithLocation(string, _location);
  }

  String getSource(SyntacticEntity entity) => result.content!.substring(entity.offset, entity.end);

  void reportProblem({required AstNode node, String? message}) {
    collector.addError(HooksExhaustiveDeps.code, result.locationFor(node), errorMessageArgs: [
      message ?? '',
    ]);
  }

  Future<void> _handleReactiveHookCallback(ReactiveHookCallbackInfo info) async {
    final callback = info.callback;
    final reactiveHook = info.reactiveHook;
    final reactiveHookName = info.reactiveHookName;
    final declaredDependenciesNode = info.declaredDependenciesNode;
    final isEffect = info.isEffect;

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
      await visitFunctionWithDependencies(callbackFunction: callback, info: info);
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
        await visitFunctionWithDependencies(callbackFunction: function, info: info);
        return; // Handled
      }
      // Unhandled
    } else {
      // useEffect(generateEffectBody(), []);
      reportProblem(
        node: reactiveHook,
        message: "React Hook $reactiveHookName received a function whose dependencies "
            "are unknown. Pass an inline function instead.",
      );
      return; // Handled
    }

    // Something unusual. Fall back to suggesting to add the body itself as a dep.
    final callbackName = callback.name;
    await collector.addErrorWithFix(
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

// Visitor for both function expressions and arrow function expressions.
  Future<void> visitFunctionWithDependencies({
    required ReactiveHookCallbackInfo info,
    required FunctionExpression callbackFunction,
  }) async {
    final reactiveHook = info.reactiveHook;
    final reactiveHookName = info.reactiveHookName;
    final declaredDependenciesNode = info.declaredDependenciesNode;
    final isEffect = info.isEffect;

    final rootNode = callbackFunction.root;

    if (isEffect && callbackFunction.body.isAsynchronous) {
      reportProblem(
        node: callbackFunction,
        message: "Effect callbacks are synchronous to prevent race conditions. "
            "Put the async function inside:\n\n"
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

    // todo improve this
    final componentOrCustomHookFunctionBody = getClosestFunctionComponentOrHookBody(callbackFunction);
    final componentOrCustomHookFunction = componentOrCustomHookFunctionBody?.parentExpression;
    assert(componentOrCustomHookFunction == null || componentOrCustomHookFunction != callbackFunction);

    final componentOrCustomHookFunctionElement = componentOrCustomHookFunction?.declaredElement;

    debug('componentOrCustomHookFunctionElement: ${componentOrCustomHookFunctionElement?.debugString}',
        componentOrCustomHookFunction?.offset ?? 0);

    bool isDeclaredInPureScope(Element element) =>
        // todo(greg) is this function even valid when this is null?
        componentOrCustomHookFunctionElement != null &&
        // Don't use thisOrAncestorOfType with since `element` may itself be an ExecutableElement (e.g., local functions).
        // FIXME(greg) audit existing usages of thisOrAncestor* for similar bugs
        element.ancestorOfType<ExecutableElement>() == componentOrCustomHookFunctionElement;

    bool isProps(Element e) {
      // FIXME(greg) make this way better
      return e.name == 'props' &&
          e.enclosingElement == componentOrCustomHookFunctionElement &&
          lookUpParameter(e, rootNode)?.parent == componentOrCustomHookFunction?.parameters;
    }

    // Returns whether [element] is a variable assigned to a prop value.
    bool isPropVariable(Element element) {
      if (!isDeclaredInPureScope(element)) return false;
      final variable = lookUpVariable(element, rootNode);
      if (variable == null) return false;

      final initializer = variable.initializer;
      if (initializer == null) return false;
      final initializerTargetElement =
          getSimpleTargetAndPropertyName(initializer, allowMethodInvocation: false)?.item1.staticElement;

      return initializerTargetElement != null && isProps(initializerTargetElement);
    }

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
      VariableDeclaration? lookUpVariableDeclarationForReference() {
        final referenceElement = reference.staticElement;
        return referenceElement == null
            ? null
            : lookUpDeclaration(referenceElement, reference.root)?.tryCast<VariableDeclaration>();
      }

      // Check whether this reference is only used to a stable hook property.
      {
        final parent = reference.parent;
        final stableHookInfo = parent != null ? getStableHookMethodInfo(parent) : null;
        if (stableHookInfo != null && stableHookInfo.target == reference) {
          // FIXME(greg) what about edge cases here?
          if (stableHookInfo.isStateSetterMethod) {
            final declaration = lookUpVariableDeclarationForReference();
            if (declaration != null) {
              setStateCallSites.set(reference, declaration);
            }
          }

          return true;
        }
      }

      // Look up the variable declaration.
      // Don't worry about functions, since they're handled in memoizedIsFunctionWithoutCapturedValues.
      final declaration = lookUpVariableDeclarationForReference();
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
      // fixme(greg) handle namespaced imports, add test cases for useRef
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
    bool isInsideEffectCleanup(AstNode reference) => callbackFunction.body.returnExpressions
        .whereType<FunctionExpression>()
        .any((cleanupFunction) => cleanupFunction.body.containsRangeOf(reference));

    // Get dependencies from all our resolved references in pure scopes.
    // Key is dependency string, value is whether it's stable.
    final dependencies = <String, _Dependency>{};
    final optionalChains = <String, bool>{};

    // The original implementation needs to recurse to process references in child scopes,
    // but we can process all descendant references regardless of scope in one go.
    for (final reference in resolvedReferencesWithin(callbackFunction)) {
      // debug(
      //     'reference.staticElement.ancestors: \n${prettyPrint(reference.staticElement.ancestors.map(elementDebugString).toList())}',
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
        isInvocationAllowedForNode: true,
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
        );
      }

      // FIXME need to check more parents for GenericFunctionType case?
      // FIXME(greg) add test cases
      if (reference.parent is NamedType) {
        continue;
      }

      // FIXME add tests to ensure references to type parameters don't make it this far.

      // Add the dependency to a map so we can make sure it is referenced
      // again in our dependencies array. Remember whether it's stable.
      dependencies
          .putIfAbsent(dependency, () {
            return _Dependency(
              isStable: memoizedIsStableKnownHookValue(reference) ||
                  memoizedIsFunctionWithoutCapturedValues(referenceElement),
              references: [],
            );
          })
          // Note that for the the `state.set` case, the reference is still `state`.
          .references
          .add(reference);
    }

    // Warn about accessing .current in cleanup effects.
    currentRefsInEffectCleanup.forEach(
      (dependency, _entry) {
        final reference = _entry.reference;

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
          node: reference.parent!,
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

          final isDirectlyInsideEffect = reference.thisOrAncestorOfType<FunctionBody>() == callbackFunction.body;
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
        await collector.addErrorWithFix(
          code,
          result.locationFor(reactiveHook),
          errorMessageArgs: [
            // ignore: no_adjacent_strings_in_list
            "React Hook $reactiveHookName contains a call to '$setStateInsideEffectWithoutDeps'. "
                "Without a list of dependencies, this can lead to an infinite chain of updates. "
                "To fix this, pass ["
                "${suggestedDependencies.join(', ')}"
                "] as a second argument to the $reactiveHookName Hook.",
          ],
          fixKind: fixKind,
          fixMessageArgs: ['Add dependencies list: [${suggestedDependencies.join(', ')}]'],
          computeFix: () => buildGenericFileEdit(result, (builder) {
            builder.addSimpleInsertion(callbackFunction.end, ', [${suggestedDependencies.join(', ')}]');
          }),
        );
      }
      return;
    }

    final declaredDependencies = <_DeclaredDependency>[];
    final externalDependencies = <String>{};
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
        // FIXME(greg) add test cases
        if (declaredDependencyNode.staticType?.isStateHook ?? false) {
          final declaredDepSource = getSource(declaredDependencyNode);

          // Conditionally suggest value or removing the dep based on whether `stateHook.value` is used.
          // This check isn't perfect, but should handle most cases.
          //
          // Dependencies have `?.` normalized to `.`, but they may still be accessing properties or calling methods.
          // For example: `stateHook.set.call`, `stateHook.value()`. So, use regexes with word boundaries.
          final dependenciesUsingValue =
              dependencies.keys.where(RegExp(r'^' + RegExp.escape(declaredDepSource) + r'\.value\b').hasMatch).toList();
          final stableMethodsUsed = stableStateHookMethods
              .where((method) => dependencies.keys.any(
                  RegExp(r'^' + RegExp.escape(declaredDepSource) + r'\.' + RegExp.escape(method) + r'\b').hasMatch))
              .toList();

          final shouldDependOnValue = dependenciesUsingValue.isNotEmpty;
          final suggestedValueDependency =
              dependenciesUsingValue.length == 1 ? dependenciesUsingValue.single : '$declaredDepSource.value';

          // TODO(greg) have a fallback check if stableMethodsUsed.isEmpty && dependenciesUsingValue.isEmpty but dependencies contains a reference to declaredDependencyNode?

          final messageBuffer = StringBuffer()
            ..write("The '$declaredDepSource' StateHook (from useState)")
            ..write(" makes the dependencies of React Hook ${getSource(reactiveHook)}")
            ..write(" change every render, and should not itself be a dependency.");
          if (stableMethodsUsed.isNotEmpty) {
            messageBuffer
              ..write(" Since ")
              ..write(joinEnglish(stableMethodsUsed.map((m) => "'$declaredDepSource.$m'")))
              ..write(stableMethodsUsed.length == 1 ? ' is' : ' are')
              ..write(" stable across renders, no dependencies are required to use")
              ..write(stableMethodsUsed.length == 1 ? ' it' : ' them')
              // Include an extra message when !shouldDependOnValue, since otherwise we don't tell the user what to do with this dependency.
              ..write(shouldDependOnValue ? '.' : ", and this dependency can be safely removed.");
          }
          if (shouldDependOnValue) {
            messageBuffer.write(" Since '$suggestedValueDependency' is being used, depend on that instead.");
          }
          // FIXME(greg) add message like we have elsewhere when using `setWithUpdater` and `.value`.

          await collector.addErrorWithFix(
            HooksExhaustiveDeps.code,
            result.locationFor(declaredDependencyNode),
            errorMessageArgs: [messageBuffer.toString()],
            fixKind: HooksExhaustiveDeps.fixKind,
            fixMessageArgs: [
              if (shouldDependOnValue)
                "Change the dependency to: $suggestedValueDependency"
              else
                "Remove the dependency on '$declaredDepSource'."
            ],
            computeFix: () => buildGenericFileEdit(result, (builder) {
              if (shouldDependOnValue) {
                builder.addSimpleReplacement(range.node(declaredDependencyNode), suggestedValueDependency);
              } else {
                builder.addDeletion(range.nodeInList(declaredDependenciesNode.elements, declaredDependencyNode));
              }
            }),
          );
          // Return here so that other dependency checks don't interfere.
          // TODO(greg) if people ignore this, they won't get other dependency checks below :/. Should we move this check, or should we not care about that case?
          return;

          // FIXME(greg) make sure we want to return here and not continue. If we do want to return, add explanation about why, and what would happen if we were to continue (adapt below comment).
          // // By continuing here, the dependency isn't added to declaredDependencies, allowing the rest of our
          // // dependency computation logic to work and not treat `state.value` as being satisfied by `state`.
          // // If this approach becomes an issue in the future, we can adjust it so long as test cases pass.
          // continue;
        }

        // Try to normalize the declared dependency. If we can't then an error
        // will be thrown. We will catch that error and report an error.
        String declaredDependency;
        try {
          declaredDependency = analyzePropertyChain(
            declaredDependencyNode,
            null,
            // While invocations are allowed in certain cases when using dependencies,
            // they're not allowed in the dependency list.
            isInvocationAllowedForNode: false,
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

        // Add the dependency to our declared dependency map.
        declaredDependencies.add(_DeclaredDependency(
          declaredDependency,
          declaredDependencyNode,
          debugEnclosingElement: maybeID.tryCast<Identifier>()?.staticElement?.enclosingElement,
        ));

        if (!isDeclaredInComponent) {
          externalDependencies.add(declaredDependency);
        }
      }
    }

    debug(
        prettyPrint({
          'dependencies': dependencies,
          'declaredDependencies': declaredDependencies,
          'stableDependencies': stableDependencies,
          'externalDependencies': externalDependencies,
          'isEffect': isEffect,
        }),
        callbackFunction.body.offset);

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
        callbackNode: callbackFunction,
      );
      debug('constructions: $constructions', callbackFunction.body.offset);
      for (final _construction in constructions) {
        final construction = _construction.declaration;
        final constructionName = _construction.declarationElement.name;

        final isUsedOutsideOfHook = _construction.isUsedOutsideOfHook;
        final depType = _construction.depType;
        final wrapperHook = depType == _DepType.function ? 'useCallback' : 'useMemo';

        final constructionType = depType == _DepType.function ? 'definition' : 'initialization';

        final defaultAdvice = "wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook.";

        final advice = isUsedOutsideOfHook
            ? "To fix this, $defaultAdvice"
            : "Move it inside the $reactiveHookName callback. Alternatively, $defaultAdvice";

        final causation =
            depType == _DepType.conditional || depType == _DepType.binaryExpression ? 'could make' : 'makes';

        final message = "The '$constructionName' $depType $causation the dependencies of "
            "$reactiveHookName Hook (at line ${result.lineInfo.getLocation(declaredDependenciesNode.offset).lineNumber}) "
            "change on every render. $advice";

        // Only handle the simple case of variable assignments.
        // Wrapping function declarations can mess up hoisting.
        // FIXME(greg) change this since hoisting doesn't exist in Dart functions
        if (isUsedOutsideOfHook &&
            construction is VariableDeclaration &&
            // Objects may be mutated ater construction, which would make this
            // fix unsafe. Functions _probably_ won't be mutated, so we'll
            // allow this fix for them.
            depType == _DepType.function) {
          // FIXME(greg) is it safe to assume this here?
          final constructionInitializer = construction.initializer!;

          await collector.addErrorWithFix(
            HooksExhaustiveDeps.code,
            result.locationFor(construction),
            errorMessageArgs: [message],
            fixKind: HooksExhaustiveDeps.fixKind,
            fixMessageArgs: ["Wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook."],
            computeFix: () => buildGenericFileEdit(
              result,
              (builder) {
                // TODO: ideally we'd gather deps here but it would require
                // restructuring the rule code. Note we're
                // not adding [] because would that changes semantics.
                if (wrapperHook == 'useMemo') {
                  builder.addSimpleInsertion(constructionInitializer.offset, '$wrapperHook(() => ');
                  builder.addSimpleInsertion(constructionInitializer.end, ')');
                } else {
                  builder.addSimpleInsertion(constructionInitializer.offset, '$wrapperHook(');
                  // Add a placeholder here so there isn't a static error about using useCallback with the wrong number of arguments.
                  builder.addSimpleInsertion(constructionInitializer.end, ', [/* FIXME add dependencies */])');
                }
              },
            ),
          );
        } else {
          // TODO: What if the function needs to change on every render anyway?
          // Should we suggest removing effect deps as an appropriate fix too?
          collector.addError(
            HooksExhaustiveDeps.code,
            result.locationFor(construction),
            errorMessageArgs: [message],
          );
        }
      }
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
        final isDeclaredInCallbackFunction = _hasDeclarationWithName(callbackFunction.body, dep);
        if (!isDeclaredInCallbackFunction) {
          extraWarning = " Outer scope values like '$dep' aren't valid dependencies "
              "because mutating them doesn't re-render the component.";
        }
      }
    }

    // Removed extra warning around this old beavior:
    // // "props.foo()" marks "props" as a dependency because it has
    // // a "this" value. This warning can be confusing.
    // // So if we're going to show it, append a clarification.
    // which is no longer relevant in this implementation since "props.foo()" no longer marks "props" as a dependency.

    if (extraWarning == null && missingDependencies.isNotEmpty) {
      // See if the user is trying to avoid specifying a callable prop.
      // This usually means they're unaware of useCallback.
      final missingCallbackDeps = missingDependencies.where((missingDep) {
        // Is this a variable from top scope?
        // FIXME(greg) can we reuse logic from scanForConstructions here?
        final usedDep = dependencies[missingDep];
        if (usedDep == null) return false;

        return usedDep.references.any((ref) {
          final element = ref.staticElement;
          if (element != null && isPropVariable(element)) {
            // foo()
            if (ref.parent.tryCast<InvocationExpression>()?.function == ref) {
              return true;
            }
            // foo.call()
            final inv = PropertyInvocation.detectClosest(ref);
            if (inv != null) {
              return inv.target == ref && inv.functionName.name == 'call';
            }
          }

          if (element != null && isProps(element)) {
            final inv = PropertyInvocation.detectClosest(ref);
            if (inv != null) {
              final target = inv.target;
              // props.foo()
              if (target == ref) {
                return true;
              }
              // props.foo.call()
              if (inv.functionName.name == 'call' &&
                  target != null &&
                  getSimpleTargetAndPropertyName(target, allowMethodInvocation: false)?.item1 == ref) {
                return true;
              }
            }
          }

          return false;
        });
      }).toList();
      if (missingCallbackDeps.isNotEmpty) {
        extraWarning = " If " +
            (missingCallbackDeps.length == 1
                ? "'${formatDependency(missingCallbackDeps.single)}'"
                : "any of " + joinEnglish((missingCallbackDeps.toList()..sort()).map((d) => "'$d'").toList(), 'or')) +
            " changes too often, "
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
        for (final reference in usedDep.references) {
          // Try to see if we have setState(someExpr(missingDep)).
          for (var maybeCall = reference.parent;
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
                } else if (reference.staticType?.isStateHook ?? false) {
                  // setCount(count + increment)
                  setStateRecommendation = _SetStateRecommendation(
                    missingDep: missingDep,
                    setter: maybeCallFunctionName,
                    form: _SetStateRecommendationForm.reducer,
                  );
                } else {
                  // Recommend an inline reducer if it's a prop.
                  final referenceElement = reference.staticElement;
                  if (referenceElement != null && (isProps(referenceElement) || isPropVariable(referenceElement))) {
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
                "if '$setter' needs '$missingDep'.";
            break;
          case _SetStateRecommendationForm.inlineReducer:
            extraWarning = " If '$setter' needs the current value of '$missingDep', "
                "you can also switch to useReducer instead of useState and "
                "read '$missingDep' in the reducer.";
            break;
          case _SetStateRecommendationForm.updater:
            final updaterArgumentName = missingDep.substring(0, 1);
            // This might already by an updater function, if they're referencing the state in the updater.
            // TODO(greg) add a better message for this case, telling them to use the arg instead?
            final functionalUpdateSetter = setter.endsWith('WithUpdater') ? setter : '${setter}WithUpdater';
            extraWarning = " You can also do a functional update"
                " '$functionalUpdateSetter(($updaterArgumentName) => ...)'"
                " if you only need '$missingDep' in the '$setter' call.";
            break;
        }
      }
    }

    await collector.addErrorWithFix(
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
}

class _ExhaustiveDepsVisitor extends GeneralizingAstVisitor<void> {
  final RegExp? additionalHooks;
  final void Function(ReactiveHookCallbackInfo) onReactiveHookCallback;

  _ExhaustiveDepsVisitor({
    this.additionalHooks,
    required this.onReactiveHookCallback,
  });

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

    onReactiveHookCallback(ReactiveHookCallbackInfo(
      node: node,
      callback: callback,
      reactiveHook: reactiveHook,
      reactiveHookName: reactiveHookName,
      declaredDependenciesNode: declaredDependenciesNode,
      isEffect: isEffect,
    ));
  }
}

class ReactiveHookCallbackInfo {
  final InvocationExpression? node;
  final Expression? callback;
  final Expression reactiveHook;
  final String reactiveHookName;
  final Expression? declaredDependenciesNode;
  final bool isEffect;

  ReactiveHookCallbackInfo({
    required this.node,
    required this.callback,
    required this.reactiveHook,
    required this.reactiveHookName,
    required this.declaredDependenciesNode,
    required this.isEffect,
  });
}

class _Dependency {
  final bool isStable;

  final List<Identifier> references;

  _Dependency({required this.isStable, required this.references});

  @override
  String toString() => prettyPrint({
        'isStable': isStable,
        'references': references,
      });
}

class _RefInEffectCleanup {
  final Identifier reference;

  /// [reference].staticElement, but stored as a separate non-nullable field.
  final Element referenceElement;

  _RefInEffectCleanup({required this.reference, required this.referenceElement});

  @override
  String toString() => prettyPrint({
        'reference': reference,
      });
}

// FIXME(greg) unit test these functions
FunctionExpression? lookUpFunction(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is Identifier && node.staticElement == element) {
    final parent = node.parent;
    return parent.tryCast<FunctionDeclaration>()?.functionExpression ??
        parent.tryCast<VariableDeclaration>()?.initializer?.tryCast<FunctionExpression>();
  }

  return null;
}

// FIXME(greg) make name clear about the cases it handles (variables, functions?, not parameters)
Declaration? lookUpDeclaration(Element element, AstNode root) {
  // if (element is ExecutableElement) return null;
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  final declaration = node?.thisOrAncestorOfType<Declaration>();
  if (declaration?.declaredElement == element) {
    return declaration;
  }

  return null;
}

FormalParameter? lookUpParameter(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  final declaration = node?.thisOrAncestorOfType<FormalParameter>();
  if (declaration?.declaredElement == element) {
    return declaration;
  }

  return null;
}

Iterable<Identifier> resolvedReferencesWithin(AstNode node) =>
    allDescendantsOfType<Identifier>(node).where((e) => e.staticElement != null);

enum HookTypeWithStableMethods { stateHook, reducerHook, transitionHook }

const stateHookSetMethods = {'set', 'setWithUpdater'};
const stableStateHookMethods = {...stateHookSetMethods};
const stableReducerHookMethods = {'dispatch'};
const stableTransitionHookMethods = {'startTransition'};

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
  if ((target.staticType?.isStateHook ?? false) && stableStateHookMethods.contains(property.name)) {
    return StableHookMethodInfo(
        node: node, target: target, property: property, hookType: HookTypeWithStableMethods.stateHook);
  }
  if ((target.staticType?.isReducerHook ?? false) && stableReducerHookMethods.contains(property.name)) {
    return StableHookMethodInfo(
        node: node, target: target, property: property, hookType: HookTypeWithStableMethods.reducerHook);
  }
  if ((target.staticType?.isTransitionHook ?? false) && stableTransitionHookMethods.contains(property.name)) {
    return StableHookMethodInfo(
        node: node, target: target, property: property, hookType: HookTypeWithStableMethods.transitionHook);
  }

  return null;
}

/// Returns whether [body] has a declaration (a variable or local function) with the name
/// [childName].
///
/// Declarations in nested functions are ignored.
///
/// Example:
///
/// ```dart
/// // For the code:
/// //    void parent(arg) {
/// //      var variable;
/// //      void function() {
/// //        var nestedVariable;
/// //      }
/// //      {
/// //        var insideBlock;
/// //      }
/// //    }
/// _hasDeclarationWithName(parentEl, 'variable');       // true
/// _hasDeclarationWithName(parentEl, 'function');       // true
/// _hasDeclarationWithName(parentEl, 'insideBlock');    // true
/// _hasDeclarationWithName(parentEl, 'nestedVariable'); // false - nested inside another function
/// _hasDeclarationWithName(parentEl, 'arg');            // false - arguments aren't matched
/// ```
bool _hasDeclarationWithName(FunctionBody body, String childName) {
  // Can't use an ElementVisitor Here since FunctionElement doesn't have references to child declarations.
  // Use a visitor so we properly handle declarations inside blocks.
  var hasMatch = false;
  body.visitChildren(_ChildLocalVariableOrFunctionDeclarationVisitor((_, name) {
    if (name.name == childName) {
      hasMatch = true;
    }
  }));
  return hasMatch;
}

class _ChildLocalVariableOrFunctionDeclarationVisitor extends RecursiveAstVisitor<void> {
  final void Function(Declaration, SimpleIdentifier name) onChildLocalDeclaration;

  _ChildLocalVariableOrFunctionDeclarationVisitor(this.onChildLocalDeclaration);

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    super.visitVariableDeclaration(node);
    onChildLocalDeclaration(node, node.name);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    super.visitFunctionDeclaration(node);
    onChildLocalDeclaration(node, node.name);
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    // Don't call super so that we don't recurse into function expressions,
    // allowing us to ignore their parameters and any descendant declarations.
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
  String toString() => prettyPrint({
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
    return _DepType.list;
  } else if (node is SetOrMapLiteral) {
    return node.isMap ? _DepType.map : _DepType.set;
  } else if (node is FunctionExpression) {
    return _DepType.function;
  } else if (node is ConditionalExpression) {
    if (getConstructionExpressionType(node.thenExpression) != null ||
        getConstructionExpressionType(node.elseExpression) != null) {
      return _DepType.conditional;
    }
    return null;
  } else if (node is BinaryExpression) {
    if (getConstructionExpressionType(node.leftOperand) != null ||
        getConstructionExpressionType(node.rightOperand) != null) {
      return _DepType.binaryExpression;
    }
    return null;
  } else if (node is AssignmentExpression) {
    if (getConstructionExpressionType(node.rightHandSide) != null) {
      return _DepType.assignmentExpression;
    }
    return null;
  } else if (node is AsExpression) {
    return getConstructionExpressionType(node.expression);
  } else if (node is InvocationExpression && (node.staticType?.isReactElement ?? false)) {
    return _DepType.reactElement;
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
  required AstNode callbackNode,
}) {
  bool isUsedOutsideOfHook(Declaration declaration, Element declarationElement) {
    for (final reference in findReferences(declarationElement, declaration.root)) {
      final parent = reference.parent;
      // TODO(greg) make sure there aren't edge cases here
      if (parent is Declaration && parent.declaredElement == declarationElement) continue;
      if (!callbackNode.containsRangeOf(reference)) {
        // This reference is outside the Hook callback.
        // It can only be legit if it's the deps array.
        if (!declaredDependenciesNode.containsRangeOf(reference)) {
          return true;
        }
      }
    }
    return false;
  }

  return declaredDependencies
      .map<_Construction?>((dep) {
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
              return _Construction(
                declaration: declaration,
                declarationElement: declarationElement,
                depType: constantExpressionType,
                isUsedOutsideOfHook: isUsedOutsideOfHook(declaration, declarationElement),
              );
            }
          }
          return null;
        }
        // handleChange() {}
        if (declaration is FunctionDeclaration) {
          return _Construction(
            declaration: declaration,
            declarationElement: declarationElement,
            depType: _DepType.function,
            isUsedOutsideOfHook: isUsedOutsideOfHook(declaration, declarationElement),
          );
        }

        return null;
      })
      .whereNotNull()
      .toList();
}

class _Construction {
  final Declaration declaration;
  final Element declarationElement;

  /// Will either be a constant in [_DepType] or the name of the object/constructor being used.
  final String depType;
  final bool isUsedOutsideOfHook;

  _Construction(
      {required this.declaration,
      required this.declarationElement,
      required this.depType,
      required this.isUsedOutsideOfHook});

  @override
  String toString() => prettyPrint({
        'declaration': declaration,
        'depType': depType,
        'isUsedOutsideOfHook': isUsedOutsideOfHook,
      });
}

abstract class _DepType {
  static const list = 'List';
  static const map = 'Map';
  static const set = 'Set';
  static const function = 'function';
  static const conditional = 'conditional';
  static const binaryExpression = 'binary expression';
  static const assignmentExpression = 'assignment expression';
  static const reactElement = 'ReactElement';
}

bool isInvocationADiscreteDependency(PropertyInvocation invocation) {
  // FIXME(greg) should we do this better/differently?
  bool isProps(Expression e) => e is Identifier && e.name == 'props';

  final target = invocation.target;
  // FIXME(greg) pull this out better
  return target != null && (getStableHookMethodInfo(invocation.functionName.parent!) != null || isProps(target));
}

// fixme Greg this doc comment has to be incorrect for some cases, right?
/// Assuming () means the passed/returned node:
/// (props) => (props)
/// props.(foo) => (props.foo)
/// props.foo.(bar) => (props).foo.bar
/// props.foo.bar.(baz) => (props).foo.bar.baz
Expression getDependency(Expression node) {
  final parent = node.parent!;
  final grandparent = parent.parent;

  // Invocations can show up as MethodInvocations or an FunctionExpressionInvocation with a PropertyAccess.
  // We want to handle both here.
  // This invocation check deviates from the JS, and is necessary to handle stable hook methods and function props.
  final propertyInvocation = PropertyInvocation.detectClosest(node);
  if (propertyInvocation != null && propertyInvocation.target == node) {
    if (isInvocationADiscreteDependency(propertyInvocation)) {
      // Return this directly since we don't want to recurse into property accesses on the return value.
      return propertyInvocation.invocation;
    }
  }

  // 1.
  // FIXME(greg) are there other places we don't handle the FunctionExpressionInvocation case properly?

  if (parent is PropertyAccess &&
      parent.target == node &&
      parent.propertyName.name != 'current' && // FIXME only test for ref/dynamic values?
      !(grandparent is InvocationExpression && grandparent.function == parent)) {
    return getDependency(parent);
  }
  if (parent is PrefixedIdentifier &&
      parent.prefix == node &&
      parent.identifier.name != 'current' && // FIXME only test for ref/dynamic values?
      !(grandparent is InvocationExpression && grandparent.function == parent)) {
    return getDependency(parent);
  }

  // FIXME(greg) make sure we have test cases for these, including cascaded assignments: `dependency..property = value`
  if (parent is AssignmentExpression && parent.leftHandSide == node) {
    if (node is PropertyAccess) return node.realTarget;
    if (node is PrefixedIdentifier) return node.prefix;
  }

  return node;
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
///
/// If [isInvocationAllowedForNode] is true, then invocations will be handled (for certain cases,
/// like function props and stable hook methods). Otherwise, this will throw.
String analyzePropertyChain(AstNode node, Map<String, bool>? optionalChains,
    {required bool isInvocationAllowedForNode}) {
  late final propertyInvocation = PropertyInvocation.detect(node);

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
    final object = analyzePropertyChain(node.target!, optionalChains, isInvocationAllowedForNode: false);
    final property = analyzePropertyChain(node.propertyName, null, isInvocationAllowedForNode: false);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: node.isNullAware);
    return result;
  } else if (node is PrefixedIdentifier) {
    final object = analyzePropertyChain(node.prefix, optionalChains, isInvocationAllowedForNode: false);
    final property = analyzePropertyChain(node.identifier, null, isInvocationAllowedForNode: false);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: false);
    return result;
    // rule out cascades and implicit this // fixme greg update other locations to use this pattern
  } else if (isInvocationAllowedForNode &&
      propertyInvocation != null &&
      propertyInvocation.target != null &&
      isInvocationADiscreteDependency(propertyInvocation)) {
    // This invocation check deviates from the JS, and is necessary to handle stable hook methods and function props.
    final object = analyzePropertyChain(propertyInvocation.target!, optionalChains, isInvocationAllowedForNode: false);
    final property = analyzePropertyChain(propertyInvocation.functionName, null, isInvocationAllowedForNode: false);
    final result = "$object.$property";
    markNode(node, optionalChains, result, isOptional: propertyInvocation.isNullAware);
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
          name = analyzePropertyChain(node, null, isInvocationAllowedForNode: false);
        } on UnsupportedNodeTypeException catch (_) {
          return 0;
        }
        return additionalHooks.hasMatch(name) ? 0 : -1;
      } else {
        return -1;
      }
  }
}

String joinEnglish(Iterable<String> items, [String joinWord = 'and']) {
  final arr = items is List<String> ? items : items.toList();
  var s = '';
  for (var i = 0; i < arr.length; i++) {
    s += arr[i];
    if (i == 0 && arr.length == 2) {
      s += ' $joinWord ';
    } else if (i == arr.length - 2 && arr.length > 2) {
      s += ', $joinWord ';
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

  /// Returns the most immediate ancestor of this element
  /// that has the given type, or `null` if there is no such element.
  // ignore: unused_element
  E? ancestorOfType<E extends Element>() => enclosingElement?.thisOrAncestorOfType<E>();

  /// Returns the most immediate ancestor of this element
  /// for which the [predicate] returns `true`, or `null` if there is no such
  /// element.
  // ignore: unused_element
  E? ancestorMatching<E extends Element>(bool Function(Element) predicate) =>
      enclosingElement?.thisOrAncestorMatching(predicate);
}
