// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'with_transition.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $WithTransitionPropsMixin on WithTransitionPropsMixin {
  static const PropsMeta meta = _$metaForWithTransitionPropsMixin;
  @override
  bool get isShown =>
      props[_$key__isShown__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isShown(bool value) =>
      props[_$key__isShown__WithTransitionPropsMixin] = value;
  @override
  Map<TransitionPhase, Map> get childPropsByPhase =>
      props[_$key__childPropsByPhase__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childPropsByPhase(Map<TransitionPhase, Map> value) =>
      props[_$key__childPropsByPhase__WithTransitionPropsMixin] = value;
  @override
  Duration get transitionTimeout =>
      props[_$key__transitionTimeout__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set transitionTimeout(Duration value) =>
      props[_$key__transitionTimeout__WithTransitionPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__isShown__WithTransitionPropsMixin =
      PropDescriptor(_$key__isShown__WithTransitionPropsMixin);
  static const PropDescriptor
      _$prop__childPropsByPhase__WithTransitionPropsMixin =
      PropDescriptor(_$key__childPropsByPhase__WithTransitionPropsMixin);
  static const PropDescriptor
      _$prop__transitionTimeout__WithTransitionPropsMixin =
      PropDescriptor(_$key__transitionTimeout__WithTransitionPropsMixin);
  static const String _$key__isShown__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.isShown';
  static const String _$key__childPropsByPhase__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.childPropsByPhase';
  static const String _$key__transitionTimeout__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.transitionTimeout';

  static const List<PropDescriptor> $props = [
    _$prop__isShown__WithTransitionPropsMixin,
    _$prop__childPropsByPhase__WithTransitionPropsMixin,
    _$prop__transitionTimeout__WithTransitionPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__isShown__WithTransitionPropsMixin,
    _$key__childPropsByPhase__WithTransitionPropsMixin,
    _$key__transitionTimeout__WithTransitionPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForWithTransitionPropsMixin = PropsMeta(
  fields: $WithTransitionPropsMixin.$props,
  keys: $WithTransitionPropsMixin.$propKeys,
);

final UiFactoryConfig<_$$WithTransitionProps> $WithTransitionConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$WithTransitionProps(map),
          jsMap: (map) => _$$WithTransitionProps$JsMap(map),
        ),
        displayName: 'WithTransition');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$WithTransitionProps extends UiProps
    with
        v2.TransitionPropsMixin,
        v2.$TransitionPropsMixin, // If this generated mixin is undefined, it's likely because v2.TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of v2.TransitionPropsMixin.
        WithTransitionPropsMixin,
        $WithTransitionPropsMixin // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of WithTransitionPropsMixin.
    implements
        WithTransitionProps {
  _$$WithTransitionProps._();

  factory _$$WithTransitionProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$WithTransitionProps$JsMap(backingMap);
    } else {
      return _$$WithTransitionProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionProps$PlainMap extends _$$WithTransitionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionProps$PlainMap(Map backingMap)
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
class _$$WithTransitionProps$JsMap extends _$$WithTransitionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
