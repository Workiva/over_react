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
  final int count1;
  @override
  final int count2;

  factory _$BaseState([void updates(BaseStateBuilder b)]) =>
      (new BaseStateBuilder()..update(updates)).build();

  _$BaseState._({this.count1, this.count2}) : super._() {
    if (count1 == null) throw new ArgumentError.notNull('count1');
    if (count2 == null) throw new ArgumentError.notNull('count2');
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
    return count1 == other.count1 && count2 == other.count2;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count1.hashCode), count2.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseState')
          ..add('count1', count1)
          ..add('count2', count2))
        .toString();
  }
}

class BaseStateBuilder implements Builder<BaseState, BaseStateBuilder> {
  _$BaseState _$v;

  int _count1;
  int get count1 => _$this._count1;
  set count1(int count1) => _$this._count1 = count1;

  int _count2;
  int get count2 => _$this._count2;
  set count2(int count2) => _$this._count2 = count2;

  BaseStateBuilder();

  BaseStateBuilder get _$this {
    if (_$v != null) {
      _count1 = _$v.count1;
      _count2 = _$v.count2;
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
    final _$result = _$v ?? new _$BaseState._(count1: count1, count2: count2);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$BaseActions extends BaseActions {
  factory _$BaseActions() => new _$BaseActions._();
  _$BaseActions._() : super._();

  final ActionDispatcher<Null> trigger1 =
      new ActionDispatcher<Null>('BaseActions-trigger1');
  final ActionDispatcher<Null> trigger2 =
      new ActionDispatcher<Null>('BaseActions-trigger2');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    trigger1.setDispatcher(dispatcher);
    trigger2.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final ActionName<Null> trigger1 =
      new ActionName<Null>('BaseActions-trigger1');
  static final ActionName<Null> trigger2 =
      new ActionName<Null>('BaseActions-trigger2');
}
