library mock_classes;

import 'dart:html';

import 'package:mockito/mockito.dart';

class MockKeyEvent extends Mock implements KeyEvent {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockDocument extends Mock implements Document {
  noSuchMethod(i) => super.noSuchMethod(i);
}
