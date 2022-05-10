import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:path/path.dart' as p;

import 'config.dart';

Future<void> registerContributorMetadata(List<DocsGenerationConfig> configs) async {
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final collection = AnalysisContextCollection(
    includedPaths: [p.canonicalize('lib')],
    resourceProvider: resourceProvider,
  );
  for (final filePath
      in Glob('lib/src/{${configs.map((c) => c.srcDir).join(',')}}/**').listSync().map((f) => p.canonicalize(f.path))) {
    final resolvedUnit = await collection.contextFor(filePath).currentSession.getResolvedUnit(filePath);
    resolvedUnit.unit!.declaredElement!.accept(ContributorVisitor(configs));
  }
}

class ContributorVisitor extends RecursiveElementVisitor<void> {
  final List<DocsGenerationConfig> _configs;
  ContributorVisitor(this._configs);

  @override
  void visitClassElement(ClassElement element) {
    for (final config in _configs) {
      if (!element.isOrIsSubtypeOfTypeFromPackage(
          config.typeNameOfContributorClass, config.packageNameContainingContributorClass)) continue;

      final annotatedFields = element.fields
          .where((f) => f.metadata.any((a) => a.element!.thisOrAncestorOfType<ClassElement>()?.name == 'DocsMeta'));
      for (final field in annotatedFields) {
        if (!field.isConst) {
          throw UnsupportedError(
              'The DocsMeta() annotation should only be used to annotate constant values:\n    ${field.toString()}');
        }

        if (field.type.element.isOrIsSubtypeOfTypeFromPackage(
            config.typeNameOfAnnotatedField, config.packageNameContainingAnnotatedFieldType)) {
          config.registry.register(config.getMeta(field));
        } else {
          throw UnsupportedError(
              'The DocsMeta() annotation was found on a field of an unsupported type:\n    ${field.type}');
        }
      }
    }
  }
}
