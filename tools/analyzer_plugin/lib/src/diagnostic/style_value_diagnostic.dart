import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

const _desc = r'Do not use string CSS property values without specifying a unit.';
// <editor-fold desc="Documentation Details">
const _details = '''

**ALWAYS** Use CSS property values that are strings _with_ units, or numbers _(in which case `px` will be inferred)_.

**GOOD:**
```
@override
render() {
  return (Dom.div()..style = {'width': 80})(
    'I am eighty pixels wide!',
  );
}
```

**GOOD:**
```
@override
render() {
  return (Dom.div()..style = {'width': '80px'})(
    'I am also eighty pixels wide!',
  );
}
```

**BAD:**
```
@override
render() {
  return (Dom.div()..style = {'width': '80'})(
    'I never rendered because of a ReactJS runtime error :(',
  );
}
```

''';
// </editor-fold>

class StyleValueDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_style_missing_unit',
    'CSS property value is missing a unit, and will be ignored by React.',
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.SYNTACTIC_ERROR,
    correction: "Try adding a unit, or using a 'num' instead of 'String' (in which case 'px' will be inferred).",
  );

  static final fixKind = FixKind(code.name, 200, "Convert to number (and treat as 'px')");

  static const propertyCode = DiagnosticCode(
    'over_react_style_camel_case',
    'CSS properties must be camelCase, not kebab-case.',
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.SYNTACTIC_ERROR,
  );

  static final propertyFixKind = FixKind(propertyCode.name, 200, "Use camelCase property name: '{0}'");

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // Collect these then iterate later to make keeping things async simpler
    final styleEntries = <MapLiteralEntry>[];
    for (final prop in usage.cascadedProps) {
      if (prop.name.name == 'style') {
        prop.rightHandSide.accept(_RecursiveMapLiteralEntryVisitor(styleEntries.add));
      }
    }

    for (final entry in styleEntries) {
      final propertyName = getConstOrLiteralStringValueFrom(entry.key);
      if (propertyName == null || _isCustomProperty(propertyName)) continue;

      if (propertyName.contains('-')) {
        final camelCaseName = _spinalToCamelCase(propertyName);
        await collector.addErrorWithFix(
          propertyCode,
          result.locationFor(entry.key),
          fixKind: propertyFixKind,
          fixMessageArgs: [camelCaseName],
          computeFix: () => buildGenericFileEdit(result, (builder) {
            builder.addSimpleReplacement(range.node(entry.key), _stringLiteral(camelCaseName));
          }),
        );
      } else {
        // TODO more name validation (style, sx)
      }

      if (unitlessNumberStyles.contains(propertyName)) {
        continue;
      }

      // Only worry about strings, since numbers get values
      final stringValue = getConstOrLiteralStringValueFrom(entry.value);
      if (stringValue == null) continue;

      if (num.tryParse(stringValue) != null) {
        final location = result.locationFor(entry.value);
        final errorArgs = [propertyName, stringValue];

        // Don't suggest the change if this is an interpolated string,
        // reference to constant variable, etc.
        if (entry.value is SimpleStringLiteral) {
          await collector.addErrorWithFix(
            code,
            location,
            errorMessageArgs: errorArgs,
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addSimpleReplacement(range.node(entry.value), stringValue);
            }),
          );
        } else {
          collector.addError(code, location, errorMessageArgs: errorArgs);
        }
      }
    }
  }
}

// fixme use better/shared implementation
String _spinalToCamelCase(String spinal) {
  final parts = spinal.split('-').toList();
  return parts[0] + parts.skip(1).map(capitalize).join('');
}

String capitalize(String string) {
  if (string.isEmpty) return string;
  return string[0].toUpperCase() + string.substring(1);
}

class _RecursiveMapLiteralEntryVisitor extends RecursiveAstVisitor<void> {
  _RecursiveMapLiteralEntryVisitor(this.onMapLiteralEntry);

  final void Function(MapLiteralEntry) onMapLiteralEntry;

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    onMapLiteralEntry(node);
    node.visitChildren(this);
  }
}

bool _isCustomProperty(String propertyName) => propertyName.startsWith('--');

