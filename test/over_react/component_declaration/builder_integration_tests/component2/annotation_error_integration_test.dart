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
import 'package:over_react/src/component_declaration/builder_helpers.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'annotation_error_integration_test.over_react.g.dart';
part 'component_integration_test/annotation_error_component.dart';
part 'component_integration_test/annotation_error_stateful_component.dart';
part 'component_integration_test/annotation_error_stateful_default_props_component.dart';

main() {
  group('(Component2) throws a helpful error message if the @Component annotation is used:',
      () {
    final throwsExpectedError = throwsA(hasToStringValue(contains(
      GeneratedErrorMessages.component1AnnotationOnComponent2,
    )));

    test('when rendering a UiComponent2', () {
      expect(() => mount(AnnotationError()()), throwsExpectedError);
    });

    test('when rendering a UiStatefulComponent2', () {
      expect(() => mount(AnnotationErrorStateful()()), throwsExpectedError);
    });

    test('when rendering a UiComponent2 with default props', () {
      expect(() => mount(AnnotationErrorDefaultProps()()), throwsExpectedError);
    });

    test('when rendering a UiComponentStateful2 with default props', () {
      expect(() => mount(AnnotationErrorStatefulDefaultProps()()), throwsExpectedError);
    });
  });
}

@Factory()
UiFactory<AnnotationErrorDefaultPropsProps>
    AnnotationErrorDefaultProps = _$AnnotationErrorDefaultProps; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$AnnotationErrorDefaultPropsProps extends UiProps {}

// ignore: deprecated_member_use_from_same_package
@Component()
class AnnotationErrorDefaultPropsComponent
    extends UiComponent2<AnnotationErrorDefaultPropsProps> {
  @override
  // ignore: must_call_super
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => props.children;
}
