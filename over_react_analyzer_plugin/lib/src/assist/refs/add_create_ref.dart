import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

enum RefTypeToReplace {
  string,
  callback,
}

typedef CreateRefLinkedEditFn = void Function(
  DartFileEditBuilder builder,
  FluentComponentUsage usage, {
  String groupName,
});

/// Utility function shared between diagnostics and assists to add a field to a
/// component assigned to the return value of a `createRef()` call.
void addCreateRef(
  DartFileEditBuilder builder,
  FluentComponentUsage usage,
  ResolvedUnitResult result, {
  AnalyzerDebugHelper debug,
}) {
  const nameGroup = 'refName';
  const typeGroup = 'refType';

  final lineInfo = result.unit.lineInfo;
  String oldStringRefName;
  final componentName = usage.componentName;
  final lowerCaseComponentName =
      componentName == null ? 'component' : componentName.substring(0, 1).toLowerCase() + componentName.substring(1);
  var nameOfFieldRefIsAssignedTo = '_${lowerCaseComponentName}Ref';
  RefTypeToReplace refTypeToReplace;

  final enclosingClassOrMixin = usage.node.thisOrAncestorOfType<ClassOrMixinDeclaration>();

  final refTypeName = usage.isDom
      ? 'Element'
      // TODO split this out somewhere, make more robust
      : (componentName != null ? '${componentName}Component' : 'var');

  var hasRefProp = false;
  forEachCascadedProp(usage, (lhs, rhs) {
    if (lhs.propertyName.name != 'ref') return;

    // A fix is being used to replace a String / callback ref with a createRef reference.
    hasRefProp = true;

    if (rhs.staticType.isDartCoreString) {
      refTypeToReplace = RefTypeToReplace.string;
      oldStringRefName = rhs.toSource();
    } else if (result.typeSystem.isSubtypeOf(rhs.staticType, result.typeProvider.functionType)) {
      refTypeToReplace = RefTypeToReplace.callback;
      nameOfFieldRefIsAssignedTo = _getRefCallbackAssignedFieldName(rhs);
    }

    // Replace the string or callback ref with the field we'll be assigning the return value of createRef() to.
    builder.addReplacement(SourceRange(rhs.offset, rhs.length), (editBuilder) {
      editBuilder.addSimpleLinkedEdit(nameGroup, nameOfFieldRefIsAssignedTo);
    });
  });

  if (!hasRefProp) {
    // An assist is being used to add a ref, so we have to add the ref prop as a cascaded setter
    addProp(usage, builder, result.content, lineInfo, name: 'ref', buildValueEdit: (builder) {
      builder.addSimpleLinkedEdit(nameGroup, nameOfFieldRefIsAssignedTo);
    });
  }

  void _addCreateRefFieldDeclaration(DartEditBuilder _builder) {
    _builder.write('final ');
    _builder.addSimpleLinkedEdit(nameGroup, nameOfFieldRefIsAssignedTo);
    _builder.write(' = createRef<');
    _builder.addSimpleLinkedEdit(typeGroup, refTypeName);
    _builder.write('>();');
  }

  if (refTypeToReplace == RefTypeToReplace.callback) {
    // Its a callback ref - meaning there is an existing field we need to update.
    final declOfVarRefIsAssignedTo = enclosingClassOrMixin.getFieldDeclaration(nameOfFieldRefIsAssignedTo);
    builder.addReplacement(SourceRange(declOfVarRefIsAssignedTo.offset, declOfVarRefIsAssignedTo.length), (_builder) {
      _addCreateRefFieldDeclaration(_builder);
      if (enclosingClassOrMixin.getField(nameOfFieldRefIsAssignedTo).declaredElement.isPublic) {
        _builder.write(
            '// FIXME: All usages of `$nameOfFieldRefIsAssignedTo` outside of this class must be changed to `$nameOfFieldRefIsAssignedTo.current` to finalize the conversion to createRef().');
      }
    });

    // Append all usages of the field the return value of createRef() is assigned to with `.current`
    forEachDescendantOfType<Identifier>(
      enclosingClassOrMixin,
      (identifier) {
        final isMethodInvocation = identifier.thisOrAncestorOfType<MethodInvocation>() != null;
        final isPrefixedIdentifier = identifier.thisOrAncestorOfType<PrefixedIdentifier>() != null;
        return (isMethodInvocation || isPrefixedIdentifier) && identifier.name == nameOfFieldRefIsAssignedTo;
      },
      (identifier) {
        builder.addInsertion(identifier.end, (_builder) {
          _builder.write('.current');
        });
      },
    );
  } else {
    // Its a string ref replacement, or an assist to add a ref,
    // so create the field that stores the return value of createRef().
    final insertionLocation = _getRefInsertionLocation(usage.node, lineInfo);
    final insertionOffset = insertionLocation.first;
    final insertionParent = insertionLocation.last;
    final indent = insertionParent is CompilationUnit
        ? ''
        : getIndent(result.content, lineInfo, insertionParent.parent.offset) + '  ';

    builder.addInsertion(insertionOffset, (_builder) {
      _builder.write('$indent');
      _addCreateRefFieldDeclaration(_builder);
      _builder.writeln('');
      _builder.writeln('');
    });

    if (hasRefProp) {
      // Replace all usages of ref('oldStringRef') with the new ref field
      forEachDescendantOfType<Identifier>(
        enclosingClassOrMixin,
        (identifier) {
          final parentFunctionInvocation = identifier.thisOrAncestorOfType<FunctionExpressionInvocation>();
          if (parentFunctionInvocation == null) return false;

          return identifier.name == 'ref' && parentFunctionInvocation.argumentList.toSource() == '($oldStringRefName)';
        },
        (identifier) {
          final parentFunctionInvocation = identifier.thisOrAncestorOfType<FunctionExpressionInvocation>();
          builder.addReplacement(SourceRange(parentFunctionInvocation.offset, parentFunctionInvocation.length),
              (_builder) {
            _builder.write(nameOfFieldRefIsAssignedTo);
          });
        },
      );
    }
  }
}

