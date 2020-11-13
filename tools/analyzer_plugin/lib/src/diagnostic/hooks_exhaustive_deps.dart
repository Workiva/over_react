// Adapted from https://github.com/facebook/react/blob/master@%7B2020-10-16%7D/packages/eslint-plugin-react-hooks/src/ExhaustiveDeps.js

// Copyright (c) Facebook, Inc. and its affiliates.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.
//
import 'dart:collection';

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
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
// class HooksExhaustiveDeps extends DiagnosticContributor {
//   @DocsMeta('Verifies the list of dependencies for React Hooks like useEffect and similar', details: '')
//   static const code = DiagnosticCode(
//     'over_react_hooks_exhaustive_deps',
//     "{0}",
//     AnalysisErrorSeverity.ERROR,
//     AnalysisErrorType.STATIC_WARNING,
//     url: 'https://reactjs.org/docs/hooks-rules.html',
//   );
//
//   @override
//   Future<void> computeErrors(result, collector) async {}
// }
//
//



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
}


V Function(K) memoizeWithWeakMap<K, V>(V Function(K) fn, WeakMap<K, V> map) {
  return (arg) {
    if (map.has(arg)) {
      // to verify cache hits:
      // console.log(arg.name)
      return map.get(arg);
    }
    final result = fn(arg);
    map.set(arg, result);
    return result;
  };
}


// Rough port of https://eslint.org/docs/developer-guide/scope-manager-interface
// https://github.com/eslint/eslint-scope
// Could use Dart  VariableResolverVisitor or ScopedVisitor ?
class ScopeManager {
  List<Scope> get scopes => null;

  Scope acquire(FunctionBody node) {}
}



// Rough port of https://eslint.org/docs/developer-guide/scope-manager-interface#scope-interface
class Scope {
  // The parent scope. If this is the global scope then this property is null.
  Scope get upper => null;

  /// The type of this scope.
  ///
  /// This is one of "block", "catch", "class", "for", "function", "function-expression-name", "global", "module", "switch", "with"
  ScopeType get type => null;

  /// The array of all references on this scope. This does not include references in child scopes.
  List<Reference> get references => null;

  // The array of child scopes. This does not include grandchild scopes.
  List<Scope> get childScopes => null;

  /// The AST node which created this scope.
  Block get block => null;

  /// The array of references which could not be resolved in this scope.
  List<Reference> get through => null;

  // The array of all variables which are defined on this scope. This does not include variables which are defined in child scopes.
  List<Variable> get variables => null;
}


class LazyScopeImpl implements Scope {
  static final globalScope = LazyScopeImpl(null, ScopeType.global);

  @override
  final ScopeType type;

  @override
  final Block block;

  @override
  Scope get upper {
    if (type == ScopeType.global) return null;

    final ancestorBlock = block.parent?.thisOrAncestorOfType<Block>();
    return ancestorBlock != null ? LazyScopeImpl.detect(ancestorBlock) : globalScope;
  }

  void _visit() {
    final visitor = _ScopeVisitor();
    block.visitChildren(visitor);
    _childScopes = visitor.childScopes.map((block) => LazyScopeImpl.detect(block)).toList();
    _variables = visitor.variables;
    _references = visitor.references;
    _through = visitor.through;
  }

  List<Scope> _childScopes;
  @override
  List<Scope> get childScopes {
    if (_childScopes == null) _visit();
    return _childScopes;
  }


  List<Reference> _references;
  @override
  List<Reference> get references {
    if (_references == null) _visit();
    return _references;
  }

  List<Reference> _through;
  @override
  List<Reference> get through {
    if (_through == null) _visit();
    return _through;
  }

  LazyScopeImpl(this.block, this.type);
  LazyScopeImpl.detect(this.block) : type = detectType(block);

  static ScopeType detectType(Block block) {
    ArgumentError.checkNotNull(block, 'block');

    if (block.parent is BlockFunctionBody) {
      return ScopeType.function;
    }
    return ScopeType.block;
  }
}

class _ScopeVisitor extends RecursiveAstVisitor<void> {
  final childScopes = <Block>[];
  final references = <Identifier>[];

  @override
  void visitBlock(Block node) {
    childScopes.add(node);
    // Don't recurse into scopes by calling super
  }


  // idenfier / references

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    final parent = node.parent;
    if (parent is MethodInvocation && parent.methodName == node) return;
    if (parent is NamedExpression && parent.name.label == node) return;
    if (parent is FormalParameter && parent.identifier == node) return;
    if (parent is Label && parent.label == node) return;
    if (parent is ContinueStatement || parent is BreakStatement) return;
    if (parent is PropertyAccess && parent.propertyName == node) return;

    // variables declared in other ways
    // error / stack trace vars
    if (parent is VariableDeclaration && parent.name == node) return;
    if (parent is CatchClause) return;
    // for-in variable
    if (parent is DeclaredIdentifier) return;
    if (parent is FunctionDeclaration) return;

    references.add(node);
  }


  @override
  void visitConstructorName(ConstructorName node) {}
  @override
  void visitTypeParameter(TypeParameter node) {}

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    references.add(node.prefix);
  }
}

enum ScopeType {
  global,
  function,
  block,
}



// Rough port of https://eslint.org/docs/developer-guide/scope-manager-interface#reference-interface
class Reference {
  // The Identifier node of this reference.
  Identifier identifier;

  /// The Scope object that this reference is on.
  Scope from;

  Variable resolved;

