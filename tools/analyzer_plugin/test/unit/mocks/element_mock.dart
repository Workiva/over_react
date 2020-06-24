import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:mockito/mockito.dart';

class ElementMock extends Mock implements Element {
}

class DartTypeMock extends Mock implements DartType {
  @override
  Element get element {
    return ElementMock();
  }
}
