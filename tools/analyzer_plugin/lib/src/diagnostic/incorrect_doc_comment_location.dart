import 'package:analyzer_plugin/protocol/protocol_common.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:source_span/source_span.dart';

// TODO
const _desc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _details = r'''

TODO

''';
// </editor-fold>

class IncorrectDocCommentLocationDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_incorrect_doc_comment_location',
    "Doc comments should be on factory so that consumers can see them when using the component.",
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
        final factory = factories.first.node;
        for (final member in decl.members) {
          final docComment = member.node.documentationComment;

          if (docComment != null && member is! BoilerplateFactory && factory.documentationComment == null) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(docComment),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                // Remove the whole line if possible.
                var end = docComment.end;
                if (sourceFile.getText(end, end + 1) == '\n') {
                  end = end + 1;
                }
                builder.addDeletion(range.startOffsetEndOffset(
                  docComment.offset,
                  end,
                ));
                builder.addInsertion(factory.offset, (builder) {
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
