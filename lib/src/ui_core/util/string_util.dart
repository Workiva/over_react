library ui_core.string_util;

/// Allows the use of `'''` string blocks, without having to unindent them when used within something like the
/// [markdown] method.
///
/// __Replace this:__
///     (Component()
///       ..description = markdown(
///     '''
///     Yuck... I'm indented all funky.
///     '''
///       )
///     )()
///
/// __With this:__
///     (Component()
///       ..description = markdown(unindent(
///           '''
///           Proper indentation is yummy...
///           '''
///       ))
///     )()
String unindent(String multilineString) {
  var indent = new RegExp(r'^( *)').firstMatch(multilineString)[1];
  assert(indent != null && indent.isNotEmpty);
  return multilineString.trim().replaceAll('\n$indent', '\n');
}
