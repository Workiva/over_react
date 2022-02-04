// Adapted from https://github.com/facebook/react/blob/master@%7B2020-10-16%7D/packages/eslint-plugin-react-hooks/src/ExhaustiveDeps.js

// Copyright (c) Facebook, Inc. and its affiliates.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.
//

import 'package:analyzer/analyzer.dart' show NodeLocator2, ConstantEvaluator;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' show Location;
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

//
// final _hookNamePattern = RegExp(r'^use[A-Z0-9].*$');
//
// /// Catch all identifiers that begin with "use" followed by an uppercase Latin
// /// character to exclude identifiers like "user".
// bool isHookName(String s) => _hookNamePattern.hasMatch(s);
//

class HooksExhaustiveDeps extends DiagnosticContributor {
  @DocsMeta('Verifies the list of dependencies for React Hooks like useEffect and similar', details: '')
  static const code = DiagnosticCode(
    'over_react_hooks_exhaustive_deps',
    "{0}",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    url: 'https://reactjs.org/docs/hooks-rules.html',
  );

  @override
  Future<void> computeErrors(result, collector) async {
    final helper = AnalyzerDebugHelper(result, collector);
    result.unit.accept(_ExhaustiveDepsVisitor(
      getSource: (node) => result.content.substring(node.offset, node.end),
      reportProblem: ({message, @required node}) {
        collector.addError(code, result.locationFor(node), errorMessageArgs: [
          message ?? '',
        ]);
      },
      debug: (string, location) {
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

class WeakSet<E> {
  final _isEntry = Expando<Object>();

  void add(E key) {
    _isEntry[key] = const Object();
  }

  bool has(E key) {
    if (key == null) return false;
    return _isEntry[key] != null;
  }

  void remove(E key) {
    _isEntry[key] = null;
  }
}

class WeakMap<K, V> {
  final _keys = WeakSet<K>();
  final _valueFor = Expando<V>();

  V get(K key) => has(key) ? _valueFor[key] : null;

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
    if (has(key)) return get(key);
    final value = ifAbsent();
    set(key, value);
    return value;
  }
}

extension<K, V> on V Function(K) {
  V Function(K) memoizeWithWeakMap(WeakMap<K, V> map) {
    return (key) => map.putIfAbsent(key, () => this(key));
  }
}

class _Dependency {
  final bool isStable;
  final List<Identifier> references;

  _Dependency({@required this.isStable, @required this.references});

  @override
  String toString() => '${{
        'isStable': isStable,
        'references': references,
      }}';
}

class _RefInEffectCleanup {
  final Identifier reference;
  final Identifier dependencyNode;

  _RefInEffectCleanup({this.reference, this.dependencyNode});

  @override
  String toString() => '${{
        'reference': reference,
        'dependencyNode': dependencyNode,
      }}';
}

VariableDeclaration lookUpVariable(Element element, AstNode root) {
  // if (element is ExecutableElement) return null;

  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is Identifier && node.staticElement == element) {
    return node.parent.tryCast<VariableDeclaration>();
  }

  return null;
}

FunctionExpression lookUpFunction(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is Identifier && node.staticElement == element) {
    final parent = node.parent;
    return parent.tryCast<FunctionDeclaration>()?.functionExpression ??
        parent.tryCast<VariableDeclaration>()?.initializer?.tryCast<FunctionExpression>();
  }

  return null;
}

