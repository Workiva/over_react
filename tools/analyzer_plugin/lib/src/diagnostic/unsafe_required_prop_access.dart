import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/is_props_from_render.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r"Do not unsafely access required props when they're not guaranteed to be present.";
// <editor-fold desc="Documentation Details">
const _details = r'''

**DO NOT** access required props when they're not guaranteed to be present, since that can cause errors and bad behavior.

Required props are only validated to be present on props a component was rendered with, and not on other props objects.

For example, given props:
```dart
mixin FooProps {
  late int requiredProp;
}

example() {
  final props = Foo(); // Create an empty props object.
   
  // Throws because the map is empty, and the value `null`
  // is not an `int`.
  props.requiredProp;  
}
```

**DO** use utility methods `getRequiredProp`, getRequiredPropOrNull`, or `containsProp` checks to safely access the prop.

**GOOD:**
```dart
renderFoo([Map? _additionalFooProps]) {
  final fooProps = Foo({...?_additionalFooProps});
  
  // Safe access via `.getRequiredProp`
  final requiredProp1 = fooProps.getRequiredProp((p) => p.requiredProp1),
      orElse: () => 'custom default');
      
  // Safe access via `.getRequiredPropOrNull`
  final requiredProp2Uppercase = fooProps
      .getRequiredPropOrNull((p) => requiredProp2)
      ?.toUpperCase();
    
  // Safe access via if-check with `.containsProp`
  final otherPropsToAdd = Foo();
  if (fooProps.containsProp((p) => p.requiredProp3)) {
    otherPropsToAdd.aria.label = fooProps.requiredProp3;
  }
  
  // ...
}
```

**BAD:**
```
@override
renderFoo([Map? _additionalFooProps]) {
  final fooProps = Foo({...?_additionalFooProps});
  
  // Unsafe; `.requiredProp1` will throw if it's not present.
  final requiredProp1 = fooProps.requiredProp1 ?? 'custom default';
      
  // Unsafe; `.requiredProp1` will throw if it's not present.
  // Also, there's a static analysis error because there's a null-aware 
  // on the non-nullable `requiredProp2`
  final requiredProp2Uppercase = fooProps.requiredProp2?.toUpperCase();
    
  // Unsafe; `.requiredProp3` will throw if it's not present.
  // Also, there's a static analysis error on the condition because 
  // the non-nulllable requiredProp3 will always `!= null`.
  final otherPropsToAdd = Foo();
  if (fooProps.requiredProp3 != null) {
    otherPropsToAdd.aria.label = fooProps.requiredProp3;
  }
  
  // ...
}
```
''';
// </editor-fold>

class UnsafeRequiredPropAccessDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details, maturity: Maturity.experimental)
  static const code = DiagnosticCode(
      'over_react_unsafe_required_prop_access',
      "Accessing required prop '{0}' on a potentially incomplete props map can throw.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING,
      correction: "Use 'getRequiredProp' or 'getRequiredPropOrNull' to safely access the prop,"
          " or wrap this read in a 'containsProp' check.");

  @override
  get codes => const [code];

  static final fixKind =
      FixKind('use_get_required_prop_or_null', 200, "Use 'getRequiredPropOrNull' to safely access the prop.");

  @override
  computeErrors(result, collector) async {
    final requiredPropReads = <LateRequiredPropRead>[];
    result.unit.accept(LateRequiredPropReadVisitor(requiredPropReads.add));

    // The overhead of isPropsFromRender is non-negligible; cache by the element to optimize
    // the very common case of `props.` being accessed multiple times within a component.
    final _cacheByElement = <Element, bool>{};
    bool cachedIsComponentProps(Expression target) {
      final element = target.tryCast<Identifier>()?.staticElement;
      return element != null
          ? _cacheByElement.putIfAbsent(element, () => isPropsFromRender(target))
          : isPropsFromRender(target);
    }

    for (final requiredPropRead in requiredPropReads) {
      if (cachedIsComponentProps(requiredPropRead.realTarget)) continue;
      if (isPropsSafeUtilityMethodArg(requiredPropRead.realTarget)) continue;
      if (_isSafeDueToContainsPropCheck(requiredPropRead)) continue;
      if (_isWithinLifecycleMethodWithPropsArg(requiredPropRead)) continue;
      if (_isProbablyWithinMemoAreEqualFunction(requiredPropRead)) continue;

      final prop = requiredPropRead.prop;

      if (requiredPropRead.isCompoundAssignment) {
        // This case is rare and providing a fix is complicated, so we'll just provide an error.
        collector.addError(code, result.locationFor(prop), errorMessageArgs: [prop.name]);
      } else {
        await collector.addErrorWithFix(
          code,
          result.locationFor(prop),
          errorMessageArgs: [prop.name],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(range.node(prop), 'getRequiredPropOrNull((p) => p.${prop.name})');
          }),
        );
      }
    }
  }
}

