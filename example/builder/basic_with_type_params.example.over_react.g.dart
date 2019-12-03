import 'package:over_react/over_react.dart';

import 'basic_with_type_params.dart';

final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

mixin $BasicPropsMixin<T, U extends UiProps> implements BasicPropsMixin<T, U> {
  @override
  Map get props;

  @override
  List<T> get someGenericListProp => props[_$key__someGenericListProp___$BasicProps] ?? null;

  @override
  set someGenericListProp(List<T> value) => props[_$key__someGenericListProp___$BasicProps] = value;

  @override U get somePropsClass => props[_$key__somePropsClass___$BasicProps] ?? null;
  @override set somePropsClass(U value) => props[_$key__somePropsClass___$BasicProps] = value;

  static const _$prop__someGenericListProp___$BasicProps = PropDescriptor(_$key__someGenericListProp___$BasicProps);
  static const _$prop__somePropsClass___$BasicProps = PropDescriptor(_$key__somePropsClass___$BasicProps);
  static const _$key__someGenericListProp___$BasicProps = 'BasicProps.someGenericListProp';
  static const _$key__somePropsClass___$BasicProps = 'BasicProps.somePropsClass';

  static const List<PropDescriptor> $props = [
    _$prop__someGenericListProp___$BasicProps,
    _$prop__somePropsClass___$BasicProps
  ];
  static const List<String> $propKeys = [_$key__someGenericListProp___$BasicProps, _$key__somePropsClass___$BasicProps];
}

const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: $BasicPropsMixin.$props,
  keys: $BasicPropsMixin.$propKeys,
);

$BasicProps $Basic([Map backingProps]) =>
    backingProps == null ? _$$BasicProps$JsMap(JsBackedMap()) : $BasicProps(backingProps);

class $BasicProps<T, U extends UiProps> extends BasicProps<T, U> with BasicPropsMixin<T, U>, $BasicPropsMixin<T, U> {
  $BasicProps._();

  static const PropsMeta meta = _$metaForBasicProps;

  factory $BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  @override
  Map get props;

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $BasicComponentFactory;

  @override
  String get propKeyNamespace => 'BasicProps.';
}

class _$$BasicProps$PlainMap<T, U extends UiProps> extends $BasicProps<T, U>
    with BasicPropsMixin<T, U>, $BasicPropsMixin<T, U> {
  _$$BasicProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$BasicProps$JsMap<T, U extends UiProps> extends $BasicProps<T, U>
    with BasicPropsMixin<T, U>, $BasicPropsMixin<T, U> {
  _$$BasicProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$BasicProps$JsMap(backingMap);

  @override
  $BasicProps typedPropsFactory(Map backingMap) => $BasicProps(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
