// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent(() => new _$BasicComponent(),
    builderFactory: Basic,
    componentClass: BasicComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Basic');

abstract class _$BasicPropsAccessorsMixin implements _$BasicProps {
  @override
  Map get props;

  /// Go to [_$BasicProps.basicProp] to see the source code for this prop
  @override
  @deprecated
  @requiredProp
  String get basicProp => props['BasicProps.basicProp'];

  /// Go to [_$BasicProps.basicProp] to see the source code for this prop
  @override
  @deprecated
  @requiredProp
  set basicProp(String value) => props['BasicProps.basicProp'] = value;

  /// Go to [_$BasicProps.basic1] to see the source code for this prop
  @override
  String get basic1 => props['BasicProps.basic1'];

  /// Go to [_$BasicProps.basic1] to see the source code for this prop
  @override
  set basic1(String value) => props['BasicProps.basic1'] = value;

  /// Go to [_$BasicProps.basic2] to see the source code for this prop
  @override
  String get basic2 => props['BasicProps.basic2'];

  /// Go to [_$BasicProps.basic2] to see the source code for this prop
  @override
  set basic2(String value) => props['BasicProps.basic2'] = value;

  /// Go to [_$BasicProps.basic3] to see the source code for this prop
  @override
  String get basic3 => props['BasicProps.basic3'];

  /// Go to [_$BasicProps.basic3] to see the source code for this prop
  @override
  set basic3(String value) => props['BasicProps.basic3'] = value;

  /// Go to [_$BasicProps.basic4] to see the source code for this prop
  @override
  String get basic4 => props['BasicProps.basic4'];

  /// Go to [_$BasicProps.basic4] to see the source code for this prop
  @override
  set basic4(String value) => props['BasicProps.basic4'] = value;

  /// Go to [_$BasicProps.basic5] to see the source code for this prop
  @override
  String get basic5 => props['BasicProps.basic5'];

  /// Go to [_$BasicProps.basic5] to see the source code for this prop
  @override
  set basic5(String value) => props['BasicProps.basic5'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('BasicProps.basicProp', isRequired: true),
    const PropDescriptor('BasicProps.basic1'),
    const PropDescriptor('BasicProps.basic2'),
    const PropDescriptor('BasicProps.basic3'),
    const PropDescriptor('BasicProps.basic4'),
    const PropDescriptor('BasicProps.basic5')
  ];
  static const List<String> $propKeys = const [
    'BasicProps.basicProp',
    'BasicProps.basic1',
    'BasicProps.basic2',
    'BasicProps.basic3',
    'BasicProps.basic4',
    'BasicProps.basic5'
  ];
}

const PropsMeta _$metaForBasicProps = const PropsMeta(
  fields: _$BasicPropsAccessorsMixin.$props,
  keys: _$BasicPropsAccessorsMixin.$propKeys,
);

class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicProps;
}

_$$BasicProps _$Basic([Map backingProps]) => new _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicProps extends _$BasicProps
    with _$BasicPropsAccessorsMixin
    implements BasicProps {
  _$$BasicProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$BasicComponent extends BasicComponent {
  @override
  _$$BasicProps typedPropsFactory(Map backingMap) =>
      new _$$BasicProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
