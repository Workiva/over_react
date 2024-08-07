// Copyright 2020 Workiva Inc.
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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:transformer_utils/transformer_utils.dart';

import '../parsing.dart';
import '../util.dart';
import 'names.dart';
import 'util.dart';

/// Base class for generating getters/setters for props/state fields, as well as meta constants.
abstract class TypedMapAccessorsGenerator extends BoilerplateDeclarationGenerator {
  bool get nullSafety;

  TypedMapAccessorsGenerator();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory TypedMapAccessorsGenerator.propsMixin(PropsMixinDeclaration decl,
      {required bool nullSafety}) = _TypedMapMixinAccessorsGenerator.props;

  factory TypedMapAccessorsGenerator.stateMixin(StateMixinDeclaration decl,
      {required bool nullSafety}) = _TypedMapMixinAccessorsGenerator.state;

  factory TypedMapAccessorsGenerator.legacyProps(LegacyClassComponentDeclaration decl,
      {required bool nullSafety}) = _LegacyTypedMapAccessorsGenerator.props;

  factory TypedMapAccessorsGenerator.legacyState(LegacyClassComponentDeclaration decl,
      {required bool nullSafety}) = _LegacyTypedMapAccessorsGenerator.state;

  factory TypedMapAccessorsGenerator.legacyAbstractProps(LegacyAbstractPropsDeclaration decl,
      {required bool nullSafety}) = _LegacyTypedMapAccessorsGenerator.abstractProps;

  factory TypedMapAccessorsGenerator.legacyAbstractState(LegacyAbstractStateDeclaration decl,
      {required bool nullSafety}) = _LegacyTypedMapAccessorsGenerator.abstractState;

  TypedMapType get type;

  BoilerplateTypedMapMember get member;

  TypedMapNames get names;

  String get accessorsMixinName;

  ClassishDeclaration get node => member.node.asClassish();

  TypeParameterList? get typeParameters => member.nodeHelper.typeParameters;

  @override
  void generate();

  String _generateAccessorsMixin() {
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(typeParameters);

    final generatedCodeUseOnlyDeprecation = internalGeneratedMemberDeprecationLine(
        additionalMessageStringLiteral: "' EXCEPTION: this may be used in legacy boilerplate until'"
            "' it is transitioned to the new mixin-based boilerplate.'");

    StringBuffer generatedClass = StringBuffer();
    // Preserve annotations authored by the consumer on any APIs generated by the builder
    for (final annotation in node.metadata) {
      if (!overReactBoilerplateAnnotations.contains(annotation.name.name)) {
        generatedClass.writeln(annotation.toSource());
      }
    }
    if (version.isLegacy) {
      final implementsClause = 'implements ${names.consumerName}$typeParamsOnSuper';
      generatedClass
        ..write(generatedCodeUseOnlyDeprecation)
        ..writeln('abstract class $accessorsMixinName$typeParamsOnClass $implementsClause {\n'
            '  @override'
            '  Map get ${type.isProps ? 'props' : 'state'};\n');
      if (type.isMixin) {
        generatedClass.writeln(_generateStaticMetaDecl(names.publicName, type.isProps));
        generatedClass.write(_copyStaticMembers(node));
        generatedClass.write(_copyClassMembers(node));
      }
    } else {
      generatedClass
        ..write(generatedCodeUseOnlyDeprecation)
        ..writeln(
            'mixin $accessorsMixinName$typeParamsOnClass on ${names.consumerName}$typeParamsOnSuper {');
      generatedClass.writeln(_generateStaticMetaDecl(names.publicName, type.isProps));
    }

    generatedClass.write(_generateAccessors());

    generatedClass.writeln('}');
    generatedClass.writeln();
    return generatedClass.toString();
  }

  String _generateStaticMetaDecl(String consumableClassName, bool isProps) {
    return '  static const ${isProps ? 'Props' : 'State'}Meta meta = ${names.metaConstantName};';
  }

