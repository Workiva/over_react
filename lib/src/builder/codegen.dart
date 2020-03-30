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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:logging/logging.dart';
import 'package:source_span/source_span.dart';

import 'codegen/accessors_generator.dart';
import 'codegen/component_factory_generator.dart';
import 'codegen/component_generator.dart';
import 'codegen/typed_map_impl_generator.dart';
import 'codegen/util.dart';
import 'parsing.dart';

/// A utility class that generates implementations for valid [BoilerplateDeclaration]s of any type
/// and appends them to [outputContentsBuffer].
class ImplGenerator {
  final StringBuffer outputContentsBuffer = StringBuffer();
  final Logger logger;
  final SourceFile sourceFile;

  ImplGenerator(this.logger, this.sourceFile);

  void generate(BoilerplateDeclaration declaration) {
    switch (declaration.type) {
      case DeclarationType.propsMapViewOrFunctionComponentDeclaration:
        _generatePropsMapViewOrFunctionComponent(declaration);
        break;
      case DeclarationType.classComponentDeclaration:
        _generateClassComponent(declaration);
        break;
      case DeclarationType.legacyClassComponentDeclaration:
        _generateLegacyClassComponent(declaration);
        break;
      case DeclarationType.legacyAbstractPropsDeclaration:
        _generateLegacyAbstractProps(declaration);
        break;
      case DeclarationType.legacyAbstractStateDeclaration:
        _generateLegacyAbstractState(declaration);
        break;
      case DeclarationType.propsMixinDeclaration:
        _generatePropsMixin(declaration);
        break;
      case DeclarationType.stateMixinDeclaration:
        _generateStateMixin(declaration);
        break;
      default:
        throw ArgumentError('Unhandled declaration type: $declaration');
    }
  }

  /// Injects context variables like the output buffer into [generator], generates code,
  /// and then uninjects them.
  void _generateUsing(Generator generator) {
    generator
      ..sourceFile = sourceFile
      ..outputContentsBuffer = outputContentsBuffer
      ..logger = logger
      ..generate()
      // Clean these up so that `generator` can't use logger/outputContentsBuffer unexpectedly
      // outside of _generateUsing.
      ..sourceFile = null
      ..outputContentsBuffer = null
      ..logger = null;
  }

  void _generateLegacyClassComponent(LegacyClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryProxyGenerator.legacy(declaration));
    _generateUsing(TypedMapAccessorsGenerator.legacyProps(declaration));
    _generateUsing(TypedMapImplGenerator.legacyProps(declaration));
    if (declaration.state != null) {
      _generateUsing(TypedMapAccessorsGenerator.legacyState(declaration));
      _generateUsing(TypedMapImplGenerator.legacyState(declaration));
    }
    _generateUsing(ComponentGenerator.legacy(declaration));
  }

  void _generateLegacyAbstractProps(LegacyAbstractPropsDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.legacyAbstractProps(declaration));
  }

  void _generateLegacyAbstractState(LegacyAbstractStateDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.legacyAbstractState(declaration));
  }

  void _generatePropsMixin(PropsMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.propsMixin(declaration));
  }

  void _generateStateMixin(StateMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.stateMixin(declaration));
  }

  void _generateClassComponent(ClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryProxyGenerator(declaration));
    _generateUsing(TypedMapImplGenerator.props(declaration));
    if (declaration.state != null) {
      _generateUsing(TypedMapImplGenerator.state(declaration));
    }
    _generateUsing(ComponentGenerator(declaration));
  }

  void _generatePropsMapViewOrFunctionComponent(
      PropsMapViewOrFunctionComponentDeclaration declaration) {
    _generateUsing(TypedMapImplGenerator.propsMapViewOrFunctionComponent(declaration));
  }
}
