// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

void main() {
  group('cascade_read', () {
    group('FluentComponentUsage.cascadedProps', () {
      test('returns cascaded props', () {
        final usage = parseAndGetComponentUsage(/*language=dart*/ r'''
          foo() => (Dom.a()
            ..id = idValue
            ..href = hrefValue
            // special case: nested assignments
            ..aria.describedBy = describedByValue
          )();
        ''');
        final cascadedProps = usage.cascadedProps.toList();
        expect(cascadedProps, hasLength(3));

        expect(cascadedProps[0].name.name, 'id');
        expect(cascadedProps[0].rightHandSide.toSource(), 'idValue');

        expect(cascadedProps[1].name.name, 'href');
        expect(cascadedProps[1].rightHandSide.toSource(), 'hrefValue');

        expect(cascadedProps[2].name.name, 'describedBy');
        expect(cascadedProps[2].leftHandSide.target?.toSource(), '..aria');
        expect(cascadedProps[2].rightHandSide.toSource(), 'describedByValue');
      });

      test('only includes prop assignments and not other cascades', () {
        final usage = parseAndGetComponentUsage(/*language=dart*/ r'''
          foo() => (Foo()
            ..accessPropWithoutSettingIt
            ..methodInvocation()
            ..['cascadedMapAccess']
            ..['cascadedMapAssignment'] = value
            ..actuallyAssigningProp = value
          )();
        ''');
        final cascadedProps = usage.cascadedProps.toList();
        expect(cascadedProps, hasLength(1));
        expect(cascadedProps[0].name.name, 'actuallyAssigningProp');
      });

      test('is empty for usages with no cascade', () {
        final usage = parseAndGetComponentUsage(/*language=dart*/ r'''
          foo() => Foo()();
        ''');
        expect(usage.cascadeExpression, isNull, reason: 'test setup check');
        expect(usage.cascadedProps, isEmpty);
      });
    });

    group('FluentComponentUsage.cascadedMethodInvocations', () {
      test('returns method invocations and not other cascades', () {
        final usage = parseAndGetComponentUsage(/*language=dart*/ r'''
          foo() => (Foo()
            ..accessPropWithoutSettingIt
            ..methodInvocation()
            ..['cascadedMapAccess']
            ..['cascadedMapAssignment'] = value
            ..actuallyAssigningProp = value
          )();
        ''');
        final cascadedMethodInvocations = usage.cascadedMethodInvocations.toList();
        expect(cascadedMethodInvocations, hasLength(1));
        expect(cascadedMethodInvocations[0].methodName.name, 'methodInvocation');
      });

      test('is empty for usages with no cascade', () {
        final usage = parseAndGetComponentUsage(/*language=dart*/ r'''
          foo() => Foo()();
        ''');
        expect(usage.cascadeExpression, isNull, reason: 'test setup check');
        expect(usage.cascadedMethodInvocations, isEmpty);
      });
    });
  });
}
