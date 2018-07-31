import 'dart:async';
import 'package:analyzer/analyzer.dart';
import 'package:build/build.dart';

Builder overReactBuilder(BuilderOptions options) => new OverReactBuilder();

class OverReactBuilder implements Builder {
  OverReactBuilder();

  @override
  Future build(BuildStep buildStep) async {
    // Get the `LibraryElement` for the primary input.
    var entryLib = await buildStep.inputLibrary;

    var info = buildStep.inputId.changeExtension('.g.dart');

    var astWrapper = new AstWrapper();
    astWrapper.visitCompilationUnit(
        entryLib.definingCompilationUnit.computeNode());

    await buildStep.writeAsString(info, '''
        classSuperTypes: ${astWrapper.superTypes} 
      ''');
  }

  @override
  Map<String, List<String>> get buildExtensions => {'.dart': const ['.g.dart']};
}

class AstWrapper extends RecursiveAstVisitor {
  List<String> _superTypes;

  List<String> get superTypes => _superTypes;

  @override
  visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);
    _superTypes = new List<String>();
    node?.element?.allSupertypes?.forEach((element) {
      _superTypes.add(element.toString());
    });
  }
}
