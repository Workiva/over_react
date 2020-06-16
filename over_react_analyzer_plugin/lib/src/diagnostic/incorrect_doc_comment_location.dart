import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

class IncorrectDocCommentLocationDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_incorrect_doc_comment_location',
    "Doc comments should be above the factory declaration",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );

  static final fixKind = FixKind(
    code.name,
    200,
    'Move comment above factory',
  );

  @override
  computeErrors(result, collector) async {
    final visitor = ClassVisitor();

    result.unit.accept(visitor);

    final misplacedDocComments = visitor.misplacedDocComments;
    final factoryList = visitor.factoryList;

    for (final comment in misplacedDocComments) {
      await collector.addErrorWithFix(
        code,
        result.locationFor(comment),
        fixKind: fixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          builder.addDeletion(range.startOffsetEndOffset(comment.offset - 1, comment.end));
          builder.addInsertion(factoryList.first.offset, (builder) {
            for (final line in comment.childEntities) {
              builder.write('${line.toString()}\n');
            }
          });
        }),
      );
    }
  }
}

const overReactBaseComponentClasses = {
  'UiComponent',
  'UiComponent2',
  'UiStatefulComponent',
  'UiStatefulComponent2',
  'FluxUiComponent',
  'FluxUiComponent2',
  'FluxUiStatefulComponent',
  'FluxUiStatefulComponent2',
};

bool isComponentFactory(TopLevelVariableDeclaration expr) {
  return expr.variables.type.beginToken.toString() == 'UiFactory';
}

bool isPropsOrStateClass(ClassDeclaration classDecl) {
  return classDecl.declaredElement.allSupertypes.any((m) {
    return m.getDisplayString() == 'UiProps' || m.getDisplayString() == 'UiState';
  });
}

bool isPropsOrStateMixin(MixinDeclaration mixinDecl) {
  return mixinDecl.onClause.superclassConstraints.any((m) {
    return m.name.name == 'UiProps' || m.name.name == 'UiState';
  });
}

bool isComponentClass(ClassDeclaration classDecl) {
  return classDecl.declaredElement.allSupertypes.any((m) {
    return overReactBaseComponentClasses.any((c) {
      return m.getDisplayString().contains(c);
    });
  });
}

class ClassVisitor extends SimpleAstVisitor<void> {
  List<Comment> misplacedDocComments = [];
  List<TopLevelVariableDeclaration> factoryList = [];
  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    if (isComponentFactory(node)) {
      factoryList.add(node);
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final docComment = node.documentationComment;
    if (docComment != null && (isComponentClass(node) || isPropsOrStateClass(node))) {
      misplacedDocComments.add(docComment);
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    final docComment = node.documentationComment;
    if (docComment != null && isPropsOrStateMixin(node)) {
      misplacedDocComments.add(docComment);
    }
  }
}
