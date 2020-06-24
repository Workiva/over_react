import 'package:analyzer_plugin/protocol/protocol_common.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:source_span/source_span.dart';

const _desc = r'Place documentation comments above component factories.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to place documentation comments on the `UiFactory` since that is what consumers use to build / render
in their application.

If the documentation comment that contains details such as usage instructions, documentation links, etc. is placed
on the `UiComponent2` instance, the consumer will not be able to easily find it when consuming it. 

**GOOD:**
```
/// Use a `FooBar` to render a `Bar` wrapped with a `Foo` so that it brings more fooness to the bar. 
///
/// Example:
///
/// ```dart
/// FooBar()('Bar with more foo!')
/// ```
UiFactory<FooBarProps> FooBar = _$FooBar; // ignore: undefined_identifier

mixin FooBarPropsMixin on UiProps, FooProps {
  Map barProps;
}

class FooBarProps = UiProps with FooProps, FooBarPropsMixin;

class FooBarComponent extends UiComponent2<FooBarProps> {
  @override
  get consumedProps => propsMeta.forMixins({
    FooBarPropsMixin,
  });

  @override
  render() {
    return (Foo()..modifyProps(addUnconsumedProps))(
      (Bar()..addProps(props.barProps))(props.children)
    );
  }
}
```

**BAD:**
```
UiFactory<FooBarProps> FooBar = _$FooBar; // ignore: undefined_identifier

mixin FooBarPropsMixin on UiProps, FooProps {
  Map barProps;
}

class FooBarProps = UiProps with FooProps, FooBarPropsMixin;

/// Use a `FooBar` to render a `Bar` wrapped with a `Foo` so that it brings more fooness to the bar. 
///
/// Example:
///
/// ```dart
/// FooBar()('Bar with more foo!')
/// ```
class FooBarComponent extends UiComponent2<FooBarProps> {
  @override
  get consumedProps => propsMeta.forMixins({
    FooBarPropsMixin,
  });

  @override
  render() {
    return (Foo()..modifyProps(addUnconsumedProps))(
      (Bar()..addProps(props.barProps))(props.children)
    );
  }
}
```

''';
// </editor-fold>

class IncorrectDocCommentLocationDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_incorrect_doc_comment_location',
    _desc,
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
    correction:
        'Place documentation comments above the UiFactory instead so that consumers can see them when consuming them.',
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
      if (decl is PropsMapViewOrFunctionComponentDeclaration) continue;

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
