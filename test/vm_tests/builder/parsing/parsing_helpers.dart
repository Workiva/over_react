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

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/builder/parsing.dart';

import '../util.dart';

/// A grouping that represents different possible boilerplate versions
///
/// Versions v2, v3, v4 correlate to the parser versions, and the remaining
/// cases are slight variations of the first three.
///
/// Related: [getBoilerplateString], [versionDescriptions]
enum BoilerplateVersions {
  v2,
  v3,
  v4,
  v5,
  v6,
  v7,
  v8,
  v9,
}

/// String descriptions of [BoilerplateVersions] versions.
///
/// Related: [getBoilerplateString], [BoilerplateVersions]
const versionDescriptions = {
  BoilerplateVersions.v2: 'legacy (backwords compat)',
  BoilerplateVersions.v3: 'legacy (Dart2 only)',
  BoilerplateVersions.v4: 'mixin based (abbreviated)',
  BoilerplateVersions.v5: 'mixin based (with class alias)',
  BoilerplateVersions.v6: 'legacy (backwords compat - component2)',
  BoilerplateVersions.v7: 'legacy (Dart2 only - component 2)',
  BoilerplateVersions.v8: 'mixin based (abbreviated - with annotations)',
  BoilerplateVersions.v9: 'mixin based (with class alias - with annotations)',
};

/// Generates a string representation of a provided boilerplate version.
///
/// Meant to be used in conjunction with [BoilerplateVersions] and [versionDescriptions]
/// to allow for tests to iterate over component versions, generating the appropriate boilerplate.
String getBoilerplateString({@required BoilerplateVersions version, String deprecatedLifecycleMethod, String componentBaseName}) {
  var deprecatedMethod = '';

  componentBaseName ??= 'Foo';

  switch (deprecatedLifecycleMethod) {
    case 'componentWillReceiveProps':
      deprecatedMethod = '''
      @override
      componentWillReceiveProps(_){}
      
      ''';
      break;
    case 'componentWillMount':
      deprecatedMethod = '''
      @override
      componentWillMount(){}
      
      ''';
      break;
    case 'componentWillUpdate':
      deprecatedMethod = '''
      @override
      componentWillUpdate(_, __){}
      
      ''';
      break;
    default:
      if (deprecatedLifecycleMethod != null) {
        throw ArgumentError(
            'lifecycleMethod should be componentWillReceiveProps, componentWillMount, or componentWillUpdate');
      }
  }

  switch (version) {
    case BoilerplateVersions.v2:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v3:
      return OverReactSrc.state(
        backwardsCompatible: false,
        componentBody: deprecatedMethod,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v4:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v5:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludePropsAlias: true,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v6:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
        componentVersion: 2,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v7:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
        componentVersion: 2,
        backwardsCompatible: false,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v8:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludeAnnotations: true,
        baseName: componentBaseName,
      ).source;
    case BoilerplateVersions.v9:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludePropsAlias: true,
        shouldIncludeAnnotations: true,
        baseName: componentBaseName,
      ).source;
      break;
    default:
      return '';
  }
}

