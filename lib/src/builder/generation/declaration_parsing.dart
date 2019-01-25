// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart' show getSpan, NodeWithMeta;

enum PropsClassType {
  standard,
  abstract,
  mixin,
  none,
}

/// A set of [NodeWithMeta] component pieces declared using `over_react` builder annotations.
///
/// Can include:
///
/// * A single component declared using a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
/// * Any number of abstract component pieces: `@AbstractComponent()`, `@AbstractProps()`, `@AbstractState()`
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`
class ParsedDeclarations {
  factory ParsedDeclarations(CompilationUnit unit, SourceFile sourceFile, Logger logger) {
    bool hasErrors = false;
    bool hasDeclarations = false;

    void error(String message, [SourceSpan span]) {
      hasErrors = true;
      logger.severe(messageWithSpan(message, span: span));
    }

    void validateMetaField(ClassDeclaration cd, String expectedType) {
        final metaField = getMetaField(cd);
        if (metaField == null) return;

        if (metaField.fields.type?.toSource() != expectedType) {
          error(
              'Static meta field in accessor class must be of type `$expectedType`',
              getSpan(sourceFile, metaField),
          );
        }
        final isClassPrivate = cd.name.name.startsWith('_');
        var expectedInitializers = ['\$metaFor${cd.name.name}', '_\$metaFor${cd.name.name}'];
        if (isClassPrivate) {
          expectedInitializers.add('_\$metaFor${cd.name.name.substring(1)}');
        }

        final initializer = metaField.fields.variables.single.initializer?.toSource();
        if (!expectedInitializers.contains(initializer)) {
          error(
              'Static $expectedType field in accessor class must be initialized to:'
              // The second in the list of expected initializers is the one it will need to be once on Dart 2
              '`${expectedInitializers[1]}`',
              getSpan(sourceFile, metaField),
          );
        }
      }


    // Collect the annotated declarations.

    Map<String, List<CompilationUnitMember>> declarationMap = {
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

    var companionPrefix = r'_$';
    unit.declarations.forEach((CompilationUnitMember member) {
      member.metadata.forEach((annotation) {
        var name = annotation.name.toString();
        bool isPropsClass(String annotation) {
          return (name == 'Props' || name == 'AbstractProps');
        }

        bool isStateClass(String annotation) {
          return (name == 'State' || name == 'AbstractState');
        }

        if ((isPropsClass(name) || isStateClass(name)) && member is ClassDeclaration) {
          if (member.name.name.startsWith(companionPrefix)) {
            final companionName = member.name.name.substring(companionPrefix.length);
            final privateCompanionName = '_$companionName';
            final privateCompanionClass = unit.declarations.firstWhere(
                    (innerMember) =>
                innerMember is ClassDeclaration && innerMember.name.name == privateCompanionName,
                orElse: () => null);
            final publicCompanionClass = unit.declarations.firstWhere(
                    (innerMember) =>
                innerMember is ClassDeclaration && innerMember.name.name == companionName,
                orElse: () => null);

            if (privateCompanionClass == null && publicCompanionClass == null) {
              error('${member.name.name} must have an accompanying companion class within the '
                  'same file for Dart 2 builder compatibility, but one was not found.', getSpan(sourceFile, member));
            } else {
              if (privateCompanionClass != null) {
                validateMetaField(privateCompanionClass, isPropsClass(name) ? 'PropsMeta': 'StateMeta');
              } else {
                validateMetaField(publicCompanionClass, isPropsClass(name) ? 'PropsMeta': 'StateMeta');
              }
            }
          } else {
            // Props or state class has the incorrect naming (should start with [companionPrefix]
            error('The class `${member.name.name}` does not start with $companionPrefix. All Props, State, '
                'AbstractProps, and AbstractState classes should begin with $companionPrefix under Dart 2',
              getSpan(sourceFile, member));
          }
        }

        if (declarationMap[name] != null) {
          hasDeclarations = true;
          declarationMap[name]?.add(member);
        }
      });
    });

    // Validate the types of the annotated declarations.

    List<TopLevelVariableDeclaration> topLevelVarsOnly(String annotationName, Iterable<CompilationUnitMember> declarations) {
      var topLevelVarDeclarations = <TopLevelVariableDeclaration>[];

      declarations.forEach((declaration) {
        if (declaration is TopLevelVariableDeclaration) {
          topLevelVarDeclarations.add(declaration);
        } else {
          error(
              '`@$annotationName` can only be used on top-level variable declarations.',
              getSpan(sourceFile, declaration)
          );
        }
      });

      return topLevelVarDeclarations;
    };

    List<ClassDeclaration> classesOnly(String annotationName, Iterable<CompilationUnitMember> declarations) {
      var classDeclarations = <ClassDeclaration>[];

      declarations.forEach((declaration) {
        if (declaration is ClassDeclaration) {
          classDeclarations.add(declaration);
        } else {
          error(
              '`@$annotationName` can only be used on classes.',
              getSpan(sourceFile, declaration)
          );
        }
      });

      return classDeclarations;
    };

    declarationMap[key_factory] = topLevelVarsOnly(key_factory, declarationMap[key_factory]);

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
      declarationMap[annotationName] = classesOnly(annotationName, declarationMap[annotationName]);
    });

    // Validate that all the declarations that make up a component are used correctly.

    Iterable<List<CompilationUnitMember>> requiredDecls =
        key_allComponentRequired.map((annotationName) => declarationMap[annotationName]);

    Iterable<List<CompilationUnitMember>> optionalDecls =
        key_allComponentOptional.map((annotationName) => declarationMap[annotationName]);

    bool oneOfEachRequiredDecl = requiredDecls.every((decls) => decls.length == 1);
    bool noneOfAnyRequiredDecl = requiredDecls.every((decls) => decls.length == 0);

    bool atMostOneOfEachOptionalDecl = optionalDecls.every((decls) => decls.length <= 1);
    bool noneOfAnyOptionalDecl       = optionalDecls.every((decls) => decls.length == 0);

    bool areDeclarationsValid = (
        (oneOfEachRequiredDecl && atMostOneOfEachOptionalDecl) ||
        (noneOfAnyRequiredDecl && noneOfAnyOptionalDecl)
    );

    // Give the consumer some useful errors if the declarations aren't valid.

    if (!areDeclarationsValid) {
      if (!noneOfAnyRequiredDecl) {
        key_allComponentRequired.forEach((annotationName) {
          var declarations = declarationMap[annotationName];
          if (declarations.length == 0) {
            error(
                'To define a component, there must also be a `@$annotationName` within the same file, '
                'but none were found.'
            );
          } else if (declarations.length > 1) {
            for (int i = 0; i < declarations.length; i++) {
              error(
                  'To define a component, there must be a single `@$annotationName` per file, '
                  'but ${declarations.length} were found. (${i + 1} of ${declarations.length})',
                  getSpan(sourceFile, declarations[i])
              );
            }
          }
          declarationMap[annotationName] = [];
        });
      }

      key_allComponentOptional.forEach((annotationName) {
        var declarations = declarationMap[annotationName];

        if (declarations.length > 1) {
          for (int i = 0; i < declarations.length; i++) {
            error(
                'To define a component, there must not be more than one `@$annotationName` per file, '
                'but ${declarations.length} were found. (${i + 1} of ${declarations.length})',
                getSpan(sourceFile, declarations[i])
            );
          }
        }

        if (noneOfAnyRequiredDecl && declarations.isNotEmpty) {
          error(
              'To define a component, a `@$annotationName` must be accompanied by '
              'the following annotations within the same file: '
              '${key_allComponentRequired.map((key) => '@$key').join(', ')}.',
              getSpan(sourceFile, declarations.first)
          );
        }
        declarationMap[annotationName] = [];
      });
    } else {
      for (final propsMixin in declarationMap[key_propsMixin]) {
        validateMetaField(propsMixin, 'PropsMeta');
      }

      for (final stateMixin in declarationMap[key_stateMixin]) {
        validateMetaField(stateMixin, 'StateMeta');
      }
    }

    // validate that the factory is initialized correctly
    final factory = declarationMap[key_factory].length <= 1 ? singleOrNull(declarationMap[key_factory]) : null;
    if (factory != null && factory is TopLevelVariableDeclaration) {
      final String factoryName = factory.variables.variables.first.name.name;

      if (factory.variables.variables.length != 1) {
        error('Factory declarations must be a single variable.',
            getSpan(sourceFile, factory.variables));
      }

      final variable = factory.variables.variables.first;
      final isPrivate = factoryName.startsWith('_');
      var expectedInitializers = ['\$$factoryName', '_\$$factoryName'];

      if (isPrivate) {
        expectedInitializers.add('_\$${factoryName.substring(1)}');
      }

      if (variable.initializer != null &&
          !expectedInitializers.contains(variable.initializer.toString())) {
        error(
            'Factory variables are stubs for the generated factories, and should not have initializers '
                'unless initialized with a valid variable name for Dart 2 builder compatibility. '
                // The second in the list of expected initializers is the one it will need to be once on Dart 2
                'Should be:\n    ${expectedInitializers[1]}',
            getSpan(sourceFile, variable.initializer)
        );
      }
    }

    if (hasErrors) {
      for (final key in declarationMap.keys) {
        declarationMap[key] = [];
      }
    }

    return new ParsedDeclarations._(
        factory:       singleOrNull(declarationMap[key_factory]),
        component:     singleOrNull(declarationMap[key_component]),
        props:         singleOrNull(declarationMap[key_props]),
        state:         singleOrNull(declarationMap[key_state]),

        abstractProps: declarationMap[key_abstractProps].isNotEmpty ? declarationMap[key_abstractProps] : <ClassDeclaration>[],
        abstractState: declarationMap[key_abstractState].isNotEmpty ? declarationMap[key_abstractState] : <ClassDeclaration>[],

        propsMixins:   declarationMap[key_propsMixin].isNotEmpty ? declarationMap[key_propsMixin] : <ClassDeclaration>[],
        stateMixins:   declarationMap[key_stateMixin].isNotEmpty ? declarationMap[key_stateMixin] : <ClassDeclaration>[],

        hasErrors: hasErrors,
        hasDeclarations: hasDeclarations,
    );
  }

  ParsedDeclarations._({
      TopLevelVariableDeclaration factory,
      ClassDeclaration component,
      ClassDeclaration props,
      ClassDeclaration state,

      List<ClassDeclaration> abstractProps,
      List<ClassDeclaration> abstractState,

      List<ClassDeclaration> propsMixins,
      List<ClassDeclaration> stateMixins,

      this.hasErrors,
      this.hasDeclarations,
  }) :
      this.factory       = (factory   == null) ? null : new FactoryNode(factory),
      this.component     = (component == null) ? null : new ComponentNode(component),
      this.props         = (props     == null) ? null : new PropsNode(props),
      this.state         = (state     == null) ? null : new StateNode(state),

      this.abstractProps = new List.unmodifiable(abstractProps.map((propsMixin) => new AbstractPropsNode(propsMixin))),
      this.abstractState = new List.unmodifiable(abstractState.map((stateMixin) => new AbstractStateNode(stateMixin))),

      this.propsMixins   = new List.unmodifiable(propsMixins.map((propsMixin) => new PropsMixinNode(propsMixin))),
      this.stateMixins   = new List.unmodifiable(stateMixins.map((stateMixin) => new StateMixinNode(stateMixin))),

      this.declaresComponent = factory != null
  {
    assert(
        ((this.factory == null && this.component == null && this.props == null) ||
         (this.factory != null && this.component != null && this.props != null)) &&
        '`factory`, `component`, and `props` must be either all null or all non-null. '
        'Any other combination represents an invalid component declaration. ' is String
    );
  }



  static final String key_factory           = getName(annotations.Factory);
  static final String key_component         = getName(annotations.Component);
  static final String key_props             = getName(annotations.Props);
  static final String key_state             = getName(annotations.State);

  static final String key_abstractComponent = getName(annotations.AbstractComponent);
  static final String key_abstractProps     = getName(annotations.AbstractProps);
  static final String key_abstractState     = getName(annotations.AbstractState);

  static final String key_propsMixin        = getName(annotations.PropsMixin);
  static final String key_stateMixin        = getName(annotations.StateMixin);

  static final String key_exportGeneratedAccessors = getName(annotations.ExportGeneratedAccessors);

  static final List<String> key_allComponentRequired = new List.unmodifiable([
    key_factory,
    key_component,
    key_props,
  ]);

  static final List<String> key_allComponentOptional = new List.unmodifiable([
    key_state,
  ]);

  static  final RegExp key_any_annotation = new RegExp(
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
    return key_any_annotation.hasMatch(source);
  }

  final FactoryNode factory;
  final ComponentNode component;
  final PropsNode props;
  final StateNode state;

  final List<AbstractPropsNode> abstractProps;
  final List<AbstractStateNode> abstractState;

  final List<PropsMixinNode> propsMixins;
  final List<StateMixinNode> stateMixins;

  final bool hasErrors;
  final bool hasDeclarations;
  final bool declaresComponent;

  /// Helper function that returns the single value of a [list], or null if it is empty.
  static dynamic singleOrNull(List list) => list.isNotEmpty ? list.single : null;
}

// Generic type aliases, for readability.

class ComponentNode extends NodeWithMeta<ClassDeclaration, annotations.Component> {
  static const String _subtypeOfParamName = 'subtypeOf';

  /// The value of the `subtypeOf` parameter passed in to this node's annotation.
  Identifier subtypeOfValue;

  ComponentNode(unit) : super(unit) {
    // Perform special handling for the `subtypeOf` parameter of this node's annotation.
    //
    // If valid, omit it from `unsupportedArguments` so that the `meta` can be accessed without it
    // (with the value available via `subtypeOfValue`), given that all other arguments are valid.

    NamedExpression subtypeOfParam = this.unsupportedArguments.firstWhere((expression) {
      return expression is NamedExpression && expression.name.label.name == _subtypeOfParamName;
    }, orElse: () => null);

    if (subtypeOfParam != null) {
      if (subtypeOfParam.expression is! Identifier) {
        throw '`$_subtypeOfParamName` must be an identifier: $subtypeOfParam';
      }

      this.subtypeOfValue = subtypeOfParam.expression;
      this.unsupportedArguments.remove(subtypeOfParam);
    }
  }
}

class FactoryNode           extends NodeWithMeta<TopLevelVariableDeclaration, annotations.Factory> {FactoryNode(unit)           : super(unit);}
class PropsNode             extends NodeWithMeta<ClassDeclaration, annotations.Props>              {PropsNode(unit)             : super(unit);}
class StateNode             extends NodeWithMeta<ClassDeclaration, annotations.State>              {StateNode(unit)             : super(unit);}

class AbstractPropsNode     extends NodeWithMeta<ClassDeclaration, annotations.AbstractProps>      {AbstractPropsNode(unit)     : super(unit);}
class AbstractStateNode     extends NodeWithMeta<ClassDeclaration, annotations.AbstractState>      {AbstractStateNode(unit)     : super(unit);}

class PropsMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.PropsMixin>         {PropsMixinNode(unit)        : super(unit);}
class StateMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.StateMixin>         {StateMixinNode(unit)        : super(unit);}

