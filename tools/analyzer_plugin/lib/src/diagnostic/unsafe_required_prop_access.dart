import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/is_component_props.dart';
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
          ? _cacheByElement.putIfAbsent(element, () => isComponentProps(target))
          : isComponentProps(target);
    }

    for (final requiredPropRead in requiredPropReads) {
      if (cachedIsComponentProps(requiredPropRead.target)) continue;
      if (isPropsSafeUtilityMethodArg(requiredPropRead.target)) continue;

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

class LateRequiredPropRead {
  final Expression target;
  final SimpleIdentifier prop;
  final AssignmentExpression? compoundAssignment;

  bool get isCompoundAssignment => compoundAssignment != null;

  LateRequiredPropRead({
    required this.target,
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
    required AstNode node,
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
        onRead(LateRequiredPropRead(target: target, prop: property, compoundAssignment: parent));
      } else {
        // Do nothing for non-compound assignments, since they don't involve reading the prop.
      }
    } else {
      onRead(LateRequiredPropRead(target: target, prop: property, compoundAssignment: null));
    }
  }
}

bool _isLateRequiredProp(FieldElement propertyElement) {
  return propertyElement.isLate &&
      !propertyElement.isStatic &&
      (propertyElement.enclosingElement.tryCast<InterfaceElement>()?.isPropsClass ?? false);
}
