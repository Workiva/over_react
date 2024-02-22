
abstract class _Descriptor {
  String get key;
}

/// Provides a representation of a single `prop` declared within a [UiProps] subclass or props mixin.
///
/// > Related: [StateDescriptor]
class PropDescriptor implements _Descriptor {
  /// The string key associated with the `prop`.
  @override
  final String key;

  /// Whether the `prop` is required to be set.
  final bool isRequired;

  /// Whether setting the `prop` to `null` is valid.
  final bool isNullable;

  /// The message included in the thrown [PropError] if the `prop` is not set.
  final String errorMessage;

  const PropDescriptor(this.key, {this.isRequired = false, this.isNullable = false, this.errorMessage = ''});
}

/// Provides a representation of a single `state` declared within a [UiState] subclass or state mixin.
///
/// > Related: [PropDescriptor]
class StateDescriptor implements _Descriptor {
  /// The string key associated with the `state`.
  @override
  final String key;

  /// Whether the `state` is required to be set.
  ///
  /// __Currently not used.__
  final bool isRequired;

  /// Whether setting the `state` to `null` is valid.
  ///
  /// __Currently not used.__
  final bool isNullable;

  /// The message included in the thrown error if the `state` is not set.
  ///
  /// __Currently not used.__
  final String? errorMessage;

  const StateDescriptor(this.key, {this.isRequired = false, this.isNullable = false, this.errorMessage});
}

/// Provides a list of [PropDescriptor]s and a top-level list of their keys, for easy access.
class ConsumedProps {
  /// Rich views of prop declarations.
  ///
  /// This includes string keys, and required prop validation related fields.
  final List<PropDescriptor> props;

  /// Top-level accessor of string keys of props stored in [props].
  final List<String> keys;

  const ConsumedProps(this.props, this.keys);
}

abstract class AccessorMeta<T extends _Descriptor> {
  List<T> get fields;
  List<String> get keys;
}

/// Metadata for the prop fields declared in a specific props class--
/// a class annotated with `@Props`, `@PropsMixin`, `@AbstractProps`, etc.
/// for which prop accessors are generated.
///
/// This metadata includes map key values corresponding to these fields, which
/// is used in `consumedPropKeys`, as well as other prop
/// configuration done via `@Accessor`/`@requiredProp`/etc., which is used to
/// perform prop validation within `UiComponent` lifecycle methods.
///
/// This metadata is generated as part of the over_react builder, and should be
/// exposed like so:
///     @Props()
///     class FooProps {
///       static const PropsMeta meta = _$metaForFooProps;
///
///       String foo;
///
///       @Accessor(isRequired: true, key: 'custom_key', keyNamespace: 'custom_namespace')
///       int bar;
///     }
///
/// What the metadata looks like:
///     main() {
///       print(FooProps.meta.keys); // [FooProps.foo, custom_namespace.custom_key]
///       print(FooProps.meta.props.map((p) => p.isRequired); // (false, true))
///     }
///
/// _See also: `getPropKey`_
class PropsMeta implements ConsumedProps, AccessorMeta<PropDescriptor> {
  /// Rich views of prop field declarations.
  ///
  /// This includes string keys, and required prop validation related fields.
  @override
  final List<PropDescriptor> fields;

  /// Top-level accessor of string keys of props stored in [fields].
  @override
  final List<String> keys;

  const PropsMeta({required this.fields, required this.keys});

  /// A convenience constructor to make a metadata object for a single key.
  ///
  /// Useful within `UiComponent2.consumedProps`.
  ///
  /// Example:
  ///
  ///     @override
  ///     get consumedProps => [
  ///       propsMeta.forMixin(InputWrapperProps),
  ///       PropsMeta.forSimpleKey('onChange'),
  ///     ];
  factory PropsMeta.forSimpleKey(String key) => PropsMeta(
    fields: [PropDescriptor(key)],
    keys: [key],
  );

  @override
  List<PropDescriptor> get props => fields;

