import 'package:analyzer/dart/ast/ast.dart';
import 'package:source_span/source_span.dart';

// ignore_for_file: implementation_imports
import 'package:over_react/src/builder/parsing/error_collection.dart';
import 'package:over_react/src/builder/parsing/members.dart';
import 'package:over_react/src/builder/parsing/members_from_ast.dart';
import 'package:over_react/src/builder/parsing/declarations_from_members.dart';
import 'package:over_react/src/builder/parsing/declarations.dart';
import 'package:over_react/src/builder/parsing/util.dart';
import 'package:over_react/src/builder/parsing/member_association.dart';

class ComponentDeclarationAssistApi {
  SourceFile componentSourceFile;
  BoilerplateMembers members;
  List<BoilerplateDeclaration> declarations;
  ClassComponentDeclaration component;

  ErrorCollector errorCollector;

  bool _isAValidComponentDeclaration;
  bool get isAValidComponentDeclaration => _isAValidComponentDeclaration;

  String get normalizedComponentName => getMemberName(members.components.first);

  String getMemberName(BoilerplateMember member) => normalizeNameAndRemoveSuffix(member);

  bool isAValidComponentClass(CompilationUnit unit, AstNode selectedNode, String sourceFileContent) {
    if (selectedNode.parent is! ClassDeclaration) return false;
    ClassDeclaration parent = selectedNode.parent;

    componentSourceFile = SourceFile.fromString(sourceFileContent);
    members = detectBoilerplateMembers(unit);
    declarations = getBoilerplateDeclarations(members, errorCollector).toList();

    component = declarations.whereType<ClassComponentDeclaration>()?.where((c) {
      return c.component.name.name == parent.name.name;
    })?.first;

    return component != null;
  }

  ComponentDeclarationAssistApi(CompilationUnit unit, AstNode selectedNode, String sourceFileContent) {
    // TODO This really does nothing and is just a placeholder to create a "valid"
    // ErrorCollector
    errorCollector = ErrorCollector.print(componentSourceFile);
    _isAValidComponentDeclaration = isAValidComponentClass(unit, selectedNode, sourceFileContent);
  }
}