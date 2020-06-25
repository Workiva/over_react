import 'package:over_react_analyzer_plugin/src/component_usage.dart';

class BuilderTestCase {
  String source;
  String imports;
  String componentName;
  bool isDom;
  bool isSvg;
  BuilderTestCase({this.source, this.imports, this.componentName, this.isDom, this.isSvg});
}

/// An enumeration of all the supported OverReact component builders that can be detected
/// using [FluentComponentUsage], and used to target code when formatting.
///
/// Keys are descriptions, and values are [BuilderTestCase]s.
final buildersToTest = {
  'DOM factory': BuilderTestCase(
    source: 'Dom.h1()',
    imports: /*language=dart*/ r'''import 'package:over_react/over_react.dart';''',
    componentName: 'h1',
    isDom: true,
    isSvg: false,
  ),
  'DOM factory w/ SVG props': BuilderTestCase(
    source: 'Dom.circle()',
    imports: /*language=dart*/ r'''import 'package:over_react/over_react.dart';''',
    componentName: 'circle',
    isDom: true,
    isSvg: true,
  ),
  'DOM factory w/ namespaced import': BuilderTestCase(
    source: 'foo_bar.Dom.h1()',
    imports: /*language=dart*/ r'''import 'package:over_react/over_react.dart' as foo_bar;''',
    componentName: 'h1',
    isDom: true,
    isSvg: false,
  ),
  'component factory': BuilderTestCase(
    source: 'Foo()',
    imports: /*language=dart*/ r'''import '../test/unit/util/test_components.dart';''',
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
  'component factory w/ namespaced import': BuilderTestCase(
    source: 'bar_baz.Foo()',
    imports: /*language=dart*/ r'''import '../test/unit/util/test_components.dart' as bar_baz;''',
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (ending in keyword)': BuilderTestCase(
    source: 'getFooBuilder()',
    imports: /*language=dart*/ r'''import '../test/unit/util/test_components.dart';''',
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (not ending in keyword)': BuilderTestCase(
    source: 'getBuilderForFoo()',
    imports: /*language=dart*/ r'''import '../test/unit/util/test_components.dart';''',
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
};
