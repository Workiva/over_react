import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' show setClientConfiguration;

import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

void main() {
  setClientConfiguration();

  react.render(Well()('Hello World!'), querySelector('.main'));
}
