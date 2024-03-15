// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/unsafe_required_prop_access.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UnsafeRequiredPropAccessTest);
  });
}

@reflectiveTest
class UnsafeRequiredPropAccessTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => UnsafeRequiredPropAccessDiagnostic.code;

  @override
  get fixKindUnderTest => UnsafeRequiredPropAccessDiagnostic.fixKind;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

// ignore_for_file: unused_local_variable

UiFactory<FooProps> Foo = castUiFactory(_$Foo);

mixin FooProps on UiProps {
  late String requiredProp;
  String? optionalProp;
}
''';

  Future<void> test_noErrors_withinFunctionComponent() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''    
      class TestUiFunctionProps = UiProps with FooProps;
      class TestUiForwardRefProps = UiProps with FooProps;
    
      UiFactory<TestUiFunctionProps> TestUiFunction = uiFunction((props) {
        print(props.requiredProp);
        print(props.optionalProp);
      }, _$TestUiFunctionConfig);
      
      UiFactory<TestUiForwardRefProps> TestUiForwardRef = uiForwardRef((props, ref) {
        print(props.requiredProp);
        print(props.optionalProp);
      }, _$TestUiForwardRefConfig);
    '''));
  }

  Future<void> test_noErrors_withinClassComponent() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''    
      class FooComponent extends UiComponent2<FooProps> {
        render() {
          print(props.requiredProp);
          print(props.optionalProp);
          _renderHelper();
        }
        _renderHelper() {
          print(props.requiredProp);
          print(props.optionalProp);
        }
      }
    '''));
  }

  Future<void> test_noErrors_withinUtilityMethods() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test1(FooProps props) {
        // UiProps methods
        print(props.getPropKey((p) => p.requiredProp));
        print(props.containsProp((p) => p.requiredProp));
        print(props.getRequiredProp((p) => p.requiredProp, orElse: () => ''));
        print(props.getRequiredPropOrNull((p) => p.requiredProp));
      }
      
      testTopLevel(FooProps props) {
        // Top-level functions  
        print(getPropKey<FooProps>((p) => p.requiredProp, Foo));
      }
      
      abstract class OtherComponent extends UiComponent2<FooProps> {
        render() {
          // UiComponent methods
          print(keyForProp((p) => p.requiredProp));
          // `this.` is necessary to avoid top-level getPropKey taking precedence.
          print(this.getPropKey((p) => p.requiredProp)); // ignore: deprecated_member_use
        }
      }
    '''));
  }

  // FIXME clarify that even unsafe accesses aren't linted
  Future<void> test_noErrors_withinSpecificLifecycleMethods() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      abstract class FooComponent extends UiComponent2<FooProps> {
        get propTypes => {
          keyForProp((p) => p.requiredProp): (props, _) {
            print(typedPropsFactory(props).requiredProp);
            return null;
          },
        };
        @override componentDidUpdate(prevProps, _, [__]) { print(typedPropsFactory(prevProps).requiredProp); }  
        @override getDerivedStateFromProps(nextProps, _) { print(typedPropsFactory(nextProps).requiredProp); return {}; }  
        @override getSnapshotBeforeUpdate(prevProps, _)  { print(typedPropsFactory(prevProps).requiredProp); return null; }  
        @override shouldComponentUpdate(nextProps, _)    { print(typedPropsFactory(nextProps).requiredProp); return true; }
      }
      
      abstract class OtherComponent1 extends UiComponent<FooProps> {
        // Just test UiComponent-specific methods
        @override componentWillReceiveProps(nextProps)               { print(typedPropsFactory(nextProps).requiredProp); super.componentWillReceiveProps(nextProps); }  
        @override componentWillReceivePropsWithContext(nextProps, _) { print(typedPropsFactory(nextProps).requiredProp); }  
        @override componentWillUpdate(prevProps, _, [__])            { print(typedPropsFactory(prevProps).requiredProp); }  
        @override shouldComponentUpdateWithContext(nextProps, _, __) { print(typedPropsFactory(nextProps).requiredProp); return true; }
      }
    '''));
  }

  Future<void> test_noErrorsWithContainsPropCheck() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test(FooProps props) {
        if (props.containsProp((p) => p.requiredProp)) {
          print(props.requiredProp);
        }
      }
    '''));
  }
}
