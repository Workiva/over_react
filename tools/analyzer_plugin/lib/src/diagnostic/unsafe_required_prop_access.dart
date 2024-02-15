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

const _desc = r'';
// <editor-fold desc="Documentation Details">
const _details = r'''

''';
// </editor-fold>

class UnsafeRequiredPropAccessDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details, maturity: Maturity.experimental)
  static const code = DiagnosticCode(
      'over_react_unsafe_required_prop_access',
      "Accessing required prop '{0}' on a potentially incomplete props map can throw.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING,
      // FIXME talk about simple containsProp check, potentially add quick fix
      correction:
          "Use safe utility methods to access the prop: 'getRequiredProp', 'getRequiredPropOrNull', or 'containsProp'.");

  @override
  get codes => const [code];

  static final fixKind =
      FixKind('use_get_required_prop_or_null', 200, "Use 'getRequiredPropOrNull' to safely access the prop.");

  // static final fixKind = FixKind('use_or_null', 200, "Add required prop '{0}'");

  @override
  computeErrors(result, collector) async {
    final requiredPropReads = <LateRequiredPropRead>[];
    result.unit.accept(LateRequiredPropReadVisitor(requiredPropReads.add));

    // The overhead of isComponentProps is non-negligible; cache by the element to optimize
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
      if (isGatedByContainsPropCheck(requiredPropRead)) continue;

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

bool isGatedByContainsPropCheck(LateRequiredPropRead propRead) {
  for (final ancestor in propRead.node.ancestors) {
    // If we encounter a function body, we're either inside a callback
    // or are not going to find our if-statement. Bail out.
    if (ancestor is FunctionBody) return false;
    // Handle the first if-statement we run across, and don't try to handle ancestors.
    if (ancestor is IfStatement) {
      // Only handle then-statements, not else-statements, reads within the condition, or if-cases.
      if (!ancestor.thenStatement.containsRangeOf(propRead.node) || ancestor.caseClause != null) {
        return false;
      }

      return conditionEnsuresContainsProp(ancestor.expression, propRead);
    }
  }
  return false;
}

bool conditionEnsuresContainsProp(Expression condition, LateRequiredPropRead propRead) {
  // Handle simple && case.
  if (condition is BinaryExpression && condition.operator.type == TokenType.AMPERSAND_AMPERSAND) {
    return conditionEnsuresContainsProp(condition.leftOperand, propRead) ||
        conditionEnsuresContainsProp(condition.rightOperand, propRead);
  }

  if (condition is MethodInvocation && !condition.isCascaded && condition.methodName.name == 'containsProp') {
    final containsPropCall = condition;
    // Check that `.containsProp` is heing called on the same object the prop read occurred on.
    return hasSameNonNullStaticElement(containsPropCall.realTarget, propRead.realTarget) &&
        // Check that the prop being tested in `containsProp` is the same prop we're reading.
        hasSameNonNullStaticElement(propRead.prop, getPropBeingCheckedInContainsProp(containsPropCall));
  } else {
    return false;
  }
}

bool hasSameNonNullStaticElement(Expression? a, Expression? b) =>
    a != null &&
    b != null &&
    isSameNonNullElement(
      a.tryCast<Identifier>()?.staticElement,
      b.tryCast<Identifier>()?.staticElement,
    );

bool isSameNonNullElement(Element? a, Element? b) => a != null && b != null && a == b;

SimpleIdentifier? getPropBeingCheckedInContainsProp(MethodInvocation containsPropCall) {
  final propAccess = containsPropCall.argumentList.arguments.firstOrNull
      .tryCast<FunctionExpression>()
      ?.body
      .returnExpressions
      .singleOrNull;
  if (propAccess == null) return null;

  return getSimpleTargetAndPropertyName(propAccess, allowMethodInvocation: false)?.item2;
}

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