/// Returns whether [read] is within a class component lifecycle method that receives a props map
/// as an argument.
///
/// In these cases, consumers will commonly use `typedPropsFactory` to get a view on a complete props map,
/// so we'll opt out of validation within this method.
bool _isWithinLifecycleMethodWithPropsArg(LateRequiredPropRead read) {
  final lifecycleMethod = read.node.thisOrAncestorOfType<MethodDeclaration>();
  if (lifecycleMethod == null) return false;

  return const {
    'propTypes',
    'componentDidUpdate',
    'componentWillReceiveProps',
    'componentWillReceivePropsWithContext',
    'componentWillUpdate',
    'getDerivedStateFromProps',
    'getSnapshotBeforeUpdate',
    'shouldComponentUpdate',
    'shouldComponentUpdateWithContext',
  }.contains(lifecycleMethod.name.lexeme);
}

//
bool _isProbablyWithinMemoAreEqualFunction(LateRequiredPropRead read) {
  final functionExpression = read.node.thisOrAncestorOfType<FunctionExpression>();
  if (functionExpression == null) return false;

  final functionParent = functionExpression.parent;

  if (functionParent is NamedExpression) {
    return functionParent.name.label.name == 'areEqual' &&
        functionParent.parent.tryCast<ArgumentList>()?.parent?.tryCast<MethodInvocation>()?.methodName.name == 'memo';
  }

  // Consumers commonly split out the areEqual function.
  // Instead of looking up whether the functions are used in memo calls,
  // just assume top-level functions and variables named /[aA]reEqual/ are safe.
  String functionName;
  bool isTopLevelDeclaration;
  if (functionParent is FunctionDeclaration) {
    functionName = functionParent.name.lexeme;
    isTopLevelDeclaration = functionParent.parent is CompilationUnit;
  } else if (functionParent is VariableDeclaration && functionParent.initializer == functionExpression) {
    functionName = functionParent.name.lexeme;
    // VariableDeclaration < VariableDeclarationList < TopLevelVariableDeclaration
    isTopLevelDeclaration = functionParent.parent?.parent is TopLevelVariableDeclaration;
  } else {
    return false;
  }
  if (isTopLevelDeclaration) {
    return _memoAreEqualNamePattern.hasMatch(functionName);
  }

  return false;
}

final _memoAreEqualNamePattern = RegExp(r'[aA]reEqual');

/// Returns whether [target] is an identifier referencing an argument to safe utility methods.
///
/// For example, in `props.containsProp((p) => p.requiredProp)`,
/// returns `true` for the `p` that's followed by `.requiredProp`.
bool isPropsSafeUtilityMethodArg(Expression target) {
  if (target is! Identifier) return false;

  final staticElement = target.staticElement;
  if (staticElement is! ParameterElement) return false;

  final parameter = lookUpParameter(staticElement, target.root);
  if (parameter == null) return false;

  final methodCallReceivingFunction = parameter
      .thisOrAncestorOfType<FormalParameterList>()
      ?.parent
      .tryCast<FunctionExpression>()
      ?.parent
      .tryCast<ArgumentList>()
      ?.parent
      .tryCast<MethodInvocation>();
  if (methodCallReceivingFunction == null) return false;

  return const {
    'getPropKey', // top-level, UiComponent, UiPropsSelfTypedExtension
    'keyForProp', // UiComponent
    'containsProp', // UiPropsSelfTypedExtension
    'getRequiredProp', // UiPropsSelfTypedExtension
    'getRequiredPropOrNull', // UiPropsSelfTypedExtension
  }.contains(methodCallReceivingFunction.methodName.name);
}

/// Returns whether [propRead] is safe due to a corresponding containsProp check in an ancestor if-statement.
bool _isSafeDueToContainsPropCheck(LateRequiredPropRead propRead) {
  for (final ancestor in propRead.node.ancestors) {
    // If we encounter a function body, we're either inside a callback
    // or are not going to find our if-statement. Bail out.
    if (ancestor is FunctionBody) return false;
    if (ancestor is IfStatement) {
      // Only handle then-statements, not else-statements, reads within the condition, or if-cases.
      if (ancestor.thenStatement.containsRangeOf(propRead.node) && ancestor.caseClause == null) {
        if (_conditionGuaranteesContainsProp(ancestor.expression, propRead)) return true;
      }
    }
  }
  return false;
}

/// Returns whether a `containsProp` check for the prop read in [propRead] is always `true`
/// when the boolean expression [condition] is `true`.
bool _conditionGuaranteesContainsProp(Expression condition, LateRequiredPropRead propRead) {
  // Handle simple && case.
  if (condition is BinaryExpression && condition.operator.type == TokenType.AMPERSAND_AMPERSAND) {
    return _conditionGuaranteesContainsProp(condition.leftOperand, propRead) ||
        _conditionGuaranteesContainsProp(condition.rightOperand, propRead);
  }

  if (condition is MethodInvocation && !condition.isCascaded && condition.methodName.name == 'containsProp') {
    final containsPropCall = condition;
    // Check that `.containsProp` is heing called on the same object the prop read occurred on.
    return _hasSameNonNullStaticElement(containsPropCall.realTarget, propRead.realTarget) &&
        // Check that the prop being tested in `containsProp` is the same prop we're reading.
        _hasSameNonNullStaticElement(propRead.prop, _getPropBeingCheckedInContainsProp(containsPropCall));
  } else {
    return false;
  }
}

