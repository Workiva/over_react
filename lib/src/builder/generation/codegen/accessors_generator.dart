import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/generation/parsing/meta.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:transformer_utils/transformer_utils.dart';

import '../../util.dart';
import '../parsing.dart';
import 'names.dart';
import 'util.dart';

abstract class TypedMapAccessorsGenerator extends Generator {
  TypedMapAccessorsGenerator();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory TypedMapAccessorsGenerator.propsMixin(PropsMixinDeclaration decl) =
      _TypedMapMixinAccessorsGenerator.props;

  factory TypedMapAccessorsGenerator.stateMixin(StateMixinDeclaration decl) =
      _TypedMapMixinAccessorsGenerator.state;

  factory TypedMapAccessorsGenerator.legacyProps(LegacyClassComponentDeclaration decl) =
      _LegacyTypedMapAccessorsGenerator.props;

  factory TypedMapAccessorsGenerator.legacyState(LegacyClassComponentDeclaration decl) =
      _LegacyTypedMapAccessorsGenerator.state;

  factory TypedMapAccessorsGenerator.legacyAbstractProps(LegacyAbstractPropsDeclaration decl) =
      _LegacyTypedMapAccessorsGenerator.abstractProps;

  factory TypedMapAccessorsGenerator.legacyAbstractState(LegacyAbstractStateDeclaration decl) =
      _LegacyTypedMapAccessorsGenerator.abstractState;

  AccessorType get type;

  BoilerplateAccessorsMember get member;

  TypedMapNames get names;

  String get accessorsMixinName;

  ClassOrMixinDeclaration get node => member.node as ClassOrMixinDeclaration;

  TypeParameterList get typeParameters => member.nodeHelper.typeParameters;

  @override
  void generate();

