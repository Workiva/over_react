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
  String Function({int? indent})? getComponentRenderReturnValueSrc,
});

abstract class _ExtractComponentAssistContributorBase extends AssistContributorBase {
  AssistKind get _assistKind;
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

      final content = request.result.content!;
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
      ..message = _assistKind.message
      ..id = _assistKind.id;
    collector.addAssist(PrioritizedSourceChange(_assistKind.priority, sourceChange));
  }
}

const _extractComponentDesc = r'Extract selection as a new UiComponent';
// <editor-fold desc="Documentation Details">
const _extractComponentDetails = r'''

When a VDom element is selected by the user, the assist extracts the selection into the return value of
`render` within a new OverReact component declaration:

**EXAMPLE:**
```
ReactElement renderTheFoo() {
  return Dom.div()(
    'oh hai',
    Dom.span()('again'),
    Dom.em()(' wow this is a lot we should extract it into a component!'),
  );
}
```

**BECOMES:**
```
ReactElement renderTheFoo() {
  return Foo()();
}

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {
    return Dom.div()(
      'oh hai',
      Dom.span()('again'),
      Dom.em()(' wow this is a lot we should extract it into a component!'),
    );
  }
}
```

''';
// </editor-fold>

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `UiComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractStatefulComponentAssistContributor]
///
/// {@category Assists}
class ExtractComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractComponentDesc, details: _extractComponentDetails)
  static const extractComponent = AssistKind('extractComponent', 32, _extractComponentDesc);
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orStless';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiComponentBoilerplateLinkedEdit;
}

const _extractStatefulComponentDesc = r'Extract selection as a new UiStatefulComponent';
// <editor-fold desc="Stateful Documentation Details">
const _extractStatefulComponentDetails = r'''

When a VDom element is selected by the user, the assist extracts the selection into the return value of
`render` within a new OverReact stateful component declaration:

**EXAMPLE:**
```
ReactElement renderTheFoo() {
  return Dom.div()(
    'oh hai',
    Dom.span()('again'),
    Dom.em()(' wow this is a lot we should extract it into a component!'),
  );
}
```

**BECOMES:**
```
ReactElement renderTheFoo() {
  return Foo()();
}

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

mixin FooState on UiState {}

class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
  @override
  get defaultProps => (newProps());
  
  @override
  get initialState => (newState());

  @override
  render() {
    return Dom.div()(
      'oh hai',
      Dom.span()('again'),
      Dom.em()(' wow this is a lot we should extract it into a component!'),
    );
  }
}
```

''';
// </editor-fold>

/// An assist that extracts an [InvocationExpression] which returns a React VDom `ReactElement`
/// into a new standalone OverReact `UiStatefulComponent2` component.
///
/// Caveats:
///
///   1. The user's selection must include the builder and the invocation of that builder for the assist to appear
///   2. The user's selection cannot include any trailing semi-colons
///
/// > Related: [ExtractComponentAssistContributor]
///
/// {@category Assists}
class ExtractStatefulComponentAssistContributor extends _ExtractComponentAssistContributorBase {
  @DocsMeta(_extractStatefulComponentDesc, details: _extractStatefulComponentDetails)
  static const extractComponent = AssistKind('extractStatefulComponent', 32, _extractStatefulComponentDesc);
  @override
  get _assistKind => extractComponent;

  @override
  String get linkedEditGroupName => 'orStful';

  @override
  BoilerplateLinkedEditFn addBoilerplateLinkedEditFn = addUiStatefulComponentBoilerplateLinkedEdit;
}
