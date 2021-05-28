// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.component_declaration.redux_component.reducer;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$BaseActions extends BaseActions {
  factory _$BaseActions() => _$BaseActions._();
  _$BaseActions._() : super._();

  final trigger1 = ActionDispatcher<Null>('BaseActions-trigger1');
  final trigger2 = ActionDispatcher<Null>('BaseActions-trigger2');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    trigger1.setDispatcher(dispatcher);
    trigger2.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final trigger1 = ActionName<Null>('BaseActions-trigger1');
  static final trigger2 = ActionName<Null>('BaseActions-trigger2');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseState extends BaseState {
  @override
  final int? count1;
  @override
  final int? count2;

  factory _$BaseState([void Function(BaseStateBuilder)? updates]) =>
      (new BaseStateBuilder()..update(updates)).build();

  _$BaseState._({this.count1, this.count2}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count1, 'BaseState', 'count1');
    BuiltValueNullFieldError.checkNotNull(count2, 'BaseState', 'count2');
  }

  @override
  BaseState rebuild(void Function(BaseStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseStateBuilder toBuilder() => new BaseStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseState &&
        count1 == other.count1 &&
        count2 == other.count2;
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
  _$BaseState? _$v;

  int? _count1;
  int? get count1 => _$this._count1;
  set count1(int? count1) => _$this._count1 = count1;

  int? _count2;
  int? get count2 => _$this._count2;
  set count2(int? count2) => _$this._count2 = count2;

  BaseStateBuilder();

  BaseStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count1 = $v.count1;
      _count2 = $v.count2;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BaseState;
  }

  @override
  void update(void Function(BaseStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseState build() {
    final _$result = _$v ??
        new _$BaseState._(
            count1: BuiltValueNullFieldError.checkNotNull(
                count1, 'BaseState', 'count1'),
            count2: BuiltValueNullFieldError.checkNotNull(
                count2, 'BaseState', 'count2'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
