import 'package:analyzer/dart/ast/ast.dart';
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
  AssistKind get extractComponent;
  String get linkedEditGroupName;
  BoilerplateLinkedEditFn get addBoilerplateLinkedEditFn;

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    // Only compute when there's a selection
    //
    // TODO: Its pretty annoying that if your selection includes the semi-colon at the end of a return statement, the length is zero.
    if (request.length == 0) return;

    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _extractComponent();
  }

  Future<void> _extractComponent() async {
    final usage = identifyUsage(node);

    if (usage == null) return;

    final sourceChange = await buildFileEdit(request.result, (builder) {
      // TODO: It would be nice to ensure that an OverReact generated part directive is added, but it doesn't seem possible without screwing up the offsets for all the edits that follow.

      final content = request.result.content;
      builder.addInsertion(content.length, (builder) {
        builder.write('\n');
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
      ..message = extractComponent.message
      ..id = extractComponent.id;
    collector.addAssist(PrioritizedSourceChange(extractComponent.priority, sourceChange));
  }
}

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `UiComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractStatefulComponentAssistContributor], [ExtractFluxComponentAssistContributor]
///
/// {@category Assists}
class ExtractComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @override
  AssistKind extractComponent = AssistKind('extractComponent', 32, 'Extract selection as a new UiComponent');

  @override
  String get linkedEditGroupName => 'orStless';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiComponentBoilerplateLinkedEdit;
}

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `UiStatefulComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractComponentAssistContributor], [ExtractFluxStatefulComponentAssistContributor]
///
/// {@category Assists}
class ExtractStatefulComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @override
  AssistKind extractComponent =
      AssistKind('extractStatefulComponent', 32, 'Extract selection as a new UiStatefulComponent');

  @override
  String get linkedEditGroupName => 'orStful';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiStatefulComponentBoilerplateLinkedEdit;
}

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `UiComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractFluxStatefulComponentAssistContributor]
///
/// {@category Assists}
class ExtractFluxComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @override
  AssistKind extractComponent = AssistKind('extractFluxComponent', 32, 'Extract selection as a new FluxUiComponent');

  @override
  String get linkedEditGroupName => 'orFlux';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addFluxUiComponentBoilerplateLinkedEdit;
}

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `FluxUiStatefulComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractFluxComponentAssistContributor], [ExtractStatefulComponentAssistContributor]
///
/// {@category Assists}
class ExtractFluxStatefulComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @override
  AssistKind extractComponent =
      AssistKind('extractFluxStatefulComponent', 32, 'Extract selection as a new FluxUiStatefulComponent');

  @override
  String get linkedEditGroupName => 'orFluxStful';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addFluxUiStatefulComponentBoilerplateLinkedEdit;
}