Declaration lookUpDeclaration(Element element, AstNode root) {
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

class _ExhaustiveDepsVisitor extends GeneralizingAstVisitor<void> {
  // Should be shared between visitors.
  /// A mapping from setState references to setState declarations
  final setStateCallSites = WeakMap<Identifier, VariableDeclaration>();
  final stateVariables = WeakSet();
  final stableKnownValueCache = WeakMap<Identifier, bool>();
  final functionWithoutCapturedValueCache = WeakMap<Element, bool>();

  final Function({@required AstNode node, String message}) reportProblem;

  final Function(SyntacticEntity entity) getSource;
  final RegExp additionalHooks;
  void Function(String string, dynamic location) debug;

  _ExhaustiveDepsVisitor({
    @required this.reportProblem,
    @required this.getSource,
    @required this.debug,
    this.additionalHooks,
  });

// Visitor for both function expressions and arrow function expressions.
  void visitFunctionWithDependencies({
    @required FunctionBody node,
    @required AstNode declaredDependenciesNode,
    @required AstNode reactiveHook,
    @required String reactiveHookName,
    @required bool isEffect,
  }) {
    final rootNode = node.root;

    if (isEffect && node.isAsynchronous) {
      reportProblem(
        node: node,
        message: "Effect callbacks are synchronous to prevent race conditions. "
            "Put the async inside:\n\n"
            'useEffect(() => {\n'
            '  async function fetchData() {\n'
            '    // You can await here\n'
            '    const response = await MyAPI.getData(someId);\n'
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
    final componentFunction = node.ancestors.whereType<FunctionExpression>().last;
    assert(componentFunction != null);
    assert(componentFunction != node.thisOrAncestorOfType<FunctionExpression>());

    final componentFunctionElement = componentFunction.declaredElement;

    debug('componentFunctionElement: ' + elementDebugString(componentFunctionElement), componentFunction.offset);

    bool isDeclaredInPureScope(Element element) =>
        element.thisOrAncestorOfType<ExecutableElement>() == componentFunctionElement;

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
      // FIXME what about function declarations? are those handled elsewhere
      final declaration = lookUpDeclaration(reference.staticElement, reference.root)?.tryCast<VariableDeclaration>();
      var init = declaration?.initializer;
      if (init == null) {
        return false;
      }

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

      // todo support useTransition
      const stableStateHookMethods = {'set', 'setWithUpdater'};
      const stableReducerHookMethods = {'dispatch'};

      // Handle hook tearoffs
      // final setCount = useCount(1).set;
      if (init is PropertyAccess) {
        final property = init.propertyName.name;
        if (stableStateHookMethods.contains(property) && (init.staticType?.element?.isStateHook ?? false)) {
          setStateCallSites.set(reference, declaration);
          return true;
        }
        if (stableReducerHookMethods.contains(property) && (init.staticType?.element?.isReducerHook ?? false)) {
          return true;
        }
      }

      SimpleIdentifier propertyBeingAccessed() =>
          propertyNameFromNonCascadedAccess(reference.parent.tryCast<Expression>());

      if (reference.staticType?.element?.isStateHook ?? false) {
        // Check whether this reference is only used to access the stable hook property.
        final property = propertyBeingAccessed();
        if (property != null && stableStateHookMethods.contains(property.name)) {
          // fixme reference or property.name??
          setStateCallSites.set(reference, declaration);
          setStateCallSites.set(property, declaration);
          return true;
        }
        return false;
      }
      if (reference.staticType?.element?.isReducerHook ?? false) {
        // Check whether this reference is only used to access the stable hook property.
        final property = propertyBeingAccessed();
        if (property != null && stableReducerHookMethods.contains(property.name)) {
          return true;
        }
        return false;
      }

      if (init is! InvocationExpression) {
        return false;
      }

      // TODO do we need to check for direct invocations for other cases if typing is available?

      var callee = (init as InvocationExpression).function;
      // fixme handle namespaced imports
      if (callee is! Identifier) {
        return false;
      }
      final name = (callee as Identifier).name;
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
      if (!componentFunction.containsRangeOf(fnNode)) return true;

      // Does this function capture any values
      // that are in pure scopes (aka render)?
      final referencedElements = resolvedReferencesWithin(fnNode.body);
      for (final ref in referencedElements) {
        if (isDeclaredInPureScope(ref.staticElement) &&
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
        isInReturnedFunction = current?.parentOfType<FunctionExpression>()?.parentOfType<ReturnStatement>() != null;
      });
      return isInReturnedFunction;
    }

    // Get dependencies from all our resolved references in pure scopes.
    // Key is dependency string, value is whether it's stable.
    final dependencies = <String, _Dependency>{};
    final optionalChains = <String, bool>{};

    for (final reference in resolvedReferencesWithin(node)) {
      if (reference.name == 'id') {
        debug(
            'reference.staticElement.ancestors: ${reference.staticElement.ancestors.map(elementDebugString).toList()}',
            reference.offset);
      }

      // If this reference is not not declared in a pure
      // scope then we don't care about this reference.
      // FIXME this check isn't working the way it's supposed to.
      // if (!isDeclaredInPureScope(reference.staticElement)) {
      //   continue;
      // }

      // Narrow the scope of a dependency if it is, say, a member expression.
      // Then normalize the narrowed dependency.
      final dependencyNode = getDependency(reference);
      final dependency = analyzePropertyChain(
        dependencyNode,
        optionalChains,
      );

      // Accessing ref.current inside effect cleanup is bad.
      if (
          // We're in an effect...
          isEffect &&
              // ... and this look like accessing .current...
              dependencyNode is Identifier &&
              dependencyNode.parent.tryCast<PropertyAccess>()?.propertyName?.name == 'current' &&
              // ...in a cleanup function or below...
              isInsideEffectCleanup(reference)) {
        currentRefsInEffectCleanup[dependency] = _RefInEffectCleanup(
          reference: reference,
          dependencyNode: dependencyNode,
        );
      }

      // FIXME need to check more parents for GenericFunctionType case?
      if (node.parent is NamedType) {
        continue;
      }

      // FIXME add tests to ensure references to type parameters don't make it this far.

      // TODO follow up on this and see how dynamic calls are treated
      if (reference.staticElement == null) {
        continue;
      }

      // Add the dependency to a map so we can make sure it is referenced
      // again in our dependencies array. Remember whether it's stable.
      if (!dependencies.containsKey(dependency)) {
        final isStable = memoizedIsStableKnownHookValue(reference) ||
            // FIXME handle .call tearoffs
            memoizedIsFunctionWithoutCapturedValues(reference.staticElement);
        dependencies[dependency] = _Dependency(
          isStable: isStable,
          references: [reference],
        );
      } else {
        dependencies[dependency].references.add(reference);
      }
    }

    // Warn about accessing .current in cleanup effects.
    currentRefsInEffectCleanup.forEach(
      (dependency, _entry) {
        final reference = _entry.reference;
        final dependencyNode = _entry.dependencyNode;

        // Is React managing this ref or us?
        // Let's see if we can find a .current assignment.
        var foundCurrentAssignment = false;
        // TODO find root for reference element, which may be in a different AST than the reference
        for (final reference in findReferences(reference.staticElement, reference.root)) {
          final parent = reference.parent;
          if (
              // ref.current
              parent?.tryCast<PropertyAccess>()?.propertyName?.name == 'current' &&
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
          node: dependencyNode.parent,
          message: "The ref value '$dependency.current' will likely have "
              "changed by the time this effect cleanup runs. If "
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
      String setStateInsideEffectWithoutDeps;
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
          //     desc: "Add dependencies array: [${suggestedDependencies.join(
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
      for (final _declaredDependencyNode in (declaredDependenciesNode as ListLiteral).elements) {
        // Skip elided elements.
        if (_declaredDependencyNode == null) {
          continue;
        }

        String invalidType;
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
            message: "React Hook ${getSource(reactiveHook)} has $invalidType"
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

        if (isAConstantValue(declaredDependencyNode)) {
          reportProblem(
            node: declaredDependencyNode,
            message: "The '${declaredDependencyNode.toSource()}' constant expression is not a valid dependency "
                "because it never changes. ",
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
        } catch (error) {
          if (error.toString().contains('Unsupported node type')) {
            // FIXME figure out what was actually going on here with .raw/.value
            // if (declaredDependencyNode.type == 'Literal') {
            //   if (dependencies.containsKey(declaredDependencyNode.value)) {
            //     reportProblem(
            //       node: declaredDependencyNode,
            //       message:
            //         "The ${declaredDependencyNode.raw} literal is not a valid dependency "
            //         "because it never changes. "
            //         "Did you mean to include ${declaredDependencyNode.value} in the array instead?",
            //     );
            //   } else {
            //     reportProblem(
            //       node: declaredDependencyNode,
            //       message:
            //         "The ${declaredDependencyNode.raw} literal is not a valid dependency "
            //         'because it never changes. You can safely remove it.',
            //     );
            //   }
            // } else {
            reportProblem(
              node: declaredDependencyNode,
              message: "React Hook ${getSource(reactiveHook)} has a "
                  "complex expression in the dependency array. "
                  'Extract it to a separate variable so it can be statically checked.',
            );
            // }

            continue;
          } else {
            rethrow;
          }
        }

        // todo handle / warn about cascades?
        var maybeID = declaredDependencyNode;
        while (maybeID is PropertyAccess) {
          maybeID = (maybeID as PropertyAccess).target;
        }
        while (maybeID is PrefixedIdentifier) {
          maybeID = (maybeID as PrefixedIdentifier).prefix;
        }
        final isDeclaredInComponent =
            maybeID.tryCast<Identifier>()?.staticElement?.enclosingElement == componentFunctionElement;

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
        {
          'dependencies': dependencies,
          'declaredDependencies': declaredDependencies,
          'stableDependencies': stableDependencies,
          'externalDependencies': externalDependencies,
          'isEffect': isEffect,
        }.toString(),
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
      constructions.forEach(
        (_construction) {
          final construction = _construction.declaration;
          final constructionName = construction.declaredElement.name;

          final isUsedOutsideOfHook = _construction.isUsedOutsideOfHook;
          final depType = _construction.depType;
          final wrapperHook = depType == 'function' ? 'useCallback' : 'useMemo';

          final constructionType = depType == 'function' ? 'definition' : 'initialization';

          final defaultAdvice = "wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook.";

          final advice = isUsedOutsideOfHook
              ? "To fix this, $defaultAdvice"
              : "Move it inside the $reactiveHookName callback. Alternatively, $defaultAdvice";

          final causation = depType == 'conditional' || depType == 'logical expression' ? 'could make' : 'makes';

          // TODO implement
          LineInfo lineInfo;

          final message = "The '$constructionName' $depType $causation the dependencies of "
              "$reactiveHookName Hook (at line ${lineInfo?.getLocation(declaredDependenciesNode.offset)?.lineNumber}) "
              "change on every render. $advice";

          var suggest;
          // Only handle the simple case of variable assignments.
          // Wrapping function declarations can mess up hoisting.
          if (isUsedOutsideOfHook &&
              construction is VariableDeclaration &&
              // Objects may be mutated ater construction, which would make this
              // fix unsafe. Functions _probably_ won't be mutated, so we'll
              // allow this fix for them.
              depType == 'function') {
            // suggest = [
            //   {
            //     desc: "Wrap the $constructionType of '$constructionName' in its own $wrapperHook() Hook.",
            //     fix(fixer) {
            //       final parts =
            //         wrapperHook == 'useMemo'
            //           ? ["useMemo(() => { return ", '; })']
            //           : ['useCallback(', ')'];
            //       final before = parts[0];
            //       final after = parts[1];
            //       return [
            //         // TODO: also add an import?
            //         fixer.insertTextBefore(construction.node.init, before),
            //         // TODO: ideally we'd gather deps here but it would require
            //         // restructuring the rule code. This will cause a new lint
            //         // error to appear immediately for useCallback. Note we're
            //         // not adding [] because would that changes semantics.
            //         fixer.insertTextAfter(construction.node.init, after),
            //       ];
            //     },
            //   },
            // ];
          }
          // TODO: What if the function needs to change on every render anyway?
          // Should we suggest removing effect deps as an appropriate fix too?
          reportProblem(
            // TODO: Why not report this at the dependency site?
            node: construction,
            message: message,
            // suggest: suggest,
          );
        },
      );
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

    String getWarningMessage(Iterable<String> deps, String singlePrefix, String label, String fixVerb) {
      if (deps.isEmpty) {
        return null;
      }
      return (deps.length > 1 ? '' : singlePrefix + ' ') +
          label +
          ' ' +
          (deps.length > 1 ? 'dependencies' : 'dependency') +
          ': ' +
          joinEnglish((deps.toList()..sort()).map((name) => "'" + formatDependency(name) + "'").toList()) +
          ". Either $fixVerb ${deps.length > 1 ? 'them' : 'it'} or remove the dependency array.";
    }

    String extraWarning;
    if (unnecessaryDependencies.isNotEmpty) {
      final badRef = unnecessaryDependencies.firstWhere((key) => key.endsWith('.current'), orElse: () => null);
      if (badRef != null) {
        extraWarning = " Mutable values like '$badRef' aren't valid dependencies "
            "because mutating them doesn't re-render the component.";
      } else if (externalDependencies.isNotEmpty) {
        // FIXME store actual reference to dep instead of just string representation
        // final dep = externalDependencies.first;
        // // Don't show this warning for things that likely just got moved *inside* the callback
        // // because in that case they're clearly not referring to globals.
        // if (!scope.set.contains(dep)) {
        //   extraWarning =
        //     " Outer scope values like '$dep' aren't valid dependencies "
        //     "because mutating them doesn't re-render the component.";
        // }
      }
    }

    // "props.foo()" marks "props" as a dependency because it has
    // a "this" value. This warning can be confusing.
    // So if we're going to show it, append a clarification.
    if (extraWarning == null && missingDependencies.contains('props')) {
      final propDep = dependencies['props'];
      if (propDep == null) {
        return;
      }
      final refs = propDep.references;
      if (refs == null) {
        return;
      }
      var isPropsOnlyUsedInMembers = true;
      for (final ref in refs) {
        if (ref == null) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
        final parent = ref.parent;
        if (parent == null) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
        if (!(parent is PropertyAccess && parent.target == ref) &&
            !(parent is MethodInvocation && parent.target == ref)) {
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
      String missingCallbackDep;
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
      _SetStateRecommendation setStateRecommendation;
      missingDependencies.forEach((missingDep) {
        if (setStateRecommendation != null) {
          return;
        }
        final usedDep = dependencies[missingDep];
        final references = usedDep.references;
        Identifier id;
        AstNode maybeCall;
        for (var i = 0; i < references.length; i++) {
          id = references[i];
          maybeCall = id.parent;
          // Try to see if we have setState(someExpr(missingDep)).
          while (maybeCall != null && maybeCall != componentFunction.body) {
            if (maybeCall is InvocationExpression) {
              final maybeCallFunction = maybeCall.function;
              final maybeCallFunctionName = maybeCallFunction.tryCast<MethodInvocation>()?.methodName?.name ??
                  maybeCallFunction.tryCast<Identifier>()?.name;
              final correspondingStateVariable = setStateCallSites.get(
                maybeCallFunction.tryCast(),
              );
              if (correspondingStateVariable != null) {
                if (correspondingStateVariable.name.name == missingDep) {
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
                  final def = references[i].staticElement;
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
            maybeCall = maybeCall.parent;
          }
          if (setStateRecommendation != null) {
            break;
          }
        }
      });
      if (setStateRecommendation != null) {
        switch (setStateRecommendation.form) {
          case _SetStateRecommendationForm.reducer:
            extraWarning = " You can also replace multiple useState variables with useReducer "
                "if '${setStateRecommendation.setter}' needs the "
                "current value of '${setStateRecommendation.missingDep}'.";
            break;
          case _SetStateRecommendationForm.inlineReducer:
            extraWarning = " If '${setStateRecommendation.setter}' needs the "
                "current value of '${setStateRecommendation.missingDep}', "
                "you can also switch to useReducer instead of useState and "
                "read '${setStateRecommendation.missingDep}' in the reducer.";
            break;
          case _SetStateRecommendationForm.updater:
            extraWarning =
                " You can also do a functional update '${setStateRecommendation.setter}(${setStateRecommendation.missingDep.substring(
              0,
              1,
            )} => ...)' if you only need '${setStateRecommendation.missingDep}'"
                " in the '${setStateRecommendation.setter}' call.";
            break;
        }
      }
    }

    reportProblem(
      node: declaredDependenciesNode,
      message: "React Hook ${getSource(reactiveHook)} has " +
          // To avoid a long message, show the next actionable item.
          (getWarningMessage(missingDependencies, 'a', 'missing', 'include') ??
              getWarningMessage(
                unnecessaryDependencies,
                'an',
                'unnecessary',
                'exclude',
              ) ??
              getWarningMessage(
                duplicateDependencies,
                'a',
                'duplicate',
                'omit',
              ) ??
              '<unexpected case when building warning message>') +
          (extraWarning ?? ''),
      // suggest: [
      //   {
      //     desc: "Update the dependencies array to be: [${suggestedDeps
      //       .map(formatDependency)
      //       .join(', ')}]",
      //     fix(fixer) {
      //       // TODO: consider preserving the comments or formatting?
      //       return fixer.replaceText(
      //         declaredDependenciesNode,
      //         "[${suggestedDeps.map(formatDependency).join(', ')}]",
      //       );
      //     },
      //   },
      // ],
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
              "only one argument. Did you forget to pass an array of "
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
      switch (null) {
        case null:
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
          break; // Unhandled
      }
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
    // todo fix this name logic
    final callbackName = callback.tryCast<Identifier>()?.name;
    reportProblem(
      node: reactiveHook,
      message: "React Hook $reactiveHookName has a missing dependency: '$callbackName'. "
          "Either include it or remove the dependency array.",
      // suggest: [
      //   {
      //     desc: "Update the dependencies array to be: [$callbackName]",
      //     fix(fixer) {
      //       return fixer.replaceText(
      //         declaredDependenciesNode,
      //         "[$callbackName]",
      //       );
      //     },
      //   },
      // ],
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

  _SetStateRecommendation({this.missingDep, this.setter, this.form});
}

extension on AstNode {
  T parentOfType<T extends AstNode>() {
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
    this.suggestedDependencies,
    this.unnecessaryDependencies,
    this.missingDependencies,
    this.duplicateDependencies,
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

  _DepTree({this.isUsed, this.isSatisfiedRecursively, this.isSubtreeUsed, this.children});
}

class _DeclaredDependency {
  final String key;
  final Expression node;

  final Element debugEnclosingElement;

  _DeclaredDependency(this.key, this.node, {this.debugEnclosingElement});

  @override
  String toString() => {
        'key': key,
        'node': node,
        'debugEnclosingElement': elementDebugString(debugEnclosingElement),
      }.toString();
}

String elementDebugString(Element e) => '${e.runtimeType}<${e.id}, ${e.getDisplayString(withNullability: false)}>';

// The meat of the logic.
_Recommendations collectRecommendations({
  @required Map<String, _Dependency> dependencies,
  @required List<_DeclaredDependency> declaredDependencies,
  @required Iterable<String> stableDependencies,
  @required Set<String> externalDependencies,
  @required bool isEffect,
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
String getConstructionExpressionType(Expression node) {
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
  } else if (node is InvocationExpression && node.staticType.isReactElement) {
    return 'ReactElement';
  } else {
    return null;
  }
  // todo what about function calls...?
}

// Finds variables declared as dependencies
// that would invalidate on every render.
List<_Construction> scanForConstructions({
  @required Iterable<_DeclaredDependency> declaredDependencies,
  @required AstNode declaredDependenciesNode,
}) {
  final constructions = declaredDependencies.map<Tuple2<Declaration, String>>((dep) {
    // FIXME this should be equivalent, but need to figure out how chained properties work... I'm not sure how that would work with analyzePropertyChain being used with the existing code to look up identifiers
    // final ref = componentScope.variables.firstWhere((v) => v.name == key, orElse: () => null);
    final refElement = dep.node?.tryCast<Identifier>()?.staticElement;
    if (refElement == null) return null;

    final declaration = lookUpDeclaration(refElement, dep.node.root);
    if (declaration == null) {
      return null;
    }
    // final handleChange = () {};
    // final foo = {};
    // final foo = [];
    // etc.
    if (declaration is VariableDeclaration) {
      // Const variables never change
      if (declaration.isConst) return null;
      if (declaration.initializer != null) {
        // todo should this be stricter in Dart?
        final constantExpressionType = getConstructionExpressionType(
          declaration.initializer,
        );
        if (constantExpressionType != null) {
          return Tuple2(declaration, constantExpressionType);
        }
      }
      return null;
    }
    // handleChange() {}
    if (declaration is FunctionDeclaration) {
      return Tuple2(declaration, _DepType.function);
    }

    return null;
  }).whereNotNull();

  bool isUsedOutsideOfHook(Declaration declaration) {
    for (final reference in findReferences(declaration.declaredElement, declaration.root)) {
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
    final declaration = tuple.first;
    final depType = tuple.second;
    return _Construction(
      declaration: declaration,
      depType: depType,
      isUsedOutsideOfHook: isUsedOutsideOfHook(declaration),
    );
  }).toList();
}

class Tuple2<T1, T2> {
  final T1 first;
  final T2 second;

  const Tuple2(this.first, this.second);
}

class _Construction {
  final Declaration declaration;
  final String depType;
  final bool isUsedOutsideOfHook;

  _Construction({this.declaration, this.depType, this.isUsedOutsideOfHook});
}

abstract class _DepType {
  static const classDep = 'class';
  static const function = 'function';
}

// fixme Greg this doc comment has to be incorrect for some cases, right?
/// Assuming () means the passed/returned node:
/// (props) => (props)
/// props.(foo) => (props.foo)
/// props.foo.(bar) => (props).foo.bar
/// props.foo.bar.(baz) => (props).foo.bar.baz
AstNode getDependency(AstNode node) {
  final parent = node.parent;
  final grandparent = parent.parent;

  if (parent is PropertyAccess &&
      parent.target == node &&
      parent.propertyName.name != 'current' &&
      !(grandparent is InvocationExpression &&
          // fixme is this right?
          grandparent.function == parent)) {
    return getDependency(parent);
  }
  if (parent is PrefixedIdentifier &&
      parent.prefix == node &&
      parent.identifier.name != 'current' &&
      !(grandparent is InvocationExpression &&
          // fixme is this right?
          grandparent.function == parent)) {
    return getDependency(parent);
  }

  if (node is PropertyAccess && parent is AssignmentExpression && parent.leftHandSide == node) {
    return node.target;
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
void markNode(AstNode node, Map<String, bool> optionalChains, String result, {@required bool isOptional}) {
  if (optionalChains != null && isOptional == null) {
    throw ArgumentError('isOptional must be specified when optionalChains is');
  }

  if (optionalChains != null) {
    if (isOptional) {
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
String analyzePropertyChain(AstNode node, Map<String, bool> optionalChains) {
  if (node is SimpleIdentifier) {
    final result = node.name;
    if (optionalChains != null) {
      // Mark as required.
      optionalChains[result] = false;
    }
    return result;
  } else if (node is PropertyAccess) {
    final object = analyzePropertyChain(node.target, optionalChains);
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
  } else {
    throw ArgumentError("Unsupported node type: ${node.runtimeType}");
  }
}

// todo unit test this and remove extraneous cases
AstNode getNodeWithoutReactNamespace(Expression node) {
  if (node is PrefixedIdentifier) {
    if (node.prefix.staticElement is LibraryElement) {}
  } else if (node is PropertyAccess) {
    if (node.realTarget?.tryCast<Identifier>()?.staticElement is LibraryElement) {
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
int getReactiveHookCallbackIndex(Expression calleeNode, {RegExp additionalHooks}) {
  final node = getNodeWithoutReactNamespace(calleeNode);
  if (node is! Identifier) {
    return -1;
  }
  switch ((node as Identifier).name) {
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
      if (node == calleeNode && additionalHooks != null) {
        // Allow the user to provide a regular expression which enables the lint to
        // target custom reactive hooks.
        String name;
        try {
          name = analyzePropertyChain(node, null);
        } on Object catch (error) {
          if (error.toString().contains('Unsupported node type')) {
            return 0;
          } else {
            rethrow;
          }
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

extension<E extends Comparable> on Iterable<E> {
  /// Whether the elements in this collection are already sorted.
  bool get isSorted {
    var isFirst = true;
    E prev;
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

SimpleIdentifier propertyNameFromNonCascadedAccess(Expression node) {
  if (node is PrefixedIdentifier) {
    return node.identifier;
  }
  if (node is PropertyAccess && !node.isCascaded) {
    return node.propertyName;
  }

  return null;
}

extension on AstNode {
  Iterable<AstNode> get ancestors sync* {
    final parent = this.parent;
    if (parent != null) {
      yield parent;
      yield* parent.ancestors;
    }
  }
}

extension on Element {
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
  E elementAtOrNull(int index) => index < length ? this[index] : null;
}