  String _generateMetaConstImpl() {
    final metaStructName = type.isProps ? 'PropsMeta' : 'StateMeta';
    final String keyListName = type.isProps ? staticPropKeysName : staticStateKeysName;
    final String fieldListName = type.isProps ? staticPropsName : staticStateName;

    final String metaInstanceName = names.metaConstantName;

    final output = StringBuffer();
    output.write(internalGeneratedMemberDeprecationLine());
    output.writeln('const $metaStructName $metaInstanceName = $metaStructName(');
    output.writeln('  fields: $accessorsMixinName.$fieldListName,');
    output.writeln('  keys: $accessorsMixinName.$keyListName,');
    output.writeln(');');
    output.writeln();
    return output.toString();
  }

  static const String proxiedPropsMapName = 'props';
  static const String proxiedStateMapName = 'state';

  static const String staticPropKeysName = '${publicGeneratedPrefix}propKeys';
  static const String staticStateKeysName = '${publicGeneratedPrefix}stateKeys';

  static const String staticPropsName = '${publicGeneratedPrefix}props';
  static const String staticStateName = '${publicGeneratedPrefix}state';

  static const String staticConsumedPropsName = '${publicGeneratedPrefix}consumedProps';

  String _generateAccessors() {
    String keyNamespace = getAccessorKeyNamespace(names, member.meta);

    final String proxiedMapName = type.isProps ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = type.isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = type.isProps ? staticPropsName : staticStateName;
    final String constConstructorName = type.isProps ? 'PropDescriptor' : 'StateDescriptor';

    Map keyConstants = {};
    Map constants = {};

    StringBuffer output = StringBuffer();

    final requiredPropChecks = <String>[];

    node.members.whereType<FieldDeclaration>().where((field) => !field.isStatic).forEach((field) {
      T? getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
        return member.metadata.any((annotation) => annotation.name.name == name) ? value : null;
      }

      final accessorMeta = instantiateAnnotationTyped<annotations.Accessor>(field);
      final requiredProp = getConstantAnnotation(field, 'requiredProp', annotations.requiredProp);
      final nullableRequiredProp =
          getConstantAnnotation(field, 'nullableRequiredProp', annotations.nullableRequiredProp);
      final disableRequiredPropValidation = getConstantAnnotation(
          field, 'disableRequiredPropValidation', annotations.disableRequiredPropValidation);

      if (accessorMeta?.doNotGenerate == true) {
        return;
      }

      field.fields.variables.forEach((variable) {
        if (variable.initializer != null) {
          logger.severe(messageWithSpan(
              'Fields are stubs for generated setters/getters and should not have initializers.\n'
              'Instead, initialize ${type.isProps ? 'prop values within defaultProps' : 'state values within initialState'}.',
              span: getSpan(sourceFile, variable)));
        }

        String accessorName = variable.name.name;

        String individualKeyNamespace = accessorMeta?.keyNamespace ?? keyNamespace;
        String individualKey = accessorMeta?.key ?? accessorName;

        /// Necessary to work around issue where private static declarations in different classes
        /// conflict with each other in strong mode.
        /// TODO remove once https://github.com/dart-lang/sdk/issues/29751 is resolved
        String staticConstNamespace = node.name.name;

        String keyConstantName =
            '${privateSourcePrefix}key__${accessorName}__$staticConstNamespace';
        String keyValue = stringLiteral(individualKeyNamespace + individualKey);

        String constantName = '${privateSourcePrefix}prop__${accessorName}__$staticConstNamespace';
        String constantValue = '$constConstructorName($keyConstantName';

        var requiredReasonCount = 0;

        var isRequired = false;
        var isLate = false;
        var isPotentiallyNullable = true;
        var requiredErrorMessage = '';

        if (variable.isLate) {
          requiredReasonCount++;
          isRequired = true;
          isLate = true;
          isPotentiallyNullable = true;

          if (type.isProps && disableRequiredPropValidation == null) {
            requiredPropChecks.add(
                '  if(!props.containsKey($keyValue) && !requiredPropNamesToSkipValidation.contains(${stringLiteral(accessorName)})) {\n'
                '  throw MissingRequiredPropsError(${stringLiteral('Required prop `$accessorName` is missing.')});\n'
                '}\n');
          }
        }

        if (accessorMeta != null) {
          if (accessorMeta.isRequired) {
            requiredReasonCount++;
            isRequired = true;
            isPotentiallyNullable = accessorMeta.isNullable;
            requiredErrorMessage = accessorMeta.requiredErrorMessage ?? '';
          }
        }

        if (requiredProp != null) {
          requiredReasonCount++;
          isRequired = true;
          isPotentiallyNullable = false;
        }

        if (nullableRequiredProp != null) {
          requiredReasonCount++;
          isRequired = true;
          isPotentiallyNullable = true;
        }

        if (requiredReasonCount > 1) {
          const requiredPropAnnotations = '@requiredProp/@nullableProp/@Accessor(isRequired: true)';

          String message;
          if (variable.isLate) {
            message = 'Props declared using `late` are already considered required,'
                ' and cannot also have required prop annotations: $requiredPropAnnotations.'
                '\nPlease remove these annotations.';
          } else {
            message = '$requiredPropAnnotations cannot be used together.\n'
                'You can use `@Accessor(isRequired: true)` or `isNullable: true` instead of the shorthand versions.';
          }

          logger.severe(messageWithSpan(message, span: getSpan(sourceFile, field)));
        }

        if (isRequired) {
          constantValue += ', isRequired: $isRequired';
          if (isPotentiallyNullable) {
            constantValue += ', isNullable: $isPotentiallyNullable';
          }
          if (isLate) {
            constantValue += ', isLate: $isLate';
          }
          if (requiredErrorMessage.isNotEmpty) {
            constantValue += ', errorMessage: ${stringLiteral(requiredErrorMessage)}';
          }
        }
        constantValue += ')';

        keyConstants[keyConstantName] = keyValue;
        constants[constantName] = constantValue;

        final fieldType = field.fields.type;
        final typeSource = fieldType?.toSource();
        final typeString = typeSource == null ? '' : '$typeSource ';
        final metadataSrc = StringBuffer();
        for (final annotation in field.metadata) {
          metadataSrc.writeln('  ${annotation.toSource()}');
        }

        final getterTypeString = typeString;
        final setterTypeString =
            // This change is attempting to help with null safe migration when generated code is available in legacy components
            field.covariantKeyword == null
                ? getterTypeString
                : '${field.covariantKeyword} $typeString';

        // Carry over the existing doc comment since IDEs don't inherit
        // doc comments for some reason.
        String docComment;
        if (version.isLegacy) {
          if (variable.documentationComment == null) {
            docComment = '';
          } else {
            final existingCommentSource = sourceFile.getText(
                variable.documentationComment!.offset, variable.documentationComment!.end);
            docComment = '  $existingCommentSource\n'
                '  ///\n';
          }
          // Provide a link to the original declaration:
          // - for better UX in VS Code, since the "Dart: Go to Super Class/Method" action isn't easily discoverable
          // - to provide a reminder to the user that they probably want to look at the original declaration
          //
          // Use an HTML comment so it isn't rendered to the hover/quickdoc, which clutters up the comment.
          // Even inside comments, this link will be clickable in IDEs!
          docComment += '  /// <!-- Generated from [${names.consumerName}.$accessorName] -->\n';
        } else {
          docComment = '';
        }

        final conversionConfig = parseConversionConfig(
          field: field,
          accessorName: accessorName,
          typeSource: typeSource,
          onError: (message, [spanNode]) {
            logger.severe(messageWithSpan(message, span: getSpan(sourceFile, spanNode ?? field)));
          },
        );

        String castGetterMapValueIfNecessary(String expression) {
          final typeToCastTo = conversionConfig?.rawType ?? typeSource;
          if (typeToCastTo == null) return expression;
          return '($expression) as $typeToCastTo';
        }

        String convertIfNecessary(String expression, {required bool isGetter}) {
          if (conversionConfig != null) {
            final convertFunc = isGetter ? conversionConfig.getter : conversionConfig.setter;
            return '$convertFunc($expression)';
          }
          return expression;
        }

        String generatedAccessor = '$docComment'
            // TODO reinstate inlining once https://github.com/dart-lang/sdk/issues/36217 is fixed and all workarounds are removed
            // inlining is necessary to get mixins to use $index/$indexSet instead of $index$asx
            // '  @tryInline\n'
            '  @override\n'
            '$metadataSrc'
            // Add ` ?? null` to work around DDC bug: <https://github.com/dart-lang/sdk/issues/36052
            // Apply this workaround ASAP, before the cast, to limit where undefined can leak into
            // and potentially cause issues (for instance, DDC cast internals).
            '  ${getterTypeString}get $accessorName => ${convertIfNecessary(castGetterMapValueIfNecessary('$proxiedMapName[$keyConstantName] ?? null'), isGetter: true)};\n'
            '$docComment'
            // '  @tryInline\n'
            '  @override\n'
            '$metadataSrc'
            '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = ${convertIfNecessary('value', isGetter: false)};\n';

        output.write(generatedAccessor);
      });

      if (version.isLegacy &&
          field.fields.variables.length > 1 &&
          (field.documentationComment != null || field.metadata.isNotEmpty)) {
        logger.warning(messageWithSpan(
            'Note: accessors declared as comma-separated variables will not all be generated '
            'with the original doc comments and annotations; only the first variable will.',
            span: getSpan(sourceFile, field.fields)));
      }
    });

