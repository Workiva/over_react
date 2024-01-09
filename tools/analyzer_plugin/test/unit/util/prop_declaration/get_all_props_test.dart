// Copyright 2023 Workiva Inc.
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

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:collection/collection.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/get_all_props.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';

void main() {
  group('get_all_props', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('getAllProps', () {
      late ResolvedUnitResult result;

      setUpAll(() async {
        final libraryFilename = sharedContext.nextFilename();
        final partFilename = p.setExtension(libraryFilename, '.over_react.g.dart');
        final libraryPath = sharedContext.createTestFile(source.replaceSingle('{{PART_PATH}}', partFilename),
            filename: libraryFilename);
        final partPath = sharedContext.createTestFile(partSource.replaceSingle('{{PART_OF_PATH}}', libraryFilename),
            filename: partFilename);

        final libraryResult = await sharedContext.collection
            .contextFor(libraryPath)
            .currentSession
            .getResolvedUnit(libraryPath) as ResolvedUnitResult;

        List<AnalysisError> filterErrors(List<AnalysisError> errors) => errors
            .where((e) => e.severity != Severity.info && !e.errorCode.name.toLowerCase().startsWith('unused_'))
            .toList();
        expect(filterErrors(libraryResult.errors), isEmpty);

        final partResult = await sharedContext.collection.contextFor(partPath).currentSession.getResolvedUnit(partPath)
            as ResolvedUnitResult;
        expect(filterErrors(partResult.errors), isEmpty);

        result = libraryResult;
      });

      InterfaceElement getInterfaceElement(String name) =>
          result.libraryElement.topLevelElements.whereType<InterfaceElement>().singleWhere((e) => e.name == name);

      group('returns only the expected props from', () {
        test('a v2 concrete props class', () {
          final v4Props = getInterfaceElement('V2Props');
          expect(
              getAllProps(v4Props).map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v2_lateRequiredProp',
                'v2_optionalProp',
                'v2_annotationRequiredProp',
              ]));
        });

        test('a v3 concrete props class', () {
          final v4Props = getInterfaceElement('V3Props');
          expect(
              getAllProps(v4Props).map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v3_lateRequiredProp',
                'v3_optionalProp',
                'v3_annotationRequiredProp',
              ]));
        });

        test('a v4 props mixin', () {
          final v4Props = getInterfaceElement('V4Props');
          expect(
              getAllProps(v4Props).map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v4_lateRequiredProp',
                'v4_optionalProp',
                'v4_annotationRequiredProp',
              ]));
        });

        test('DomProps', () {
          // Grab DomProps from the over_react import
          final domProps = result.libraryElement.importedLibraries
              .map((l) => l.exportNamespace.get('DomProps'))
              .whereNotNull()
              .single as InterfaceElement;
          expect(
              getAllProps(domProps).map((e) => e.name).toList(),
              allOf([
                contains('disabled'),
                // Also declared in UbiquitousDomPropsMixin
                contains('onClick'),
                contains('id'),
                // Also declared in ClassNamePropsMixin
                contains('className'),
              ]));
        });

        group('props classes that extend from other props classes, including props from supertypes', () {
          test('a v2 concrete props class', () {
            final v4Props = getInterfaceElement('ExtendsV2Props');
            expect(
                getAllProps(v4Props).map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v2_optionalProp_inSubclass',
                  // From supertype
                  'v2_lateRequiredProp',
                  'v2_optionalProp',
                  'v2_annotationRequiredProp',
                ]));
          });

          test('a v3 concrete props class', () {
            final v4Props = getInterfaceElement('ExtendsV3Props');
            expect(
                getAllProps(v4Props).map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v3_optionalProp_inSubclass',
                  // From supertype
                  'v3_lateRequiredProp',
                  'v3_optionalProp',
                  'v3_annotationRequiredProp',
                ]));
          });

          test('a v4 props mixin', () {
            final v4Props = getInterfaceElement('ExtendsV4Props');
            expect(
                getAllProps(v4Props).map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v4_optionalProp_inSubclass',
                  // From supertype
                  'v4_lateRequiredProp',
                  'v4_optionalProp',
                  'v4_annotationRequiredProp',
                ]));
          });
        });

      });

      test('returns an empty list for a class that is not a props class', () {
        final notAPropsClass = getInterfaceElement('NotAPropsClass');
        expect(getAllProps(notAPropsClass), isEmpty);
      });
    });
  });
}

