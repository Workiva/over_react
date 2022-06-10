import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as protocol;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as protocol;
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Wrap with ReactElement';
// <editor-fold desc="Documentation Details">
const _details = r'''

When a VDom element is selected by the user, the assist wraps the selection with another ReactElement:

**EXAMPLE:**
```
final foo = Dom.div()(
  'Hi there foo',
);
```

**BECOMES:**
```
final foo = component()(
  Dom.div()(
    'Hi there foo',
  ),
);  
```

''';
// </editor-fold>

class WrapUnwrapAssistContributor extends AssistContributorBase {
  @DocsMeta(_desc, details: _details)
  static const wrapInElement = AssistKind('wrapInElement', 30, _desc);

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _wrapInElement();
  }

  Future<void> _wrapInElement() async {
    // todo tweak where this happens: should happen on child of element
    final usage = identifyUsage(node);
    if (usage == null) {
      return;
    }

    final content = request.result.content!;
    final widgetSrc = content.substring(usage.node.offset, usage.node.end);
    final widgetSrcIndentedOneLevel = widgetSrc.split('\n').map((line) => '  ' + line).join('\n');
    final widgetIndent = getIndent(content, request.result.lineInfo, usage.node.offset);

    final enclosingComponentNameEstimate = estimateEnclosingComponentName(node);

    final overReactTypes = await OverReactTypes.forSession(request.result.session);
    final sourceChange = await buildFileEdit(request.result, (builder) {
      builder.addReplacement(range.node(usage.node), (builder) {
        // TODO how to compute easily compute suggestions for factories?
        final suggestions = getComponentFactorySuggestions(
          request.result.libraryElement,
          uiFactoryType: overReactTypes.uiFactoryType,
          typeSystem: request.result.typeSystem,
        )..remove(enclosingComponentNameEstimate);

        builder.addSimpleLinkedEdit('COMPONENT_NAME', 'ComponentName',
            kind: protocol.LinkedEditSuggestionKind.VARIABLE, suggestions: suggestions);

        builder.write('()');
        builder.selectHere();
        builder.write('(\n$widgetIndent');
        builder.write(widgetSrcIndentedOneLevel);
        builder.write(',');
        builder.selectHere();
        builder.write('\n$widgetIndent)');
      });
    });
    sourceChange
      ..message = wrapInElement.message
      ..id = wrapInElement.id;
    collector.addAssist(protocol.PrioritizedSourceChange(wrapInElement.priority, sourceChange));
  }
}

// TODO probably need to optimize this
List<String> getComponentFactorySuggestions(
  LibraryElement library, {
  required FunctionType uiFactoryType,
  required TypeSystem typeSystem,
}) {
  bool isUiFactory(Element element) {
    if (const {'domProps', 'ariaProps'}.contains(element.name)) return false;

    // Watch out: PropertyAccessorElement is  a subtype of FunctionTypedElement
    if (element is FunctionTypedElement) {
      if (element is PropertyAccessorElement) {
        return element.isGetter &&
            isUiFactoryType(element.returnType, typeSystem: typeSystem, uiFactoryType: uiFactoryType);
      } else {
        return isUiFactoryType(element.type, typeSystem: typeSystem, uiFactoryType: uiFactoryType);
      }
    } else if (element is PropertyInducingElement) {
      return isUiFactoryType(element.type, typeSystem: typeSystem, uiFactoryType: uiFactoryType);
    } else {
      return false;
    }
  }

  final names = <String>[];

  names.addAll(library.topLevelElements.where(isUiFactory).map((e) => e.name).whereNotNull());

  names.addAll(library.imports.expand((import) sync* {
    // These keys come with the namespace included
    yield* import.namespace.definedNames.entries.where((e) => isUiFactory(e.value)).map((e) => e.key);

    // TODO clean this up
    final importedUri = import.importedLibrary?.librarySource.uri;
    if (importedUri != null && isUriWithinPackage(importedUri, 'over_react')) {
      final domEntry = import.namespace.definedNames.entries.firstWhereOrNull((entry) => entry.value.name == 'Dom');
      if (domEntry != null) {
        const domComponentsToSuggest = ['div', 'span'];
        yield* domComponentsToSuggest.map((component) => '${domEntry.key}.$component');
      }
    }
  }));

  return names;
}

bool isUiFactoryType(
  DartType type, {
  required FunctionType uiFactoryType,
  required TypeSystem typeSystem,
}) {
  final staticTypeOrBound = type.typeOrBound;

  if (typeSystem.isSubtypeOf(staticTypeOrBound, uiFactoryType)) {
    // Filter out functions that return dynamic, for libraries that haven't disabled implicit casts.
    final returnType = staticTypeOrBound.tryCast<FunctionType>()?.returnType;
    if (returnType != null && !returnType.isDartCoreNull && !returnType.isDynamic) {
      return true;
    }
  }

  return false;
}

class OverReactTypes {
  final FunctionType uiFactoryType;
  final FunctionType builderOnlyUiFactoryType;

  OverReactTypes._({
    required this.uiFactoryType,
    required this.builderOnlyUiFactoryType,
  });

  // FIXME better handling of failure ccases
  static Future<OverReactTypes> forSession(AnalysisSession session) async {
    print('Resolving over_react library...');
    final overReactLibResult = await session
        .getResolvedLibrary2(session.uriConverter.uriToPath(Uri.parse('package:over_react/over_react.dart'))!);
    final getOverReactElement = (overReactLibResult as ResolvedLibraryResult).element!.exportNamespace.get;

    var uiFactoryType = instantiateGenericFunctionTypeBounds(getOverReactElement('UiFactory') as TypeAliasElement);

    var builderOnlyUiFactoryType =
        instantiateGenericFunctionTypeBounds(getOverReactElement('BuilderOnlyUiFactory') as TypeAliasElement);

    return OverReactTypes._(
      uiFactoryType: uiFactoryType,
      builderOnlyUiFactoryType: builderOnlyUiFactoryType,
    );
  }
}

FunctionType instantiateGenericFunctionTypeBounds(TypeAliasElement functionTypeAliasElement) {
  return functionTypeAliasElement.library.typeSystem.instantiateToBounds2(
      typeAliasElement: functionTypeAliasElement, nullabilitySuffix: NullabilitySuffix.star) as FunctionType;
}

String? estimateEnclosingComponentName(AstNode node) {
  final factoryOfClosestFunctionComponent = getClosestFunctionComponent(node)?.factoryVariable;
  if (factoryOfClosestFunctionComponent != null) {
    return factoryOfClosestFunctionComponent.name.name;
  }

  final closestClass = node.thisOrAncestorOfType<ClassDeclaration>();
  if (closestClass != null && closestClass.name.name.endsWith('Component')) {
    return closestClass.name.name.replaceFirst(RegExp(r'Component$'), '');
  }

  return null;
}