  /// The ASTNode object which is right-hand side.
  Expression writeExpr;
}

class Variable {
  /// The name of this variable.
  String name;

  /// The array of Identifier nodes which define this variable. If this variable is redeclared, this array includes two or more nodes.
  Identifier identifier;

  /// The array of the references of this variable.
  List<Reference> references;
}


extension on Element {
  Scope get scope => null;
}


class _Dependency {
  final bool isStable;
  final List<Reference> references;

  _Dependency({this.isStable = false, this.references = const []});
}

class _RefInEffectCleanup {
  final Reference reference;
  final Identifier dependencyNode;

  _RefInEffectCleanup({this.reference, this.dependencyNode});
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
  if (element is ExecutableElement) return null;

  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is Identifier && node.staticElement == element) {
    final parent = node.parent;
    return parent.tryCast<FunctionDeclaration>()?.functionExpression
        ?? parent.tryCast<VariableDeclaration>()?.initializer?.tryCast<FunctionExpression>();
  }

  return null;
}

Declaration lookUpDeclaration(Element element, AstNode root) {
  // if (element is ExecutableElement) return null;
   final node = NodeLocator2(element.nameOffset).searchWithin(root);
   final declaration = node?.thisOrAncestorOfType<Declaration>();
   if (declaration.declaredElement == element) {
     return declaration;
   }

   return null;
}

bool isConstExpression(Expression expression) =>
    expression.accept(ConstantEvaluator()) != ConstantEvaluator.NOT_A_CONSTANT;



/// What thihs does
///
///

