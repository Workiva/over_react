library web_skin_dart.transformer.declaration_parsing;

import 'dart:mirrors';

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/ui_core/transformer_generation/annotations.dart' as annotations;

import './analyzer_helpers.dart';

class ComponentDeclarations {
  static String _getName(Type type) {
    return MirrorSystem.getName(reflectType(type).simpleName);
  }

  static final String key_factory           = _getName(annotations.Factory);
  static final String key_component         = _getName(annotations.Component);
  static final String key_props             = _getName(annotations.Props);
  static final String key_state             = _getName(annotations.State);

  static final String key_abstractComponent = _getName(annotations.AbstractComponent);
  static final String key_abstractProps     = _getName(annotations.AbstractProps);
  static final String key_abstractState     = _getName(annotations.AbstractState);

  static final String key_propsMixin        = _getName(annotations.PropsMixin);
  static final String key_stateMixin        = _getName(annotations.StateMixin);

  static final List<String> key_allComponent = new List.unmodifiable([
    key_factory,
    key_component,
    key_props,
    key_state,
  ]);

  static final List<String> key_allAbstractComponent = new List.unmodifiable([
    key_abstractComponent,
    key_abstractProps,
    key_abstractState,
  ]);

 static  final RegExp key_any = new RegExp(
      r'@(?:' +
      [
        key_factory,
        key_component,
        key_props,
        key_state,
        key_abstractComponent,
        key_abstractProps,
        key_abstractState,
        key_propsMixin,
        key_stateMixin,
      ].join('|').replaceAll(r'$', r'\$') +
      r')',
      caseSensitive: true
  );

  static bool mightContainDeclarations(String source) {
    return key_any.hasMatch(source);
  }

  final FactoryNode factory;
  final ComponentNode component;
  final PropsNode props;
  final StateNode state;

  final AbstractComponentNode abstractComponent;
  final AbstractPropsNode abstractProps;
  final AbstractStateNode abstractState;

  final List<PropsMixinNode> propsMixins;
  final List<StateMixinNode> stateMixins;


  ComponentDeclarations._({
      TopLevelVariableDeclaration factory,
      ClassDeclaration component,
      ClassDeclaration props,
      ClassDeclaration state,

      ClassDeclaration abstractComponent,
      ClassDeclaration abstractProps,
      ClassDeclaration abstractState,

      List<ClassDeclaration> propsMixins,
      List<ClassDeclaration> stateMixins
  }) :
      this.factory           = (factory           == null) ? null : new FactoryNode(factory),
      this.component         = (component         == null) ? null : new ComponentNode(component),
      this.props             = (props             == null) ? null : new PropsNode(props),
      this.state             = (state             == null) ? null : new StateNode(state),

      this.abstractComponent = (abstractComponent == null) ? null : new AbstractComponentNode(abstractComponent),
      this.abstractProps     = (abstractProps     == null) ? null : new AbstractPropsNode(abstractProps),
      this.abstractState     = (abstractState     == null) ? null : new AbstractStateNode(abstractState),

      this.propsMixins = propsMixins.map((propsMixin) => new PropsMixinNode(propsMixin)).toList(),
      this.stateMixins = stateMixins.map((stateMixin) => new StateMixinNode(stateMixin)).toList();


