// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

part 'compact_hoc_syntax_integration_test.over_react.g.dart';

main() {
  group('Compact HOC syntax, with generated factory used in factory initializer:', () {
    group('(using Dart <2.9.0 syntax)', () {
      test('variable initializes correctly', () {
        expect(() => Foo, returnsNormally);
        expect(Foo, isNotNull);
      });

      test('component renders normally, and reading/writing props works', () {
        TestJacket<FooComponent> jacket;
        expect(() {
          jacket = mount(
            (ReduxProvider()..store = Store((_, __) => null))(
              (Foo()..foo = 'bar')(),
            ),
          );
        }, returnsNormally);
        expect(jacket.mountNode.text, contains('bar'));
      });
    });

    group('(using Dart >=2.9.0 syntax)', () {
      test('variable initializes correctly', () {
        expect(() => Foo290, returnsNormally);
        expect(Foo290, isNotNull);
      });

      test('component renders normally, and reading/writing props works', () {
        TestJacket<FooComponent290> jacket;
        expect(() {
          jacket = mount(
            (ReduxProvider()..store = Store((_, __) => null))(
              (Foo290()..foo = 'bar')(),
            ),
          );
        }, returnsNormally);
        expect(jacket.mountNode.text, contains('bar'));
      });
    });
  });
}

UiFactory<Foo290Props> Foo290 = connect<Null, Foo290Props>(
  mapStateToPropsWithOwnProps: (state, props) => Foo(),
  mapDispatchToPropsWithOwnProps: (state, props) => Foo(),
)(castUiFactory(_$Foo290)); // ignore: undefined_identifier

mixin Foo290Props on UiProps {
  String foo;
}

class FooComponent290 extends UiComponent2<Foo290Props> {
  @override
  render() => props.foo;
}

UiFactory<FooProps> Foo = connect<Null, FooProps>(
  mapStateToPropsWithOwnProps: (state, props) => Foo(),
  mapDispatchToPropsWithOwnProps: (state, props) => Foo(),
)(_$Foo); // ignore: undefined_identifier, argument_type_not_assignable

mixin FooProps on UiProps {
  String foo;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => props.foo;
}
