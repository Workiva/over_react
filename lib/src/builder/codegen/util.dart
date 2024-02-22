// @dart=2.11
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

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';

import '../parsing.dart';
import 'names.dart';

abstract class BoilerplateDeclarationGenerator with TemporaryGenerationContext {
  @protected
  Version get version;

  @protected
  String internalGeneratedMemberDeprecationLine({String additionalMessageStringLiteral = ''}) {
    final string = version.isLegacy
        ? ''
        : '@Deprecated('
            "'This API is for use only within generated code.'"
            "' Do not reference it in your code, as it may change at any time.'"
            '$additionalMessageStringLiteral'
            ')\n';

    assert(string.isEmpty || string.endsWith('\n'),
        'code that consumes this relies on there being a trailing newline if it is non-empty');
    return string;
  }

  void generate();
}

/// Encapsulates context needed for generation which are temporarily stored via class fields
/// as opposed to being passing around.
///
/// TODO after the null safety migration, look into just passing these around to simplify this code.
///
/// Since these variables can't be non-nullable, expose non-nullable getters so that we don't have
/// to use `!` everywhere, and so that we get better error messages if they're ever null.
mixin TemporaryGenerationContext {
  SourceFile _sourceFile;
  StringBuffer _outputContentsBuffer;
  Logger _logger;

  StateError _uninitializedError(String name) =>
      StateError('$name is null. setGenerationContext must be called first to initialize it.');

  SourceFile get sourceFile => _sourceFile ?? (throw _uninitializedError('sourceFile'));
  StringBuffer get outputContentsBuffer =>
      _outputContentsBuffer ?? (throw _uninitializedError('outputContentsBuffer'));
  Logger get logger => _logger ?? (throw _uninitializedError('logger'));

  /// Populates fields needed temporarily for generation.
  void setGenerationContext({
     SourceFile sourceFile,
     StringBuffer outputContentsBuffer,
     Logger logger,
  }) {
    _sourceFile = sourceFile;
    _outputContentsBuffer = outputContentsBuffer;
    _logger = logger;
  }

  /// Clears fields set in [setGenerationContext].
  void clearGenerationContext() {
    _sourceFile = null;
    _outputContentsBuffer = null;
    _logger = null;
  }
}

String getAccessorKeyNamespace(TypedMapNames names, annotations.TypedMap meta) {
  // Default to the name of the class followed by a period.
  final defaultNamespace = '${names.publicName}.';
  // Allow the consumer to specify a custom namespace that trumps the default.
  final specifiedKeyNamespace = meta.keyNamespace;

  return specifiedKeyNamespace ?? defaultNamespace;
}

String generatedMixinWarningCommentLine(TypedMapNames mixinNames, { bool isProps}) {
  final value = '// If this generated mixin is undefined, it\'s likely because'
      ' ${mixinNames.consumerName} is not a valid `mixin`-based ${isProps ? 'props' : 'state'} mixin,'
      ' or because it is but the generated mixin was not imported.'
      ' Check the declaration of ${mixinNames.consumerName},'
      ' and check that ${mixinNames.generatedMixinName} is exported/imported properly.\n';

  assert(value.endsWith('\n'));

  return value;
}

void generatePropsMeta(
  StringBuffer buffer,
  List<String> mixins, {
  String classType = 'PropsMetaCollection',
  String fieldName = 'propsMeta',
}) {
  buffer
    ..writeln()
    ..writeln('  @override')
    ..writeln('  $classType get $fieldName => const $classType({');
  for (final name in mixins) {
    final names = TypedMapNames(name);
    buffer.write('    ${generatedMixinWarningCommentLine(names, isProps: true)}');
    buffer.writeln('    ${names.consumerName}: ${names.publicGeneratedMetaName},');
  }
  buffer.writeln('  });');
}