    String keyConstantsImpl;
    String constantsImpl;

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl = keyConstants.keys
              .map((keyName) => '  static const String $keyName = ${keyConstants[keyName]}')
              .join(';\n') +
          ';\n';
    }

    if (constants.keys.isEmpty) {
      constantsImpl = '';
    } else {
      constantsImpl = constants.keys
              .map((constantName) =>
                  '  static const $constConstructorName $constantName = ${constants[constantName]}')
              .join(';\n') +
          ';\n';
    }

    String keyListImpl =
        '  static const List<String> $keyListName = [' + keyConstants.keys.join(', ') + '];\n';

    String listImpl = '  static const List<$constConstructorName> $constantListName = [' +
        constants.keys.join(', ') +
        '];\n';

    String staticVariablesImpl =
        '  /* GENERATED CONSTANTS */\n$constantsImpl$keyConstantsImpl\n$listImpl$keyListImpl';

    output.write(staticVariablesImpl);

    if (type.isProps &&
        version != Version.v3_legacyDart2Only &&
        version != Version.v2_legacyBackwardsCompat) {
      final validateRequiredPropsMethod = '\n  @override\n'
          '  @UiProps.\$mustCallSuper\n'
          '  void validateRequiredProps() {\n'
          '    super.validateRequiredProps();\n'
          '    ${requiredPropChecks.join('\n')}\n'
          '  }\n';
      output.write(validateRequiredPropsMethod);
    }

    return output.toString();
  }
}

T? getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
  return member.metadata.any((annotation) => annotation.name.name == name) ? value : null;
}

// Parse @ConvertProp annotation.
PropConversionConfig? parseConversionConfig({
  required FieldDeclaration field,
  required String accessorName,
  required String? typeSource,
  required void Function(String errorMessage, [AstNode? spanNode]) onError,
}) {
  PropConversionConfig? conversionConfig;

  final convertProp =
      field.metadata.firstWhereOrNull((annotation) => annotation.name.name == 'ConvertProp');

  void handleAnnotationError(String message, [AstNode? spanNode]) {
    onError("Unsupported prop annotation combination for prop '$accessorName': $message", spanNode);
  }

  if (convertProp != null) {
    var rawType = convertProp.typeArguments?.arguments.firstOrNull?.toSource();
    var convertedType = convertProp.typeArguments?.arguments.lastOrNull?.toSource();
    var setter = convertProp.arguments?.arguments.firstOrNull?.toSource();
    var getter = convertProp.arguments?.arguments.lastOrNull?.toSource();
    if (rawType == null || convertedType == null) {
      handleAnnotationError(
          'The @ConvertProp annotation must be used with generic parameters: `@Convert<Raw, Converted>(setter, getter)`',
          convertProp);
      return null;
    }
    if (setter == null || getter == null) {
      // Analysis errors with `ConvertProp` should prevent this from happening.
      handleAnnotationError(
          'The @ConvertProp annotation must have two arguments: `@Convert<Raw, Converted>(setter, getter)`',
          convertProp);
      return null;
    }
    if (convertedType != typeSource) {
      handleAnnotationError(
          'A prop annotated with `@Convert<Raw, Converted>(setter, getter)` should have the same type as the `Converted` generic parameter.',
          convertProp);
      return null;
    }
    conversionConfig = PropConversionConfig(
      rawType: rawType,
      convertedType: convertedType,
      setter: setter,
      getter: getter,
    );
  }

  // Look for special-case conversion annotations (@convertJsMapProp and
  // @convertJsRefProp) only if @ConvertProp(...) annotation isn't already used.

  if (conversionConfig == null) {
    final convertJsMapProp =
        getConstantAnnotation(field, 'convertJsMapProp', annotations.convertJsMapProp);
    final convertJsRefProp =
        getConstantAnnotation(field, 'convertJsRefProp', annotations.convertJsRefProp);
    if (convertJsMapProp != null) {
      conversionConfig = PropConversionConfig(
        rawType: 'JsMap?',
        convertedType: 'Map?',
        setter: 'jsifyMapProp',
        getter: 'unjsifyMapProp',
      );
      if (conversionConfig.convertedType != typeSource) {
        handleAnnotationError(
            'A prop annotated with `@convertJsMapProp` should be typed as `Map?`.', field);
        return null;
      }
    } else if (convertJsRefProp != null) {
      conversionConfig = PropConversionConfig(
        rawType: 'dynamic',
        convertedType: 'dynamic',
        setter: 'jsifyRefProp',
        getter: 'unjsifyRefProp',
      );
      if (conversionConfig.convertedType != typeSource) {
        handleAnnotationError(
            'A prop annotated with `@convertJsRefProp` should be typed as `dynamic`.', field);
        return null;
      }
    }
  }

  return conversionConfig;
}