  String _generateAccessorsMixin() {
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(typeParameters);

    final deprecationLine = internalGeneratedMemberDeprecationLine(
        additionalMessageStringLiteral: "' EXCEPTION: this may be used in legacy boilerplate until'"
            "' it is transitioned to the new mixin-based boilerplate.'");

    StringBuffer generatedClass = StringBuffer();
    if (version.isLegacy) {
      final implementsClause = 'implements ${names.consumerName}$typeParamsOnSuper';
      generatedClass
          ..write(deprecationLine)
          ..writeln(
          'abstract class $accessorsMixinName$typeParamsOnClass $implementsClause {\n' +
              '  @override' +
              '  Map get ${type.isProps ? 'props' : 'state'};\n');
      if (type.isMixin) {
        generatedClass.writeln(_generateStaticMetaDecl(names.publicName, type.isProps));
        generatedClass.write(_copyStaticMembers(node));
        generatedClass.write(_copyClassMembers(node));
      }
    } else {
      generatedClass
          ..write(deprecationLine)
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

    node.members.whereType<FieldDeclaration>().where((field) => !field.isStatic).forEach((field) {
      T getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
        return member.metadata.any((annotation) => annotation.name?.name == name) ? value : null;
      }

      final accessorMeta = instantiateAnnotationTyped<annotations.Accessor>(field);
      final requiredProp = getConstantAnnotation(field, 'requiredProp', annotations.requiredProp);
      final nullableRequiredProp =
          getConstantAnnotation(field, 'nullableRequiredProp', annotations.nullableRequiredProp);

      if (accessorMeta?.doNotGenerate == true) {
        return;
      }

      field.fields.variables.forEach((variable) {
        if (variable.initializer != null) {
          logger.severe(messageWithSpan(
              'Fields are stubs for generated setters/getters and should not have initializers.\n'
              'Instead, initialize ${type.isProps ? 'prop values within getDefaultProps()' : 'state values within getInitialState()'}.',
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

        var annotationCount = 0;

        if (accessorMeta != null) {
          annotationCount++;

          if (accessorMeta.isRequired) {
            constantValue += ', isRequired: true';

            if (accessorMeta.isNullable) constantValue += ', isNullable: true';

            if (accessorMeta.requiredErrorMessage != null &&
                accessorMeta.requiredErrorMessage.isNotEmpty) {
              constantValue +=
                  ', errorMessage: ${stringLiteral(accessorMeta.requiredErrorMessage)}';
            }
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
          logger.severe(messageWithSpan(
              '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
              'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
              span: getSpan(sourceFile, field)));
        }

        constantValue += ')';

        keyConstants[keyConstantName] = keyValue;
        constants[constantName] = constantValue;

        final typeSource = field.fields.type?.toSource();
        final typeString = typeSource == null ? '' : '$typeSource ';
        final metadataSrc = StringBuffer();
        if (version.isLegacy) {
          for (final annotation in field.metadata) {
            metadataSrc.writeln('  ${annotation.toSource()}');
          }
        }

        String setterTypeString =
            field.covariantKeyword == null ? typeString : '${field.covariantKeyword} $typeString';

        // Carry over the existing doc comment since IDEs don't inherit
        // doc comments for some reason.
        String docComment;
        if (version.isLegacy) {
          if (variable.documentationComment == null) {
            docComment = '';
          } else {
            final existingCommentSource = sourceFile.getText(
                variable.documentationComment.offset, variable.documentationComment.end);
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

        String generatedAccessor = '$docComment'
            // TODO reinstate inlining once https://github.com/dart-lang/sdk/issues/36217 is fixed and all workarounds are removed
            // inlining is necessary to get mixins to use $index/$indexSet instead of $index$asx
            // '  @tryInline\n'
            '  @override\n'
            '$metadataSrc'
            '  ${typeString}get $accessorName => $proxiedMapName[$keyConstantName] ?? null;'
            ' // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;\n'
            '$docComment'
            // '  @tryInline\n'
            '  @override\n'
            '$metadataSrc'
            '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;\n';

        output.write(generatedAccessor);
      });

      if (field.fields.variables.length > 1 &&
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

    return output.toString();
  }
}

class _TypedMapMixinAccessorsGenerator extends TypedMapAccessorsGenerator {
  @override
  final BoilerplatePropsOrStateMixin member;

  @override
  final TypedMapNames names;

  @override
  final AccessorType type;

  @override
  final Version version;

  _TypedMapMixinAccessorsGenerator.props(PropsMixinDeclaration decl)
      : member = decl.mixin,
        names = TypedMapNames(decl.mixin.name.name),
        version = decl.version,
        type = AccessorType.propsMixin;

  _TypedMapMixinAccessorsGenerator.state(StateMixinDeclaration decl)
      : member = decl.mixin,
        names = TypedMapNames(decl.mixin.name.name),
        version = decl.version,
        type = AccessorType.stateMixin;

  @override
  String get accessorsMixinName => names.generatedMixinName;

  @override
  void generate() {
    outputContentsBuffer..write(_generateAccessorsMixin())..write(_generateMetaConstImpl());
  }
}

class _LegacyTypedMapAccessorsGenerator extends TypedMapAccessorsGenerator {
  @override
  final BoilerplatePropsOrState member;

  @override
  final TypedMapNames names;

  @override
  final AccessorType type;

  @override
  final Version version;

  _LegacyTypedMapAccessorsGenerator.props(LegacyClassComponentDeclaration decl)
      : member = decl.props,
        names = TypedMapNames(decl.props.name.name),
        version = decl.version,
        type = AccessorType.props;

  _LegacyTypedMapAccessorsGenerator.state(LegacyClassComponentDeclaration decl)
      : member = decl.state,
        names = TypedMapNames(decl.state.name.name),
        version = decl.version,
        type = AccessorType.state;

  _LegacyTypedMapAccessorsGenerator.abstractProps(LegacyAbstractPropsDeclaration decl)
      : member = decl.props,
        names = TypedMapNames(decl.props.name.name),
        version = decl.version,
        type = AccessorType.abstractProps;

  _LegacyTypedMapAccessorsGenerator.abstractState(LegacyAbstractStateDeclaration decl)
      : member = decl.state,
        names = TypedMapNames(decl.state.name.name),
        version = decl.version,
        type = AccessorType.abstractState;

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

    final classishNode = node.asClassish();
    final metadata = classishNode.metadata;
    final typeParameters = classishNode.typeParameters;
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

String _copyClassMembers(ClassOrMixinDeclaration node) {
  bool isValidForCopying(ClassMember member) {
    // Static members should be copied over as needed by [_copyStaticMembers].
    // Otherwise, fields which are not synthetic have concrete getters/setters
    // generated for them, so don't copy those over either. We also don't want
    // to copy anything that would conflict with what the builder already may
    // generate, namely `props`, `state`, and `meta`
    final isValid = !_isStaticFieldOrMethod(member) &&
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

String _copyStaticMembers(ClassOrMixinDeclaration node) {
  final buffer = StringBuffer();
  node.members.where(_isStaticFieldOrMethod).forEach((member) {
    // Don't copy over anything named `meta`, since the static meta field is already going to be generated.
    if (!_memberHasName(member, 'meta')) {
      buffer.writeln(member.toSource());
    }
  });
  return buffer.toString();
}

bool _isStaticFieldOrMethod(ClassMember member) {
  return (member is MethodDeclaration && member.isStatic) ||
      (member is FieldDeclaration && member.isStatic);
}

bool _memberHasName(ClassMember member, String name) {
  return (member is FieldDeclaration && fieldDeclarationHasName(member, name)) ||
      (member is MethodDeclaration && member.name.name == name);
}
