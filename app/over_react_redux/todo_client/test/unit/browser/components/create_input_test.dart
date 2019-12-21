@TestOn('browser')
import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/components/create_input.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('CreateInput', () {
    Ref textFieldComponentRef;
    TestJacket<CreateInputComponent> jacket;
    Completer<String> onCreateCompleter;

    setUp(() {
      textFieldComponentRef = createRef();
      onCreateCompleter = Completer<String>();
    });

    tearDown(() {
      jacket = null;
      textFieldComponentRef = null;
      onCreateCompleter = null;
    });

    group('renders a Mui TextField component', () {
      setUp(() {
        jacket = mount((CreateInput()
          ..ref = textFieldComponentRef
          ..onCreate = (value) {
            onCreateCompleter.complete(value);
          }
        )());
      });

      test('', () {
        expect(jacket.getDartInstance().textFieldRef, isNotNull);
        expect(jacket.getDartInstance().textFieldRef.current, isA<InputElement>());
      });

      test('that calls props.onCreate when the ENTER key is pressed', () async {
        InputElement inputElement = jacket.getDartInstance().textFieldRef.current;
        inputElement.focus();
        inputElement.value = ' and something else ';
        keyDown(inputElement, {'keyCode': KeyCode.ENTER});
        final onCreateValue = await onCreateCompleter.future;
        expect(onCreateValue, 'and something else');
      });
    });
  });
}