/// A single source to pull different types of component declarations.
const mockComponentDeclarations = r'''
  // -------------------------- Version.v2_legacyBackwardsCompat --------------------------
  @Factory()
  UiFactory<FirstFooProps> FirstFoo = _$FirstFoo;

  @Props()
  class _$FirstFooProps extends UiProps {}

  class FirstFooProps extends _$FirstFooProps with _$FirstFooPropsAccessorsMixin {}

  @State()
  class _$FirstFooState extends UiState with _$FirstFooStateAccessorsMixin {}

  class FirstFooState extends _$FirstFooState with _$FirstFooStateAccessorsMixin {}

  @Component()
  class FirstFooComponent extends UiStatefulComponent<FirstFooProps, FooState>{}
  
  // -------------------------- Version.v3_legacyDart2Only --------------------------
  @Factory()
  UiFactory<SecondFooProps> SecondFoo = _$SecondFoo;

  @Props()
  class _$SecondFooProps extends UiProps {}

  @State()
  class _$SecondFooState extends _$SecondFooState with _$SecondFooStateAccessorsMixin {}

  @Component2()
  class SecondFooComponent extends UiStatefulComponent2<SecondFooProps, SecondFooState>{}
  
  // -------------------------- Version.v3_legacyDart2Only --------------------------
  // But with dissassociated names to force grouping logic to utilize generics
  @Factory()
  UiFactory<HowAboutARandomNameForLegacyProps> ThisIsABadLegacyFactoryName = _$ThisIsABadLegacyFactoryName;

  @Props()
  class _$HowAboutARandomNameForLegacyProps extends UiProps {}

  @State()
  class _$AVeryRandomNameForLegacyState extends _$AVeryRandomNameForLegacyState with _$AVeryRandomNameForLegacyStateAccessorsMixin {}

  @Component2()
  class IsThisEvenAComponentNameLegacyComponent extends UiStatefulComponent2<HowAboutARandomNameForLegacyProps, AVeryRandomNameForLegacyState>{}
  

  // -------------------------- Version.v4_mixinBased --------------------------
  UiFactory<ThirdFooProps> ThirdFoo = _$ThirdFoo;

  mixin ThirdFooProps on UiProps {}

  mixin ThirdFooState on UiState {}

  class ThirdFooComponent extends UiStatefulComponent2<ThirdFooProps, ThirdFooState>{}

  // -------------------------- Version.v4_mixinBased --------------------------
  // But with extended props / state aliase syntax
  UiFactory<FourthFooProps> FourthFoo = _$FourthFoo;

  mixin FourthFooPropsMixin on UiProps {}

  class FourthFooProps = UiProps with FourthFooPropsMixin;

  mixin FourthFooStateMixin on UiState {}
  
  class FourthFooState = UiState with FourthFooStateMixin;

  class FourthFooComponent extends UiStatefulComponent<FourthFooProps, FourthFooState>{}
  
  // -------------------------- Version.v4_mixinBased --------------------------
  // But with dissassociated names to force grouping logic to utilize generics
  UiFactory<HowAboutARandomNameForProps> ThisIsABadFactoryName = _$IsThisEvenAComponentName;

  mixin HowAboutARandomNameForProps on UiProps {}

  mixin AVeryRandomNameForState on UiState {}

  class IsThisEvenAComponentNameComponent extends UiStatefulComponent<HowAboutARandomNameForProps, AVeryRandomNameForState>{}
  
  // -------------------------- Version.v4_mixinBased --------------------------
  // Function components
  UiFactory<FunctionFoo2Props> FunctionFoo = uiFunction(
    (props) => Dom.div()(),
    _$FunctionFooConfig, // ignore: undefined_identifier
  );
  
  final FunctionFoo1 = uiFunction<FunctionFoo2Props>(
    (props) => Dom.div()(),
    _$FunctionFoo1Config, // ignore: undefined_identifier
  );
  
  UiFactory<_$FunctionFooProps> FunctionFoo2 = uiFunction(
    (props) => Dom.div()(),
    $FunctionFoo2Config, // ignore: undefined_identifier
  );
  
  mixin _$FunctionFooProps on UiProps {}
  
  mixin FunctionFoo2Props on UiProps {}
''';

/// Utility class that holds boilerplate members that can be accessed during testing.
class BoilerplateMemberHelper {
  BoilerplateMembers members;

  List<BoilerplateFactory> factories;
  List<BoilerplateComponent> components;
  List<BoilerplateProps> props;
  List<BoilerplateState> states;
  List<BoilerplateStateMixin> stateMixins;
  List<BoilerplatePropsMixin> propsMixins;

  BoilerplateMemberHelper(String boilerplateString) {
    final unit = parseString(content: boilerplateString).unit;

     members = detectBoilerplateMembers(unit);

     _initializeMembers(members);
  }

  /// Constructs the object with all the components from [mockComponentDeclarations]
  BoilerplateMemberHelper.withMockDeclarations() {
    final unit = parseString(content: mockComponentDeclarations).unit;

    members ??= detectBoilerplateMembers(unit);
    _initializeMembers(members);
  }

  static BoilerplateMembers getBoilerplateMembersFromString([String content]) {
    final unit = parseString(content: content ?? mockComponentDeclarations).unit;

    return detectBoilerplateMembers(unit);
  }

  static Iterable<BoilerplateMember> getBoilerplateMembersForVersion(BoilerplateVersions version, {String componentBaseName}) {
    final unit = parseString(content: getBoilerplateString(version: version, componentBaseName: componentBaseName)).unit;

    return detectBoilerplateMembers(unit).allMembers;
  }

  static Iterable<BoilerplateMember> parseAndReturnMembers(String content) => getBoilerplateMembersFromString(content).allMembers;

  void _initializeMembers(BoilerplateMembers members) {
    factories = members.factories;
    components = members.components;
    props = members.props;
    states = members.states;
    stateMixins = members.stateMixins;
    propsMixins = members.propsMixins;
  }
}
