import 'package:analyzer_plugin/protocol/protocol_common.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:source_span/source_span.dart';

class IncorrectDocCommentLocationDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_incorrect_doc_comment_location',
    "Doc comments should be above the factory declaration.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );

  static final fixKind = FixKind(
    code.name,
    200,
    'Move comment above factory',
  );

  @override
  computeErrors(result, collector) async {
    final sourceFile = SourceFile.fromString(result.content, url: result.path);
    final errorCollector = ErrorCollector.callback(sourceFile);
    final declarations = parseDeclarations(result.unit, errorCollector);

    for (final decl in declarations) {
      final factories = decl.members.whereType<BoilerplateFactory>();

      if (factories.isNotEmpty) {
        for (final member in decl.members) {
          final docComment = member.node.documentationComment;

          if (docComment != null && member is! BoilerplateFactory) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(docComment),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addDeletion(range.startOffsetEndOffset(
                  // [offset - 1] to remove the extra line.
                  docComment.offset - 1,
                  docComment.end,
                ));
                builder.addInsertion(factories.first.node.offset, (builder) {
                  for (final line in docComment.childEntities) {
                    builder.write('${line.toString()}\n');
                  }
                });
              }),
            );
          }
        }
      }
    }
  }
}
