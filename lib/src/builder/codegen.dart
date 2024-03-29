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
  final bool nullSafety;

  ImplGenerator(this.logger, this.sourceFile, {required this.nullSafety});

  void generate(BoilerplateDeclaration declaration) {
    switch (declaration.type) {
      case DeclarationType.propsMapViewOrFunctionComponentDeclaration:
        _generatePropsMapViewOrFunctionComponent(
            declaration as PropsMapViewOrFunctionComponentDeclaration);
        break;
      case DeclarationType.classComponentDeclaration:
        _generateClassComponent(declaration as ClassComponentDeclaration);
        break;
      case DeclarationType.legacyClassComponentDeclaration:
        _generateLegacyClassComponent(declaration as LegacyClassComponentDeclaration);
        break;
      case DeclarationType.legacyAbstractPropsDeclaration:
        _generateLegacyAbstractProps(declaration as LegacyAbstractPropsDeclaration);
        break;
      case DeclarationType.legacyAbstractStateDeclaration:
        _generateLegacyAbstractState(declaration as LegacyAbstractStateDeclaration);
        break;
      case DeclarationType.propsMixinDeclaration:
        _generatePropsMixin(declaration as PropsMixinDeclaration);
        break;
      case DeclarationType.stateMixinDeclaration:
        _generateStateMixin(declaration as StateMixinDeclaration);
        break;
      default:
        throw ArgumentError('Unhandled declaration type: $declaration');
    }
  }

  /// Injects context variables like the output buffer into [generator], generates code,
  /// and then uninjects them.
  void _generateUsing(BoilerplateDeclarationGenerator generator) {
    generator
      ..setGenerationContext(
        sourceFile: sourceFile,
        outputContentsBuffer: outputContentsBuffer,
        logger: logger,
      )
      ..generate()
      // Clean these up so that `generator` can't use logger/outputContentsBuffer unexpectedly
      // outside of _generateUsing.
      ..clearGenerationContext();
  }

  void _generateLegacyClassComponent(LegacyClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryProxyGenerator.legacy(declaration));
    _generateUsing(TypedMapAccessorsGenerator.legacyProps(declaration, nullSafety: nullSafety));
    _generateUsing(TypedMapImplGenerator.legacyProps(declaration, nullSafety: nullSafety));
    if (declaration.state != null) {
      _generateUsing(TypedMapAccessorsGenerator.legacyState(declaration, nullSafety: nullSafety));
      _generateUsing(TypedMapImplGenerator.legacyState(declaration, nullSafety: nullSafety));
    }
    _generateUsing(ComponentGenerator.legacy(declaration, nullSafety: nullSafety));
  }

  void _generateLegacyAbstractProps(LegacyAbstractPropsDeclaration declaration) {
    _generateUsing(
        TypedMapAccessorsGenerator.legacyAbstractProps(declaration, nullSafety: nullSafety));
  }

  void _generateLegacyAbstractState(LegacyAbstractStateDeclaration declaration) {
    _generateUsing(
        TypedMapAccessorsGenerator.legacyAbstractState(declaration, nullSafety: nullSafety));
  }

  void _generatePropsMixin(PropsMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.propsMixin(declaration, nullSafety: nullSafety));
  }

  void _generateStateMixin(StateMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.stateMixin(declaration, nullSafety: nullSafety));
  }

  void _generateClassComponent(ClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryProxyGenerator(declaration));
    _generateUsing(TypedMapImplGenerator.props(declaration, nullSafety: nullSafety));
    if (declaration.state != null) {
      _generateUsing(TypedMapImplGenerator.state(declaration, nullSafety: nullSafety));
    }
    _generateUsing(ComponentGenerator(declaration, nullSafety: nullSafety));
  }

  void _generatePropsMapViewOrFunctionComponent(
      PropsMapViewOrFunctionComponentDeclaration declaration) {
    _generateUsing(
        TypedMapImplGenerator.propsMapViewOrFunctionComponent(declaration, nullSafety: nullSafety));
  }
}