  @override
  String toString() => 'PropsMeta:$keys';
}

/// Metadata for the state fields declared in a specific state class--
/// a class annotated with `@State`, `@StateMixin`, `@AbstractState`, etc.
/// for which state accessors are generated.
///
/// This metadata includes map key values corresponding to these fields, which
/// is used to perform state validation within `UiComponent` lifecycle methods.
///
/// This metadata is generated as part of the over_react builder, and should be
/// exposed like so:
///     @State()
///     class FooState {
///       static const StateMeta meta = _$metaForFooState;
///
///       String foo;
///
///       @Accessor(key: 'custom_key', keyNamespace: 'custom_namespace')
///       int bar;
///     }
///
/// What the metadata looks like:
///     main() {
///       print(FooState.meta.keys); // [FooState.foo, custom_namespace.custom_key]
///       print(FooState.meta.fields.map((s) => s.key); // [FooState.foo, custom_namespace.custom_key]
///     }
class StateMeta implements AccessorMeta<StateDescriptor> {
  /// Rich views of state field declarations.
  ///
  /// This includes string keys, and required state validation related fields.
  @override
  final List<StateDescriptor> fields;

  /// Top-level accessor of string keys of state stored in [fields].
  @override
  final List<String> keys;

  const StateMeta({required this.fields, required this.keys});
}

abstract class _AccessorMetaCollection<T extends _Descriptor, U extends AccessorMeta<T>> implements AccessorMeta<T> {
  final Map<Type, U> _metaByMixin;

  const _AccessorMetaCollection(this._metaByMixin);

  U get _emptyMeta;

  /// Returns the metadata for only the prop fields declared in [mixinType].
  ///
  /// See `UiComponent2.consumedProps` for usage examples.
  U forMixin(Type mixinType) {
    final meta = _metaByMixin[mixinType];
    assert(meta != null,
        'No meta found for $mixinType;'
        'it likely isn\'t mixed in by the props/state class.');
    return meta ?? _emptyMeta;
  }

  /// Returns a set of all the metadata in this collection
  /// (for `propsMeta`, this corresponds to all props mixins mixed into the props class).
  ///
  /// See `UiComponent2.consumedProps` for usage examples.
  Iterable<U> get all => _metaByMixin.values;

  /// Returns a set of the metadata corresponding to [mixinTypes].
  ///
  /// See `UiComponent2.consumedProps` for usage examples.
  Iterable<U> forMixins(Set<Type> mixinTypes) =>
      mixinTypes.map(forMixin);

  /// Returns a set of all the metadata in this collection
  /// (for `propsMeta`, this corresponds to all props mixins mixed into the props class),
  /// except for the metadata corresponding to [excludedMixinTypes].
  ///
  /// See `UiComponent2.consumedProps` for usage examples.
  Iterable<U> allExceptForMixins(Set<Type> excludedMixinTypes) {
    final filtered = Map.of(_metaByMixin);
    for (final mixinType in excludedMixinTypes) {
      assert(_metaByMixin.containsKey(mixinType),
      'No meta found for $mixinType;'
          'it likely isn\'t mixed in by the props/state class.');
      filtered.remove(mixinType);
    }
    return filtered.values;
  }

  @override
  List<String> get keys =>
      _metaByMixin.values.expand((meta) => meta.keys).toList();

  @override
  List<T> get fields =>
      _metaByMixin.values.expand((meta) => meta.fields).toList();
}

/// A collection of metadata for the prop fields in all prop mixins
/// used by a given component.
///
/// See [PropsMeta] for more info.
class PropsMetaCollection extends _AccessorMetaCollection<PropDescriptor, PropsMeta> implements PropsMeta {
  const PropsMetaCollection(Map<Type, PropsMeta> metaByMixin) : super(metaByMixin);

  @override
  PropsMeta get _emptyMeta => const PropsMeta(fields: [], keys: []);

  @override
  List<PropDescriptor> get props => fields;
}
