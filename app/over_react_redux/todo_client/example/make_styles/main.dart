import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;

import 'example_entrypoint.dart';

main() {
  final container = querySelector('#example-container');

  final app = ExampleEntrypoint()();

  react_dom.render(app, container);
}
