import 'package:analyzer/analyzer.dart';

class _NormalFormalParameterCollector extends GeneralizingAstVisitor<Null> {
  final List<NormalFormalParameter> _parameters = [];

  _NormalFormalParameterCollector._();

  @override
  Null visitNormalFormalParameter(NormalFormalParameter node) {
    _parameters.add(node);
  }
}

List<NormalFormalParameter> getNormalParameters(AstNode node) {
  final visitor = new _NormalFormalParameterCollector._();
  visitor.visitNode(node);
  return visitor._parameters;
}

NormalFormalParameter getNormalParameter(FormalParameter parameter) {
  if (parameter is NormalFormalParameter) {
    return parameter;
  }

  // Use .first instead of .single since not sure if function type arguments have these as well.
  return getNormalParameters(parameter).first;
}

bool areParametersEqual(FormalParameterList aList, FormalParameterList bList) {
  if (aList.parameters.length != bList.parameters.length) return false;

  final aNormalParameters = getNormalParameters(aList);
  final bNormalParameters = getNormalParameters(bList);

  return aNormalParameters.every((a) {
    return bNormalParameters.any((b) {
      if (a.identifier.name != b.identifier.name) {
        return false;
      }

      if ([a, b].any((parameter) =>
          parameter is! SimpleFormalParameter
      )) {
        /// Can't validate types with certainty in this case.
        return true;
      }

      final SimpleFormalParameter simpleA = a;
      final SimpleFormalParameter simpleB = b;
      if (simpleA.type != null && simpleB.type != null) {
        final typeASource = simpleA.type.toSource();
        final typeBSource = simpleB.type.toSource();
        if (typeASource == null || typeBSource == null) {
          // Failed to compute node for some reason/
          return false;
        }
        return typeASource == typeBSource;
      } if (simpleA.type == null && simpleB.type == null) {
        // Both untyped
        return true;
      } else {
        // Mismatch
        return false;
      }
    });
  });
}

class _Argument {
  final String name;
  final String defaultValue;

  _Argument(this.name, [this.defaultValue]);
}

class ArgumentForwardingHelper {
  final List<_Argument> positional = [];
  final List<_Argument> positionalOptional = [];
  final List<_Argument> named = [];

  Iterable<String> get positionalNames => positional.map((arg) => arg.name);
  Iterable<String> get positionalOptionalNames => positionalOptional.map((arg) => arg.name);
  Iterable<String> get namedNames => named.map((arg) => arg.name);

  ArgumentForwardingHelper(FormalParameterList list) {
    for (var param in list.parameters) {
      final normal = getNormalParameter(param);
      if (param.kind == ParameterKind.REQUIRED) {
        positional.add(new _Argument(normal.identifier.name));
      } else {
        final args = param.kind == ParameterKind.NAMED
            ? named
            : positionalOptional;
        final DefaultFormalParameter defaultParam = param;
        args.add(new _Argument(
          normal.identifier.name,
          defaultParam?.defaultValue?.toSource(),
        ));
      }
    }
  }

  /// Returns source code for forwarding the provided arguments from the
  /// constructor returned in [getArgumentForwarding].
  ///
  /// Example input constructor:
  ///
  ///     Foo(this.foo, {String bar: 'bar', int baz})
  ///
  /// Output String:
  ///    '''foo, bar: bar, baz: baz'''
  String getArgumentForwarding() {
    final sections = <String>[];
    if (positional.isNotEmpty) {
      sections.add(positionalNames.join(', '));
    }
    if (positionalOptionalNames.isNotEmpty) {
      sections.add(positionalOptionalNames.join(', '));
    }
    if (namedNames.isNotEmpty) {
      sections.add(namedNames.map((name) => '$name: $name').join(', '));
    }

    return sections.join(', ');
  }

  /// Returns source code of the provided arguments for use in another constructor,
  /// with any final field initializers stripped out.
  ///
  /// Currently, this doesn't include the types of the arguments, since they're
  /// not needed for certain usages, which avoids the complexity of dealing
  /// with inline typedef types.
  ///
  /// Example input constructor:
  ///
  ///     Foo(this.foo, {String bar: 'bar', int baz})
  ///
  /// Output String:
  ///    '''foo, {bar: 'bar', baz}'''
  ///
  String getArgumentsForForwarding() {
    final sections = <String>[];

    if (positionalNames.isNotEmpty) {
      sections.add(positionalNames.join(', '));
    }

    String optionalArg(_Argument arg) {
      return arg.defaultValue == null ? arg.name : '${arg.name} = ${arg.defaultValue}';
    }
    if (positionalOptional.isNotEmpty) {
      final argsWithDefaults = positionalOptional.map(optionalArg).join(', ');
      sections.add('[$argsWithDefaults]');
    }
    if (named.isNotEmpty) {
      final argsWithDefaults = named.map(optionalArg).join(', ');
      sections.add('{$argsWithDefaults}');
    }

    return sections.join(', ');
  }
}
