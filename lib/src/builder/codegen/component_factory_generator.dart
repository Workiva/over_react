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

/// Generates aReactComponentFactoryProxys for a component declarations,
/// for all boilerplate versions.
class ComponentFactoryGenerator extends Generator {
  final ComponentNames componentNames;
  final String factoryName;

  final BoilerplateComponent component;
  final bool isComponent2;

  @override
  final Version version;

  ComponentFactoryGenerator.legacy(LegacyClassComponentDeclaration declaration)
      : factoryName = declaration.factory.name.name,
        componentNames = ComponentNames(declaration.component.name.name),
        component = declaration.component,
        isComponent2 = declaration.isComponent2,
        version = declaration.version;

  ComponentFactoryGenerator(ClassComponentDeclaration declaration)
      : factoryName = declaration.factory.name.name,
        componentNames = ComponentNames(declaration.component.name.name),
        component = declaration.component,
        isComponent2 = true,
        version = declaration.version;

  @override
  void generate() {
    _generateClassComponentFactory();
  }

  void _generateClassComponentFactory() {
    String parentTypeParam = 'null';
    String parentTypeParamComment = '';

    Identifier parentType = component.configSubtypeOf;
    if (parentType != null) {
      parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

      final parentNames = ComponentNames(parentType.name);
      parentTypeParam = parentNames.componentFactoryName;
    }

    if (parentTypeParam == componentNames.componentFactoryName) {
      /// It doesn't make sense to have a component subtype itself, and also an error occurs
      /// if a component's factory variable tries to reference itself during its initialization.
      /// Therefore, this is not allowed.
      // todo move to validation
      logger.severe(messageWithSpan('A component cannot be a subtype of itself.',
          span: getSpan(sourceFile, parentType)));
    }

    if (isComponent2) {
      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        ..write(internalGeneratedMemberDeprecationLine())
        ..writeln('final ${componentNames.componentFactoryName}'
            ' = registerComponent2(() => ${componentNames.implName}(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: ${componentNames.consumerName},')
        ..writeln('    isWrapper: ${component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)},');

      if ((component.meta as annotations.Component2).isErrorBoundary) {
        // Override `skipMethods` as an empty list so that
        // the `componentDidCatch` and `getDerivedStateFromError`
        // lifecycle methods are included in the component's JS bindings.
        outputContentsBuffer.writeln('    skipMethods: const [],');
      }

      outputContentsBuffer..writeln(');')..writeln();
    } else {
      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        ..write(internalGeneratedMemberDeprecationLine())
        ..writeln(
            'final ${componentNames.componentFactoryName} = registerComponent(() => ${componentNames.implName}(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: ${componentNames.consumerName},')
        ..writeln('    isWrapper: ${component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)}')
        ..writeln(');')
        ..writeln();
    }
  }
}
