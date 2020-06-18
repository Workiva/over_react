import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/component_assist_api.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';
import 'package:over_react_analyzer_plugin/src/util/node.dart';

class ToggleComponentStatefulness extends AssistContributorBase {
  static AssistKind makeStateful = AssistKind('makeStateful', 30, 'Make component stateful.');
  static AssistKind makeStateless = AssistKind('makeStateless', 30, 'Make component stateless.');

  ComponentDeclarationAssistApi _componentApi;

  var _componentName = '';
  ClassDeclaration parent;
  List<MixinDeclaration> mixins;

  NamedType get componentType => parent?.extendsClause?.childEntities?.whereType<TypeName>()?.first;

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    _componentApi = ComponentDeclarationAssistApi(request.result.unit, node, request.result.content);

    if (!_componentApi.isAValidComponentDeclaration) return;

    _componentName = getComponentName(node);
    parent = _getComponentClassDeclaration(node);
    final file = node.thisOrAncestorOfType<CompilationUnit>();
    mixins = file.childEntities.whereType<MixinDeclaration>().toList();

    if (_isStateful(node)) {
      await _removeStatefulness();
    } else {
      await _addStatefulness();
    }
  }

  ClassDeclaration _getComponentClassDeclaration(AstNode node) {
    if (node.parent == null) return null;
    return node.parent as ClassDeclaration;
  }

  bool _isStateful(AstNode node) {
    if (parent == null) return false;

    return componentType.name.name.contains('UiStatefulComponent2');
  }


  Future<void> _addStatefulness() async {
    if (parent == null) return;

    final sourceChange = await buildFileEdit(request.result, (builder) {
      final renderMethod = parent.childEntities.firstWhere((e) {
        if (e is MethodDeclaration) {
          if (e.name.name == 'render') {
            return true;
          }
        }

        return false;
      });

      final indent = getIndent(request.result.content, request.result.unit.declaredElement.lineInfo, renderMethod.offset);

      builder.addInsertion(renderMethod.offset - 2, (builder) {
        builder.write('\n${indent}@override');
        builder.write('\n${indent}get initialState => (newState());\n\n');
      });

      builder.addInsertion(node.parent.offset - 1, (builder) {
        builder.write('\nmixin ${_componentApi.normalizedComponentName}State on UiState {}\n');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write('UiStatefulComponent2<${_componentApi.normalizedComponentName}Props, ${_componentApi.normalizedComponentName}State>');
      });
    });
    sourceChange
      ..message = makeStateful.message
      ..id = makeStateful.id;
    collector.addAssist(PrioritizedSourceChange(makeStateful.priority, sourceChange));
  }

  Future<void> _removeStatefulness() async {
    if (parent == null) return;

    final stateNode = mixins.firstWhere((m) => m.name.name.contains('${_componentApi.normalizedComponentName}State'));

    final sourceChange = await buildFileEdit(request.result, (builder) {
      final initialState = parent.childEntities.firstWhere((e) {
        if (e is MethodDeclaration) {
          if (e.name.name == 'initialState') {
            return true;
          }
        }

        return false;
      });
      final r = range.node(stateNode);
      final r2 = range.node(initialState);

      builder.addReplacement(SourceRange(r.offset - 2, r.length + 2), (builder) {
        builder.write('');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write('UiComponent2<${_componentName}Props>');
      });

      builder.addReplacement(SourceRange(r2.offset - 4, r2.length + 5), (builder) {
        builder.write('');
      });
    });
    sourceChange
      ..message = makeStateless.message
      ..id = makeStateless.id;
    collector.addAssist(PrioritizedSourceChange(makeStateless.priority, sourceChange));
  }
}

class OverReactProps {
  final String name;

  OverReactProps(this.name);
}
