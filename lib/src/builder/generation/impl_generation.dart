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

library over_react.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/builder/builder_util.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/transformer/impl_generation.dart';
import 'package:over_react/src/transformer/text_util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/src/text_util.dart' show stringLiteral;
import 'package:transformer_utils/src/transformed_source_file.dart' show getSpan;
import 'package:transformer_utils/transformer_utils.dart';

/// A utility class that modifies a [TransformedSourceFile] by generating implementations for a set of [ParsedDeclarations].
///
/// Generates implementations for:
///
/// * A component comprised of a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
///
///     * Generates:
///
///          * private subclasses for the component, props, and state classes, implementing stubbed methods.
///          * a private React component factory via a call to `registerComponent`.
///
///     * Wires up all the generated component pieces and exposes them via a function assigned to
///     the previously uninitialized factory function variable.
///
/// * Any number of abstract component pieces: `@AbstractProps()`, `@AbstractState()`
///
///     * Replaces fields with generated getters/setters.
///
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`
///
///     * Replaces fields with generated getters/setters.
class ImplGenerator {
  ImplGenerator(this.logger, this.sourceFile, this.libUriPathToImportAlias, this.ancestorClassNamesToImportAlias, this.importCounter);

  static const String generatedPrefix = r'_$';
  static const String publicGeneratedPrefix = r'$';

  Logger logger;
  TransformedSourceFile transformedFile;
  StringBuffer outputContentsBuffer = new StringBuffer();
  bool shouldFixDdcAbstractAccessors = false;

  Set<String> generatedAccessorMixinClassNames = new Set<String>();
  Map<String, String> libUriPathToImportAlias;
  Map<String, Set<String>>  ancestorClassNamesToImportAlias;
  ImportCounter importCounter;

  SourceFile sourceFile;

  static String getClassNameFromNode(NodeWithMeta classNode) {
    ClassDeclaration classDeclaration = classNode.node;
    return classDeclaration.name.toString();
  }

  static String getComponentFactoryName(String componentClassName) {
    if (componentClassName == null) {
      throw new ArgumentError.notNull(componentClassName);
    }

    return '$publicGeneratedPrefix${componentClassName}Factory';
  }

  static String getAccessorsMixinName(String className) {
    if (className == null) {
      throw new ArgumentError.notNull(className);
    }

    return '$publicGeneratedPrefix${className}AccessorsMixin';
  }

  static String getMetaClassName(String name) {
    if (name == null) {
      throw new ArgumentError.notNull(name);
    }

    return '${publicGeneratedPrefix}metaFor$name';
  }

  List<String> getAncestorPropAccessorsMixinNames(ParsedDeclarations declarations) {
    var ancestorPropNames = new List<String>();
    declarations?.propAncestorCompUnits?.forEach((unit) {
      var accessorsMixinName = getAccessorsMixinName(unit.declaredElement.name);
      var prefix = libUriPathToImportAlias[getLibraryUriPathFromCompilationUnit(unit).replaceAll('.dart', outputExtension)];
      if (prefix == null) {
        ancestorPropNames.add(accessorsMixinName);
      } else {
        ancestorPropNames.add('$prefix.$accessorsMixinName');
      }
    });

    return ancestorPropNames;
  }

  bool hasExportGeneratedAccessorsAnnotation(List<Annotation> appliedAnnotations) {
    var hasExportGeneratedAccessorsAnnotation = false;
    appliedAnnotations.forEach((annotation) {
      if (annotation.name.toString().compareTo(getName(annotations.PropsMixin)) == 0) {
        hasExportGeneratedAccessorsAnnotation = true;
      }
    });
    return hasExportGeneratedAccessorsAnnotation;
  }

  generate(ParsedDeclarations declarations) {
    StringBuffer implementations = new StringBuffer();

    if (declarations.declaresComponent) {
      final String factoryName = declarations.factory.node.variables.variables.first.name.toString();

      final String propsName = declarations.props.node.name.toString();
      final String propsImplName = '$generatedPrefix$propsName';
      final String propsAccessorsMixinName = getAccessorsMixinName(propsName);

      final String componentClassName = declarations.component.node.name
          .toString();
      final String componentClassImplMixinName = '$generatedPrefix${componentClassName}';

      final String componentFactoryName = getComponentFactoryName(componentClassName);

      String typedPropsFactoryImpl = '';
      String typedStateFactoryImpl = '';

      // ----------------------------------------------------------------------
      //   Factory implementation
      // ----------------------------------------------------------------------

      if (declarations.factory.node.variables.variables.length != 1) {
        logger.severe('Factory declarations must a single variable.');
//            span: getSpan(sourceFile, declarations.factory.node.variables));
      }

      /// Factories are stubbed for the generated factories and may only be initialized with the generated factory.
      declarations.factory.node.variables.variables.forEach((variable) {
        if (variable.initializer?.toSource() != '\$$factoryName' && variable.initializer != null) {
          logger.severe(
              'Factories are stubbed for the generated factories and may only be initialized with the generated factory.',
//              span: getSpan(sourceFile, variable.initializer)
          );
        }
      });

      String parentTypeParam = 'null';
      String parentTypeParamComment = '';

      Identifier parentType = declarations.component.subtypeOfValue;
      if (parentType != null) {
        parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

        var parentLibPath = parentType.staticElement.library.source.uri.path.replaceAll('.dart', outputExtension);
        if (!libUriPathToImportAlias.containsKey(parentLibPath)) {
          var importAlias = getLibAlias(importCounter.count++);
          libUriPathToImportAlias[parentLibPath] = importAlias;
        }
        var prefix = libUriPathToImportAlias[parentLibPath];
        String parentClassName = parentType is PrefixedIdentifier ? parentType.identifier.name : parentType.name;
        parentTypeParam = '$prefix.${getComponentFactoryName(parentClassName)}';
      }

      if (parentTypeParam == componentFactoryName) {
        /// It doesn't make sense to have a component subtype itself, and also an error occurs
        /// if a component's factory variable tries to reference itself during its initialization.
        /// Therefore, this is not allowed.
        logger.severe('A component cannot be a subtype of itself.',
//            span: getSpan(sourceFile, declarations.component.metaNode)
        );
      }

      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        // TODO: verify that the component class has a default constructor?
        ..writeln('final $componentFactoryName = registerComponent(() => new $componentClassImplMixinName(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: $componentClassName,')
        ..writeln('    isWrapper: ${declarations.component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)}')
        ..writeln(');')
        ..writeln();

      // ----------------------------------------------------------------------
      //   Props implementation
      // ----------------------------------------------------------------------

      // Generate accessor classes for base class and all ancestor classes

      // TODO: Look into using accessors+meta generation function
      outputContentsBuffer.write(_generateAccessorsClass(AccessorType.props, propsAccessorsMixinName, declarations.props, propsName));
      outputContentsBuffer.write(_generateMetaClass(AccessorType.props, propsName, propsAccessorsMixinName));

      /// _$BasicProps $Basic([Map backingProps]) => new _$BasicProps(backingProps);
      outputContentsBuffer.writeln('$propsImplName \$$factoryName([Map backingProps]) => new $propsImplName(backingProps);');

      final String propKeyNamespace = getAccessorKeyNamespace(
          declarations.props);

      outputContentsBuffer.write(_generateConcretePropsImpl(
          propsName, propsImplName, propsAccessorsMixinName,
          componentFactoryName, propKeyNamespace,
          getAncestorPropAccessorsMixinNames(declarations)
      ));

      // ----------------------------------------------------------------------
      //   State implementation
      // ----------------------------------------------------------------------
      if (declarations.state != null) {
        generateAccessorsMixinAndMetaClasses(AccessorType.state, declarations.state);

        final stateName = getClassNameFromNode(declarations.state);
        final stateImplName = '$generatedPrefix${stateName}Impl';

        /// TODO: Implement state super class mixins
        outputContentsBuffer
          ..writeln('// Concrete state implementation.')
          ..writeln('//')
          ..writeln('// Implements constructor and backing map.')
          ..writeln('class $stateImplName extends $stateName {')
          ..writeln('  /// The backing state map proxied by this class.')
          ..writeln('  @override')
          ..writeln('  final Map state;')
          ..writeln()
          // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
          ..writeln('  $stateImplName(Map backingMap) : this.state = backingMap ?? ({});')
          ..writeln()
          ..writeln('  /// Let [UiState] internals know that this class has been generated.')
          ..writeln('  @override')
          ..writeln('  bool get \$isClassGenerated => true;')
          ..writeln('}')
          ..writeln();
      }

      // ----------------------------------------------------------------------
      //   Component implementation
      // ----------------------------------------------------------------------
      outputContentsBuffer
        ..writeln('// Concrete component implementation mixin.')
        ..writeln('//')
        ..writeln('// Implements typed props/state factories, defaults `consumedPropKeys` to the keys')
        ..writeln('// generated for the associated props class.')
        ..writeln('class $componentClassImplMixinName extends $componentClassName {')
        ..writeln('  @override')
        ..writeln('  $propsImplName typedPropsFactory(Map backingMap) => new $propsImplName(backingMap);')
        ..writeln()
        ..writeln('  /// Let [UiComponent] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The default consumed props, taken from $propsName.')
        ..writeln('  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.')
        ..writeln('  @override')
        ..writeln('  final List<ConsumedProps> \$defaultConsumedProps = '
                        'const [${getMetaClassName(propsName)}];')
        ..writeln('}');


      var implementsTypedPropsStateFactory = declarations.component.node.members.any((member) =>
          member is MethodDeclaration &&
          !member.isStatic &&
          (member.name.name == 'typedPropsFactory' || member.name.name == 'typedStateFactory')
      );

      if (implementsTypedPropsStateFactory) {
        // Can't be an error, because consumers may be implementing typedPropsFactory or typedStateFactory in their components.
        logger.warning(
            'Components should not add their own implementions of typedPropsFactory or typedStateFactory.',
//            span: getSpan(sourceFile, declarations.component.node)
        );
      }
    }

    // ----------------------------------------------------------------------
    //   Props/State Mixins implementations
    // ----------------------------------------------------------------------
    bool hasAbstractGetter(ClassDeclaration classDeclaration, String type, String name) {
      return classDeclaration.members.any((member) {
        return (
            member is MethodDeclaration &&
            member.isGetter &&
            !member.isSynthetic &&
            member.isAbstract &&
            member.name.name == name &&
            member.returnType?.toSource() == type
        );
      });
    }

    declarations.propsMixins.forEach((propMixin) {
      if (!hasAbstractGetter(propMixin.node, 'Map', 'props')) {
        logger.severe(
            'Props mixin classes must declare an abstract props getter `Map get props;` '
            'so that they can be statically analyzed properly.',
//            span: getSpan(sourceFile, propMixin.node)
        );
      }

      generateAccessorsMixinAndMetaClasses(AccessorType.props, propMixin);
    });

    declarations.stateMixins.forEach((stateMixin) {
      if (!hasAbstractGetter(stateMixin.node, 'Map', 'state')) {
        logger.severe(
            'State mixin classes must declare an abstract state getter `Map get state;` '
            'so that they can be statically analyzed properly.',
//            span: getSpan(sourceFile, stateMixin.node)
        );
      }

      generateAccessorsMixinAndMetaClasses(AccessorType.state, stateMixin);
    });

    // ----------------------------------------------------------------------
    //   Abstract Props/State implementations
    // ----------------------------------------------------------------------
    declarations.abstractProps.forEach((abstractPropsClass) {
      generateAccessorsMixinAndMetaClasses(AccessorType.props, abstractPropsClass);
    });

    declarations.abstractState.forEach((abstractStateClass) {
      generateAccessorsMixinAndMetaClasses(AccessorType.state, abstractStateClass);
    });
  }

  void generateAccessorsMixinAndMetaClasses(AccessorType type, NodeWithMeta classNode) {
    var className = getClassNameFromNode(classNode);
    var accessorMixinName = getAccessorsMixinName(className);
    if (!generatedAccessorMixinClassNames.contains(accessorMixinName)) {
      outputContentsBuffer.write(_generateAccessorsClass(type, accessorMixinName, classNode, className));
      outputContentsBuffer.write(_generateMetaClass(type, className, accessorMixinName));
      generatedAccessorMixinClassNames.add(accessorMixinName);
    } else {
      logger.fine(
          'Duplicate ancestor class with name $accessorMixinName');
    }
  }


  // ----------------------------------------------------------------------
  //   Accessor generation
  // ----------------------------------------------------------------------

  static const String proxiedPropsMapName = 'props';
  static const String proxiedStateMapName = 'state';

  static const String staticPropKeysName = '${publicGeneratedPrefix}propKeys';
  static const String staticStateKeysName = '${publicGeneratedPrefix}stateKeys';

  static const String staticPropsName = '${publicGeneratedPrefix}props';
  static const String staticStateName = '${publicGeneratedPrefix}state';

  static const String staticConsumedPropsName = '${publicGeneratedPrefix}consumedProps';

  static String getAccessorKeyNamespace(NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap) {
    // Default to the name of the class followed by a period.
    var defaultNamespace = typedMap.node.name.name + '.';
    // Allow the consumer to specify a custom namespace that trumps the default.
    var specifiedKeyNamespace = typedMap.meta?.keyNamespace;

    return specifiedKeyNamespace ?? defaultNamespace;
  }

  AccessorOutput generateAccessors(
      AccessorType type,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap
  ) {
//    if (shouldFixDdcAbstractAccessors) {
//      fixDdcAbstractAccessors(type, typedMap);
//    }

    String keyNamespace = getAccessorKeyNamespace(typedMap);

    final bool isProps = type == AccessorType.props;

    final String proxiedMapName = isProps ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String constConstructorName = isProps ? 'PropDescriptor' : 'StateDescriptor';

    Map keyConstants = {};
    Map constants = {};

    StringBuffer output = new StringBuffer();

    typedMap.node.members
        .where((member) => member is FieldDeclaration && !member.isStatic)
        .forEach((_field) {
          final field = _field as FieldDeclaration; // ignore: avoid_as


          annotations.Accessor accessorMeta = instantiateAnnotation(field, annotations.Accessor);
          annotations.Accessor requiredProp = getConstantAnnotation(field, 'requiredProp', annotations.requiredProp);
          annotations.Accessor nullableRequiredProp = getConstantAnnotation(field, 'nullableRequiredProp', annotations.nullableRequiredProp);
          // ignore: deprecated_member_use
          annotations.Required requiredMeta = instantiateAnnotation(field, annotations.Required);


          if (accessorMeta?.doNotGenerate == true) {
            logger.fine('Skipping generation of field `$field`.',
//                span: getSpan(sourceFile, field)
            );

            return;
          }

          field.fields.variables.forEach((VariableDeclaration variable) {
            if (variable.initializer != null) {
              logger.severe(
                  'Fields are stubs for generated setters/getters and should not have initializers.',
//                  span: getSpan(sourceFile, variable)
              );
            }

            String accessorName = variable.name.name;

            String individualKeyNamespace = accessorMeta?.keyNamespace ?? keyNamespace;
            String individualKey = accessorMeta?.key ?? accessorName;

            /// Necessary to work around issue where private static declarations in different classes
            /// conflict with each other in strong mode: https://github.com/dart-lang/sdk/issues/29751
            /// TODO remove once that issue is resolved
            String staticConstNamespace = typedMap.node.name.name;

            String keyConstantName = '${generatedPrefix}key__${accessorName}__$staticConstNamespace';
            String keyValue = stringLiteral(individualKeyNamespace + individualKey);

            String constantName = '${generatedPrefix}prop__${accessorName}__$staticConstNamespace';
            String constantValue = 'const $constConstructorName($keyConstantName';

            var annotationCount = 0;

            if (accessorMeta != null) {
              annotationCount++;

              if (accessorMeta.isRequired) {
                constantValue += ', isRequired: true';

                if (accessorMeta.isNullable) constantValue += ', isNullable: true';

                if (accessorMeta.requiredErrorMessage != null && accessorMeta.requiredErrorMessage.isNotEmpty) {
                  constantValue += ', errorMessage: ${stringLiteral(accessorMeta.requiredErrorMessage)}';
                }
              }
            }

            if (requiredMeta != null) {
              constantValue += ', isRequired: true';

              if (requiredMeta.isNullable) constantValue += ', isNullable: true';

              if (requiredMeta.message != null && requiredMeta.message.isNotEmpty) {
                constantValue += ', errorMessage: ${stringLiteral(requiredMeta.message)}';
              }
            }

            if (requiredProp != null) {
              annotationCount++;
              constantValue += ', isRequired: true';
            }

            if (nullableRequiredProp != null) {
              annotationCount++;
              constantValue += ', isRequired: true, isNullable: true';
            }

            if (annotationCount > 1) {
              logger.severe(
                  '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
                  'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
//                  span: getSpan(sourceFile, field)
              );
            }

            constantValue += ')';

            keyConstants[keyConstantName] = keyValue;
            constants[constantName] = constantValue;

            final type = field.fields.type?.toSource();
            String typeString = type == null ? '' : '$type ';
            String setterTypeString = field.covariantKeyword == null
                ? typeString
                : '${field.covariantKeyword} $typeString';

            String generatedAccessor =
                '  ${typeString}get $accessorName => $proxiedMapName[$keyConstantName];\n'
                '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;\n';

            output.write(generatedAccessor);

            logger.fine('Generated accessor `$accessorName` with key $keyValue.');
//                span: getSpan(sourceFile, variable)
          });

          if (field.fields.variables.length > 1 &&
              (field.documentationComment != null || field.metadata.isNotEmpty)) {
            logger.warning(
                'Note: accessors declared as comma-separated variables will not all be generated '
                'with the original doc comments and annotations; only the first variable will.',
//                span: getSpan(sourceFile, field.fields)
            );
          }
        });

    var keyConstantsImpl;
    var constantsImpl;

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl =
          keyConstants.keys.map((keyName) => '  static const String $keyName = ${keyConstants[keyName]}').join(';\n') +
          ';\n';
    }

    if (constants.keys.isEmpty) {
      constantsImpl = '';
    } else {
      constantsImpl =
          constants.keys.map((constantName) => '  static const $constConstructorName $constantName = ${constants[constantName]}').join(';\n') +
          ';\n';
    }

    String keyListImpl =
        '  static const List<String> $keyListName = const [' +
        keyConstants.keys.join(', ') +
        '];\n';

    String listImpl =
        '  static const List<$constConstructorName> $constantListName = const [' +
        constants.keys.join(', ') +
        '];\n';

    String staticVariablesImpl = '  /* GENERATED CONSTANTS */\n$constantsImpl$keyConstantsImpl\n$listImpl$keyListImpl';

    output.write(staticVariablesImpl);
    return new AccessorOutput(output.toString());
  }

  String _generateMetaClass(AccessorType type, String name, String accessorMixinName) {
    var isProps = type == AccessorType.props;
    final metaStructName = isProps ? 'PropsMeta' : 'StateMeta';
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String metaObjectName = getMetaClassName(name);

    var output = new StringBuffer();
    output.writeln('const $metaStructName $metaObjectName = const $metaStructName(');
    output.writeln('  fields: $accessorMixinName.$constantListName,');
    output.writeln('  keys: $accessorMixinName.$keyListName,');
    output.writeln(');');
    output.writeln();
    return output.toString();
  }

  String _generateAccessorsClass(AccessorType type, String accessorsMixinName,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> node, String name) {
    var isProps = type == AccessorType.props;
    StringBuffer generatedClass = new StringBuffer();
    generatedClass.writeln(
        'abstract class $accessorsMixinName {\n' +
        '  Map get ${isProps ? 'props': 'state'};\n'
    );

    generatedClass.write(generateAccessors(type, node).implementations);
    generatedClass.writeln('}');
    generatedClass.writeln();
    return generatedClass.toString();
  }

  String _generateConcretePropsImpl(String propsName, String propsImplName,
      String propsAccessorsMixinName, String componentFactoryName,
      String propKeyNamespace, List<String> ancestorPropsClasses) {
    var classDeclaration = new StringBuffer()
      ..write(
        'class $propsImplName extends $propsName with $propsAccessorsMixinName');
    ancestorPropsClasses?.forEach((ancestor) {
      classDeclaration.write(', $ancestor');
    });
    classDeclaration.writeln(' {');
    return (new StringBuffer()
        ..writeln('// Concrete props implementation.')
        ..writeln('//')
        ..writeln('// Implements constructor and backing map, and links up to generated component factory.')
        ..write(classDeclaration.toString())
        ..writeln('  /// The backing props map proxied by this class.')
        ..writeln('  @override')
        ..writeln('  final Map props;')
        ..writeln()
        // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
        ..writeln('  $propsImplName(Map backingMap) : this.props = backingMap ?? ({});')
        ..writeln()
        ..writeln('  /// Let [UiProps] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The [ReactComponentFactory] associated with the component built by this class.')
        ..writeln('  @override')
        ..writeln('  ReactComponentFactoryProxy get componentFactory => $componentFactoryName;')
        ..writeln()
        ..writeln('  /// The default namespace for the prop getters/setters generated for this class.')
        ..writeln('  @override')
        ..writeln('  String get propKeyNamespace => ${stringLiteral(propKeyNamespace)};')
        ..writeln()
        ..writeln('  // Work around https://github.com/dart-lang/sdk/issues/16030 by making')
        ..writeln('  // the original props class abstract and redeclaring `call` in the impl class.')
        ..writeln('  @override')
        ..writeln('  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);')
        ..writeln('}')
        ..writeln())
        .toString();
  }



  /// Apply a workaround for an issue where, in the DDC, abstract getter or setter overrides declared in a class clobber
  /// the inherited concrete implementations. <https://github.com/dart-lang/sdk/issues/29914>
  ///
  /// Fixes the issue by generating corresponding abstract getters/setters to complete the pair
  /// for accessors with the `@override` annotation.
  /// NOTE: This is fixed as of dart 2.1.0 (eta Oct. 15)
  void fixDdcAbstractAccessors(
    AccessorType accessorType,
    NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap,
  ) {
    var candidateAccessors = new List<MethodDeclaration>.from(
        typedMap.node.members.where((member) =>
            member is MethodDeclaration &&
            (member.isGetter || member.isSetter) &&
            !member.isSynthetic &&
            !member.isStatic &&
            member.metadata.any((meta) => meta.name.name == 'override')
        )
    );

    for (var accessor in candidateAccessors) {
      // Non-abstract accessors don't exhibit this issue.
      if (!accessor.isAbstract) return;

      var name = accessor.name.name;

      // Don't generate for `Map get props;`/`Map get state;` in mixins
      if (accessorType == AccessorType.props && name == 'props') continue;
      if (accessorType == AccessorType.state && name == 'state') continue;

      if (candidateAccessors.any((other) => other != accessor && other.name.name == name)) {
        // Don't generate when both the getter and the setter are declared.
        continue;
      }

      /// Warning: tests rely on this comment as a means of determining whether this fix was applied.
      ///
      /// DO NOT modify or remove without updating tests
      const String generatedComment = ' /* fixDdcAbstractAccessors workaround: */ ';

      if (accessor.isGetter) {
        var type = accessor.returnType?.toSource();
        var typeString = type == null ? '' : '$type ';

        transformedFile?.insert(sourceFile?.location(accessor.end),
            // use `covariant` here to be extra safe in this typing
            '${generatedComment}set $name(covariant ${typeString}value);');
      } else {
        var parameter = accessor.parameters.parameters.single;
        var type = parameter is SimpleFormalParameter
            ? parameter.type?.toSource()
            // This `null` case is mainly for [FunctionTypedFormalParameter].
            : null;
        var typeString = type == null ? '' : '$type ';

        transformedFile?.insert(sourceFile?.location(accessor.end),
            '$generatedComment${typeString}get $name;');
      }
    }
  }
}

enum AccessorType {props, state}
