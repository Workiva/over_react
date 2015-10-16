library web_skin_dart.transformer.declaration_parsing;

import 'dart:mirrors' show MirrorSystem;

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';
// This import **is** used by Symbol references
import 'package:web_skin_dart/src/ui_core//transformer_generation/annotations.dart';

class ComponentDeclarations {
  static String _getName(Symbol symbol) {
    return MirrorSystem.getName(symbol);
  }

  static final String ANNOTATION_FACTORY = _getName(#Factory);
  static final String ANNOTATION_COMPONENT = _getName(#Component);
  static final String ANNOTATION_PROPS = _getName(#Props);
  static final String ANNOTATION_STATE = _getName(#State);

  static final String ANNOTATION_ABSTRACT_COMPONENT = _getName(#AbstractComponent);
  static final String ANNOTATION_ABSTRACT_PROPS = _getName(#AbstractProps);
  static final String ANNOTATION_ABSTRACT_STATE = _getName(#AbstractState);

  static final String ANNOTATION_PROPS_MIXIN = _getName(#PropsMixin);
  static final String ANNOTATION_STATE_MIXIN = _getName(#StateMixin);

  static final RegExp ANNOTATION_ANY = new RegExp(
      r'@(' + [
        ANNOTATION_FACTORY,
        ANNOTATION_COMPONENT,
        ANNOTATION_PROPS,
        ANNOTATION_STATE,
        ANNOTATION_ABSTRACT_COMPONENT,
        ANNOTATION_ABSTRACT_PROPS,
        ANNOTATION_ABSTRACT_STATE,
        ANNOTATION_PROPS_MIXIN,
        ANNOTATION_STATE_MIXIN,
      ].join('|') + r')'
  );

  final ClassDeclaration componentClass;
  final TopLevelVariableDeclaration factory;
  final ClassDeclaration props;
  final ClassDeclaration state;

  final ClassDeclaration abstractComponentClass;
  final ClassDeclaration abstractProps;
  final ClassDeclaration abstractState;

  final List<ClassDeclaration> propsMixins;
  final List<ClassDeclaration> stateMixins;

  ComponentDeclarations._({
      this.factory,
      this.componentClass,
      this.props,
      this.state,

      this.abstractComponentClass,
      this.abstractProps,
      this.abstractState,

      this.propsMixins,
      this.stateMixins
  });

  factory ComponentDeclarations(CompilationUnit unit, SourceFile sourceFile, {onError(String message, SourceSpan sourceSpan)}) {
    void error(String message, SourceSpan sourceSpan) {
      if (onError != null) {
        onError(message, sourceSpan);
      }
    }

    Map<String, List<CompilationUnitMember>> declarations = {
      ANNOTATION_FACTORY: <CompilationUnitMember>[],
      ANNOTATION_COMPONENT: <CompilationUnitMember>[],
      ANNOTATION_PROPS: <CompilationUnitMember>[],
      ANNOTATION_STATE: <CompilationUnitMember>[],
      ANNOTATION_ABSTRACT_COMPONENT: <CompilationUnitMember>[],
      ANNOTATION_ABSTRACT_PROPS: <CompilationUnitMember>[],
      ANNOTATION_ABSTRACT_STATE: <CompilationUnitMember>[],
      ANNOTATION_PROPS_MIXIN: <CompilationUnitMember>[],
      ANNOTATION_STATE_MIXIN: <CompilationUnitMember>[],
    };

    unit.declarations.forEach((CompilationUnitMember member) {
      member.metadata.forEach((annotation) {
        var name = annotation.name.toString();

        declarations[name]?.add(member);
      });
    });

    //todo type check builder factory

    List classesOnly(String annotationName, Iterable<CompilationUnitMember> declarations) {
      var classDeclarations = [];

      declarations.forEach((declaration) {
        if (declaration is ClassDeclaration) {
          classDeclarations.add(declaration);
        } else {
          error(
              '@`$annotationName` should only be used on classes, but was used on ${declaration}. ',
              sourceFile.location(declaration.offset).pointSpan()
          );
        }
      });

      return classDeclarations;
    };

    [
      ANNOTATION_COMPONENT,
      ANNOTATION_PROPS,
      ANNOTATION_STATE,
      ANNOTATION_ABSTRACT_COMPONENT,
      ANNOTATION_ABSTRACT_PROPS,
      ANNOTATION_ABSTRACT_STATE,
      ANNOTATION_PROPS_MIXIN,
      ANNOTATION_STATE_MIXIN,
    ].forEach((annotationName) {
      declarations[annotationName] = classesOnly(annotationName, declarations[annotationName]);
    });


    var componentAnnotations = [
      ANNOTATION_FACTORY,
      ANNOTATION_COMPONENT,
      ANNOTATION_PROPS,
      ANNOTATION_STATE,
    ];

    var abstractComponentDeclarations = [
      ANNOTATION_ABSTRACT_COMPONENT,
      ANNOTATION_ABSTRACT_PROPS,
      ANNOTATION_ABSTRACT_STATE,
    ];

    var hasComponent = componentAnnotations
        .any((annotationName) => declarations[annotationName].isNotEmpty);

    var hasAbstractComponent = abstractComponentDeclarations
        .any((annotationName) => declarations[annotationName].isNotEmpty);

    if (hasComponent && hasAbstractComponent) {
      componentAnnotations
          .forEach((annotationName) => declarations[annotationName] = []);

      abstractComponentDeclarations
          .forEach((annotationName) => declarations[annotationName] = []);
    }

    List limitDeclarations(String annotationName, Iterable<CompilationUnitMember> declarations) {
      if (declarations.length > 1) {
        declarations.forEach((declaration) {
          error(
            'There can only be one `@$annotationName` usage per file. ',
            sourceFile.location(declaration.offset).pointSpan()
          );
        });

        return [];
      }

      return declarations;
    };

    [
      ANNOTATION_FACTORY,
      ANNOTATION_COMPONENT,
      ANNOTATION_PROPS,
      ANNOTATION_STATE,
      ANNOTATION_ABSTRACT_COMPONENT,
      ANNOTATION_ABSTRACT_PROPS,
      ANNOTATION_ABSTRACT_STATE,
    ].forEach((annotationName) {
      declarations[annotationName] = limitDeclarations(annotationName, declarations[annotationName]);
    });

    if (declarations[ANNOTATION_FACTORY].isEmpty) {
      [
        ANNOTATION_COMPONENT,
        ANNOTATION_PROPS,
        ANNOTATION_STATE,
      ].forEach((annotationName) {
        if (declarations[annotationName].isNotEmpty) {
          error(
              '`@$annotationName` was used without valid `@$ANNOTATION_FACTORY`.',
              sourceFile.location(declarations[annotationName].first.offset).pointSpan()
          );

          declarations[annotationName] = [];
        }
      });
    } else {
      var builderFactory = declarations[ANNOTATION_FACTORY].single;
      if (builderFactory.variables.variables.length != 1 ||
          builderFactory.variables.variables.single.initializer != null) {
        onError(
            '`@$ANNOTATION_FACTORY` should only be used on a single unitialized variable.',
            sourceFile.location(builderFactory.offset).pointSpan()
        );
        declarations[ANNOTATION_FACTORY] = [];
      }
    }

    return new ComponentDeclarations._(
        factory: singleOrNull(declarations[ANNOTATION_FACTORY]),
        componentClass: singleOrNull(declarations[ANNOTATION_COMPONENT]),
        props: singleOrNull(declarations[ANNOTATION_PROPS]),
        state: singleOrNull(declarations[ANNOTATION_STATE]),

        abstractComponentClass: singleOrNull(declarations[ANNOTATION_ABSTRACT_COMPONENT]),
        abstractProps: singleOrNull(declarations[ANNOTATION_ABSTRACT_PROPS]),
        abstractState: singleOrNull(declarations[ANNOTATION_ABSTRACT_STATE]),

        propsMixins: declarations[ANNOTATION_PROPS_MIXIN],
        stateMixins: declarations[ANNOTATION_STATE_MIXIN]
    );
  }

  static singleOrNull(List list) => list.isNotEmpty ? list.single : null;
}
