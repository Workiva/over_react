import 'package:over_react_analyzer_plugin/src/component_usage.dart';

/// An enumeration of all the supported OverReact component builders that can be detected
/// using [FluentComponentUsage], and used to target code when formatting.
///
/// Keys are descriptions, and values are builder source.
const buildersToTest = {
  'DOM factory': 'Dom.h1()',
  'DOM factory w/ namespaced import': 'foo_bar.Dom.h1()',
  'component factory': 'Foo()',
  'private component factory': '_Foo()',
  'component factory w/ namespaced import': 'bar_baz.Foo()',
  'custom factory function (ending in keyword)': 'fooFactory()',
  'custom factory function (not ending in keyword)': 'getFactoryForFoo()',
  'custom factory function (private)': '_fooFactory()',
  'custom builder function (ending in keyword)': 'getFooBuilder()',
  'custom builder function (not ending in keyword)': 'getBuilderForFoo()',
  'custom builder function (private)': '_getFooBuilder()',
  'builder (ending in keyword)': '_fooBuilder',
  'builder (not ending in keyword)': '_builderWithRequiredProps',
};