extension on String {
  /// Creates a new string with the single occurrence of [pattern] replaced by [replacement].
  ///
  /// Throws an error if there is not exactly one non-overlapping occurrence of [pattern].
  String replaceSingle(Pattern pattern, String replacement) {
    final singleMatch = pattern.allMatches(this).single;
    return substring(0, singleMatch.start) + replacement + substring(singleMatch.end);
  }
}

const source = r'''
//@dart=2.12
// ignore_for_file: deprecated_member_use_from_same_package

import 'package:over_react/over_react.dart';

part '{{PART_PATH}}';

// Give it some supertypes
abstract class NotAPropsClass implements Map {
  String? fieldThatWouldBeAPropInAPropsClass;
}

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<V2Props> V2 = _$V2;

// ignore: undefined_class, mixin_of_non_class
class V2Props extends _$V2Props with _$V2PropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForV2Props;
}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$V2Props extends UiProps {
  late String v2_lateRequiredProp;
  String? v2_optionalProp;
  @requiredProp
  String? v2_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v2_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v2_getter => '';
  // ignore: avoid_setters_without_getters
  set v2_setter(_) => '';
  String get v2_getterAndSetter => '';
  set v2_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v2_static_field = '';
  static String get v2_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v2_static_setter(_) => '';
  static String get v2_static_getterAndSetter => '';
  static set v2_static_getterAndSetter(String _) {}
}

@Component()
class V2Component extends UiComponent2<V2Props> {
  @override
  render() {}
}

@Factory()
UiFactory<V3Props> V3 = _$V3; // ignore: undefined_identifier, invalid_assignment

@Deprecated('This is deprecated')
@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$V3Props extends UiProps {
  late String v3_lateRequiredProp;
  String? v3_optionalProp;
  @requiredProp
  String? v3_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v3_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v3_getter => '';
  // ignore: avoid_setters_without_getters
  set v3_setter(_) => '';
  String get v3_getterAndSetter => '';
  set v3_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v3_static_field = '';
  static String get v3_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v3_static_setter(_) => '';
  static String get v3_static_getterAndSetter => '';
  static set v3_static_getterAndSetter(String _) {}
}

@Component()
class V3Component extends UiComponent2<V3Props> {
  @override
  render() {}
}


UiFactory<V4Props> V4 = castUiFactory(_$V4);

mixin V4Props on UiProps {
  late String v4_lateRequiredProp;
  String? v4_optionalProp;
  @requiredProp
  String? v4_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v4_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v4_getter => '';
  // ignore: avoid_setters_without_getters
  set v4_setter(_) => '';
  String get v4_getterAndSetter => '';
  set v4_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v4_static_field = '';
  static String get v4_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v4_static_setter(_) => '';
  static String get v4_static_getterAndSetter => '';
  static set v4_static_getterAndSetter(String _) {}
}

class V4Component extends UiComponent2<V4Props> {
  @override
  render() {}
}


//
// Extending props classes
//


@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ExtendsV2Props> ExtendsV2 = _$ExtendsV2;

// ignore: undefined_class, mixin_of_non_class
class ExtendsV2Props extends _$ExtendsV2Props with _$ExtendsV2PropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForExtendsV2Props;
}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$ExtendsV2Props extends V2Props {
  String? v2_optionalProp_inSubclass;
}

@Component()
class ExtendsV2Component extends UiComponent2<ExtendsV2Props> {
  @override
  render() {}
}


@Factory()
UiFactory<ExtendsV3Props> ExtendsV3 = _$ExtendsV3; // ignore: undefined_identifier, invalid_assignment

@Deprecated('This is deprecated')
@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$ExtendsV3Props extends V3Props {
  String? v3_optionalProp_inSubclass;
}

@Component()
class ExtendsV3Component extends UiComponent2<ExtendsV3Props> {
  @override
  render() {}
}


UiFactory<ExtendsV4Props> ExtendsV4 = castUiFactory(_$ExtendsV4);

mixin ExtendsV4PropsMixin on UiProps {
  String? v4_optionalProp_inSubclass;
}

class ExtendsV4Props = UiProps with V4Props, ExtendsV4PropsMixin;
class ExtendsV4Component extends UiComponent2<ExtendsV4Props> {
  @override
  render() {}
}

''';