class PropConversionConfig {
  final String rawType;
  final String convertedType;
  final String setter;
  final String getter;

  PropConversionConfig(
      {required this.rawType,
      required this.convertedType,
      required this.setter,
      required this.getter});
}

/// Generates mixin implementations (e.g., `$FooPropsMixin`) containing accessors for
/// all boilerplate versions of props/state mixins.
class _TypedMapMixinAccessorsGenerator extends TypedMapAccessorsGenerator {
  @override
  final BoilerplatePropsOrStateMixin member;

  @override
  final TypedMapNames names;

  @override
  final TypedMapType type;

  @override
  final Version version;

  @override
  final bool nullSafety;

  _TypedMapMixinAccessorsGenerator.props(PropsMixinDeclaration decl, {required this.nullSafety})
      : member = decl.mixin,
        names = TypedMapNames(decl.mixin.name.name),
        version = decl.version,
        type = TypedMapType.propsMixin;

  _TypedMapMixinAccessorsGenerator.state(StateMixinDeclaration decl, {required this.nullSafety})
      : member = decl.mixin,
        names = TypedMapNames(decl.mixin.name.name),
        version = decl.version,
        type = TypedMapType.stateMixin;

  @override
  String get accessorsMixinName => names.generatedMixinName;

  @override
  void generate() {
    outputContentsBuffer
      ..write(_generateAccessorsMixin())
      ..write(_generateMetaConstImpl());
  }
}

/// Generates accessor mixins (e.g., `_$FooPropsAccessorsMixin`) containing accessors for
/// legacy props/state classes.
class _LegacyTypedMapAccessorsGenerator extends TypedMapAccessorsGenerator {
  @override
  final BoilerplatePropsOrState member;

  @override
  final TypedMapNames names;

  @override
  final TypedMapType type;

  @override
  final Version version;

  @override
  final bool nullSafety;

  _LegacyTypedMapAccessorsGenerator.props(LegacyClassComponentDeclaration decl,
      {required this.nullSafety})
      : member = decl.props,
        names = TypedMapNames(decl.props.name.name),
        version = decl.version,
        type = TypedMapType.props;

  _LegacyTypedMapAccessorsGenerator.state(LegacyClassComponentDeclaration decl,
      {required this.nullSafety})
      : member = decl.state!,
        names = TypedMapNames(decl.state!.name.name),
        version = decl.version,
        type = TypedMapType.state;

  _LegacyTypedMapAccessorsGenerator.abstractProps(LegacyAbstractPropsDeclaration decl,
      {required this.nullSafety})
      : member = decl.props,
        names = TypedMapNames(decl.props.name.name),
        version = decl.version,
        type = TypedMapType.abstractProps;