  factory ComponentDeclarations(CompilationUnit unit, SourceFile sourceFile, {onError(String message, SourceSpan sourceSpan)}) {
    void error(String message, SourceSpan sourceSpan) {
      if (onError != null) {
        onError(message, sourceSpan);
      }
    }

    Map<String, List<CompilationUnitMember>> declarations = {
      key_factory:           <CompilationUnitMember>[],
      key_component:         <CompilationUnitMember>[],
      key_props:             <CompilationUnitMember>[],
      key_state:             <CompilationUnitMember>[],
      key_abstractComponent: <CompilationUnitMember>[],
      key_abstractProps:     <CompilationUnitMember>[],
      key_abstractState:     <CompilationUnitMember>[],
      key_propsMixin:        <CompilationUnitMember>[],
      key_stateMixin:        <CompilationUnitMember>[],
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
      key_component,
      key_props,
      key_state,
      key_abstractComponent,
      key_abstractProps,
      key_abstractState,
      key_propsMixin,
      key_stateMixin,
    ].forEach((annotationName) {
      declarations[annotationName] = classesOnly(annotationName, declarations[annotationName]);
    });

    var hasComponent = key_allComponent
        .any((annotationName) => declarations[annotationName].isNotEmpty);

    var hasAbstractComponent = key_allAbstractComponent
        .any((annotationName) => declarations[annotationName].isNotEmpty);

    if (hasComponent && hasAbstractComponent) {
      key_allComponent
          .forEach((annotationName) => declarations[annotationName] = []);

      key_allAbstractComponent
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
      key_factory,
      key_component,
      key_props,
      key_state,
      key_abstractComponent,
      key_abstractProps,
      key_abstractState,
    ].forEach((annotationName) {
      declarations[annotationName] = limitDeclarations(annotationName, declarations[annotationName]);
    });

    if (declarations[key_factory].isEmpty) {
      [
        key_component,
        key_props,
        key_state,
      ].forEach((annotationName) {
        if (declarations[annotationName].isNotEmpty) {
          error(
              '`@$annotationName` was used without valid `@$key_factory`.',
              sourceFile.location(declarations[annotationName].first.offset).pointSpan()
          );

          declarations[annotationName] = [];
        }
      });
    } else {
      var builderFactory = declarations[key_factory].single;
      if (builderFactory.variables.variables.length != 1 ||
          builderFactory.variables.variables.single.initializer != null) {
        onError(
            '`@$key_factory` should only be used on a single unitialized variable.',
            sourceFile.location(builderFactory.offset).pointSpan()
        );
        declarations[key_factory] = [];
      }
    }

    if (declarations[key_component].isEmpty) {
      [
        key_factory,
        key_props,
        key_state,
      ].forEach((annotationName) {
        if (declarations[annotationName].isNotEmpty) {
          error(
              '`@$annotationName` was used without valid `@$key_component`.',
              sourceFile.location(declarations[annotationName].first.offset).pointSpan()
          );

          declarations[annotationName] = [];
        }
      });
    }

    return new ComponentDeclarations._(
        factory:           singleOrNull(declarations[key_factory]),
        component:         singleOrNull(declarations[key_component]),
        props:             singleOrNull(declarations[key_props]),
        state:             singleOrNull(declarations[key_state]),

        abstractComponent: singleOrNull(declarations[key_abstractComponent]),
        abstractProps:     singleOrNull(declarations[key_abstractProps]),
        abstractState:     singleOrNull(declarations[key_abstractState]),

        propsMixins: declarations[key_propsMixin],
        stateMixins: declarations[key_stateMixin]
    );
  }

  /// Helper function that returns the single value of a [list], or null if it is empty.
  static dynamic singleOrNull(List list) => list.isNotEmpty ? list.single : null;
}

// Generic type aliases, for readability.
class FactoryNode           extends NodeWithMeta<TopLevelVariableDeclaration, annotations.Factory> {FactoryNode(unit)           : super(unit);}
class ComponentNode         extends NodeWithMeta<ClassDeclaration, annotations.Component>          {ComponentNode(unit)         : super(unit);}
class PropsNode             extends NodeWithMeta<ClassDeclaration, annotations.Props>              {PropsNode(unit)             : super(unit);}
class StateNode             extends NodeWithMeta<ClassDeclaration, annotations.State>              {StateNode(unit)             : super(unit);}

class AbstractComponentNode extends NodeWithMeta<ClassDeclaration, annotations.AbstractComponent>  {AbstractComponentNode(unit) : super(unit);}
class AbstractPropsNode     extends NodeWithMeta<ClassDeclaration, annotations.AbstractProps>      {AbstractPropsNode(unit)     : super(unit);}
class AbstractStateNode     extends NodeWithMeta<ClassDeclaration, annotations.AbstractState>      {AbstractStateNode(unit)     : super(unit);}

class PropsMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.PropsMixin>         {PropsMixinNode(unit)        : super(unit);}
class StateMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.StateMixin>         {StateMixinNode(unit)        : super(unit);}
