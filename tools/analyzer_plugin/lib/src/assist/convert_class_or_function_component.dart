import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _convertToClassDesc = r'Convert to class component';
const _convertToFunctionDesc = r'Convert to function component';
// <editor-fold desc="Documentation Details">
const _convertToClassDetails = r'''''';
const _convertToFunctionDetails = r'''''';

class ConvertClassOrFunctionComponentAssistContributor extends AssistContributorBase {
  @DocsMeta(_convertToClassDesc, details: _convertToClassDetails)
  static const convertToClass = AssistKind('convertToClass', 30, _convertToClassDesc);

  @DocsMeta(_convertToFunctionDesc, details: _convertToFunctionDetails)
  static const convertToFunction = AssistKind('convertToFunction', 30, _convertToFunctionDesc);

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    // todo get this working on the factory as well
    final closestClass = node.thisOrAncestorOfType<ClassDeclaration>();
    if (closestClass != null) {
      await _tryConvertClassComponent(closestClass);
      return;
    }

    // todo make sure this works on the whole factory variable declaration and not just when you're inside the function
    final closestFunctionComponent = getClosestFunctionComponent(node);
    if (closestFunctionComponent != null) {
      await _tryConvertFunctionComponent(closestFunctionComponent);
      return;
    }
  }

  Future<void> _tryConvertClassComponent(ClassDeclaration closestClass) async {
    // todo use over_react builders' boilerplate parsing to get the associated factory and config instead of this logic

    if (!closestClass.name.name.endsWith('Component')) return;

    final name = closestClass.name.name.substring(0, closestClass.name.name.length - 'Component'.length);
    final generatedFactoryConfigName = '_\$${name}Config';

    final factory = node
        .thisOrAncestorOfType<CompilationUnit>()
        ?.declarations
        .whereType<TopLevelVariableDeclaration>()
        .expand((element) => element.variables.variables)
        .firstWhere((element) => element.name.name == name);
    if (factory == null) return;

    final factoryDecl = factory.thisOrAncestorOfType<TopLevelVariableDeclaration>()!;

    final factoryInitializer = factory.initializer;
    if (factoryInitializer == null) return;

    // todo migrate defaults?

    final render = closestClass.members.whereType<MethodDeclaration>().firstWhereOrNull((m) => m.name.name == 'render');
    if (render == null) return;

    final renderBody = render.body;
    if (renderBody is EmptyFunctionBody) return;

    final getSource = request.result.content!.substring;

    const classMemberIndent = '  ';
    const functionComponentBodyIndent = '    ';

    late String newRenderSource;
    if (renderBody is BlockFunctionBody) {
      newRenderSource = getSource(renderBody.block.leftBracket.end, renderBody.block.rightBracket.offset);
    } else if (renderBody is ExpressionFunctionBody) {
      final bodyExpressionSource = getSource(renderBody.expression.offset, renderBody.expression.end);
      newRenderSource = '\n${functionComponentBodyIndent}return $bodyExpressionSource;\n';
    } else {
      // This case is currently unreachable, but may become reachable if new function body types are ever added.
      newRenderSource = getSource(renderBody.offset, renderBody.end);
    }

    final otherMethodsSources = closestClass.members
        .where((member) => member != render)
        // Add indentation since `.offset` won't include it.
        // Assume it's two spaces since it should always be, and getting the actual indent is more effort.
        .map((e) => classMemberIndent + getSource(e.offset, e.end))
        // Indent one more level to match the new indentation of the function body.
        .map((e) => e.split('\n').map((e) => '  $e').join('\n'))
        .join('\n\n');

    if (otherMethodsSources.isNotEmpty) {
      newRenderSource = '\n$otherMethodsSources\n$newRenderSource';
    }

    final changeBuilder = ChangeBuilder(session: request.result.session);

    await changeBuilder.addGenericFileEdit(request.result.path!, (builder) {
      builder.addSimpleReplacement(range.node(closestClass), '');
      builder.addSimpleReplacement(
          range.node(factoryInitializer),
          'uiFunction(\n'
          '  (props) {$newRenderSource},\n'
          '  $generatedFactoryConfigName, // ignore:undefined_identifier\n'
          ')');

      final comment = factoryDecl.semicolon.next?.precedingComments;
      if (comment != null && isSameLine(request.result.lineInfo, comment.offset, factoryDecl.semicolon.end)) {
        if (request.result.content!.substring(comment.offset, comment.end).contains('undefined_identifier')) {
          builder.addSimpleReplacement(range.token(comment), '');
        }
      }

      // todo also remove undefined_identifier comment from class factory
    });
    changeBuilder.setSelection(Position(request.result.path!, factoryInitializer.offset));

    final sourceChange = changeBuilder.sourceChange
      ..message = convertToFunction.message
      ..id = convertToFunction.id;
    collector.addAssist(PrioritizedSourceChange(convertToFunction.priority, sourceChange));
  }

  Future<void> _tryConvertFunctionComponent(FunctionComponent functionComponent) async {
    final factory = functionComponent.factoryVariable;
    if (factory == null) return;

    final functionComponentBody = functionComponent.body;
    final factoryInitializer = factory.initializer!;

    // todo use over_react builders' boilerplate parsing to get the associated factory and name of assiciated props class instead of this logic

    final name = factory.name.name;
    final componentClassName = '${name}Component';
    final generatedFactoryName = '_\$$name';
    final propsClassName = '${name}Props';

    // todo check for hooks
    // todo migrate defaults?

    final renderSource = request.result.content!.substring(functionComponentBody.offset,
        functionComponentBody.tryCast<ExpressionFunctionBody>()?.semicolon?.offset ?? functionComponentBody.end);

    final changeBuilder = ChangeBuilder(session: request.result.session);

    await changeBuilder.addGenericFileEdit(request.result.path!, (builder) {
      // todo also add undefined_identifier to initializer class factory
      builder.addSimpleReplacement(range.node(factoryInitializer), 'castUiFactory($generatedFactoryName)');

      // TODO find real props class and put after that
      final insertionLocation = (node
                  .thisOrAncestorOfType<CompilationUnit>()
                  ?.declarations
                  .whereType<NamedCompilationUnitMember>()
                  .firstWhereOrNull((element) => element.name.name == propsClassName) ??
              factoryInitializer.thisOrAncestorOfType<CompilationUnitMember>()!)
          .end;

      final needsSemicolon = functionComponentBody is ExpressionFunctionBody;

      builder.addSimpleInsertion(
          insertionLocation,
          '\n\nclass $componentClassName extends UiComponent2<$propsClassName> {\n'
          '  @override\n'
          '  render() $renderSource${needsSemicolon ? ';' : ''}\n'
          '}');
    });

    final sourceChange = changeBuilder.sourceChange
      ..message = convertToClass.message
      ..id = convertToClass.id;
    collector.addAssist(PrioritizedSourceChange(convertToClass.priority, sourceChange));
  }
}