/// Returns whether [a] and [b] are both identifiers that have the same non-null [Identifier.staticElement].
bool _hasSameNonNullStaticElement(Expression? a, Expression? b) {
  final elementA = a.tryCast<Identifier>()?.staticElement;
  final elementB = b.tryCast<Identifier>()?.staticElement;
  return elementA != null && elementB != null && elementA == elementB;
}

/// Returns the identifier of the prop being checked in a `containsProp` call.
///
/// For example, returns `foo` for `props.containsProp((p) => p.foo)`.
SimpleIdentifier? _getPropBeingCheckedInContainsProp(MethodInvocation containsPropCall) {
  final propAccess = containsPropCall.argumentList.arguments.firstOrNull
      .tryCast<FunctionExpression>()
      ?.body
      .returnExpressions
      .singleOrNull;
  if (propAccess == null) return null;

  return getSimpleTargetAndPropertyName(propAccess, allowMethodInvocation: false)?.item2;
}

/// A read of a late required prop.
class LateRequiredPropRead {
  final Expression node;
  final Expression realTarget;
  final SimpleIdentifier prop;
  final AssignmentExpression? compoundAssignment;

  bool get isCompoundAssignment => compoundAssignment != null;

  LateRequiredPropRead({
    required this.node,
    required this.realTarget,
    required this.prop,
    required this.compoundAssignment,
  });
}

class LateRequiredPropReadVisitor extends RecursiveAstVisitor<void> {
  final void Function(LateRequiredPropRead) onRead;

  LateRequiredPropReadVisitor(this.onRead);

  @override
  void visitComment(Comment node) {
    // Don't recurse into doc comments
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    super.visitPropertyAccess(node);

    final staticElement = node.propertyName.staticElement ?? _getElementFromParentAssignment(node);
    if (staticElement == null) return;

    _handlePrefixedOrPropertyAccess(
      node: node,
      target: node.realTarget,
      property: node.propertyName,
      propertyElement: staticElement,
    );
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    super.visitPrefixedIdentifier(node);

    final staticElement = node.identifier.staticElement ?? _getElementFromParentAssignment(node);
    if (staticElement == null) return;

    _handlePrefixedOrPropertyAccess(
      node: node,
      target: node.prefix,
      property: node.identifier,
      propertyElement: staticElement,
    );
  }

  static Element? _getElementFromParentAssignment(Expression node) {
    final parent = node.parent;
    if (parent is AssignmentExpression && parent.leftHandSide == node) {
      return parent.readElement ?? parent.writeElement;
    }
    return null;
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    final realTarget = node.realTarget;
    if (realTarget == null) return;

    final staticElement = node.methodName.staticElement;
    if (staticElement == null) return;

    _handlePrefixedOrPropertyAccess(
      node: node,
      target: realTarget,
      property: node.methodName,
      propertyElement: staticElement,
    );
  }

  void _handlePrefixedOrPropertyAccess({
    required Expression node,
    required Expression target,
    required SimpleIdentifier property,
    required Element propertyElement,
  }) {
    final fieldElement = propertyElement.tryCast<FieldElement>() ??
        propertyElement.tryCast<PropertyAccessorElement>()?.variable.tryCast<FieldElement>();
    if (fieldElement == null) return;

    if (!_isLateRequiredProp(fieldElement)) return;

    final parent = node.parent;
    if (parent is AssignmentExpression && parent.leftHandSide == node) {
      /// Whether it's a compound assignment, which also involves a read.
      /// E.g., `builder.fooProp ??= 'foo'`
      final isCompoundAssignment = parent.readElement != null;
      if (isCompoundAssignment) {
        onRead(LateRequiredPropRead(node: node, realTarget: target, prop: property, compoundAssignment: parent));
      } else {
        // Do nothing for non-compound assignments, since they don't involve reading the prop.
      }
    } else {
      onRead(LateRequiredPropRead(node: node, realTarget: target, prop: property, compoundAssignment: null));
    }
  }
}

/// Whether [propertyElement] is the declaration of a late required prop.
bool _isLateRequiredProp(FieldElement propertyElement) {
  if (!propertyElement.isLate || propertyElement.isStatic) return false;

  final enclosingClass = propertyElement.enclosingElement.tryCast<InterfaceElement>();
  if (enclosingClass == null) return false;

  // Short-circuit earlier using the name so we can avoid unnecessarily computing allSuperTypes in `.isPropsClass`.
  // v4 boilerplate props mixins must end with either "Props" or "PropsMixin",
  // and most legacy classes also match this convention.
  if (!enclosingClass.name.contains('Props') || !enclosingClass.isPropsClass) {
    return false;
  }

  return true;
}
