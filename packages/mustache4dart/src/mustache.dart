part of mustache4dart;

render(String template, Object context, {Function partial: null,
    Delimiter delimiter: null, String ident: EMPTY_STRING, StringSink out: null,
    bool errorOnMissingProperty: false, bool assumeNullNonExistingProperty: true}) {
  return compile(
      template,
      partial: partial,
      delimiter: delimiter,
      ident: ident)(
          context,
          out: out,
          errorOnMissingProperty: errorOnMissingProperty,
          assumeNullNonExistingProperty: assumeNullNonExistingProperty);
}

compile(String template, {Function partial: null, Delimiter delimiter: null,
    String ident: EMPTY_STRING}) {
  if (delimiter == null) {
    delimiter = new Delimiter('{{', '}}');
  }
  return new _Template(
      template: template,
      delimiter: delimiter,
      ident: ident,
      partial: partial);
}
