import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';
import 'package:over_react_analyzer_plugin/src/util/linked_edits.dart';
import 'package:over_react_analyzer_plugin/src/util/node.dart';

typedef BoilerplateLinkedEditFn = void Function(
  DartEditBuilder builder, {
  String groupName,
  String componentFactoryName,
  String Function({int indent}) getComponentRenderReturnValueSrc,
});

abstract class _ExtractComponentAssistContributorBase extends AssistContributorBase {
  AssistKind get _assistKind;
  String get linkedEditGroupName;
  BoilerplateLinkedEditFn get addBoilerplateLinkedEditFn;

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    // Only compute when there's a selection
    if (request.length == 0) return;

    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _extractComponent();
  }

  Future<void> _extractComponent() async {
    final usage = identifyUsage(node);

    if (usage == null) return;

    // TODO: Why can't we create a new file within an Assist? (It works within fixes)
    // TODO: Possibly create an analogous diagnostic + fix that prompts the user to move the component boilerplate that our assist puts at the end of the existing file to a new file that we generate (since we can do it in a fix)
    // TODO: Is there a heuristic we could use to have a more sane default for the new file name?
    // final newFileName = path.join(path.dirname(request.result.path), 'extracted_component.dart');

    final sourceChange = await buildFileEdit(request.result, (builder) {
      final content = request.result.content;
      builder.addInsertion(content.length, (builder) {
        builder.write('\n\n');
        addBoilerplateLinkedEditFn(
          builder,
          groupName: linkedEditGroupName,
          getComponentRenderReturnValueSrc: ({indent}) {
            return getNodeSource(
              usage.node,
              content,
              request.result.lineInfo,
              indent: indent,
              firstLineIndent: 0,
            );
          },
        );
      });

      builder.addReplacement(SourceRange(usage.node.offset, usage.node.length), (builder) {
        builder.addSimpleLinkedEdit(linkedEditGroupName, 'Foo');
        builder.write('()()');
      });
    });

    sourceChange
      ..message = _assistKind.message
      ..id = _assistKind.id;
    collector.addAssist(PrioritizedSourceChange(_assistKind.priority, sourceChange));
  }
}

// TODO
const _extractComponentDesc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _extractComponentDetails = r'''

TODO

''';
// </editor-fold>

class ExtractComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractComponentDesc, details: _extractComponentDetails)
  static const extractComponent = AssistKind('extractComponent', 32, 'Extract selection as a new UiComponent');
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orStless';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiComponentBoilerplateLinkedEdit;
}

// TODO
const _extractStatefulComponentDesc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _extractStatefulComponentDetails = r'''

TODO

''';
// </editor-fold>

class ExtractStatefulComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractStatefulComponentDesc, details: _extractStatefulComponentDetails)
  static const extractComponent =
      AssistKind('extractStatefulComponent', 32, 'Extract selection as a new UiStatefulComponent');
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orStful';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiStatefulComponentBoilerplateLinkedEdit;
}

// TODO
const _extractFluxComponentDesc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _extractFluxComponentDetails = r'''

TODO

''';
// </editor-fold>

class ExtractFluxComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractFluxComponentDesc, details: _extractFluxComponentDetails)
  static const extractComponent = AssistKind('extractFluxComponent', 32, 'Extract selection as a new FluxUiComponent');
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orFlux';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addFluxUiComponentBoilerplateLinkedEdit;
}

// TODO
const _extractFluxStatefulComponentDesc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _extractFluxStatefulComponentDetails = r'''

TODO

''';
// </editor-fold>

class ExtractFluxStatefulComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractFluxStatefulComponentDesc, details: _extractFluxStatefulComponentDetails)
  static const extractComponent =
      AssistKind('extractFluxStatefulComponent', 32, 'Extract selection as a new FluxUiStatefulComponent');
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orFluxStful';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addFluxUiStatefulComponentBoilerplateLinkedEdit;
}
