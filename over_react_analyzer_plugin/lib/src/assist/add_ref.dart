import 'package:analyzer/analyzer.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';

class AddRefAssistContributor extends AssistContributorBase {
  static AssistKind addRef = new AssistKind('addRef', 32, 'Add callback ref');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _addRef();
  }

  Future<void> _addRef() async {
    final usage = identifyUsage(node);

    if (usage == null) return;

    // Check if it already has a ref
    if (getSetPropNames(usage).any((id) => id.name == 'ref')) {
      return;
    }

    final changeBuilder = new DartChangeBuilder(session);
    await changeBuilder.addFileEdit(request.result.path, (fileBuilder) {
      const nameGroup = 'refName';
      const typeGroup = 'refType';

      final componentName = usage.componentName;
      final lowerCaseComponentName = componentName == null
          ? 'component'
          : componentName.substring(0, 1).toLowerCase() + componentName.substring(1);
      final refName = '_${lowerCaseComponentName}Ref';

      final refTypeName = usage.isDom
          ? 'Element'
          // TODO split this out somewhere, make more robust
          : (componentName != null ? '${componentName}Component' : 'var');

      final lineInfo = request.result.unit.lineInfo;

      final insertionLocation = getRefInsertionLocation(usage.node, lineInfo);
      final insertionOffset = insertionLocation.first;
      final insertionParent = insertionLocation.last;
      final indent = insertionParent is CompilationUnit
          ? ''
          : getIndent(request.result.content, lineInfo, insertionParent.parent.offset) + '  ';

      // TODO how to get the linked edit to show up on the ref declaration instead? Why does this afterwards messes up the offsets?
      addProp(usage, fileBuilder, request.result.content, lineInfo,
          name: 'ref',
          buildValueEdit: (builder) {
        builder.write('(ref) { ');
        builder.addSimpleLinkedEdit(nameGroup, refName);
        builder.write(' = ref; }');
      });

      fileBuilder.addInsertion(insertionOffset, (builder) {
        builder.write('$indent');
        // TODO look up component type and use writeFieldDeclaration
//        builder.writeFieldDeclaration(refName, nameGroupName: nameGroup, typeGroupName: typeGroup);
        builder.addSimpleLinkedEdit(typeGroup, refTypeName);
        builder.write(' ');
        builder.addSimpleLinkedEdit(nameGroup, refName);
        builder.write(';');
        // TODO improve newlines handling adding first ref (add extra newline after)
        builder.write('\n');
      });
    });

    final sourceChange = changeBuilder.sourceChange
      ..message = addRef.message
      ..id = addRef.id;
    collector.addAssist(new PrioritizedSourceChange(addRef.priority, sourceChange));
  }
}

Pair<int, AstNode> getRefInsertionLocation(AstNode node, LineInfo lineInfo) {
  CompilationUnit closestUnit;
  // For now, don't support expression bodies since we can't easily insert a ref statement
  BlockFunctionBody closestFunctionBody;
  ClassDeclaration closestClass;

  for (; node != null; node = node.parent) {
    if (node is BlockFunctionBody) {
      closestFunctionBody ??= node;
    } else if (node is ClassDeclaration) {
      closestClass = node;
      break;
    } else if (node is CompilationUnit) {
      closestUnit = node;
      break;
    }
  }

  AstNode parent;
  int offset;

  if (closestClass != null) {
    parent = closestClass;
    offset = nextLine(closestClass.leftBracket.end, lineInfo);
  } else if (closestFunctionBody != null) {
    parent = closestFunctionBody;
    offset = nextLine(closestFunctionBody.block.leftBracket.end, lineInfo);
  } else if (closestUnit != null) {
    parent = closestUnit;
    offset = prevLine(node.thisOrAncestorMatching((node) => node is CompilationUnitMember).offset, lineInfo);
  } else {
    // Not sure how we got here... TODO throw error instead or handle this return value at call site
    return new Pair(-1, null);
  }

  for (var child in parent.childEntities.toList().reversed) {
    if (child is FieldDeclaration || child is VariableDeclarationStatement || child is TopLevelVariableDeclaration) {
      VariableDeclarationList variables;
      if (child is FieldDeclaration) {
        variables = child.fields;
      } else if (child is TopLevelVariableDeclaration) {
        variables = child.variables;
      } else {
        variables = (child as VariableDeclarationStatement).variables;
      }

      if (variables.variables.any((decl) => decl.name.name != 'Ref' && decl.name.name.endsWith('Ref'))) {
        offset = nextLine(child.end, lineInfo);
        break;
      }
    }
  }

  return new Pair(offset, parent);
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}
int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}
