import 'package:over_react_analyzer_plugin/src/component_usage.dart';

class BuilderTestCase {
  String source;
  String imports;
  String componentName;
  bool isDom;
  bool isSvg;
  BuilderTestCase(this.source, this.imports, this.componentName, this.isDom, this.isSvg);
}

/// An enumeration of all the supported OverReact component builders that can be detected
/// using [FluentComponentUsage], and used to target code when formatting.
///
/// Keys are descriptions, and values are builder source.
final buildersToTest = {
  'DOM factory': BuilderTestCase('Dom.h1()', /*language=dart*/ r'''import 'package:over_react/over_react.dart';''', 'h1', true, false),
  'DOM factory w/ namespaced import': BuilderTestCase('foo_bar.Dom.h1()', /*language=dart*/ r'''import 'package:over_react/over_react.dart' as foo_bar;''', 'h1', true, false),
  'component factory': BuilderTestCase('Foo()', /*language=dart*/ r'''import '../test/unit/util/test_components.dart';''', 'Foo', false, false),
//  'private component factory': ['_Foo()', ''],
  'component factory w/ namespaced import': BuilderTestCase('bar_baz.Foo()', /*language=dart*/ r'''import '../test/unit/util/test_components.dart' as bar_baz;''', 'Foo', false, false),
//  'custom factory function (ending in keyword)': ['fooFactory()', ''],
//  'custom factory function (not ending in keyword)': ['getFactoryForFoo()', ''],
//  'custom factory function (private)': ['_fooFactory()', ''],
//  'custom builder function (ending in keyword)': ['getFooBuilder()', ''],
//  'custom builder function (not ending in keyword)': ['getBuilderForFoo()', ''],
//  'custom builder function (private)': ['_getFooBuilder()', ''],
//  'builder (ending in keyword)': ['_fooBuilder', ''],
//  'builder (not ending in keyword)': ['_builderWithRequiredProps', ''],
};
