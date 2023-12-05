import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

import 'ast_util.dart';
import 'util.dart';

ClassDeclaration? getClosestClassComponent(AstNode node) =>
    node.ancestors.whereType<ClassDeclaration>().firstWhereOrNull((c) => c.declaredElement?.isComponentClass ?? false);
