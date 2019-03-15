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
    bool hasPropsCompanionClass = false;
    bool hasAbstractPropsCompanionClass = false;
    bool hasStateCompanionClass = false;
    bool hasAbstractStateCompanionClass = false;

    void error(String message, [SourceSpan span]) {
      hasErrors = true;
      logger.severe(messageWithSpan(message, span: span));
    }

    /// If a [ClassMember] exists in [node] with the name `meta`, this will
    /// throw an error if the member is not static and a warning if the member
    /// is static.
    void checkForMetaPresence(ClassDeclaration node) {
      final metaField = metaFieldOrNull(node);
      final metaMethod = metaMethodOrNull(node);
      final isNotNull = metaField != null || metaMethod != null;
      final isStatic = (metaField?.isStatic ?? false) || (metaMethod?.isStatic ?? false);
      if (isNotNull) {
        // If a class declares a field or method with the name of `meta` which is
        // not static, then we should error, since the static `meta` const in the
        // generated implementation will have a naming collision.
        if (!isStatic) {
          error('Non-static class member `meta` is declared in ${node.name.name}. '
              '`meta` is a field declared by the over_react builder, and is therefore not '
              'valid for use as a class member in any class annotated with  @Props(), @State(), '
              '@AbstractProps(), @AbstractState(), @PropsMixin(), or @StateMixin()',
              getSpan(sourceFile, metaField ?? metaMethod));
        } else {
          // warn that static `meta` definition will not be accessible by consumers.
          logger.warning(messageWithSpan('Static class member `meta` is declared in ${node.name.name}. '
              '`meta` is a field declared by the over_react builder, and therefore this '
              'class member will be unused and should be removed or renamed.',
              span: getSpan(sourceFile, metaField ?? metaMethod)));
        }
      }
    }

    /// Validates that `meta` field in a companion class or props/state mixin
    /// is formatted as expected.
    ///
    /// Meta fields should have the following format:
    ///   `static const {Props|State}Meta meta = _$metaFor{className};`
    ///
    /// [cd] should be either a [ClassDeclaration] instance for the companion
    /// class of a props/state/abstract props/abstract state class, or the
    /// [ClassDeclaration] for a props or state mixin class.
    void validateMetaField(ClassDeclaration cd, String expectedType) {
      final metaField = getMetaField(cd);
      if (metaField == null) return;

      if (metaField.fields.type?.toSource() != expectedType) {
        error(
          'Static meta field in accessor class must be of type `$expectedType`',
          getSpan(sourceFile, metaField),
        );
      }

      final expectedInitializer = '${privateSourcePrefix}metaFor${cd.name.name}';

      final initializer = metaField.fields.variables.single.initializer
          ?.toSource();
      if (!(expectedInitializer == initializer)) {
        error(
          'Static $expectedType field in accessor class must be initialized to:'
              '`$expectedInitializer`',
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

    void updateCompanionClass(String annotation, bool value) {
      switch (annotation) {
        case 'Props':
          hasPropsCompanionClass = value;
          break;
        case 'AbstractProps':
          hasAbstractPropsCompanionClass = value;
          break;
        case 'State':
          hasStateCompanionClass = value;
          break;
        case 'AbstractState':
          hasAbstractStateCompanionClass = value;
          break;
      }
    }

    bool isPropsClass(String annotation) {
      return (annotation == 'Props' || annotation == 'AbstractProps');
    }

    bool isStateClass(String annotation) {
      return (annotation == 'State' || annotation == 'AbstractState');
    }

    unit.declarations.forEach((CompilationUnitMember _member) {
      _member.metadata.forEach((_annotation) {
        final annotation = _annotation.name.toString();

        // Add to declarationMap if we have a valid over_react annotation
        if (declarationMap[annotation] != null) {
          hasDeclarations = true;
          declarationMap[annotation].add(_member);
        }

        // Now we need to check for a companion class on Dart 2 backwards compatible boilerplate
        // only check for companion class for @Props(), @State, @AbstractProps(),
        // and @AbstractState() annotated classes
        if (_member is! ClassDeclaration || !(isPropsClass(annotation) || isStateClass(annotation))) {
          return;
        }

        final ClassDeclaration member = _member;

        // Check that class name starts with [privateSourcePrefix]
        if (!member.name.name.startsWith(privateSourcePrefix)) {
          error('The class `${member.name.name}` does not start with `$privateSourcePrefix`. All Props, State, '
              'AbstractProps, and AbstractState classes should begin with `$privateSourcePrefix` on Dart 2',
              getSpan(sourceFile, member));
          return;
        }

        final companionName = member.name.name.substring(privateSourcePrefix.length);
        final companionClass = unit.declarations.firstWhere(
                (innerMember) =>
            innerMember is ClassDeclaration && innerMember.name.name == companionName,
            orElse: () => null);

        final hasCompanionClass = companionClass != null;
        if (hasCompanionClass) {
          // Backwards compatible boilerplate. Verify the companion class' meta field
          updateCompanionClass(annotation, true);
          validateMetaField(companionClass, isPropsClass(annotation) ? 'PropsMeta': 'StateMeta');
        } else {
          // Dart 2 only boilerplate. Check for meta presence
          checkForMetaPresence(member);
          updateCompanionClass(annotation, false);
        }
      });
    });

    // Validate the types of the annotated declarations.

    List<TopLevelVariableDeclaration> topLevelVarsOnly(String annotationName, Iterable<CompilationUnitMember> declarations) {
      final topLevelVarDeclarations = <TopLevelVariableDeclaration>[];

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
      final classDeclarations = <ClassDeclaration>[];

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
          final declarations = declarationMap[annotationName];
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
        final declarations = declarationMap[annotationName];

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
      void checkMetaForMixin(ClassDeclaration mixin, String metaStructName) {
        final className = mixin.name.name;
        // If the mixin starts with `_$`, then we are on Dart 2 only boilerplate,
        // and the mixin should not have a meta field/method
        if (className.startsWith(privateSourcePrefix)) {
          checkForMetaPresence(mixin);
        } else {
          // If the mixin does start not start with `_$`, then we are on the transitional
          // boilerplate and we need to validate the meta field.
          validateMetaField(mixin, metaStructName);
        }
      }
      for (final propsMixin in declarationMap[key_propsMixin]) {
        checkMetaForMixin(propsMixin, 'PropsMeta');
      }

      for (final stateMixin in declarationMap[key_stateMixin]) {
        checkMetaForMixin(stateMixin, 'StateMeta');
      }
    }

    // validate that the factory is initialized correctly
    final factory = declarationMap[key_factory].length <= 1 ? singleOrNull(declarationMap[key_factory]) : null;
    if (factory != null && factory is TopLevelVariableDeclaration) {
      final String factoryName = factory.variables.variables.first.name.name;

      if (factory.variables.variables.length != 1) {
        error('Factory declarations must be a single variable.',
            getSpan(sourceFile, factory.variables));
      } else {
        final variable = factory.variables.variables.first;
        final expectedInitializer = '$privateSourcePrefix$factoryName';

        if ((variable?.initializer?.toString() ?? '') != expectedInitializer) {
          error(
              'Factory variables are stubs for the generated factories, and should '
                  'be initialized with the valid variable name for builder compatibility. '
                  'Should be: $expectedInitializer',
              getSpan(sourceFile, variable.initializer ?? variable)
          );
        }
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
        hasPropsCompanionClass: hasPropsCompanionClass,
        hasAbstractPropsCompanionClass: hasAbstractPropsCompanionClass,
        hasStateCompanionClass: hasStateCompanionClass,
        hasAbstractStateCompanionClass: hasAbstractStateCompanionClass,
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

      bool hasPropsCompanionClass,
      bool hasAbstractPropsCompanionClass,
      bool hasStateCompanionClass,
      bool hasAbstractStateCompanionClass,
  }) :
      this.factory       = (factory   == null) ? null : new FactoryNode(factory),
      this.component     = (component == null) ? null : new ComponentNode(component),
      this.props         = (props     == null) ? null : new PropsNode(props, hasPropsCompanionClass),
      this.state         = (state     == null) ? null : new StateNode(state, hasStateCompanionClass),

      this.abstractProps = new List.unmodifiable(abstractProps.map((props) => new AbstractPropsNode(props, hasAbstractPropsCompanionClass))),
      this.abstractState = new List.unmodifiable(abstractState.map((state) => new AbstractStateNode(state, hasAbstractStateCompanionClass))),

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

  /// Whether the component extends from Component2.
  final bool isComponent2;

  /// The value of the `subtypeOf` parameter passed in to this node's annotation.
  Identifier subtypeOfValue;

  ComponentNode(ClassDeclaration node)
      : this.isComponent2 = node.declaredElement == null
            // This can be null when using non-resolved AST in tests; FIXME 3.0.0-wip do we need to update that setup?
            ? false
            // TODO 3.0.0-wip is there a better way to check against react's Component2?
            : node.declaredElement.allSupertypes.any((type) {
              return type.name == 'Component2';
            }),
        super(node) {
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

class PropsOrStateNode<T> extends NodeWithMeta<ClassDeclaration, T> {
  final bool hasCompanionClass;
  PropsOrStateNode(unit, this.hasCompanionClass): super(unit);
}
class PropsNode extends PropsOrStateNode<annotations.Props> {
  PropsNode(unit, hasCompanionClass): super(unit, hasCompanionClass);
}
class StateNode extends PropsOrStateNode<annotations.State> {
  StateNode(unit, hasCompanionClass): super(unit, hasCompanionClass);
}

class AbstractPropsNode extends PropsOrStateNode<annotations.AbstractProps> {
  AbstractPropsNode(unit, hasCompanionClass): super(unit, hasCompanionClass);
}
class AbstractStateNode extends PropsOrStateNode<annotations.AbstractState> {
  AbstractStateNode(unit, hasCompanionClass): super(unit, hasCompanionClass);
}

class PropsMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.PropsMixin>         {PropsMixinNode(unit)        : super(unit);}
class StateMixinNode        extends NodeWithMeta<ClassDeclaration, annotations.StateMixin>         {StateMixinNode(unit)        : super(unit);}

