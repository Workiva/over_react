/// Generates allowedHtmlElementsForAttribute for use in dom_prop_types.dart
main() {
  final supportedElements = <String, List<String>>{};
  final globalAttributes = <String>[];

  for (var line in _rawTable.trim().split('\n')) {
    final columns = line.split('\t');
    assert(columns.length == 2);

    final attr = _attrToReactishAttr(columns[0]);
    final elementsColumn = columns[1];

    if (elementsColumn == 'Global attribute') {
      globalAttributes.add(attr);
    } else {
      supportedElements[attr] = new RegExp(r'<(\w+)>')
          .allMatches(elementsColumn)
          .map((match) => match.group(1))
          .map(_elToReactEl)
          .toList();
    }
  }

  final buffer = new StringBuffer();
  buffer.writeln('const allowedHtmlElementsForAttribute = {');
  supportedElements.forEach((key, value) {
    buffer.writeln('  \'$key\': ['
        '${value.map((el) => '\'$el\'').join(', ')}'
        '],');
  });
  buffer.writeln('};');

  print(buffer);
}

/// Converts attribute names to the names of their React prop counterparts,
/// though the casing may be different.
String _attrToReactishAttr(String attr) {
  if (attr == 'htmlFor') return 'for';

  return attr;
}

/// Converts element names to the names  their React DOM factory counterparts.
String _elToReactEl(String el) {
  const _elToReactEl = {
    'var': 'variable',
    'set': 'svgSet',
    'switch': 'svgSwitch',
    'color-profile': 'colorProfile',
    'font-face': 'fontFace',
    'font-face-format': 'fontFaceFormat',
    'font-face-name': 'fontFaceName',
    'font-face-src': 'fontFaceSrc',
    'font-face-uri': 'fontFaceUri',
    'missing-glyph': 'missingGlyph',
  };

  return _elToReactEl[el] ?? el;
}

// From https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes
const _rawTable = '''
accept	<form>, <input>
accept-charset	<form>
accesskey	Global attribute
action	<form>
align	<applet>, <caption>, <col>, <colgroup>, <hr>, <iframe>, <img>, <table>, <tbody>, <td>, <tfoot> , <th>, <thead>, <tr>
allow	<iframe>
alt	<applet>, <area>, <img>, <input>
async	<script>
autocapitalize	Global attribute
autocomplete	<form>, <input>, <textarea>
autofocus	<button>, <input>, <keygen>, <select>, <textarea>
autoplay	<audio>, <video>
bgcolor	<body>, <col>, <colgroup>, <marquee>, <table>, <tbody>, <tfoot>, <td>, <th>, <tr>
border	<img>, <object>, <table>
buffered	<audio>, <video>
challenge	<keygen>
charset	<meta>, <script>
checked	<command>, <input>
cite	<blockquote>, <del>, <ins>, <q>
class	Global attribute
code	<applet>
codebase	<applet>
color	<basefont>, <font>, <hr>
cols	<textarea>
colspan	<td>, <th>
content	<meta>
contenteditable	Global attribute
contextmenu	Global attribute
controls	<audio>, <video>
coords	<area>
crossorigin	<audio>, <img>, <link>, <script>, <video>
csp 	<iframe>
data	<object>
data-*	Global attribute
datetime	<del>, <ins>, <time>
decoding	<img>
default	<track>
defer	<script>
dir	Global attribute
dirname	<input>, <textarea>
disabled	<button>, <command>, <fieldset>, <input>, <keygen>, <optgroup>, <option>, <select>, <textarea>
download	<a>, <area>
draggable	Global attribute
dropzone	Global attribute
enctype	<form>
for	<label>, <output>
form	<button>, <fieldset>, <input>, <keygen>, <label>, <meter>, <object>, <output>, <progress>, <select>, <textarea>
formaction	<input>, <button>
headers	<td>, <th>
height	<canvas>, <embed>, <iframe>, <img>, <input>, <object>, <video>
hidden	Global attribute
high	<meter>
href	<a>, <area>, <base>, <link>
hreflang	<a>, <area>, <link>
http-equiv	<meta>
icon	<command>
id	Global attribute
importance 	<iframe>, <img>, <link>, <script>
integrity	<link>, <script>
ismap	<img>
itemprop	Global attribute
keytype	<keygen>
kind	<track>
label	<track>
lang	Global attribute
language	<script>
lazyload 	<img>, <iframe>
list	<input>
loop	<audio>, <bgsound>, <marquee>, <video>
low	<meter>
manifest	<html>
max	<input>, <meter>, <progress>
maxlength	<input>, <textarea>
minlength	<input>, <textarea>
media	<a>, <area>, <link>, <source>, <style>
method	<form>
min	<input>, <meter>
multiple	<input>, <select>
muted	<audio>, <video>
name	<button>, <form>, <fieldset>, <iframe>, <input>, <keygen>, <object>, <output>, <select>, <textarea>, <map>, <meta>, <param>
novalidate	<form>
open	<details>
optimum	<meter>
pattern	<input>
ping	<a>, <area>
placeholder	<input>, <textarea>
poster	<video>
preload	<audio>, <video>
radiogroup	<command>
readonly	<input>, <textarea>
referrerpolicy	<a>, <area>, <iframe>, <img>, <link>, <script>
rel	<a>, <area>, <link>
required	<input>, <select>, <textarea>
reversed	<ol>
rows	<textarea>
rowspan	<td>, <th>
sandbox	<iframe>
scope	<th>
scoped	<style>
selected	<option>
shape	<a>, <area>
size	<input>, <select>
sizes	<link>, <img>, <source>
slot	Global attribute
span	<col>, <colgroup>
spellcheck	Global attribute
src	<audio>, <embed>, <iframe>, <img>, <input>, <script>, <source>, <track>, <video>
srcdoc	<iframe>
srclang	<track>
srcset	<img>, <source>
start	<ol>
step	<input>
style	Global attribute
summary	<table>
tabindex	Global attribute
target	<a>, <area>, <base>, <form>
title	Global attribute
translate	Global attribute
type	<button>, <input>, <command>, <embed>, <object>, <script>, <source>, <style>, <menu>
usemap	<img>, <input>, <object>
value	<button>, <option>, <input>, <li>, <meter>, <progress>, <param>
width	<canvas>, <embed>, <iframe>, <img>, <input>, <object>, <video>
wrap	<textarea>
''';
