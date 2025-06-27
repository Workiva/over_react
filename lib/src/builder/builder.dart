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

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart' show LanguageVersionToken;
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:package_config/package_config.dart' as pc;
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:source_span/source_span.dart';

import './util.dart';
import 'codegen.dart';
import 'codegen/language_version_util.dart';
import 'parsing.dart';

Builder overReactBuilder(BuilderOptions? options) => OverReactBuilder();

class OverReactBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': [outputExtension],
  };

  /// The generation order of boilerplate declarations.
  ///
  /// Changing the order of this iterable changes the order in which
  /// the builder will write the generated code to the output file.
  static const generationOrder = [
    DeclarationType.classComponentDeclaration,
    DeclarationType.legacyClassComponentDeclaration,
    DeclarationType.propsMixinDeclaration,
    DeclarationType.stateMixinDeclaration,
    DeclarationType.propsMapViewOrFunctionComponentDeclaration,
    DeclarationType.legacyAbstractPropsDeclaration,
    DeclarationType.legacyAbstractStateDeclaration,
  ];

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final source = await buildStep.readAsString(buildStep.inputId);
    final libraryUnit = _tryParseCompilationUnit(source, buildStep.inputId);
    if (libraryUnit == null) {
      return;
    }
    if (isPart(libraryUnit)) {
      return;
    }

    pc.LanguageVersion? packageConfigLanguageVersion;
    String nullSafetyReason;
    bool nullSafety;
    {
      final versionToken = libraryUnit.languageVersionToken;
      if (versionToken != null) {
        // If there's a language version comment, honor that.
        nullSafety = versionToken.supportsNullSafety;
        nullSafetyReason = {
          'languageVersion': '${versionToken.major}.${versionToken.minor}',
          'source': 'libraryVersionComment',
        }.toString();
      } else {
        // Otherwise, read the language version from the package config.
        //
        // Normally, builders would do this via (await buildStep.inputLibrary).languageVersion,
        // but that would trigger resolved analysis which we don't want to do for this builder,
        // for performance reasons.
        final packageName = buildStep.inputId.package;

        // Catch any errors coming from our implementation of `$packageConfig`.
        // We can remove this once we switch to build 2.4.0's `packageConfig`
        // (see `$packageConfig` doc comment for more info).
        try {
          packageConfigLanguageVersion = (await buildStep.$packageConfig)
              .packages
              .firstWhereOrNull((p) => p.name == packageName)
              ?.languageVersion;
        } catch (e, st) {
          log.warning('Error reading package config', e, st);
        }

        if (packageConfigLanguageVersion != null) {
          nullSafety = packageConfigLanguageVersion.supportsNullSafety;
          nullSafetyReason = {
            'languageVersion': packageConfigLanguageVersion,
            'source': 'packageConfig',
            'package': packageName,
          }.toString();
        } else {
          // If we don't have any information to go off of, opt out of null safety in 2.x,
          // and opt in for newer versions (Dart 3+).
          // It should be pretty unlikely that we don't have access to the package config,
          // or that the file being generated doesn't have an associated package.
          final platformOnlySupportsNullSafety = !Platform.version.startsWith('2.');
          nullSafety = platformOnlySupportsNullSafety;
          nullSafetyReason = {
            'languageVersion': 'unknown (no package config or package config entry)',
            'defaultNullSafetyForCurrentSdk': platformOnlySupportsNullSafety,
          }.toString();
        }
      }
    }

    final outputs = <String>[];
    void generateForFile(String source, AssetId id, CompilationUnit unit) {
      if (!mightContainDeclarations(source)) {
        return;
      }
      final sourceFile = SourceFile.fromString(
        source, url: idToPackageUri(id));

      //
      // Set up error collection, logging, and utilities to be used by parsing and codegen.
      //

      // A local flag to help determine if a specific call resulted in errors.
      // Should be reset before using.
      var hadErrors = false;
      final errorCollector = ErrorCollector.callback(sourceFile,
        onError: (message, [span]) {
          log.severe(span?.message(message) ?? message);
          hadErrors = true;
        },
        onWarning: (message, [span]) {
          log.warning(span?.message(message) ?? message);
        },
      );

      //
      // Parse boilerplate members and group them into declarations.
      //

      final members = detectBoilerplateMembers(unit);
      final declarations = getBoilerplateDeclarations(members, errorCollector).toList()
        ..sort((a, b) {
          return generationOrder.indexOf(a.type).compareTo(generationOrder.indexOf(b.type));
        });

      //
      // Validate boilerplate declarations and generate if there aren't any errors.
      //

      final generator = ImplGenerator(log, sourceFile, nullSafety: nullSafety);

      for (final declaration in declarations) {
        hadErrors = false;
        declaration.validate(errorCollector);
        if (!hadErrors) {
          generator.generate(declaration);
        } else {
          // Log the declaration that had issues for debugging purposes.
          log.severe('The above error(s) are associated with $declaration');
          log.fine('Members:');
          for (final member in declaration.members) {
            log.fine(member.debugString);
          }
        }
      }

      final generatedOutput = generator.outputContentsBuffer.toString().trim();
      if (generatedOutput.isNotEmpty) {
        outputs.add(generatedOutput);
      }
    }

    // Collect all of the part files for this library.
    final parts = getNonGeneratedParts(libraryUnit);

    // Generate over_react code for the input library.
    generateForFile(source, buildStep.inputId, libraryUnit);


    final outputId = buildStep.inputId.changeExtension(outputExtension);
    final expectedPart = p.basename(outputId.path);

    bool hasOutputPartDirective() {
      final partUris = libraryUnit.directives
        .whereType<PartDirective>()
        .map((p) => p.uri.stringValue);
      return partUris.contains(expectedPart);
    }

    // Generate over_react code for each part file of the input library.
    for (final part in parts) {
      final partId = AssetId.resolve(
        Uri.parse(part.uri.stringValue!),
        from: buildStep.inputId);
      if (!await buildStep.canRead(partId)) {
        continue;
      }
      final partSource = await buildStep.readAsString(partId);
      final partUnit = _tryParseCompilationUnit(partSource, partId);
      if (partUnit == null) {
        continue;
      }
      generateForFile(partSource, partId, partUnit);
    }

    if (outputs.isNotEmpty) {
      // Verify that the library file has an `.over_react.g.dart` part.
      if (!hasOutputPartDirective()) {
        log.severe('Missing "part \'$expectedPart\';".');
      }

      // Add an extra space, since `false` is one character longer than `true`, so that the next
      // sentence lines up when grepped across multiple files.
      final nullSafetyCommentText = 'Using nullSafety: $nullSafety.${nullSafety ? ' ' : ''} $nullSafetyReason';

      // Generated part files must have matching language version comments, so copy them over if they exist.
      final languageVersionComment = libraryUnit.languageVersionToken?.value();

      final formatter = DartFormatter(
          // Try to use the actual version of the library if possible:
          // 1. to avoid any potential parse errors
          // 2. to preserve existing formatting in checked-in generated files in this repo when running on Dart 2
          languageVersion: libraryUnit.languageVersionToken?.asSemver() ??
              packageConfigLanguageVersion?.asSemver() ??
              DartFormatter.latestLanguageVersion);

      await _writePart(buildStep, outputId, outputs,
          formatter: formatter,
          nullSafetyCommentText: nullSafetyCommentText,
          languageVersionComment: languageVersionComment);
    } else {
      if (hasOutputPartDirective()) {
        log.warning('An over_react part directive was found in ${buildStep.inputId.path}, '
            'but no code was generated. The part directive may be unnecessary if the file '
            'does not contain any concrete components or abstract state/props classes.');
      }
    }
  }

  static final _headerLine = '// '.padRight(77, '*');

  static CompilationUnit? _tryParseCompilationUnit(String source, AssetId id) {
    final result = parseString(content: source, path: id.path, throwIfDiagnostics: false);

    if (result.errors.isEmpty) return result.unit;

    log.fine('Analysis errors encountered when parsing compilation unit for file "$id":');
    // Warn and not severe in case parsing failed on an unrelated file due to an outdated
    // analyzer version in this builder.
    result.errors.forEach(log.warning);

    return result.unit;
  }

  static const _ignoreForFileCodes = {
    // Needed when the component itself or some of its props are deprecated,
    // or if deprecated types are referenced within the boilerplate.
    'deprecated_member_use_from_same_package',
    // These two are needed for the `?? null` workaround in prop accessors.
    'unnecessary_null_in_if_null_operators',
    'prefer_null_aware_operators',
    // Needed to ignore the `requiredPropNamesToSkipValidation` checks.
    'invalid_use_of_visible_for_overriding_member',
  };

  static FutureOr<void> _writePart(
    BuildStep buildStep,
    AssetId outputId,
    Iterable<String> outputs, {
    required DartFormatter formatter,
    required String nullSafetyCommentText,
    String? languageVersionComment,
  }) async {
    final partOf = "'${p.basename(buildStep.inputId.uri.toString())}'";

    final buffer = StringBuffer();
    if (languageVersionComment != null) {
      buffer.writeln(languageVersionComment);
    }
    buffer
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln()
      ..writeln('// ignore_for_file: ${_ignoreForFileCodes.join(', ')}')
      ..writeln('part of $partOf;')
      ..writeln()
      ..writeln(_headerLine)
      ..writeln('// OverReactBuilder (package:over_react/src/builder.dart)');
    // Omit this for now for filed from over_react so it doesn't show up as a diff in golds and
    // checked in files in the conditional null safety generation PR.
    // TODO re-enable after that merges.
    if (outputId.package != 'over_react') {
      buffer
        ..writeln('//')
        ..write(lineComment(nullSafetyCommentText));
    }
    buffer.writeln(_headerLine);

    for (final item in outputs) {
      buffer
        ..writeln()
        ..writeln(item);
    }

    var output = buffer.toString();
    // Output the file even if formatting fails, so that it can be used to debug the issue.
    try {
      output = formatter.format(buffer.toString());
    } catch (e, st) {
      log.severe('Error formatting generated code', e, st);
    }
    await buildStep.writeAsString(outputId, output);
  }
}

extension on pc.LanguageVersion {
  semver.Version asSemver() => semver.Version(major, minor, 0); // There's no patch available on this version.
}

extension on LanguageVersionToken {
  semver.Version asSemver() => semver.Version(major, minor, 0); // There's no patch available on this version.
}

extension on BuildStep {
  // Cache the result so we don't read and parse the package config for every file.
  //
  // This value should be safe to reuse globally within an isolate.
  static pc.PackageConfig? _cachedPackageConfig;

  /// Polyfill for build 2.4.0's BuildStep.packageConfig, which only seems to be resolvable in Dart 3.
  /// From: https://github.com/dart-lang/build/issues/3492#issuecomment-1533455176
  ///
  /// We could name this `packageConfig` and have it get shadowed by the real implementation from
  /// `BuildStep` when 2.4.0 is resolved to, but that feels unnecessarily risky, and we can just
  /// follow up later to remove this extension and use the real implementation instead.
  Future<pc.PackageConfig> get $packageConfig async {
    return _cachedPackageConfig ??= await pc.loadPackageConfigUri((await Isolate.packageConfig)!);
  }
}
