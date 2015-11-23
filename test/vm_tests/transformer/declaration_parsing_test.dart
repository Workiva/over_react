library declaration_parsing_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';

main() {
  group('ComponentDeclarations', () {
    group('shouldParse()', () {
      bool shouldParse(String source) => ComponentDeclarations.shouldParse(source);

      group('returns true when the source contains', () {
        test('"@Factory"',           () => expect(shouldParse('@Factory()\nvar Foo;'), isTrue));
        test('"@Props"',             () => expect(shouldParse('@Props()\nclass Foo {}'), isTrue));
        test('"@State"',             () => expect(shouldParse('@State()\nclass Foo {}'), isTrue));
        test('"@Component"',         () => expect(shouldParse('@Component()\nclass Foo {}'), isTrue));
        test('"@AbstractProps"',     () => expect(shouldParse('@AbstractProps()\nclass Foo {}'), isTrue));
        test('"@AbstractState"',     () => expect(shouldParse('@AbstractState()\nclass Foo {}'), isTrue));
        test('"@AbstractComponent"', () => expect(shouldParse('@AbstractComponent()\nclass Foo {}'), isTrue));
        test('"@PropsMixin"',        () => expect(shouldParse('@PropsMixin()\nclass Foo {}'), isTrue));
        test('"@StateMixin"',        () => expect(shouldParse('@StateMixin()\nclass Foo {}'), isTrue));
      });

      test('returns false when no matching annotations are found', () {
        expect(shouldParse('class FooComponent extends UiComponent<FooProps> {}'), isFalse,
            reason: 'should not return true for an unannotated class');

        expect(shouldParse('@Bar\nclass Foo {}'), isFalse,
            reason: 'should not return true for a class with non-matching annotations');

        expect(shouldParse('/// Component that...\nclass Foo {}'), isFalse,
            reason: 'should not return true when an annotation class name is not used as an annotation');
      });
    });
  });
}