  _LegacyTypedMapAccessorsGenerator.abstractState(LegacyAbstractStateDeclaration decl,
      {required this.nullSafety})
      : member = decl.state,
        names = TypedMapNames(decl.state.name.name),
        version = decl.version,
        type = TypedMapType.abstractState;

  @override
  String get accessorsMixinName => names.legacyAccessorsMixinName;

  @override
  void generate() {
    outputContentsBuffer
      ..write(_generateAccessorsMixin())
      ..write(_generateMetaConstImpl())
      ..write(_generateConsumablePropsOrStateClass());
  }

  String _generateConsumablePropsOrStateClass() {
    if (version == Version.v2_legacyBackwardsCompat) {
      return '';
    }

    final metadata = node.metadata;
    final typeParameters = node.typeParameters;
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(typeParameters);
    final accessorsMixinName = names.legacyAccessorsMixinName;

    final classKeywords = '${type.isAbstract ? 'abstract ' : ''}class';
    final buffer = StringBuffer();
    for (final annotation in metadata) {
      if (!overReactBoilerplateAnnotations.contains(annotation.name.name)) {
        buffer.writeln(annotation.toSource());
      }
    }
    return (buffer
          ..writeln('$classKeywords ${names.publicName}$typeParamsOnClass'
              ' extends ${names.consumerName}$typeParamsOnSuper'
              ' with $accessorsMixinName$typeParamsOnSuper {')
          ..write(_copyStaticMembers(node))
          ..writeln(_generateStaticMetaDecl(names.publicName, type.isProps))
          ..writeln('}'))
        .toString();
  }
}

class TypedMapType {
  final bool isProps;
  final bool isAbstract;
  final bool isMixin;

  // ignore: avoid_positional_boolean_parameters
  const TypedMapType(this.isProps, this.isAbstract, this.isMixin);

  static const TypedMapType props = TypedMapType(true, false, false);
  static const TypedMapType state = TypedMapType(false, false, false);
  static const TypedMapType abstractProps = TypedMapType(true, true, false);
  static const TypedMapType abstractState = TypedMapType(false, true, false);
  static const TypedMapType propsMixin = TypedMapType(true, false, true);
  static const TypedMapType stateMixin = TypedMapType(false, false, true);
}

String _copyClassMembers(ClassishDeclaration node) {
  bool isValidForCopying(ClassMember member) {
    // Static members should be copied over as needed by [_copyStaticMembers].
    // Otherwise, fields which are not synthetic have concrete getters/setters
    // generated for them, so don't copy those over either. We also don't want
    // to copy anything that would conflict with what the builder already may
    // generate, namely `props`, `state`, and `meta`
    final isValid = !isStaticMember(member) &&
        !(member is FieldDeclaration && !member.isSynthetic) &&
        !_memberHasName(member, 'props') &&
        !_memberHasName(member, 'state') &&
        !_memberHasName(member, 'meta');

    // If a field is marked with `@Accessor(doNotGenerate: true)`, we should
    // copy over that field
    bool shouldNotBeGenerated = false;
    if (member is FieldDeclaration) {
      final accessorMeta = instantiateAnnotationTyped<annotations.Accessor>(member);
      shouldNotBeGenerated = accessorMeta?.doNotGenerate ?? false;
    }

    return isValid || shouldNotBeGenerated;
  }

  final buffer = StringBuffer();
  node.members
      .where(isValidForCopying)
      .forEach((member) => buffer.write('@override\n' + member.toSource()));
  return buffer.toString();
}

String _copyStaticMembers(ClassishDeclaration node) {
  final buffer = StringBuffer();
  node.members.where(isStaticMember).forEach((member) {
    // Don't copy over anything named `meta`, since the static meta field is already going to be generated.
    if (!_memberHasName(member, 'meta')) {
      buffer.writeln(member.toSource());
    }
  });
  return buffer.toString();
}

bool _memberHasName(ClassMember member, String name) {
  return (member is FieldDeclaration && fieldDeclarationHasName(member, name)) ||
      (member is MethodDeclaration && member.name.name == name);
}
