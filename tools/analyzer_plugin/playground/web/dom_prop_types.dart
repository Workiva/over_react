import 'package:over_react/over_react.dart';

main() {
  final content = Fragment()(
    (Dom.a()
      // These should have a lint.
      ..size = 1
      ..dom.label = 'foo'
      // These should have no lint
      ..href = null
      ..hrefLang = null
      ..download = null
      ..rel = null
      ..target = null
      ..aria.label = 'foo'
    )(),
    (Dom.abbr()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..title = 'foo'
    )(),
    (Dom.address()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..title = 'foo'
    )(),
    (Dom.area()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..coords = 1
      ..download = null
      ..href = null
      ..hrefLang = null
      ..rel = null
      ..shape = null
      ..target = null
    )(),
    (Dom.article()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..title = 'foo'
    )(),
    (Dom.aside()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..title = 'foo'
    )(),
    (Dom.audio()
      // This should have a lint.
      ..size = 1
      // These should have no lint
      ..autoPlay = true
      ..controls = true
      ..muted = true
    )(),
  );
}
