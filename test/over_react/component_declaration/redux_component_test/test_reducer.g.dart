// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.component_declaration.redux_component.reducer;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$BaseState extends BaseState {
  @override
  final int count;

  factory _$BaseState([void updates(BaseStateBuilder b)]) =>
      (new BaseStateBuilder()..update(updates)).build();

  _$BaseState._({this.count}) : super._() {
    if (count == null) throw new ArgumentError.notNull('count');
  }

  @override
  BaseState rebuild(void updates(BaseStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseStateBuilder toBuilder() => new BaseStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! BaseState) return false;
    return count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseState')..add('count', count))
        .toString();
  }
}

class BaseStateBuilder implements Builder<BaseState, BaseStateBuilder> {
  _$BaseState _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  BaseStateBuilder();

  BaseStateBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$BaseState;
  }

  @override
  void update(void updates(BaseStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseState build() {
    final _$result = _$v ?? new _$BaseState._(count: count);
    replace(_$result);
    return _$result;
  }
}

class _$MultipleStates extends MultipleStates {
  @override
  final Store<BaseState, BaseStateBuilder, BaseActions> store1;
  @override
  final Store<BaseState, BaseStateBuilder, BaseActions> store2;
  @override
  final Store<BaseState, BaseStateBuilder, BaseActions> store3;

  factory _$MultipleStates([void updates(MultipleStatesBuilder b)]) =>
      (new MultipleStatesBuilder()..update(updates)).build();

  _$MultipleStates._({this.store1, this.store2, this.store3}) : super._() {
    if (store1 == null) throw new ArgumentError.notNull('store1');
    if (store2 == null) throw new ArgumentError.notNull('store2');
    if (store3 == null) throw new ArgumentError.notNull('store3');
  }

  @override
  MultipleStates rebuild(void updates(MultipleStatesBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MultipleStatesBuilder toBuilder() =>
      new MultipleStatesBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! MultipleStates) return false;
    return store1 == other.store1 &&
        store2 == other.store2 &&
        store3 == other.store3;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, store1.hashCode), store2.hashCode), store3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MultipleStates')
          ..add('store1', store1)
          ..add('store2', store2)
          ..add('store3', store3))
        .toString();
  }
}

class MultipleStatesBuilder
    implements Builder<MultipleStates, MultipleStatesBuilder> {
  _$MultipleStates _$v;

  Store<BaseState, BaseStateBuilder, BaseActions> _store1;
  Store<BaseState, BaseStateBuilder, BaseActions> get store1 => _$this._store1;
  set store1(Store<BaseState, BaseStateBuilder, BaseActions> store1) =>
      _$this._store1 = store1;

  Store<BaseState, BaseStateBuilder, BaseActions> _store2;
  Store<BaseState, BaseStateBuilder, BaseActions> get store2 => _$this._store2;
  set store2(Store<BaseState, BaseStateBuilder, BaseActions> store2) =>
      _$this._store2 = store2;

  Store<BaseState, BaseStateBuilder, BaseActions> _store3;
  Store<BaseState, BaseStateBuilder, BaseActions> get store3 => _$this._store3;
  set store3(Store<BaseState, BaseStateBuilder, BaseActions> store3) =>
      _$this._store3 = store3;

  MultipleStatesBuilder();

  MultipleStatesBuilder get _$this {
    if (_$v != null) {
      _store1 = _$v.store1;
      _store2 = _$v.store2;
      _store3 = _$v.store3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultipleStates other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$MultipleStates;
  }

  @override
  void update(void updates(MultipleStatesBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MultipleStates build() {
    final _$result = _$v ??
        new _$MultipleStates._(store1: store1, store2: store2, store3: store3);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$BaseActions extends BaseActions {
  final ActionDispatcher<String> trigger =
      new ActionDispatcher<String>('BaseActions-trigger');
  factory _$BaseActions() => new _$BaseActions._();

  _$BaseActions._() : super._();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    trigger.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final ActionName<String> trigger =
      new ActionName<String>('BaseActions-trigger');
}

class _$MultipleStatesActions extends MultipleStatesActions {
  factory _$MultipleStatesActions() => new _$MultipleStatesActions._();

  _$MultipleStatesActions._() : super._();

  @override
  void setDispatcher(Dispatcher dispatcher) {}
}

class MultipleStatesActionsNames {}
