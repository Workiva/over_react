import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

class IncorrectDocCommentLocationDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_incorrect_doc_comment_location',
    "Doc comments should be above the factory declaration.",
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
    final visitor = CommentsVisitor();

    result.unit.accept(visitor);

    final classesWithMisplacedDocComments = visitor.classesWithMisplacedDocComments;
    final factoryList = visitor.factoryList;

    for (final classWithComment in classesWithMisplacedDocComments) {
      final docComment = classWithComment.documentationComment;
      final componentFactory = getComponentFactory(classWithComment, factoryList);
      if(componentFactory != null) {
        await collector.addErrorWithFix(
          code,
          result.locationFor(docComment),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addDeletion(range.startOffsetEndOffset(
              // [offset - 1] to remove the extra line
              docComment.offset - 1,
              docComment.end,
            ));
            builder.addInsertion(componentFactory.offset, (builder) {
              for (final line in docComment.childEntities) {
                builder.write('${line.toString()}\n');
              }
            });
          }),
        );
      } else {
        collector.addError(
          code,
          result.locationFor(docComment),
        );
      }
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

const overReactClassEndings = {
  'Component',
  'State',
  'StateMixin',
  'Props',
  'PropsMixin',
};

/// Returns the name of [factory].
String getFactoryName(TopLevelVariableDeclaration factory) {
  return factory.variables.variables.first.name.name;
}

/// Returns [className] with the `Component`, `Props`, `PropsMixin`, `State`,
/// or `StateMixin` ending removed.
///
/// This should be the factory name (see [getComponentFactory]).
String removeClassNameEnding(String className) {
  if(overReactClassEndings.any((ending) => className.contains(ending))) {
    final ending = overReactClassEndings.firstWhere((ending) {
      return className.endsWith(ending);
    });
    return className.substring(0, className.lastIndexOf(ending));
  }
  return className;
}

/// Returns the component factory in [factoryList] that corresponds to the
/// component class or props/state class or mixin [classDecl].
TopLevelVariableDeclaration getComponentFactory(ClassOrMixinDeclaration classDecl, List<TopLevelVariableDeclaration> factoryList) {
  if(factoryList.isEmpty) {
    return null;
  } else if(factoryList.length == 1) {
    return factoryList.first;
  }
  return factoryList.firstWhere((factory) => removeClassNameEnding(classDecl.name.name) == getFactoryName(factory));
}

/// Returns whether or not [decl] is a `UiFactory`.
bool isComponentFactory(TopLevelVariableDeclaration decl) {
  return decl.variables.type.beginToken.toString() == 'UiFactory';
}

/// Returns whether or not [classDecl] is a props or state class.
bool isPropsOrStateClass(ClassDeclaration classDecl) {
  return classDecl.declaredElement.allSupertypes.any((m) {
    return m.getDisplayString() == 'UiProps' || m.getDisplayString() == 'UiState';
  });
}

/// Returns whether or not [mixinDecl] is a props or state mixin.
bool isPropsOrStateMixin(MixinDeclaration mixinDecl) {
  return mixinDecl.onClause.superclassConstraints.any((m) {
    return m.name.name == 'UiProps' || m.name.name == 'UiState';
  });
}

/// Returns whether or not [classDecl] is a `UiComponent` class.
bool isComponentClass(ClassDeclaration classDecl) {
  return classDecl.declaredElement.allSupertypes.any((m) {
    return overReactBaseComponentClasses.any((c) {
      return m.getDisplayString().contains(c);
    });
  });
}

class CommentsVisitor extends SimpleAstVisitor<void> {
  List<ClassOrMixinDeclaration> classesWithMisplacedDocComments = [];
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
    if (node.documentationComment != null && (isComponentClass(node) || isPropsOrStateClass(node))) {
      classesWithMisplacedDocComments.add(node);
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    if (node.documentationComment != null && isPropsOrStateMixin(node)) {
      classesWithMisplacedDocComments.add(node);
    }
  }
}
