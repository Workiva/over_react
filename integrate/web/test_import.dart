import 'dart:html';

import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' show setClientConfiguration;

import 'package:web_skin_dart/ui_components.dart';

void main() {
  setClientConfiguration();

  react_dom.render(Well()('Hello World!'), querySelector('.main'));
}