create(context, {RegExp additionalHooks}) {
  AstNode rootNode;
  void reportProblem({AstNode node, String message}) {}

  final ScopeManager scopeManager = null;

  // Should be shared between visitors.
  final setStateCallSites = WeakMap();
  final stateVariables = WeakSet();
  final stableKnownValueCache = WeakMap<Element, bool>();
  final functionWithoutCapturedValueCache = WeakMap<Element, bool>();
  // Visitor for both function expressions and arrow function expressions.
  void visitFunctionWithDependencies({
    @required FunctionBody node,
    @required AstNode declaredDependenciesNode,
    @required AstNode reactiveHook,
    @required String reactiveHookName,
    @required bool isEffect,
  }) {
    if (isEffect && node.isAsynchronous) {
      reportProblem(
        node: node,
        message:
          "Effect callbacks are synchronous to prevent race conditions. "
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

    // Get the current scope.
    final scope = scopeManager.acquire(node);

    // Find all our "pure scopes". On every re-render of a component these
    // pure scopes may have changes to the variables declared within. So all
    // variables used in our reactive hook callback but declared in a pure
    // scope need to be listed as dependencies of our reactive hook callback.
    //
    // According to the rules of React you can't read a mutable value in pure
    // scope. We can't enforce this in a lint so we trust that all variables
    // declared outside of pure scope are indeed frozen.
    final pureScopes = <Scope>{};
    Scope componentScope;
    {
      var currentScope = scope.upper;
      while (currentScope != null) {
        pureScopes.add(currentScope);
        if (currentScope.type == ScopeType.function) {
          break;
        }
        currentScope = currentScope.upper;
      }
      // If there is no parent function scope then there are no pure scopes.
      // The ones we've collected so far are incorrect. So don't continue with
      // the lint.
      if (currentScope == null) {
        return;
      }
      componentScope = currentScope;
    }

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
    bool isStableKnownHookValue(Element resolved) { // fixme need to pass in reference to expression and not hhook itself? (`count.value` vs just ount)
      // fixme switch to AST
      // final init = resolved.tryCast<VariableElement>()?.initializer;
      VariableDeclaration declaration;
      var init = declaration.initializer;
      if (init == null) {
        return false;
      }
      while (init is AsExpression) {
        init = (init as AsExpression).expression;
      }
      // Detect primitive constants
      // const foo = 42

      // Note: in the JS version of this plugin, there was:
      // > This might happen if variable is declared after the callback.
      // but that isn't possible in Dart, so we can omit that logic.

      if (declaration.isConst || (declaration.isFinal && !declaration.isLate && isConstExpression(init))) {
        // Definitely stable
        return true;
      }
      // Detect known Hook calls
      // const [_, setState] = useState()
      if (init is! InvocationExpression) {
        return false;
      }
      // todo handle tearoffs of hooks nodes // final setCount = useCount(1).set;
      var callee = (init as InvocationExpression).function;
      // fixme handle namespaced imports
      if (callee is! Identifier) {
        return false;
      }
      final name = (callee as Identifier).name;
      if (name == 'useRef') {
        // useRef() return value is stable.
        return true;
      } else if (name == 'useState' || name == 'useReducer') {
        // FIXME special case, probably at call-site when they pass in the whole hook object
        // Only consider second value in initializing tuple stable.
        if (
          id.type == 'ArrayPattern' &&
          id.elements.length == 2 &&
          Array.isArray(resolved.identifiers)
        ) {
          // Is second tuple value the same reference we're checking?
          if (id.elements[1] == resolved.identifiers[0]) {
            if (name == 'useState') {
              final references = resolved.references;
              for (var i = 0; i < references.length; i++) {
                setStateCallSites.set(
                  references[i].identifier,
                  id.elements[0],
                );
              }
            }
            // Setter is stable.
            return true;
          } else if (id.elements[0] == resolved.identifiers[0]) {
            if (name == 'useState') {
              final references = resolved.references;
              for (var i = 0; i < references.length; i++) {
                stateVariables.add(references[i].identifier);
              }
            }
            // State variable itself is dynamic.
            return false;
          }
        }
      } else if (name == 'useTransition') {
        if (
          id.type == 'ArrayPattern' &&
          Array.isArray(resolved.identifiers)
        ) {
          // Is first tuple value the same reference we're checking?
          if (id.elements[0] == resolved.identifiers[0]) {
            // Setter is stable.
            return true;
          }
        }
      }
      // By default assume it's dynamic.
      return false;
    }
    // Remember such values. Avoid re-running extra checks on them.
    final memoizedIsStableKnownHookValue = memoizeWithWeakMap(
      isStableKnownHookValue,
      stableKnownValueCache,
    );

    // Some are just functions that don't reference anything dynamic.
    bool isFunctionWithoutCapturedValues(Element resolved) {
      // fixme convert to AST, account for function variables
      final fnNode = lookUpFunction(resolved, rootNode);

      // Search the direct component subscopes for
      // top-level function definitions matching this reference.
      final childScopes = componentScope.childScopes;
      Scope fnScope;
      for (final childScope in childScopes) {
        final childScopeBlock = childScope.block;
        if (
          fnNode.body.tryCast<BlockFunctionBody>().block == childScopeBlock
          // function handleChange() {}
          // (fnNode.type == 'FunctionDeclaration' &&
          //   childScopeBlock == fnNode) ||
          // // const handleChange = () => {}
          // // const handleChange = function() {}
          // (fnNode.type == 'VariableDeclarator' &&
          //   childScopeBlock.parent == fnNode)
        ) {
          // Found it!
          fnScope = childScope;
          break;
        }
      }
      if (fnScope == null) {
        return false;
      }
      // Does this function capture any values
      // that are in pure scopes (aka render)?
      for (final ref in fnScope.through) {
        if (ref.resolved == null) {
          continue;
        }
        if (
          pureScopes.contains(ref.resolved.scope) &&
          // Stable values are fine though,
          // although we won't check functions deeper.
          !memoizedIsStableKnownHookValue(ref.resolved)
        ) {
          return false;
        }
      }
      // If we got here, this function doesn't capture anything
      // from render--or everything it captures is known stable.
      return true;
    }
    final memoizedIsFunctionWithoutCapturedValues = memoizeWithWeakMap(
      isFunctionWithoutCapturedValues,
      functionWithoutCapturedValueCache,
    );

    // These are usually mistaken. Collect them.
    final currentRefsInEffectCleanup = <String, _RefInEffectCleanup>{};

    // Is this reference inside a cleanup function for this effect node?
    // We can check by traversing scopes upwards  from the reference, and checking
    // if the last "return () => " we encounter is located directly inside the effect.
    bool isInsideEffectCleanup(Reference reference) {
      var curScope = reference.from;
      var isInReturnedFunction = false;
      while (curScope.block != node.tryCast<BlockFunctionBody>().block) {
        if (curScope.type == ScopeType.function) {
          isInReturnedFunction = curScope.block
              ?.parentOfType<FunctionBody>()
              ?.parentOfType<FunctionExpression>()
              ?.parentOfType<ReturnStatement>() != null;
        }
        curScope = curScope.upper;
      }
      return isInReturnedFunction;
    }

    // Get dependencies from all our resolved references in pure scopes.
    // Key is dependency string, value is whether it's stable.
    final dependencies = <String, _Dependency>{};
    final optionalChains = {};

    void gatherDependenciesRecursively(Scope currentScope) {
      for (final reference in currentScope.references) {
        // If this reference is not resolved or it is not declared in a pure
        // scope then we don't care about this reference.
        if (reference.resolved == null) {
          continue;
        }
        if (!pureScopes.contains(reference.resolved.scope)) {
          continue;
        }

        // Narrow the scope of a dependency if it is, say, a member expression.
        // Then normalize the narrowed dependency.
        final referenceNode = fastFindReferenceWithParent(
          node,
          reference.identifier,
        );
        final dependencyNode = getDependency(referenceNode);
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
          isInsideEffectCleanup(reference)
        ) {
          currentRefsInEffectCleanup[dependency] = _RefInEffectCleanup(
            reference: reference,
            dependencyNode: dependencyNode,
          );
        }

        //todo what are these cases?
        // if (
        //   dependencyNode.parent.type == 'TSTypeQuery' ||
        //   dependencyNode.parent.type == 'TSTypeReference'
        // ) {
        //   continue;
        // }

        final def = lookUpDeclaration(reference.resolved, rootNode);
        if (def == null) {
          continue;
        }
        // Ignore references to the function itself as it's not defined yet.
        if (def.tryCast<FunctionDeclaration>()?.functionExpression?.body == node.parent) {
          continue;
        }

        // Add the dependency to a map so we can make sure it is referenced
        // again in our dependencies array. Remember whether it's stable.
        if (!dependencies.containsKey(dependency)) {
          final resolved = reference.resolved;
          final isStable =
            memoizedIsStableKnownHookValue(resolved) ||
            memoizedIsFunctionWithoutCapturedValues(resolved);
          dependencies[dependency] = _Dependency(
            isStable: isStable,
            references: [reference],
          );
        } else {
          dependencies[dependency].references.add(reference);
        }
      }

      for (final childScope in currentScope.childScopes) {
        gatherDependenciesRecursively(childScope);
      }
    }
    gatherDependenciesRecursively(scope);

    // Warn about accessing .current in cleanup effects.
    currentRefsInEffectCleanup.forEach(
      (dependency, _entry) {
        final reference = _entry.reference;
        final dependencyNode = _entry.dependencyNode;

        // Is React managing this ref or us?
        // Let's see if we can find a .current assignment.
        var foundCurrentAssignment = false;
        for (final reference in reference.resolved.references) {
          final identifier = reference.identifier;
          final parent = identifier.parent;
          if (
            // ref.current
            parent?.tryCast<PropertyAccess>()?.propertyName?.name == 'current' &&
            // ref.current = <something>
            parent.parent?.tryCast<AssignmentExpression>()?.leftHandSide == parent
          ) {
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
          message:
            "The ref value '$dependency.current' will likely have "
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
        message:
          "Assignments to the '$key' variable from inside React Hook "
          "${context.getSource(reactiveHook)} will be lost after each "
          "render. To preserve the value over time, store it in a useRef "
          "Hook and keep the mutable value in the '.current' property. "
          "Otherwise, you can move this variable directly inside "
          "${context.getSource(reactiveHook)}.",
      );
    }

    // Remember which deps are stable and report bad usage first.
    final stableDependencies = <String>{};
    dependencies.forEach((key, dep) {
      if (dep.isStable) {
        stableDependencies.add(key);
      }
      for (final reference in dep.references) {
        if (reference.writeExpr != null) {
          reportStaleAssignment(reference.writeExpr, key);
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
        final isStable = _entry.isStable;
        final references = _entry.references;
        if (setStateInsideEffectWithoutDeps != null) {
          return;
        }
        references.forEach((reference) {
          if (setStateInsideEffectWithoutDeps != null) {
            return;
          }

          final id = reference.identifier;
          final isSetState = setStateCallSites.has(id);
          if (!isSetState) {
            return;
          }

          var fnScope = reference.from;
          while (fnScope.type != ScopeType.function) {
            fnScope = fnScope.upper;
          }
          final isDirectlyInsideEffect = fnScope.block.parentOfType<FunctionBody>() == node;
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
          message:
            "React Hook $reactiveHookName contains a call to '$setStateInsideEffectWithoutDeps'. "
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
        message:
          "React Hook ${context.getSource(reactiveHook)} was passed a "
          'dependency list that is not a list literal. This means we '
          "can't statically verify whether you've passed the correct "
          'dependencies.',
      );
    } else {
      for (final declaredDependencyNode in (declaredDependenciesNode as ListLiteral).elements) {
        // Skip elided elements.
        if (declaredDependencyNode == null) {
          continue;
        }

        String invalidType;
        if (declaredDependencyNode is SpreadElement) {
          invalidType = 'a spread element';
        } else if (declaredDependenciesNode is IfElement) {
          invalidType = "an 'if' element";
        } else if (declaredDependenciesNode is ForElement) {
          invalidType = "a 'for' element";
        }
        if (invalidType != null) {
          reportProblem(
            node: declaredDependencyNode,
            message:
              "React Hook ${context.getSource(reactiveHook)} has $invalidType"
              "in its dependency list. This means we can't "
              "statically verify whether you've passed the "
              'correct dependencies.',
          );
          continue;
        }


        // FIXNE check here or somewhere else to ensure whole hook (state, ref?) isn't passed in, provide quick fix

        // TODO add isConstExpression check

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
            if (declaredDependencyNode.type == 'Literal') {
              if (dependencies.containsKey(declaredDependencyNode.value)) {
                reportProblem(
                  node: declaredDependencyNode,
                  message:
                    "The ${declaredDependencyNode.raw} literal is not a valid dependency "
                    "because it never changes. "
                    "Did you mean to include ${declaredDependencyNode.value} in the array instead?",
                );
              } else {
                reportProblem(
                  node: declaredDependencyNode,
                  message:
                    "The ${declaredDependencyNode.raw} literal is not a valid dependency "
                    'because it never changes. You can safely remove it.',
                );
              }
            } else {
              reportProblem(
                node: declaredDependencyNode,
                message:
                  "React Hook ${context.getSource(reactiveHook)} has a "
                  "complex expression in the dependency array. "
                  'Extract it to a separate variable so it can be statically checked.',
              );
            }

            continue;
          } else {
            rethrow;
          }
        }

        var maybeID = declaredDependencyNode;
        while (
          maybeID.type == 'MemberExpression' ||
          maybeID.type == 'OptionalMemberExpression' ||
          maybeID.type == 'ChainExpression'
        ) {
          maybeID = maybeID.object || maybeID.expression.object;
        }
        final isDeclaredInComponent = !componentScope.through.any(
          (ref) => ref.identifier == maybeID,
        );

        // Add the dependency to our declared dependency map.
        declaredDependencies.push({
          key: declaredDependency,
          node: declaredDependencyNode,
        });

        if (!isDeclaredInComponent) {
          externalDependencies.add(declaredDependency);
        }
      }
    }

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

    final problemCount =
      duplicateDependencies.length +
      missingDependencies.length +
      unnecessaryDependencies.length;

    if (problemCount == 0) {
      // If nothing else to report, check if some dependencies would
      // invalidate on every render.
      final constructions = scanForConstructions(
        declaredDependencies: declaredDependencies,
        declaredDependenciesNode: declaredDependenciesNode,
        componentScope: componentScope,
        scope: scope,
      );
      constructions.forEach(
        (_construction) {
          final construction = _construction.construction;
          final isUsedOutsideOfHook = _construction.isUsedOutsideOfHook;
          final depType = _construction.depType;
          final wrapperHook =
            depType == 'function' ? 'useCallback' : 'useMemo';

          final constructionType =
            depType == 'function' ? 'definition' : 'initialization';

          final defaultAdvice = "wrap the $constructionType of '${construction.name.name}' in its own $wrapperHook() Hook.";

          final advice = isUsedOutsideOfHook
            ? "To fix this, $defaultAdvice"
            : "Move it inside the $reactiveHookName callback. Alternatively, $defaultAdvice";

          final causation =
            depType == 'conditional' || depType == 'logical expression'
              ? 'could make'
              : 'makes';

          final message =
            "The '${construction.name.name}' $depType $causation the dependencies of "
            "$reactiveHookName Hook (at line ${declaredDependenciesNode.loc.start.line}) "
            "change on every render. $advice";

          var suggest;
          // Only handle the simple case of variable assignments.
          // Wrapping function declarations can mess up hoisting.
          if (
            isUsedOutsideOfHook &&
            construction.type == 'Variable' &&
            // Objects may be mutated ater construction, which would make this
            // fix unsafe. Functions _probably_ won't be mutated, so we'll
            // allow this fix for them.
            depType == 'function'
          ) {
            // suggest = [
            //   {
            //     desc: "Wrap the $constructionType of '${construction.name.name}' in its own $wrapperHook() Hook.",
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
            node: construction.node,
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
        declaredDependencies: [], // Pretend we don't know
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
      return
        (deps.length > 1 ? '' : singlePrefix + ' ') +
        label +
        ' ' +
        (deps.length > 1 ? 'dependencies' : 'dependency') +
        ': ' +
        joinEnglish(
          (deps.toList()..sort())
            .map((name) => "'" + formatDependency(name) + "'").toList()) +
        ". Either $fixVerb ${
          deps.length > 1 ? 'them' : 'it'
        } or remove the dependency array."
      ;
    }

    String extraWarning;
    if (unnecessaryDependencies.isNotEmpty) {
      final badRef = unnecessaryDependencies.firstWhere((key) => key.endsWith('.current'), orElse: () => null);
      if (badRef != null) {
        extraWarning =
          " Mutable values like '$badRef' aren't valid dependencies "
          "because mutating them doesn't re-render the component.";
      } else if (externalDependencies.isNotEmpty) {
        final dep = externalDependencies.first;
        // Don't show this warning for things that likely just got moved *inside* the callback
        // because in that case they're clearly not referring to globals.
        if (!scope.set.contains(dep)) {
          extraWarning =
            " Outer scope values like '$dep' aren't valid dependencies "
            "because mutating them doesn't re-render the component.";
        }
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
        final id = fastFindReferenceWithParent(
          componentScope.block,
          ref.identifier,
        );
        if (id == null) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
        final parent = id.parent;
        if (parent == null) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
        if (
          parent.type != 'MemberExpression' &&
          parent.type != 'OptionalMemberExpression'
        ) {
          isPropsOnlyUsedInMembers = false;
          break;
        }
      }
      if (isPropsOnlyUsedInMembers) {
        extraWarning =
          " However, 'props' will change when *any* prop changes, so the "
          "preferred fix is to destructure the 'props' object outside of "
          "the $reactiveHookName call and refer to those specific props "
          "inside ${context.getSource(reactiveHook)}.";
      }
    }

    if (extraWarning == null && missingDependencies.isNotEmpty) {
      // See if the user is trying to avoid specifying a callable prop.
      // This usually means they're unaware of useCallback.
      String missingCallbackDep;
      // ignore_for_file: avoid_function_literals_in_foreach_calls
      missingDependencies.forEach((missingDep) {
        if (missingCallbackDep != null) {
          return;
        }
        // Is this a variable from top scope?
        final topScopeRef = componentScope.set.get(missingDep);
        final usedDep = dependencies.get(missingDep);
        if (usedDep.references[0].resolved != topScopeRef) {
          return;
        }
        // Is this a destructured prop?
        final def = topScopeRef.defs[0];
        if (def == null || def.name == null || def.type != 'Parameter') {
          return;
        }
        // Was it called in at least one case? Then it's a function.
        var isFunctionCall = false;
        var id;
        for (var i = 0; i < usedDep.references.length; i++) {
          id = usedDep.references[i].identifier;
          if (
            id != null &&
            id.parent != null &&
            (id.parent.type == 'CallExpression' ||
              id.parent.type == 'OptionalCallExpression') &&
            id.parent.callee == id
          ) {
            isFunctionCall = true;
            break;
          }
        }
        if (!isFunctionCall) {
          return;
        }
        // If it's missing (i.e. in component scope) *and* it's a parameter
        // then it is definitely coming from props destructuring.
        // (It could also be props itself but we wouldn't be calling it then.)
        missingCallbackDep = missingDep;
      });
      if (missingCallbackDep != null) {
        extraWarning =
          " If '$missingCallbackDep' changes too often, "
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
        final usedDep = dependencies.get(missingDep);
        final references = usedDep.references;
        var id;
        var maybeCall;
        for (var i = 0; i < references.length; i++) {
          id = references[i].identifier;
          maybeCall = id.parent;
          // Try to see if we have setState(someExpr(missingDep)).
          while (maybeCall != null && maybeCall != componentScope.block) {
            if (maybeCall is InvocationExpression) {
              final correspondingStateVariable = setStateCallSites.get(
                maybeCall.callee,
              );
              if (correspondingStateVariable != null) {
                if (correspondingStateVariable.name == missingDep) {
                  // setCount(count + 1)
                  setStateRecommendation = _SetStateRecommendation(
                    missingDep: missingDep,
                    setter: maybeCall.callee.name,
                    form: 'updater',
                  );
                } else if (stateVariables.has(id)) {
                  // setCount(count + increment)
                  setStateRecommendation = _SetStateRecommendation(
                    missingDep: missingDep,
                    setter: maybeCall.callee.name,
                    form: 'reducer',
                  );
                } else {
                  final resolved = references[i].resolved;
                  if (resolved != null) {
                    // If it's a parameter *and* a missing dep,
                    // it must be a prop or something inside a prop.
                    // Therefore, recommend an inline reducer.
                    final def = resolved.defs[0];
                    if (def != null && def.type == 'Parameter') {
                      setStateRecommendation = _SetStateRecommendation(
                        missingDep: missingDep,
                        setter: maybeCall.callee.name,
                        form: 'inlineReducer',
                      );
                    }
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
            extraWarning =
              " You can also replace multiple useState variables with useReducer "
              "if '${setStateRecommendation.setter}' needs the "
              "current value of '${setStateRecommendation.missingDep}'.";
            break;
          case _SetStateRecommendationForm.inlineReducer:
            extraWarning =
              " If '${setStateRecommendation.setter}' needs the "
              "current value of '${setStateRecommendation.missingDep}', "
              "you can also switch to useReducer instead of useState and "
              "read '${setStateRecommendation.missingDep}' in the reducer.";
            break;
          case _SetStateRecommendationForm.updater:
            extraWarning =
              " You can also do a functional update '${
                setStateRecommendation.setter
              }(${setStateRecommendation.missingDep.substring(
                0,
                1,
              )} => ...)' if you only need '${
                setStateRecommendation.missingDep
              }'" " in the '${setStateRecommendation.setter}' call.";
            break;
        }
      }
    }

    reportProblem(
      node: declaredDependenciesNode,
      message:
        "React Hook ${context.getSource(reactiveHook)} has " +
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
          )) +
        extraWarning,
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

  void visitCallExpression(InvocationExpression node) {
    final callbackIndex = getReactiveHookCallbackIndex(node.callee, options);
    if (callbackIndex == -1) {
      // Not a React Hook call that needs deps.
      return;
    }
    final callback = node.argumentList.arguments[callbackIndex];
    final reactiveHook = node.function;
    final reactiveHookName = getNodeWithoutReactNamespace(reactiveHook).name as String;
    final declaredDependenciesNode = node.argumentList.arguments[callbackIndex + 1];
    final isEffect = RegExp(r'Effect($|[^a-z])').hasMatch(reactiveHookName);

    // Check the declared dependencies for this reactive hook. If there is no
    // second argument then the reactive callback will re-run on every render.
    // So no need to check for dependency inclusion.
    if (declaredDependenciesNode == null && !isEffect) {
      // These are only used for optimization.
      if (
        reactiveHookName == 'useMemo' ||
        reactiveHookName == 'useCallback'
      ) {
        // TODO: Can this have a suggestion?
        reportProblem(
          node: reactiveHook,
          message:
            "React Hook $reactiveHookName does nothing when called with "
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
      switch(null) {
        case null:
        if (declaredDependenciesNode == null) {
          // No deps, no problems.
          return; // Handled
        }
        // The function passed as a callback is not written inline.
        // But perhaps it's in the dependencies array?
        if (
          declaredDependenciesNode is ListLiteral &&
          declaredDependenciesNode.elements.whereType<Identifier>().any(
            (el) => el.name == callback.name,
          )
        ) {
          // If it's already in the list of deps, we don't care because
          // this is valid regardless.
          return; // Handled
        }
        // We'll do our best effort to find it, complain otherwise.
        final variable = context.getScope().set.get(callback.name);
        if (variable == null || variable.defs == null) {
          // If it's not in scope, we don't care.
          return; // Handled
        }
        // The function passed as a callback is not written inline.
        // But it's defined somewhere in the render scope.
        // We'll do our best effort to find and check it, complain otherwise.
        final def = variable.defs[0];
        if (def == null || def.node == null) {
          break; // Unhandled
        }
        if (def.type != 'Variable' && def.type != 'FunctionName') {
          // Parameter or an unusual pattern. Bail out.
          break; // Unhandled
        }
        switch (def.node.type) {
          case 'FunctionDeclaration':
            // useEffect(() => { ... }, []);
            visitFunctionWithDependencies(
              def.node,
              declaredDependenciesNode,
              reactiveHook,
              reactiveHookName,
              isEffect,
            );
            return; // Handled
          case 'VariableDeclarator':
            final init = def.node.init;
            if (!init) {
              break; // Unhandled
            }
            switch (init.type) {
              // const effectBody = () => {...};
              // useEffect(effectBody, []);
              case 'ArrowFunctionExpression':
              case 'FunctionExpression':
                // We can inspect this function as if it were inline.
                visitFunctionWithDependencies(
                  init,
                  declaredDependenciesNode,
                  reactiveHook,
                  reactiveHookName,
                  isEffect,
                );
                return; // Handled
            }
            break; // Unhandled
        }
        break; // Unhandled
      }
    } else {
      // useEffect(generateEffectBody(), []);
      reportProblem(
        node: reactiveHook,
        message:
          "React Hook $reactiveHookName received a whose dependencies "
          "are unknown. Pass an inline instead.",
      );
      return; // Handled
    }

    // Something unusual. Fall back to suggesting to add the body itself as a dep.
    reportProblem(
      node: reactiveHook,
      message:
        "React Hook $reactiveHookName has a missing dependency: '${callback.name}'. "
        "Either include it or remove the dependency array.",
      // suggest: [
      //   {
      //     desc: "Update the dependencies array to be: [${callback.name}]",
      //     fix(fixer) {
      //       return fixer.replaceText(
      //         declaredDependenciesNode,
      //         "[${callback.name}]",
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
  updater ,
}

class _SetStateRecommendation {
  final String missingDep;
  final String setter;
  final String form;

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

  _Recommendations(
      {this.suggestedDependencies, this.unnecessaryDependencies, this.missingDependencies, this.duplicateDependencies,});
}

class _DepTree {
  /// True if used in code
  final bool isUsed;

  /// True if specified in deps
  final bool isSatisfiedRecursively;

  /// True if something deeper is used by code
  final bool isSubtreeUsed;

  // Nodes for properties
  final Map children;

  _DepTree({this.isUsed, this.isSatisfiedRecursively, this.isSubtreeUsed, this.children});
}

class _DeclaredDependency {
  final String key;
  final AstNode node;
}

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


  // Mark all required nodes first.
  // Imagine exclamation marks next to each used deep property.
  dependencies.forEach((_, key)  {
    final node = getOrCreateNodeByPath(depTree, key);
    node.isUsed = true;
    markAllParentsByPath(depTree, key, (parent) {
      parent.isSubtreeUsed = true;
    });
  });

  // Mark all satisfied nodes.
  // Imagine checkmarks next to each declared dependency.
  declaredDependencies.forEach((_entry) {
    final key = _entry;
    final node = getOrCreateNodeByPath(depTree, key);
    node.isSatisfiedRecursively = true;
  });
  stableDependencies.forEach((key) {
    final node = getOrCreateNodeByPath(depTree, key);
    node.isSatisfiedRecursively = true;
  });

  // Tree manipulation helpers.
  getOrCreateNodeByPath(rootNode, path) {
    final keys = path.split('.');
    var node = rootNode;
    for (final key in keys) {
      var child = node.children.get(key);
      if (child == null) {
        child = createDepTree();
        node.children.set(key, child);
      }
      node = child;
    }
    return node;
  }
  markAllParentsByPath(rootNode, path, fn) {
    final keys = path.split('.');
    var node = rootNode;
    for (final key in keys) {
      final child = node.children.get(key);
      if (child == null) {
        return;
      }
      fn(child);
      node = child;
    }
  }

  // Now we can learn which dependencies are missing or necessary.
  final missingDependencies = <String>{};
  final satisfyingDependencies = <String>{};
  scanTreeRecursively(_DepTree node, missingPaths, satisfyingPaths, keyToPath) {
    node.children.forEach((child, key) {
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
        suggestedDependencies.push(key);
      } else {
        // Duplicate.
        duplicateDependencies.add(key);
      }
    } else {
      if (
        isEffect &&
        !key.endsWith('.current') &&
        !externalDependencies.contains(key)
      ) {
        // Effects are allowed extra "unnecessary" deps.
        // Such as resetting scroll when ID changes.
        // Consider them legit.
        // The exception is ref.current which is always wrong.
        if (!suggestedDependencies.contains(key)) {
          suggestedDependencies.push(key);
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
  Iterable<_DeclaredDependency> declaredDependencies,
  AstNode declaredDependenciesNode,
  Scope componentScope,
  Scope scope,
}) {
  final constructions = declaredDependencies
    .map<Tuple2<Variable, String>>((dep) {
      final key = dep.key;

      final ref = componentScope.variables.firstWhere((v) => v.name == key, orElse: () => null);
      if (ref == null) {
        return null;
      }

      final node = ref.identifier;
      if (node == null) {
        return null;
      }
      // final handleChange = () {};
      // final foo = {};
      // final foo = [];
      // etc.
      final parent = node.parent;
      if (parent is VariableDeclaration) {
        // Const variables never change
        if (parent.isConst) return null;
        if (parent.initializer != null) {
          final constantExpressionType = getConstructionExpressionType(
            parent.initializer,
          );
          if (constantExpressionType != null) {
            return Tuple2(ref, constantExpressionType);
          }
        }
        return null;
      }
      // handleChange() {}
      if (
        parent is FunctionDeclaration
      ) {
        return Tuple2(ref, _DepType.function);
      }

      return null;
    })
    .whereNotNull();

  bool isUsedOutsideOfHook(Reference ref) {
    var foundWriteExpr = false;
    for (var i = 0; i < ref.references.length; i++) {
      final reference = ref.references[i];
      if (reference.writeExpr != null) {
        if (foundWriteExpr) {
          // Two writes to the same function.
          return true;
        } else {
          // Ignore first write as it's not usage.
          foundWriteExpr = true;
          continue;
        }
      }
      var currentScope = reference.from;
      while (currentScope != scope && currentScope != null) {
        currentScope = currentScope.upper;
      }
      if (currentScope != scope) {
        // This reference is outside the Hook callback.
        // It can only be legit if it's the deps array.
        if (!isAncestorNodeOf(declaredDependenciesNode, reference.identifier)) {
          return true;
        }
      }
    }
    return false;
  }

  return constructions.map((tuple) {
    final ref = tuple.first;
    final depType = tuple.second;
    return _Construction(
      construction: ref.defs[0],
      depType: depType,
      isUsedOutsideOfHook: isUsedOutsideOfHook(ref),
    );
  }).toList();
}

class Tuple2<T1, T2> {
  final T1 first;
  final T2 second;
  const Tuple2(this.first, this.second);
}

class _Construction {
  final AstNode construction;
  final String depType;
  final bool isUsedOutsideOfHook;

  _Construction({this.construction, this.depType, this.isUsedOutsideOfHook});
}
abstract class _DepType {
  static const classDep = 'class';
  static const function = 'function';
}

/// Assuming () means the passed/returned node:
/// (props) => (props)
/// props.(foo) => (props.foo)
/// props.foo.(bar) => (props).foo.bar
/// props.foo.bar.(baz) => (props).foo.bar.baz
Expression getDependency(Expression node) {
  if (
    (node.parent.type == 'MemberExpression' ||
      node.parent.type == 'OptionalMemberExpression') &&
    node.parent.object == node &&
    node.parent.property.name != 'current' &&
    !(
      node.parent.parent != null &&
      (node.parent.parent.type == 'CallExpression' ||
        node.parent.parent.type == 'OptionalCallExpression') &&
      node.parent.parent.callee == node.parent
    )
  ) {
    return getDependency(node.parent);
  } else if (
    // Note: we don't check OptionalMemberExpression because it can't be LHS.
    node.type == 'MemberExpression' &&
    node.parent &&
    node.parent.type == 'AssignmentExpression' &&
    node.parent.left == node
  ) {
    return node.object;
  } else {
    return node;
  }
}

/// Mark a node as either optional or required.
/// Note: If the node argument is an OptionalMemberExpression, it doesn't necessarily mean it is optional.
/// It just means there is an optional member somewhere inside.
/// This particular node might still represent a required member, so check .optional field.
void markNode(AstNode node, Map<String, bool> optionalChains, String result) {
  if (optionalChains != null) {
    if (node.optional) {
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
  if (node.type == 'Identifier' || node.type == 'JSXIdentifier') {
    final result = node.name;
    if (optionalChains != null) {
      // Mark as required.
      optionalChains[result] = false;
    }
    return result;
  } else if (node.type == 'MemberExpression') {
    final object = analyzePropertyChain(node.object, optionalChains);
    final property = analyzePropertyChain(node.property, null);
    final result = "$object.$property";
    markNode(node, optionalChains, result);
    return result;
  } else if (node.type == 'OptionalMemberExpression') {
    final object = analyzePropertyChain(node.object, optionalChains);
    final property = analyzePropertyChain(node.property, null);
    final result = "$object.$property";
    markNode(node, optionalChains, result);
    return result;
  } else if (node.type == 'ChainExpression') {
    final expression = node.expression;
    final object = analyzePropertyChain(expression.object, optionalChains);
    final property = analyzePropertyChain(expression.property, null);
    final result = "$object.$property";
    markNode(expression, optionalChains, result);
    return result;
  } else {
    throw ArgumentError("Unsupported node type: ${node.type}");
  }
}

AstNode getNodeWithoutReactNamespace(node) {
  if (
    node.type == 'MemberExpression' &&
    node.object.type == 'Identifier' &&
    node.object.name == 'React' &&
    node.property.type == 'Identifier'
  ) {
    return node.property;
  }
  return node;
}

// What's the index of callback that needs to be analyzed for a given Hook?
// -1 if it's not a Hook we care about (e.g. useState).
// 0 for useEffect/useMemo/useCallback(fn).
// 1 for useImperativeHandle(ref, fn).
// For additionally configured Hooks, assume that they're like useEffect (0).
int getReactiveHookCallbackIndex(calleeNode, options) {
  final node = getNodeWithoutReactNamespace(calleeNode);
  if (node.type != 'Identifier') {
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
      if (node == calleeNode && options != null && options.additionalHooks != null) {
        // Allow the user to provide a regular expression which enables the lint to
        // target custom reactive hooks.
        var name;
        try {
          name = analyzePropertyChain(node, null);
        } catch (error) {
          if (error.toString().contains('Unsupported node type')) {
            return 0;
          } else {
            rethrow;
          }
        }
        return options.additionalHooks.test(name) ? 0 : -1;
      } else {
        return -1;
      }
  }
}

/// ESLint won't assign node.parent to references from context.getScope()
///
/// So instead we search for the node from an ancestor assigning node.parent
/// as we go. This mutates the AST.
///
/// This traversal is:
/// - optimized by only searching nodes with a range surrounding our target node
/// - agnostic to AST node types, it looks for "{ type: string, ... }"
Identifier fastFindReferenceWithParent(AstNode start, Identifier target) {
  final queue = Queue.of([start]);
  AstNode item;

  while (queue.isNotEmpty) {
    item = queue.removeFirst();

    if (isSameIdentifier(item, target)) {
      return item as Identifier;
    }

    if (!isAncestorNodeOf(item, target)) {
      continue;
    }

    for (final value in item.childEntities.whereType<AstNode>()) {
      value.parent = item;
      queue.add(value);
    }
  }

  return null;
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

bool isSameIdentifier(AstNode a, Identifier b) {
  return a is Identifier &&
      a.name == b.name &&
      a.offset == b.offset &&
      a.end == b.end;
}

bool isAncestorNodeOf(AstNode a, AstNode b) {
  return a.offset <= b.offset && a.end >= b.end;
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