const partSource = r'''
//@dart=2.12

part of '{{PART_OF_PATH}}';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $V4ComponentFactory = registerComponent2(
  () => _$V4Component(),
  builderFactory: _$V4,
  componentClass: V4Component,
  isWrapper: false,
  parentType: null,
);

_$$V4Props _$V4([Map? backingProps]) => backingProps == null
    ? _$$V4Props$JsMap(JsBackedMap())
    : _$$V4Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$V4Props extends UiProps
    with
        V4Props,
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        $V4Props {
  _$$V4Props._();

  factory _$$V4Props(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$V4Props$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$V4Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $V4ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        V4Props: $V4Props.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V4Props(accessMap, (map) => _$$V4Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V4Props = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$V4Props$PlainMap extends _$$V4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V4Props$PlainMap(Map? backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$V4Props$JsMap extends _$$V4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V4Props$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$V4Component extends V4Component {
  late _$$V4Props$JsMap _cachedTypedProps;

  @override
  _$$V4Props$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$V4Props$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$V4Props$JsMap(backingMap);

  @override
  _$$V4Props typedPropsFactory(Map? backingMap) => _$$V4Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V4';

  /// The default consumed props, comprising all props mixins used by V4Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        V4Props: $V4Props.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ExtendsV4ComponentFactory = registerComponent2(
  () => _$ExtendsV4Component(),
  builderFactory: _$ExtendsV4,
  componentClass: ExtendsV4Component,
  isWrapper: false,
  parentType: null,
);

_$$ExtendsV4Props _$ExtendsV4([Map? backingProps]) => backingProps == null
    ? _$$ExtendsV4Props$JsMap(JsBackedMap())
    : _$$ExtendsV4Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExtendsV4Props extends UiProps
    with
        V4Props,
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        $V4Props,
        ExtendsV4PropsMixin,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        $ExtendsV4PropsMixin
    implements
        ExtendsV4Props {
  _$$ExtendsV4Props._();

  factory _$$ExtendsV4Props(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExtendsV4Props$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ExtendsV4Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ExtendsV4ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        V4Props: $V4Props.meta,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        ExtendsV4PropsMixin: $ExtendsV4PropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV4Props(
          accessMap, (map) => _$$ExtendsV4Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV4Props = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExtendsV4Props$PlainMap extends _$$ExtendsV4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV4Props$PlainMap(Map? backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExtendsV4Props$JsMap extends _$$ExtendsV4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV4Props$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ExtendsV4Component extends ExtendsV4Component {
  late _$$ExtendsV4Props$JsMap _cachedTypedProps;

  @override
  _$$ExtendsV4Props$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ExtendsV4Props$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ExtendsV4Props$JsMap(backingMap);

  @override
  _$$ExtendsV4Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV4Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV4';

  /// The default consumed props, comprising all props mixins used by ExtendsV4Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4Props, and check that $V4Props is exported/imported properly.
        V4Props: $V4Props.meta,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        ExtendsV4PropsMixin: $ExtendsV4PropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $V2ComponentFactory = registerComponent(
  () => _$V2Component(),
  builderFactory: _$V2,
  componentClass: V2Component,
  isWrapper: false,
  parentType: null,
);

abstract class _$V2PropsAccessorsMixin implements _$V2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$V2Props.v2_lateRequiredProp] -->
  @override
  String get v2_lateRequiredProp =>
      (props[_$key__v2_lateRequiredProp___$V2Props] ?? null) as String;

  /// <!-- Generated from [_$V2Props.v2_lateRequiredProp] -->
  @override
  set v2_lateRequiredProp(String value) =>
      props[_$key__v2_lateRequiredProp___$V2Props] = value;

  /// <!-- Generated from [_$V2Props.v2_optionalProp] -->
  @override
  String? get v2_optionalProp =>
      (props[_$key__v2_optionalProp___$V2Props] ?? null) as String?;

  /// <!-- Generated from [_$V2Props.v2_optionalProp] -->
  @override
  set v2_optionalProp(String? value) =>
      props[_$key__v2_optionalProp___$V2Props] = value;

  /// <!-- Generated from [_$V2Props.v2_annotationRequiredProp] -->
  @override
  @requiredProp
  String? get v2_annotationRequiredProp =>
      (props[_$key__v2_annotationRequiredProp___$V2Props] ?? null) as String?;

  /// <!-- Generated from [_$V2Props.v2_annotationRequiredProp] -->
  @override
  @requiredProp
  set v2_annotationRequiredProp(String? value) =>
      props[_$key__v2_annotationRequiredProp___$V2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v2_lateRequiredProp___$V2Props =
      PropDescriptor(_$key__v2_lateRequiredProp___$V2Props,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v2_optionalProp___$V2Props =
      PropDescriptor(_$key__v2_optionalProp___$V2Props);
  static const PropDescriptor _$prop__v2_annotationRequiredProp___$V2Props =
      PropDescriptor(_$key__v2_annotationRequiredProp___$V2Props,
          isRequired: true);
  static const String _$key__v2_lateRequiredProp___$V2Props =
      'V2Props.v2_lateRequiredProp';
  static const String _$key__v2_optionalProp___$V2Props =
      'V2Props.v2_optionalProp';
  static const String _$key__v2_annotationRequiredProp___$V2Props =
      'V2Props.v2_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v2_lateRequiredProp___$V2Props,
    _$prop__v2_optionalProp___$V2Props,
    _$prop__v2_annotationRequiredProp___$V2Props
  ];
  static const List<String> $propKeys = [
    _$key__v2_lateRequiredProp___$V2Props,
    _$key__v2_optionalProp___$V2Props,
    _$key__v2_annotationRequiredProp___$V2Props
  ];
}

const PropsMeta _$metaForV2Props = PropsMeta(
  fields: _$V2PropsAccessorsMixin.$props,
  keys: _$V2PropsAccessorsMixin.$propKeys,
);

_$$V2Props _$V2([Map? backingProps]) => _$$V2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$V2Props extends _$V2Props
    with _$V2PropsAccessorsMixin
    implements V2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V2Props(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $V2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'V2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V2Props(accessMap, (map) => _$$V2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$V2Component extends V2Component {
  @override
  _$$V2Props typedPropsFactory(Map? backingMap) => _$$V2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V2';

  /// The default consumed props, taken from _$V2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForV2Props];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $V3ComponentFactory = registerComponent(
  () => _$V3Component(),
  builderFactory: _$V3,
  componentClass: V3Component,
  isWrapper: false,
  parentType: null,
);

@Deprecated('This is deprecated')
abstract class _$V3PropsAccessorsMixin implements _$V3Props {
  @override
  Map get props;

  /// <!-- Generated from [_$V3Props.v3_lateRequiredProp] -->
  @override
  String get v3_lateRequiredProp =>
      (props[_$key__v3_lateRequiredProp___$V3Props] ?? null) as String;

  /// <!-- Generated from [_$V3Props.v3_lateRequiredProp] -->
  @override
  set v3_lateRequiredProp(String value) =>
      props[_$key__v3_lateRequiredProp___$V3Props] = value;

  /// <!-- Generated from [_$V3Props.v3_optionalProp] -->
  @override
  String? get v3_optionalProp =>
      (props[_$key__v3_optionalProp___$V3Props] ?? null) as String?;

  /// <!-- Generated from [_$V3Props.v3_optionalProp] -->
  @override
  set v3_optionalProp(String? value) =>
      props[_$key__v3_optionalProp___$V3Props] = value;

  /// <!-- Generated from [_$V3Props.v3_annotationRequiredProp] -->
  @override
  @requiredProp
  String? get v3_annotationRequiredProp =>
      (props[_$key__v3_annotationRequiredProp___$V3Props] ?? null) as String?;

  /// <!-- Generated from [_$V3Props.v3_annotationRequiredProp] -->
  @override
  @requiredProp
  set v3_annotationRequiredProp(String? value) =>
      props[_$key__v3_annotationRequiredProp___$V3Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v3_lateRequiredProp___$V3Props =
      PropDescriptor(_$key__v3_lateRequiredProp___$V3Props,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v3_optionalProp___$V3Props =
      PropDescriptor(_$key__v3_optionalProp___$V3Props);
  static const PropDescriptor _$prop__v3_annotationRequiredProp___$V3Props =
      PropDescriptor(_$key__v3_annotationRequiredProp___$V3Props,
          isRequired: true);
  static const String _$key__v3_lateRequiredProp___$V3Props =
      'V3Props.v3_lateRequiredProp';
  static const String _$key__v3_optionalProp___$V3Props =
      'V3Props.v3_optionalProp';
  static const String _$key__v3_annotationRequiredProp___$V3Props =
      'V3Props.v3_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v3_lateRequiredProp___$V3Props,
    _$prop__v3_optionalProp___$V3Props,
    _$prop__v3_annotationRequiredProp___$V3Props
  ];
  static const List<String> $propKeys = [
    _$key__v3_lateRequiredProp___$V3Props,
    _$key__v3_optionalProp___$V3Props,
    _$key__v3_annotationRequiredProp___$V3Props
  ];
}

const PropsMeta _$metaForV3Props = PropsMeta(
  fields: _$V3PropsAccessorsMixin.$props,
  keys: _$V3PropsAccessorsMixin.$propKeys,
);

@Deprecated('This is deprecated')
class V3Props extends _$V3Props with _$V3PropsAccessorsMixin {
  static String v3_static_field = '';
  static String get v3_static_getter => '';
  static set v3_static_setter(_) => '';
  static String get v3_static_getterAndSetter => '';
  static set v3_static_getterAndSetter(String _) {}
  static const PropsMeta meta = _$metaForV3Props;
}

_$$V3Props _$V3([Map? backingProps]) => _$$V3Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$V3Props extends _$V3Props
    with _$V3PropsAccessorsMixin
    implements V3Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V3Props(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $V3ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'V3Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V3Props(accessMap, (map) => _$$V3Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V3Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$V3Component extends V3Component {
  @override
  _$$V3Props typedPropsFactory(Map? backingMap) => _$$V3Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V3';

  /// The default consumed props, taken from _$V3Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForV3Props];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ExtendsV2ComponentFactory = registerComponent(
  () => _$ExtendsV2Component(),
  builderFactory: _$ExtendsV2,
  componentClass: ExtendsV2Component,
  isWrapper: false,
  parentType: null,
);

abstract class _$ExtendsV2PropsAccessorsMixin implements _$ExtendsV2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$ExtendsV2Props.v2_optionalProp_inSubclass] -->
  @override
  String? get v2_optionalProp_inSubclass =>
      (props[_$key__v2_optionalProp_inSubclass___$ExtendsV2Props] ?? null)
          as String?;

  /// <!-- Generated from [_$ExtendsV2Props.v2_optionalProp_inSubclass] -->
  @override
  set v2_optionalProp_inSubclass(String? value) =>
      props[_$key__v2_optionalProp_inSubclass___$ExtendsV2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v2_optionalProp_inSubclass___$ExtendsV2Props =
      PropDescriptor(_$key__v2_optionalProp_inSubclass___$ExtendsV2Props);
  static const String _$key__v2_optionalProp_inSubclass___$ExtendsV2Props =
      'ExtendsV2Props.v2_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v2_optionalProp_inSubclass___$ExtendsV2Props
  ];
  static const List<String> $propKeys = [
    _$key__v2_optionalProp_inSubclass___$ExtendsV2Props
  ];
}

const PropsMeta _$metaForExtendsV2Props = PropsMeta(
  fields: _$ExtendsV2PropsAccessorsMixin.$props,
  keys: _$ExtendsV2PropsAccessorsMixin.$propKeys,
);

_$$ExtendsV2Props _$ExtendsV2([Map? backingProps]) =>
    _$$ExtendsV2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ExtendsV2Props extends _$ExtendsV2Props
    with _$ExtendsV2PropsAccessorsMixin
    implements ExtendsV2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV2Props(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ExtendsV2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ExtendsV2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV2Props(
          accessMap, (map) => _$$ExtendsV2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ExtendsV2Component extends ExtendsV2Component {
  @override
  _$$ExtendsV2Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV2';

  /// The default consumed props, taken from _$ExtendsV2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForExtendsV2Props
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ExtendsV3ComponentFactory = registerComponent(
  () => _$ExtendsV3Component(),
  builderFactory: _$ExtendsV3,
  componentClass: ExtendsV3Component,
  isWrapper: false,
  parentType: null,
);

@Deprecated('This is deprecated')
abstract class _$ExtendsV3PropsAccessorsMixin implements _$ExtendsV3Props {
  @override
  Map get props;

  /// <!-- Generated from [_$ExtendsV3Props.v3_optionalProp_inSubclass] -->
  @override
  String? get v3_optionalProp_inSubclass =>
      (props[_$key__v3_optionalProp_inSubclass___$ExtendsV3Props] ?? null)
          as String?;

  /// <!-- Generated from [_$ExtendsV3Props.v3_optionalProp_inSubclass] -->
  @override
  set v3_optionalProp_inSubclass(String? value) =>
      props[_$key__v3_optionalProp_inSubclass___$ExtendsV3Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v3_optionalProp_inSubclass___$ExtendsV3Props =
      PropDescriptor(_$key__v3_optionalProp_inSubclass___$ExtendsV3Props);
  static const String _$key__v3_optionalProp_inSubclass___$ExtendsV3Props =
      'ExtendsV3Props.v3_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v3_optionalProp_inSubclass___$ExtendsV3Props
  ];
  static const List<String> $propKeys = [
    _$key__v3_optionalProp_inSubclass___$ExtendsV3Props
  ];
}

const PropsMeta _$metaForExtendsV3Props = PropsMeta(
  fields: _$ExtendsV3PropsAccessorsMixin.$props,
  keys: _$ExtendsV3PropsAccessorsMixin.$propKeys,
);

@Deprecated('This is deprecated')
class ExtendsV3Props extends _$ExtendsV3Props
    with _$ExtendsV3PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForExtendsV3Props;
}

_$$ExtendsV3Props _$ExtendsV3([Map? backingProps]) =>
    _$$ExtendsV3Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ExtendsV3Props extends _$ExtendsV3Props
    with _$ExtendsV3PropsAccessorsMixin
    implements ExtendsV3Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV3Props(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ExtendsV3ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ExtendsV3Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV3Props(
          accessMap, (map) => _$$ExtendsV3Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV3Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ExtendsV3Component extends ExtendsV3Component {
  @override
  _$$ExtendsV3Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV3Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV3';

  /// The default consumed props, taken from _$ExtendsV3Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForExtendsV3Props
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $V4Props on V4Props {
  static const PropsMeta meta = _$metaForV4Props;
  @override
  String get v4_lateRequiredProp =>
      (props[_$key__v4_lateRequiredProp__V4Props] ?? null) as String;
  @override
  set v4_lateRequiredProp(String value) =>
      props[_$key__v4_lateRequiredProp__V4Props] = value;
  @override
  String? get v4_optionalProp =>
      (props[_$key__v4_optionalProp__V4Props] ?? null) as String?;
  @override
  set v4_optionalProp(String? value) =>
      props[_$key__v4_optionalProp__V4Props] = value;
  @override
  @requiredProp
  String? get v4_annotationRequiredProp =>
      (props[_$key__v4_annotationRequiredProp__V4Props] ?? null) as String?;
  @override
  @requiredProp
  set v4_annotationRequiredProp(String? value) =>
      props[_$key__v4_annotationRequiredProp__V4Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v4_lateRequiredProp__V4Props =
      PropDescriptor(_$key__v4_lateRequiredProp__V4Props,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v4_optionalProp__V4Props =
      PropDescriptor(_$key__v4_optionalProp__V4Props);
  static const PropDescriptor _$prop__v4_annotationRequiredProp__V4Props =
      PropDescriptor(_$key__v4_annotationRequiredProp__V4Props,
          isRequired: true);
  static const String _$key__v4_lateRequiredProp__V4Props =
      'V4Props.v4_lateRequiredProp';
  static const String _$key__v4_optionalProp__V4Props =
      'V4Props.v4_optionalProp';
  static const String _$key__v4_annotationRequiredProp__V4Props =
      'V4Props.v4_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp__V4Props,
    _$prop__v4_optionalProp__V4Props,
    _$prop__v4_annotationRequiredProp__V4Props
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp__V4Props,
    _$key__v4_optionalProp__V4Props,
    _$key__v4_annotationRequiredProp__V4Props
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('V4Props.v4_lateRequiredProp')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_lateRequiredProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForV4Props = PropsMeta(
  fields: $V4Props.$props,
  keys: $V4Props.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ExtendsV4PropsMixin on ExtendsV4PropsMixin {
  static const PropsMeta meta = _$metaForExtendsV4PropsMixin;
  @override
  String? get v4_optionalProp_inSubclass =>
      (props[_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin] ?? null)
          as String?;
  @override
  set v4_optionalProp_inSubclass(String? value) =>
      props[_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v4_optionalProp_inSubclass__ExtendsV4PropsMixin =
      PropDescriptor(_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin);
  static const String _$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin =
      'ExtendsV4PropsMixin.v4_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v4_optionalProp_inSubclass__ExtendsV4PropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForExtendsV4PropsMixin = PropsMeta(
  fields: $ExtendsV4PropsMixin.$props,
  keys: $ExtendsV4PropsMixin.$propKeys,
);

    ''';