// From React's CssProperty
const unitlessNumberStyles = {
  'animationIterationCount',
  'borderImageOutset',
  'borderImageSlice',
  'borderImageWidth',
  'boxFlex',
  'boxFlexGroup',
  'boxOrdinalGroup',
  'columnCount',
  'flex',
  'flexGrow',
  'flexPositive',
  'flexShrink',
  'flexNegative',
  'flexOrder',
  'gridRow',
  'gridRowEnd',
  'gridRowSpan',
  'gridRowStart',
  'gridColumn',
  'gridColumnEnd',
  'gridColumnSpan',
  'gridColumnStart',
  'fontWeight',
  'lineClamp',
  'lineHeight',
  'opacity',
  'order',
  'orphans',
  'tabSize',
  'widows',
  'zIndex',
  'zoom',

  // SVG-related properties
  'fillOpacity',
  'floodOpacity',
  'stopOpacity',
  'strokeDasharray',
  'strokeDashoffset',
  'strokeMiterlimit',
  'strokeOpacity',
  'strokeWidth'
};

/// Returns [content] escaped and optionally quoted for use as a string literal
/// in Dart source code.
///
/// If [content] is null, a string version of the the `null` literal will be
/// returned instead.
String _stringLiteral(String? content, {bool quote = true, bool useSingleQuote = true}) {
  // Adapted from dart.convert library's JSON encoder:
  // https://github.com/dart-lang/sdk/blob/1.12.0/sdk/lib/convert/json.dart#L565
  //
  //
  // Copyright 2012, the Dart project authors. All rights reserved.
  // Redistribution and use in source and binary forms, with or without
  // modification, are permitted provided that the following conditions are
  // met:
  //     * Redistributions of source code must retain the above copyright
  //       notice, this list of conditions and the following disclaimer.
  //     * Redistributions in binary form must reproduce the above
  //       copyright notice, this list of conditions and the following
  //       disclaimer in the documentation and/or other materials provided
  //       with the distribution.
  //     * Neither the name of Google Inc. nor the names of its
  //       contributors may be used to endorse or promote products derived
  //       from this software without specific prior written permission.
  // THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  // "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  // LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  // A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  // OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  // SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  // LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  // DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  if (content == null) {
    return 'null';
  }

  const BACKSPACE = 0x08;
  const TAB = 0x09;
  const NEWLINE = 0x0a;
  const CARRIAGE_RETURN = 0x0d;
  const FORM_FEED = 0x0c;
  const DOLLAR_SIGN = 0x24;
  const SINGLE_QUOTE = 0x27;
  const DOUBLE_QUOTE = 0x22;
  const CHAR_0 = 0x30;
  const BACKSLASH = 0x5c;
  const CHAR_b = 0x62;
  const CHAR_f = 0x66;
  const CHAR_n = 0x6e;
  const CHAR_r = 0x72;
  const CHAR_t = 0x74;
  const CHAR_u = 0x75;

  var quoteChar = useSingleQuote ? SINGLE_QUOTE : DOUBLE_QUOTE;

  var buffer = StringBuffer();

  void writeStringSlice(String string, int start, int end) {
    buffer.write(string.substring(start, end));
  }

  void writeCharCode(int charCode) {
    buffer.writeCharCode(charCode);
  }

  void writeString(String string) {
    buffer.write(string);
  }

  // ('0' + x) or ('a' + x - 10)
  int hexDigit(int x) => x < 10 ? 48 + x : 87 + x;

  if (quote) {
    writeCharCode(quoteChar);
  }

  var offset = 0;
  final length = content.length;
  for (var i = 0; i < length; i++) {
    var charCode = content.codeUnitAt(i);
    if (charCode > BACKSLASH) continue;
    if (charCode < 32) {
      if (i > offset) writeStringSlice(content, offset, i);
      offset = i + 1;
      writeCharCode(BACKSLASH);
      switch (charCode) {
        case BACKSPACE:
          writeCharCode(CHAR_b);
          break;
        case TAB:
          writeCharCode(CHAR_t);
          break;
        case NEWLINE:
          writeCharCode(CHAR_n);
          break;
        case FORM_FEED:
          writeCharCode(CHAR_f);
          break;
        case CARRIAGE_RETURN:
          writeCharCode(CHAR_r);
          break;
        default:
          writeCharCode(CHAR_u);
          writeCharCode(CHAR_0);
          writeCharCode(CHAR_0);
          writeCharCode(hexDigit((charCode >> 4) & 0xf));
          writeCharCode(hexDigit(charCode & 0xf));
          break;
      }
    } else if (charCode == quoteChar || charCode == BACKSLASH || charCode == DOLLAR_SIGN) {
      if (i > offset) writeStringSlice(content, offset, i);
      offset = i + 1;
      writeCharCode(BACKSLASH);
      writeCharCode(charCode);
    }
  }

  if (offset == 0) {
    writeString(content);
  } else if (offset < length) {
    writeStringSlice(content, offset, length);
  }

  if (quote) {
    writeCharCode(quoteChar);
  }

  return buffer.toString();
}
