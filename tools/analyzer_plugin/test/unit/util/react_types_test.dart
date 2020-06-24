import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:test/test.dart';

void main() {
  group('react_types', () {
    Future<ResolvedUnitResult> getResolvedAstForSource(String dartSource) {
      // Must be absolute
      const filePath = '/_fake_in_memory_path/my_file.dart';

      final resourceProvider =
      OverlayResourceProvider(PhysicalResourceProvider.INSTANCE)
        ..setOverlay(filePath, content: dartSource, modificationStamp: 0);

      final collection = AnalysisContextCollection(
        includedPaths: [filePath],
        resourceProvider: resourceProvider,
      );
      return collection
          .contextFor(filePath)
          .currentSession
          .getResolvedUnit(filePath);
    }

    test('component isComponentClass', () async {
      final unit = await getResolvedAstForSource(/*language=dart*/ r'''
        import 'package:over_react/over_react.dart';
        import 'dart:html';

        part 'foo.over_react.g.dart';

        UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

        mixin FooProps on UiProps {}
        
        class FooComponent extends UiComponent2<FooProps> {
          @override
          render() {}
        }
      ''');
      final compClass = allDescendantsOfType<ClassDeclaration>(unit.unit).singleWhere((element) => element.name.name =='FooComponent');

      expect(compClass.declaredElement.isComponentClass, isTrue);
    });
  });
}

