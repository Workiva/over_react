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

part of '../members.dart';

/// A member representing a UiFactory variable.
///
/// See [BoilerplateMember] for more information.
class BoilerplateFactory extends BoilerplateMember {
  /// The entity that backs the boilerplate member.
  @override
  final TopLevelVariableDeclaration node;

  @override
  SimpleIdentifier get name => node.firstVariable.name;

  @override
  annotations.Factory get meta => const annotations.Factory();

  /// The [TypeAnnotation] for the component's factory.
  TypeAnnotation get propsGenericArg {
    final type = node.variables.type;
    if (type is NamedType && type.typeNameWithoutPrefix == 'UiFactory') {
      final typeArgs = type.typeArguments?.arguments;
      if (typeArgs?.length == 1) {
        return typeArgs[0];
      }
    }

    return null;
  }

  BoilerplateFactory(this.node, VersionConfidences confidence) : super(confidence);

  bool get hasFactoryAnnotation => node.hasAnnotationWithName('Factory');

  /// Verifies the correct implementation of a boilerplate factory
  ///
  /// Major checks included are:
  /// - Enforcing annotation for [Version.v3_legacyDart2Only]
  /// - Preventing the presence of multiple initializer variables
  /// - Verifying the presence of a generated factory
  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        break;
      case Version.v2_legacyBackwardsCompat:
      case Version.v3_legacyDart2Only:
        if (!hasFactoryAnnotation) {
          errorCollector.addError(
              'Legacy boilerplate factories must be annotated with `@Factory()`.',
              errorCollector.spanFor(name));
        }

        break;
    }

    if (node.variables.variables.length > 1) {
      errorCollector.addError('Factory declarations must be a single variable.',
          errorCollector.spanFor(node.variables));
    }

    final variable = node.variables.variables.first;
    final factoryName = variable.name.name;
    final generatedFactoryName = '$privateSourcePrefix$factoryName';

    final initializer = variable.initializer;
    final referencesGeneratedFactory = initializer != null &&
        anyDescendantIdentifiers(
            initializer, (identifier) => identifier.name == generatedFactoryName);

    if (!referencesGeneratedFactory) {
      errorCollector.addError(
          'Factory variables are stubs for the generated factories, and must '
          'be initialized with or otherwise reference the generated factory. Should be: `$factoryName = $generatedFactoryName`',
          errorCollector.spanFor(variable));
    }
  }
}
