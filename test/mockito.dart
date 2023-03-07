import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Logger>(returnNullOnMissingStub: true),
  MockSpec<Map>(fallbackGenerators: {
    #update: mapUpdateShim,
    #putIfAbsent: mapPutIfAbsentShim,
  }, returnNullOnMissingStub: true)
])
void main() {}

String mapUpdateShim<K, V>(K key, V Function(V value) update,
        {V Function() ifAbsent}) =>
    'value';
String mapPutIfAbsentShim<K, V>(K key, V Function() ifAbsent) => 'value';
