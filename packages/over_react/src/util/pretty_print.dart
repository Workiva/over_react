// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library over_react.pretty_print;

/// Returns a pretty-printed version of [map], with namespaced keys grouped together.
///
/// Useful for debugging props/state maps (and build in to [UiProps.toString]/[UiState.toString]).
///
/// __Only for use when debugging.__
///
/// Example:
///
///     var map = {'foo': 'bar'};
///     Foo(map)
///       ..bar = 1
///       ..baz = 2;
///     Bar(map)
///       ..foo = 1
///       ..baz = 2;
///
///     assert(map.toString == '{foo: bar, Foo.bar: true, Foo.baz: false, Bar.foo: 1, Bar.baz: 2}');
///     assert(prettyPrintMap(map) == '''
///     {
///       Foo…
///         .bar: true,
///         .baz: false,
///
///       Bar…
///         .foo: 1,
///         .baz: 2,
///
///       foo: bar
///     }
///     '''.trim());
///
String prettyPrintMap(Map map) {
  return _prettyObj(map);
}

const String _indent = '  ';
const int _maxKeyValuePairsPerLine = 1;
const int _maxListItemsPerLine = 4;

/// Indents [str] by [_indent], trimming any trailing whitespace.
String _indentString(String str) {
  return str.split('\n').map((line) => (_indent + line).trimRight()).join('\n');
}

String _prettyObj(Object obj) {
  if (obj is List) {
    var items = obj.map(_prettyObj).toList();

    if (items.length > _maxListItemsPerLine || items.any((items) => items.contains('\n'))) {
      var inner = _indentString(items.join(',\n'));
      return '[\n$inner\n]';
    } else {
      var inner = items.join(', ');
      return '[$inner]';
    }
  } else if (obj is Map) {
    final namespacedKeys = <String, List<String>>{};
    final otherKeys = [];

    obj.keys.forEach((dynamic key) {
      const namespaceSeparator = '.';
      if (key is String && key.contains(namespaceSeparator)) {
        var index = key.indexOf(namespaceSeparator);
        var namespace = key.substring(0, index);
        var subkey = key.substring(index);

        namespacedKeys[namespace] ??= <String>[];
        namespacedKeys[namespace].add(subkey);
      } else {
        otherKeys.add(key);
      }
    });

    final pairs = <String>[];

    pairs.addAll(namespacedKeys.keys.map((String namespace) {
      String renderSubKey(String subkey) {
        var key = '$namespace$subkey';
        var value = obj[key];

        return '$subkey: ' + _prettyObj(value);
      }

      Iterable<String> subkeys = namespacedKeys[namespace];

      return '$namespace…\n' + _indentString(subkeys.map(renderSubKey).map((pair) => pair + ',\n').join());
    }));

    pairs.addAll(otherKeys.map((dynamic key) {
      return '$key: ' + _prettyObj(obj[key]) + ',';
    }));

    final RegExp trailingComma = new RegExp(r'\s*,\s*$');

    if (pairs.length > _maxKeyValuePairsPerLine || pairs.any((pair) => pair.contains('\n'))) {
      var inner = _indentString(pairs.join('\n')).replaceFirst(trailingComma, '');
      return '{\n$inner\n}';
    } else {
      var inner = pairs.join(' ').replaceFirst(trailingComma, '');
      return '{$inner}';
    }
  } else {
    return obj.toString();
  }
}