String _getRefCallbackAssignedFieldName(Expression refPropRhs) {
  final function = refPropRhs?.tryCast<FunctionExpression>();
  if (function == null) return null;

  final refCallbackArg = function.parameters.parameters.firstOrNull;
  if (refCallbackArg == null) return null;

  final referencesToArg = getMatchingDescendantsOfType<Identifier>(
      function.body, (identifier) => identifier.staticElement == refCallbackArg.declaredElement);

  for (final reference in referencesToArg) {
    final parent = reference.parent;
    if (parent is AssignmentExpression && parent.rightHandSide == reference) {
      final lhs = parent.leftHandSide;
      if (lhs is Identifier && lhs.staticElement.kind == ElementKind.SETTER) {
        return lhs.staticElement.displayName;
      }
    }
  }

  return null;
}

Pair<int, AstNode> _getRefInsertionLocation(AstNode node, LineInfo lineInfo) {
  final closestUnit = node.thisOrAncestorOfType<CompilationUnit>();
  // For now, don't support expression bodies since we can't easily insert a ref statement
  final closestFunctionBody = node.thisOrAncestorOfType<BlockFunctionBody>();
  final closestClass = node.thisOrAncestorOfType<ClassDeclaration>();

  AstNode parent;
  int offset;

  if (closestClass != null) {
    parent = closestClass;
    offset = nextLine(closestClass.leftBracket.end, lineInfo);
  } else if (closestFunctionBody != null) {
    parent = closestFunctionBody;
    offset = nextLine(closestFunctionBody.block.leftBracket.end, lineInfo);
  } else if (closestUnit != null) {
    parent = closestUnit;
    offset = prevLine(node.thisOrAncestorMatching((node) => node is CompilationUnitMember).offset, lineInfo);
  } else {
    // Not sure how we got here... TODO throw error instead or handle this return value at call site
    return Pair(-1, null);
  }

  for (final child in parent.childEntities.toList().reversed) {
    final variables = child.tryCast<FieldDeclaration>()?.fields ??
        child.tryCast<TopLevelVariableDeclaration>()?.variables ??
        child.tryCast<VariableDeclarationStatement>()?.variables;
    if (variables != null &&
        variables.variables.any((decl) => decl.name.name != 'Ref' && decl.name.name.endsWith('Ref'))) {
      offset = nextLine(child.end, lineInfo);
      break;
    }
  }

  return Pair(offset, parent);
}
