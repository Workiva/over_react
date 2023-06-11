// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'prop_mixins.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class ReactPropsMixin implements _$ReactPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForReactPropsMixin;
  @override
  List<dynamic>? get children {
    final value = _raw$ReactProps$children;
    if (value is List) return value;
    if (value == null) {
      return props.containsKey('children') ? const [] : null;
    }
    return [value];
  }

  @override
  set children(List<dynamic>? value) => _raw$ReactProps$children = value;
  @override
  String? get key => props['key'] as String?;
  @override
  set key(Object? value) =>
      props['key'] = value == null ? null : value.toString();

  /// <!-- Generated from [_$ReactPropsMixin._raw$ReactProps$children] -->
  @override
  @Accessor(key: 'children')
  get _raw$ReactProps$children =>
      (props[_$key___raw$ReactProps$children___$ReactPropsMixin]) as dynamic;

  /// <!-- Generated from [_$ReactPropsMixin._raw$ReactProps$children] -->
  @override
  @Accessor(key: 'children')
  set _raw$ReactProps$children(value) =>
      props[_$key___raw$ReactProps$children___$ReactPropsMixin] = value;

  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.ref] -->
  @override
  get ref => (props[_$key__ref___$ReactPropsMixin]) as dynamic;

  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.ref] -->
  @override
  set ref(value) => props[_$key__ref___$ReactPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop___raw$ReactProps$children___$ReactPropsMixin =
      PropDescriptor(_$key___raw$ReactProps$children___$ReactPropsMixin);
  static const PropDescriptor _$prop__ref___$ReactPropsMixin =
      PropDescriptor(_$key__ref___$ReactPropsMixin);
  static const String _$key___raw$ReactProps$children___$ReactPropsMixin =
      'children';
  static const String _$key__ref___$ReactPropsMixin = 'ref';

  static const List<PropDescriptor> $props = [
    _$prop___raw$ReactProps$children___$ReactPropsMixin,
    _$prop__ref___$ReactPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key___raw$ReactProps$children___$ReactPropsMixin,
    _$key__ref___$ReactPropsMixin
  ];
}

const PropsMeta _$metaForReactPropsMixin = PropsMeta(
  fields: ReactPropsMixin.$props,
  keys: ReactPropsMixin.$propKeys,
);

abstract class DomPropsMixin implements _$DomPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForDomPropsMixin;
  @override
  Map<String, dynamic>? get style =>
      _conditionallyUnconvertStyle(_raw$DomProps$style);
  @override
  set style(Map<String, dynamic>? value) => _raw$DomProps$style = value;

  /// <!-- Generated from [_$DomPropsMixin.cols] -->
  @override
  get cols => (props[_$key__cols___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.cols] -->
  @override
  set cols(value) => props[_$key__cols___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.minLength] -->
  @override
  get minLength => (props[_$key__minLength___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.minLength] -->
  @override
  set minLength(value) => props[_$key__minLength___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rows] -->
  @override
  get rows => (props[_$key__rows___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.rows] -->
  @override
  set rows(value) => props[_$key__rows___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.size] -->
  @override
  get size => (props[_$key__size___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.size] -->
  @override
  set size(value) => props[_$key__size___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.span] -->
  @override
  get span => (props[_$key__span___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.span] -->
  @override
  set span(value) => props[_$key__span___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.start] -->
  @override
  get start => (props[_$key__start___$DomPropsMixin]) as int?;

  /// <!-- Generated from [_$DomPropsMixin.start] -->
  @override
  set start(value) => props[_$key__start___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.high] -->
  @override
  get high => (props[_$key__high___$DomPropsMixin]) as num?;

  /// <!-- Generated from [_$DomPropsMixin.high] -->
  @override
  set high(value) => props[_$key__high___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.low] -->
  @override
  get low => (props[_$key__low___$DomPropsMixin]) as num?;

  /// <!-- Generated from [_$DomPropsMixin.low] -->
  @override
  set low(value) => props[_$key__low___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.marginHeight] -->
  @override
  get marginHeight => (props[_$key__marginHeight___$DomPropsMixin]) as num?;

  /// <!-- Generated from [_$DomPropsMixin.marginHeight] -->
  @override
  set marginHeight(value) =>
      props[_$key__marginHeight___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.marginWidth] -->
  @override
  get marginWidth => (props[_$key__marginWidth___$DomPropsMixin]) as num?;

  /// <!-- Generated from [_$DomPropsMixin.marginWidth] -->
  @override
  set marginWidth(value) => props[_$key__marginWidth___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.optimum] -->
  @override
  get optimum => (props[_$key__optimum___$DomPropsMixin]) as num?;

  /// <!-- Generated from [_$DomPropsMixin.optimum] -->
  @override
  set optimum(value) => props[_$key__optimum___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.htmlDefault] -->
  @override
  @Accessor(key: 'default')
  get htmlDefault => (props[_$key__htmlDefault___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.htmlDefault] -->
  @override
  @Accessor(key: 'default')
  set htmlDefault(value) => props[_$key__htmlDefault___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.htmlIs] -->
  @override
  @Accessor(key: 'is')
  get htmlIs => (props[_$key__htmlIs___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.htmlIs] -->
  @override
  @Accessor(key: 'is')
  set htmlIs(value) => props[_$key__htmlIs___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.allowFullScreen] -->
  @override
  get allowFullScreen =>
      (props[_$key__allowFullScreen___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.allowFullScreen] -->
  @override
  set allowFullScreen(value) =>
      props[_$key__allowFullScreen___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.async] -->
  @override
  get async => (props[_$key__async___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.async] -->
  @override
  set async(value) => props[_$key__async___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.autoPlay] -->
  @override
  get autoPlay => (props[_$key__autoPlay___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.autoPlay] -->
  @override
  set autoPlay(value) => props[_$key__autoPlay___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.checked] -->
  @override
  get checked => (props[_$key__checked___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.checked] -->
  @override
  set checked(value) => props[_$key__checked___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.controls] -->
  @override
  get controls => (props[_$key__controls___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.controls] -->
  @override
  set controls(value) => props[_$key__controls___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defer] -->
  @override
  get defer => (props[_$key__defer___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.defer] -->
  @override
  set defer(value) => props[_$key__defer___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.disabled] -->
  @override
  get disabled => (props[_$key__disabled___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.disabled] -->
  @override
  set disabled(value) => props[_$key__disabled___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formNoValidate] -->
  @override
  get formNoValidate =>
      (props[_$key__formNoValidate___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.formNoValidate] -->
  @override
  set formNoValidate(value) =>
      props[_$key__formNoValidate___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.hidden] -->
  @override
  get hidden => (props[_$key__hidden___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.hidden] -->
  @override
  set hidden(value) => props[_$key__hidden___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.loop] -->
  @override
  get loop => (props[_$key__loop___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.loop] -->
  @override
  set loop(value) => props[_$key__loop___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.multiple] -->
  @override
  get multiple => (props[_$key__multiple___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.multiple] -->
  @override
  set multiple(value) => props[_$key__multiple___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.muted] -->
  @override
  get muted => (props[_$key__muted___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.muted] -->
  @override
  set muted(value) => props[_$key__muted___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.noValidate] -->
  @override
  get noValidate => (props[_$key__noValidate___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.noValidate] -->
  @override
  set noValidate(value) => props[_$key__noValidate___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.open] -->
  @override
  get open => (props[_$key__open___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.open] -->
  @override
  set open(value) => props[_$key__open___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.readOnly] -->
  @override
  get readOnly => (props[_$key__readOnly___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.readOnly] -->
  @override
  set readOnly(value) => props[_$key__readOnly___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.required] -->
  @override
  get required => (props[_$key__required___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.required] -->
  @override
  set required(value) => props[_$key__required___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.reversed] -->
  @override
  get reversed => (props[_$key__reversed___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.reversed] -->
  @override
  set reversed(value) => props[_$key__reversed___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.scoped] -->
  @override
  get scoped => (props[_$key__scoped___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.scoped] -->
  @override
  set scoped(value) => props[_$key__scoped___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.seamless] -->
  @override
  get seamless => (props[_$key__seamless___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.seamless] -->
  @override
  set seamless(value) => props[_$key__seamless___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.selected] -->
  @override
  get selected => (props[_$key__selected___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.selected] -->
  @override
  set selected(value) => props[_$key__selected___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin._raw$DomProps$style] -->
  @override
  @Accessor(key: 'style')
  get _raw$DomProps$style =>
      (props[_$key___raw$DomProps$style___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin._raw$DomProps$style] -->
  @override
  @Accessor(key: 'style')
  set _raw$DomProps$style(value) =>
      props[_$key___raw$DomProps$style___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.challenge] -->
  @override
  get challenge => (props[_$key__challenge___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.challenge] -->
  @override
  set challenge(value) => props[_$key__challenge___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.cite] -->
  @override
  get cite => (props[_$key__cite___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.cite] -->
  @override
  set cite(value) => props[_$key__cite___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.className] -->
  @override
  get className => (props[_$key__className___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.className] -->
  @override
  set className(value) => props[_$key__className___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.controlsList] -->
  @override
  get controlsList => (props[_$key__controlsList___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.controlsList] -->
  @override
  set controlsList(value) =>
      props[_$key__controlsList___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formAction] -->
  @override
  get formAction => (props[_$key__formAction___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.formAction] -->
  @override
  set formAction(value) => props[_$key__formAction___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formEncType] -->
  @override
  get formEncType => (props[_$key__formEncType___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.formEncType] -->
  @override
  set formEncType(value) => props[_$key__formEncType___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formMethod] -->
  @override
  get formMethod => (props[_$key__formMethod___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.formMethod] -->
  @override
  set formMethod(value) => props[_$key__formMethod___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formTarget] -->
  @override
  get formTarget => (props[_$key__formTarget___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.formTarget] -->
  @override
  set formTarget(value) => props[_$key__formTarget___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.headers] -->
  @override
  get headers => (props[_$key__headers___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.headers] -->
  @override
  set headers(value) => props[_$key__headers___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.id] -->
  @override
  get id => (props[_$key__id___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.id] -->
  @override
  set id(value) => props[_$key__id___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.inputMode] -->
  @override
  get inputMode => (props[_$key__inputMode___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.inputMode] -->
  @override
  set inputMode(value) => props[_$key__inputMode___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.integrity] -->
  @override
  get integrity => (props[_$key__integrity___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.integrity] -->
  @override
  set integrity(value) => props[_$key__integrity___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.keyParams] -->
  @override
  get keyParams => (props[_$key__keyParams___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.keyParams] -->
  @override
  set keyParams(value) => props[_$key__keyParams___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.keyType] -->
  @override
  get keyType => (props[_$key__keyType___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.keyType] -->
  @override
  set keyType(value) => props[_$key__keyType___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.kind] -->
  @override
  get kind => (props[_$key__kind___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.kind] -->
  @override
  set kind(value) => props[_$key__kind___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.nonce] -->
  @override
  get nonce => (props[_$key__nonce___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.nonce] -->
  @override
  set nonce(value) => props[_$key__nonce___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.srcLang] -->
  @override
  get srcLang => (props[_$key__srcLang___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.srcLang] -->
  @override
  set srcLang(value) => props[_$key__srcLang___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.summary] -->
  @override
  get summary => (props[_$key__summary___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.summary] -->
  @override
  set summary(value) => props[_$key__summary___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.title] -->
  @override
  get title => (props[_$key__title___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.title] -->
  @override
  set title(value) => props[_$key__title___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.wrap] -->
  @override
  get wrap => (props[_$key__wrap___$DomPropsMixin]) as String?;

  /// <!-- Generated from [_$DomPropsMixin.wrap] -->
  @override
  set wrap(value) => props[_$key__wrap___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.accept] -->
  @override
  get accept => (props[_$key__accept___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.accept] -->
  @override
  set accept(value) => props[_$key__accept___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.acceptCharset] -->
  @override
  get acceptCharset =>
      (props[_$key__acceptCharset___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.acceptCharset] -->
  @override
  set acceptCharset(value) =>
      props[_$key__acceptCharset___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.accessKey] -->
  @override
  get accessKey => (props[_$key__accessKey___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.accessKey] -->
  @override
  set accessKey(value) => props[_$key__accessKey___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.action] -->
  @override
  get action => (props[_$key__action___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.action] -->
  @override
  set action(value) => props[_$key__action___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.allowTransparency] -->
  @override
  get allowTransparency =>
      (props[_$key__allowTransparency___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.allowTransparency] -->
  @override
  set allowTransparency(value) =>
      props[_$key__allowTransparency___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.alt] -->
  @override
  get alt => (props[_$key__alt___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.alt] -->
  @override
  set alt(value) => props[_$key__alt___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.autoComplete] -->
  @override
  get autoComplete => (props[_$key__autoComplete___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.autoComplete] -->
  @override
  set autoComplete(value) =>
      props[_$key__autoComplete___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.capture] -->
  @override
  get capture => (props[_$key__capture___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.capture] -->
  @override
  set capture(value) => props[_$key__capture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.cellPadding] -->
  @override
  get cellPadding => (props[_$key__cellPadding___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.cellPadding] -->
  @override
  set cellPadding(value) => props[_$key__cellPadding___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.cellSpacing] -->
  @override
  get cellSpacing => (props[_$key__cellSpacing___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.cellSpacing] -->
  @override
  set cellSpacing(value) => props[_$key__cellSpacing___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.charSet] -->
  @override
  get charSet => (props[_$key__charSet___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.charSet] -->
  @override
  set charSet(value) => props[_$key__charSet___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.classID] -->
  @override
  get classID => (props[_$key__classID___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.classID] -->
  @override
  set classID(value) => props[_$key__classID___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.colSpan] -->
  @override
  get colSpan => (props[_$key__colSpan___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.colSpan] -->
  @override
  set colSpan(value) => props[_$key__colSpan___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.content] -->
  @override
  get content => (props[_$key__content___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.content] -->
  @override
  set content(value) => props[_$key__content___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.contentEditable] -->
  @override
  get contentEditable =>
      (props[_$key__contentEditable___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.contentEditable] -->
  @override
  set contentEditable(value) =>
      props[_$key__contentEditable___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.contextMenu] -->
  @override
  get contextMenu => (props[_$key__contextMenu___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.contextMenu] -->
  @override
  set contextMenu(value) => props[_$key__contextMenu___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.coords] -->
  @override
  get coords => (props[_$key__coords___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.coords] -->
  @override
  set coords(value) => props[_$key__coords___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.crossOrigin] -->
  @override
  get crossOrigin => (props[_$key__crossOrigin___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.crossOrigin] -->
  @override
  set crossOrigin(value) => props[_$key__crossOrigin___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.data] -->
  @override
  get data => (props[_$key__data___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.data] -->
  @override
  set data(value) => props[_$key__data___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.dateTime] -->
  @override
  get dateTime => (props[_$key__dateTime___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.dateTime] -->
  @override
  set dateTime(value) => props[_$key__dateTime___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.dir] -->
  @override
  get dir => (props[_$key__dir___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.dir] -->
  @override
  set dir(value) => props[_$key__dir___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.download] -->
  @override
  get download => (props[_$key__download___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.download] -->
  @override
  set download(value) => props[_$key__download___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.draggable] -->
  @override
  get draggable => (props[_$key__draggable___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.draggable] -->
  @override
  set draggable(value) => props[_$key__draggable___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.encType] -->
  @override
  get encType => (props[_$key__encType___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.encType] -->
  @override
  set encType(value) => props[_$key__encType___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.form] -->
  @override
  get form => (props[_$key__form___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.form] -->
  @override
  set form(value) => props[_$key__form___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.frameBorder] -->
  @override
  get frameBorder => (props[_$key__frameBorder___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.frameBorder] -->
  @override
  set frameBorder(value) => props[_$key__frameBorder___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.height] -->
  @override
  get height => (props[_$key__height___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.height] -->
  @override
  set height(value) => props[_$key__height___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.href] -->
  @override
  get href => (props[_$key__href___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.href] -->
  @override
  set href(value) => props[_$key__href___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.hrefLang] -->
  @override
  get hrefLang => (props[_$key__hrefLang___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.hrefLang] -->
  @override
  set hrefLang(value) => props[_$key__hrefLang___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.htmlFor] -->
  @override
  get htmlFor => (props[_$key__htmlFor___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.htmlFor] -->
  @override
  set htmlFor(value) => props[_$key__htmlFor___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.httpEquiv] -->
  @override
  get httpEquiv => (props[_$key__httpEquiv___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.httpEquiv] -->
  @override
  set httpEquiv(value) => props[_$key__httpEquiv___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.icon] -->
  @override
  get icon => (props[_$key__icon___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.icon] -->
  @override
  set icon(value) => props[_$key__icon___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.label] -->
  @override
  get label => (props[_$key__label___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.label] -->
  @override
  set label(value) => props[_$key__label___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.lang] -->
  @override
  get lang => (props[_$key__lang___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.lang] -->
  @override
  set lang(value) => props[_$key__lang___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.list] -->
  @override
  get list => (props[_$key__list___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.list] -->
  @override
  set list(value) => props[_$key__list___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.manifest] -->
  @override
  get manifest => (props[_$key__manifest___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.manifest] -->
  @override
  set manifest(value) => props[_$key__manifest___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.max] -->
  @override
  get max => (props[_$key__max___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.max] -->
  @override
  set max(value) => props[_$key__max___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.maxLength] -->
  @override
  get maxLength => (props[_$key__maxLength___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.maxLength] -->
  @override
  set maxLength(value) => props[_$key__maxLength___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.media] -->
  @override
  get media => (props[_$key__media___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.media] -->
  @override
  set media(value) => props[_$key__media___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.mediaGroup] -->
  @override
  get mediaGroup => (props[_$key__mediaGroup___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.mediaGroup] -->
  @override
  set mediaGroup(value) => props[_$key__mediaGroup___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.method] -->
  @override
  get method => (props[_$key__method___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.method] -->
  @override
  set method(value) => props[_$key__method___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.min] -->
  @override
  get min => (props[_$key__min___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.min] -->
  @override
  set min(value) => props[_$key__min___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.name] -->
  @override
  get name => (props[_$key__name___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.name] -->
  @override
  set name(value) => props[_$key__name___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.pattern] -->
  @override
  get pattern => (props[_$key__pattern___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.pattern] -->
  @override
  set pattern(value) => props[_$key__pattern___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.placeholder] -->
  @override
  get placeholder => (props[_$key__placeholder___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.placeholder] -->
  @override
  set placeholder(value) => props[_$key__placeholder___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.poster] -->
  @override
  get poster => (props[_$key__poster___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.poster] -->
  @override
  set poster(value) => props[_$key__poster___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.preload] -->
  @override
  get preload => (props[_$key__preload___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.preload] -->
  @override
  set preload(value) => props[_$key__preload___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.radioGroup] -->
  @override
  get radioGroup => (props[_$key__radioGroup___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.radioGroup] -->
  @override
  set radioGroup(value) => props[_$key__radioGroup___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rel] -->
  @override
  get rel => (props[_$key__rel___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.rel] -->
  @override
  set rel(value) => props[_$key__rel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.role] -->
  @override
  get role => (props[_$key__role___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.role] -->
  @override
  set role(value) => props[_$key__role___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rowSpan] -->
  @override
  get rowSpan => (props[_$key__rowSpan___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.rowSpan] -->
  @override
  set rowSpan(value) => props[_$key__rowSpan___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.sandbox] -->
  @override
  get sandbox => (props[_$key__sandbox___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.sandbox] -->
  @override
  set sandbox(value) => props[_$key__sandbox___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.scope] -->
  @override
  get scope => (props[_$key__scope___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.scope] -->
  @override
  set scope(value) => props[_$key__scope___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.scrolling] -->
  @override
  get scrolling => (props[_$key__scrolling___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.scrolling] -->
  @override
  set scrolling(value) => props[_$key__scrolling___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.shape] -->
  @override
  get shape => (props[_$key__shape___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.shape] -->
  @override
  set shape(value) => props[_$key__shape___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.sizes] -->
  @override
  get sizes => (props[_$key__sizes___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.sizes] -->
  @override
  set sizes(value) => props[_$key__sizes___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.spellCheck] -->
  @override
  get spellCheck => (props[_$key__spellCheck___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.spellCheck] -->
  @override
  set spellCheck(value) => props[_$key__spellCheck___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.src] -->
  @override
  get src => (props[_$key__src___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.src] -->
  @override
  set src(value) => props[_$key__src___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.srcDoc] -->
  @override
  get srcDoc => (props[_$key__srcDoc___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.srcDoc] -->
  @override
  set srcDoc(value) => props[_$key__srcDoc___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.srcSet] -->
  @override
  get srcSet => (props[_$key__srcSet___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.srcSet] -->
  @override
  set srcSet(value) => props[_$key__srcSet___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.step] -->
  @override
  get step => (props[_$key__step___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.step] -->
  @override
  set step(value) => props[_$key__step___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.tabIndex] -->
  @override
  get tabIndex => (props[_$key__tabIndex___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.tabIndex] -->
  @override
  set tabIndex(value) => props[_$key__tabIndex___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.target] -->
  @override
  get target => (props[_$key__target___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.target] -->
  @override
  set target(value) => props[_$key__target___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.type] -->
  @override
  get type => (props[_$key__type___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.type] -->
  @override
  set type(value) => props[_$key__type___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.useMap] -->
  @override
  get useMap => (props[_$key__useMap___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.useMap] -->
  @override
  set useMap(value) => props[_$key__useMap___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.value] -->
  @override
  get value => (props[_$key__value___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.value] -->
  @override
  set value(value) => props[_$key__value___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.width] -->
  @override
  get width => (props[_$key__width___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.width] -->
  @override
  set width(value) => props[_$key__width___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.wmode] -->
  @override
  get wmode => (props[_$key__wmode___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.wmode] -->
  @override
  set wmode(value) => props[_$key__wmode___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationEnd] -->
  @override
  get onAnimationEnd => (props[_$key__onAnimationEnd___$DomPropsMixin])
      as AnimationEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationEnd] -->
  @override
  set onAnimationEnd(value) =>
      props[_$key__onAnimationEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationIteration] -->
  @override
  get onAnimationIteration =>
      (props[_$key__onAnimationIteration___$DomPropsMixin])
          as AnimationEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationIteration] -->
  @override
  set onAnimationIteration(value) =>
      props[_$key__onAnimationIteration___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationStart] -->
  @override
  get onAnimationStart => (props[_$key__onAnimationStart___$DomPropsMixin])
      as AnimationEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationStart] -->
  @override
  set onAnimationStart(value) =>
      props[_$key__onAnimationStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCopy] -->
  @override
  get onCopy =>
      (props[_$key__onCopy___$DomPropsMixin]) as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onCopy] -->
  @override
  set onCopy(value) => props[_$key__onCopy___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCut] -->
  @override
  get onCut =>
      (props[_$key__onCut___$DomPropsMixin]) as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onCut] -->
  @override
  set onCut(value) => props[_$key__onCut___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPaste] -->
  @override
  get onPaste =>
      (props[_$key__onPaste___$DomPropsMixin]) as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPaste] -->
  @override
  set onPaste(value) => props[_$key__onPaste___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDown] -->
  @override
  get onKeyDown =>
      (props[_$key__onKeyDown___$DomPropsMixin]) as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDown] -->
  @override
  set onKeyDown(value) => props[_$key__onKeyDown___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPress] -->
  @override
  get onKeyPress =>
      (props[_$key__onKeyPress___$DomPropsMixin]) as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPress] -->
  @override
  set onKeyPress(value) => props[_$key__onKeyPress___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUp] -->
  @override
  get onKeyUp =>
      (props[_$key__onKeyUp___$DomPropsMixin]) as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUp] -->
  @override
  set onKeyUp(value) => props[_$key__onKeyUp___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onFocus] -->
  @override
  get onFocus =>
      (props[_$key__onFocus___$DomPropsMixin]) as FocusEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onFocus] -->
  @override
  set onFocus(value) => props[_$key__onFocus___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onBlur] -->
  @override
  get onBlur => (props[_$key__onBlur___$DomPropsMixin]) as FocusEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onBlur] -->
  @override
  set onBlur(value) => props[_$key__onBlur___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onChange] -->
  @override
  get onChange =>
      (props[_$key__onChange___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onChange] -->
  @override
  set onChange(value) => props[_$key__onChange___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onInput] -->
  @override
  get onInput => (props[_$key__onInput___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onInput] -->
  @override
  set onInput(value) => props[_$key__onInput___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onSubmit] -->
  @override
  get onSubmit =>
      (props[_$key__onSubmit___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onSubmit] -->
  @override
  set onSubmit(value) => props[_$key__onSubmit___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onReset] -->
  @override
  get onReset => (props[_$key__onReset___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onReset] -->
  @override
  set onReset(value) => props[_$key__onReset___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onClick] -->
  @override
  get onClick =>
      (props[_$key__onClick___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onClick] -->
  @override
  set onClick(value) => props[_$key__onClick___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenu] -->
  @override
  get onContextMenu =>
      (props[_$key__onContextMenu___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenu] -->
  @override
  set onContextMenu(value) =>
      props[_$key__onContextMenu___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClick] -->
  @override
  get onDoubleClick =>
      (props[_$key__onDoubleClick___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClick] -->
  @override
  set onDoubleClick(value) =>
      props[_$key__onDoubleClick___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDrag] -->
  @override
  get onDrag => (props[_$key__onDrag___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDrag] -->
  @override
  set onDrag(value) => props[_$key__onDrag___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnd] -->
  @override
  get onDragEnd =>
      (props[_$key__onDragEnd___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnd] -->
  @override
  set onDragEnd(value) => props[_$key__onDragEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnter] -->
  @override
  get onDragEnter =>
      (props[_$key__onDragEnter___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnter] -->
  @override
  set onDragEnter(value) => props[_$key__onDragEnter___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragExit] -->
  @override
  get onDragExit =>
      (props[_$key__onDragExit___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragExit] -->
  @override
  set onDragExit(value) => props[_$key__onDragExit___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeave] -->
  @override
  get onDragLeave =>
      (props[_$key__onDragLeave___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeave] -->
  @override
  set onDragLeave(value) => props[_$key__onDragLeave___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragOver] -->
  @override
  get onDragOver =>
      (props[_$key__onDragOver___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragOver] -->
  @override
  set onDragOver(value) => props[_$key__onDragOver___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragStart] -->
  @override
  get onDragStart =>
      (props[_$key__onDragStart___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragStart] -->
  @override
  set onDragStart(value) => props[_$key__onDragStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDrop] -->
  @override
  get onDrop => (props[_$key__onDrop___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDrop] -->
  @override
  set onDrop(value) => props[_$key__onDrop___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDown] -->
  @override
  get onMouseDown =>
      (props[_$key__onMouseDown___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDown] -->
  @override
  set onMouseDown(value) => props[_$key__onMouseDown___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnter] -->
  @override
  get onMouseEnter =>
      (props[_$key__onMouseEnter___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnter] -->
  @override
  set onMouseEnter(value) =>
      props[_$key__onMouseEnter___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeave] -->
  @override
  get onMouseLeave =>
      (props[_$key__onMouseLeave___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeave] -->
  @override
  set onMouseLeave(value) =>
      props[_$key__onMouseLeave___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMove] -->
  @override
  get onMouseMove =>
      (props[_$key__onMouseMove___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMove] -->
  @override
  set onMouseMove(value) => props[_$key__onMouseMove___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOut] -->
  @override
  get onMouseOut =>
      (props[_$key__onMouseOut___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOut] -->
  @override
  set onMouseOut(value) => props[_$key__onMouseOut___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOver] -->
  @override
  get onMouseOver =>
      (props[_$key__onMouseOver___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOver] -->
  @override
  set onMouseOver(value) => props[_$key__onMouseOver___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUp] -->
  @override
  get onMouseUp =>
      (props[_$key__onMouseUp___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUp] -->
  @override
  set onMouseUp(value) => props[_$key__onMouseUp___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerCancel] -->
  @override
  get onPointerCancel =>
      (props[_$key__onPointerCancel___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerCancel] -->
  @override
  set onPointerCancel(value) =>
      props[_$key__onPointerCancel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerDown] -->
  @override
  get onPointerDown =>
      (props[_$key__onPointerDown___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerDown] -->
  @override
  set onPointerDown(value) =>
      props[_$key__onPointerDown___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerEnter] -->
  @override
  get onPointerEnter =>
      (props[_$key__onPointerEnter___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerEnter] -->
  @override
  set onPointerEnter(value) =>
      props[_$key__onPointerEnter___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerLeave] -->
  @override
  get onPointerLeave =>
      (props[_$key__onPointerLeave___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerLeave] -->
  @override
  set onPointerLeave(value) =>
      props[_$key__onPointerLeave___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerMove] -->
  @override
  get onPointerMove =>
      (props[_$key__onPointerMove___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerMove] -->
  @override
  set onPointerMove(value) =>
      props[_$key__onPointerMove___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerOver] -->
  @override
  get onPointerOver =>
      (props[_$key__onPointerOver___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerOver] -->
  @override
  set onPointerOver(value) =>
      props[_$key__onPointerOver___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerOut] -->
  @override
  get onPointerOut =>
      (props[_$key__onPointerOut___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerOut] -->
  @override
  set onPointerOut(value) =>
      props[_$key__onPointerOut___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPointerUp] -->
  @override
  get onPointerUp =>
      (props[_$key__onPointerUp___$DomPropsMixin]) as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPointerUp] -->
  @override
  set onPointerUp(value) => props[_$key__onPointerUp___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancel] -->
  @override
  get onTouchCancel =>
      (props[_$key__onTouchCancel___$DomPropsMixin]) as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancel] -->
  @override
  set onTouchCancel(value) =>
      props[_$key__onTouchCancel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEnd] -->
  @override
  get onTouchEnd =>
      (props[_$key__onTouchEnd___$DomPropsMixin]) as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEnd] -->
  @override
  set onTouchEnd(value) => props[_$key__onTouchEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMove] -->
  @override
  get onTouchMove =>
      (props[_$key__onTouchMove___$DomPropsMixin]) as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMove] -->
  @override
  set onTouchMove(value) => props[_$key__onTouchMove___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStart] -->
  @override
  get onTouchStart =>
      (props[_$key__onTouchStart___$DomPropsMixin]) as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStart] -->
  @override
  set onTouchStart(value) =>
      props[_$key__onTouchStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTransitionEnd] -->
  @override
  get onTransitionEnd => (props[_$key__onTransitionEnd___$DomPropsMixin])
      as TransitionEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTransitionEnd] -->
  @override
  set onTransitionEnd(value) =>
      props[_$key__onTransitionEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onScroll] -->
  @override
  get onScroll => (props[_$key__onScroll___$DomPropsMixin]) as UIEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onScroll] -->
  @override
  set onScroll(value) => props[_$key__onScroll___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onWheel] -->
  @override
  get onWheel =>
      (props[_$key__onWheel___$DomPropsMixin]) as WheelEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onWheel] -->
  @override
  set onWheel(value) => props[_$key__onWheel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCopyCapture] -->
  @override
  get onCopyCapture =>
      (props[_$key__onCopyCapture___$DomPropsMixin]) as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onCopyCapture] -->
  @override
  set onCopyCapture(value) =>
      props[_$key__onCopyCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCutCapture] -->
  @override
  get onCutCapture =>
      (props[_$key__onCutCapture___$DomPropsMixin]) as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onCutCapture] -->
  @override
  set onCutCapture(value) =>
      props[_$key__onCutCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPasteCapture] -->
  @override
  get onPasteCapture => (props[_$key__onPasteCapture___$DomPropsMixin])
      as ClipboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onPasteCapture] -->
  @override
  set onPasteCapture(value) =>
      props[_$key__onPasteCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDownCapture] -->
  @override
  get onKeyDownCapture => (props[_$key__onKeyDownCapture___$DomPropsMixin])
      as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDownCapture] -->
  @override
  set onKeyDownCapture(value) =>
      props[_$key__onKeyDownCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPressCapture] -->
  @override
  get onKeyPressCapture => (props[_$key__onKeyPressCapture___$DomPropsMixin])
      as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPressCapture] -->
  @override
  set onKeyPressCapture(value) =>
      props[_$key__onKeyPressCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUpCapture] -->
  @override
  get onKeyUpCapture =>
      (props[_$key__onKeyUpCapture___$DomPropsMixin]) as KeyboardEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUpCapture] -->
  @override
  set onKeyUpCapture(value) =>
      props[_$key__onKeyUpCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onFocusCapture] -->
  @override
  get onFocusCapture =>
      (props[_$key__onFocusCapture___$DomPropsMixin]) as FocusEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onFocusCapture] -->
  @override
  set onFocusCapture(value) =>
      props[_$key__onFocusCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onBlurCapture] -->
  @override
  get onBlurCapture =>
      (props[_$key__onBlurCapture___$DomPropsMixin]) as FocusEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onBlurCapture] -->
  @override
  set onBlurCapture(value) =>
      props[_$key__onBlurCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onChangeCapture] -->
  @override
  get onChangeCapture =>
      (props[_$key__onChangeCapture___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onChangeCapture] -->
  @override
  set onChangeCapture(value) =>
      props[_$key__onChangeCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onInputCapture] -->
  @override
  get onInputCapture =>
      (props[_$key__onInputCapture___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onInputCapture] -->
  @override
  set onInputCapture(value) =>
      props[_$key__onInputCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onSubmitCapture] -->
  @override
  get onSubmitCapture =>
      (props[_$key__onSubmitCapture___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onSubmitCapture] -->
  @override
  set onSubmitCapture(value) =>
      props[_$key__onSubmitCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onResetCapture] -->
  @override
  get onResetCapture =>
      (props[_$key__onResetCapture___$DomPropsMixin]) as FormEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onResetCapture] -->
  @override
  set onResetCapture(value) =>
      props[_$key__onResetCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onClickCapture] -->
  @override
  get onClickCapture =>
      (props[_$key__onClickCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onClickCapture] -->
  @override
  set onClickCapture(value) =>
      props[_$key__onClickCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenuCapture] -->
  @override
  get onContextMenuCapture =>
      (props[_$key__onContextMenuCapture___$DomPropsMixin])
          as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenuCapture] -->
  @override
  set onContextMenuCapture(value) =>
      props[_$key__onContextMenuCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClickCapture] -->
  @override
  get onDoubleClickCapture =>
      (props[_$key__onDoubleClickCapture___$DomPropsMixin])
          as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClickCapture] -->
  @override
  set onDoubleClickCapture(value) =>
      props[_$key__onDoubleClickCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragCapture] -->
  @override
  get onDragCapture =>
      (props[_$key__onDragCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragCapture] -->
  @override
  set onDragCapture(value) =>
      props[_$key__onDragCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEndCapture] -->
  @override
  get onDragEndCapture =>
      (props[_$key__onDragEndCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragEndCapture] -->
  @override
  set onDragEndCapture(value) =>
      props[_$key__onDragEndCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnterCapture] -->
  @override
  get onDragEnterCapture => (props[_$key__onDragEnterCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnterCapture] -->
  @override
  set onDragEnterCapture(value) =>
      props[_$key__onDragEnterCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragExitCapture] -->
  @override
  get onDragExitCapture =>
      (props[_$key__onDragExitCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragExitCapture] -->
  @override
  set onDragExitCapture(value) =>
      props[_$key__onDragExitCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeaveCapture] -->
  @override
  get onDragLeaveCapture => (props[_$key__onDragLeaveCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeaveCapture] -->
  @override
  set onDragLeaveCapture(value) =>
      props[_$key__onDragLeaveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragOverCapture] -->
  @override
  get onDragOverCapture =>
      (props[_$key__onDragOverCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragOverCapture] -->
  @override
  set onDragOverCapture(value) =>
      props[_$key__onDragOverCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragStartCapture] -->
  @override
  get onDragStartCapture => (props[_$key__onDragStartCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDragStartCapture] -->
  @override
  set onDragStartCapture(value) =>
      props[_$key__onDragStartCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDropCapture] -->
  @override
  get onDropCapture =>
      (props[_$key__onDropCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onDropCapture] -->
  @override
  set onDropCapture(value) =>
      props[_$key__onDropCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDownCapture] -->
  @override
  get onMouseDownCapture => (props[_$key__onMouseDownCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDownCapture] -->
  @override
  set onMouseDownCapture(value) =>
      props[_$key__onMouseDownCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnterCapture] -->
  @override
  get onMouseEnterCapture =>
      (props[_$key__onMouseEnterCapture___$DomPropsMixin])
          as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnterCapture] -->
  @override
  set onMouseEnterCapture(value) =>
      props[_$key__onMouseEnterCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeaveCapture] -->
  @override
  get onMouseLeaveCapture =>
      (props[_$key__onMouseLeaveCapture___$DomPropsMixin])
          as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeaveCapture] -->
  @override
  set onMouseLeaveCapture(value) =>
      props[_$key__onMouseLeaveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMoveCapture] -->
  @override
  get onMouseMoveCapture => (props[_$key__onMouseMoveCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMoveCapture] -->
  @override
  set onMouseMoveCapture(value) =>
      props[_$key__onMouseMoveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOutCapture] -->
  @override
  get onMouseOutCapture =>
      (props[_$key__onMouseOutCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOutCapture] -->
  @override
  set onMouseOutCapture(value) =>
      props[_$key__onMouseOutCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOverCapture] -->
  @override
  get onMouseOverCapture => (props[_$key__onMouseOverCapture___$DomPropsMixin])
      as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOverCapture] -->
  @override
  set onMouseOverCapture(value) =>
      props[_$key__onMouseOverCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUpCapture] -->
  @override
  get onMouseUpCapture =>
      (props[_$key__onMouseUpCapture___$DomPropsMixin]) as MouseEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUpCapture] -->
  @override
  set onMouseUpCapture(value) =>
      props[_$key__onMouseUpCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onGotPointerCapture] -->
  @override
  get onGotPointerCapture =>
      (props[_$key__onGotPointerCapture___$DomPropsMixin])
          as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onGotPointerCapture] -->
  @override
  set onGotPointerCapture(value) =>
      props[_$key__onGotPointerCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onLostPointerCapture] -->
  @override
  get onLostPointerCapture =>
      (props[_$key__onLostPointerCapture___$DomPropsMixin])
          as PointerEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onLostPointerCapture] -->
  @override
  set onLostPointerCapture(value) =>
      props[_$key__onLostPointerCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancelCapture] -->
  @override
  get onTouchCancelCapture =>
      (props[_$key__onTouchCancelCapture___$DomPropsMixin])
          as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancelCapture] -->
  @override
  set onTouchCancelCapture(value) =>
      props[_$key__onTouchCancelCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEndCapture] -->
  @override
  get onTouchEndCapture =>
      (props[_$key__onTouchEndCapture___$DomPropsMixin]) as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEndCapture] -->
  @override
  set onTouchEndCapture(value) =>
      props[_$key__onTouchEndCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMoveCapture] -->
  @override
  get onTouchMoveCapture => (props[_$key__onTouchMoveCapture___$DomPropsMixin])
      as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMoveCapture] -->
  @override
  set onTouchMoveCapture(value) =>
      props[_$key__onTouchMoveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStartCapture] -->
  @override
  get onTouchStartCapture =>
      (props[_$key__onTouchStartCapture___$DomPropsMixin])
          as TouchEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStartCapture] -->
  @override
  set onTouchStartCapture(value) =>
      props[_$key__onTouchStartCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onScrollCapture] -->
  @override
  get onScrollCapture =>
      (props[_$key__onScrollCapture___$DomPropsMixin]) as UIEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onScrollCapture] -->
  @override
  set onScrollCapture(value) =>
      props[_$key__onScrollCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onWheelCapture] -->
  @override
  get onWheelCapture =>
      (props[_$key__onWheelCapture___$DomPropsMixin]) as WheelEventCallback?;

  /// <!-- Generated from [_$DomPropsMixin.onWheelCapture] -->
  @override
  set onWheelCapture(value) =>
      props[_$key__onWheelCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defaultChecked] -->
  @override
  get defaultChecked =>
      (props[_$key__defaultChecked___$DomPropsMixin]) as bool?;

  /// <!-- Generated from [_$DomPropsMixin.defaultChecked] -->
  @override
  set defaultChecked(value) =>
      props[_$key__defaultChecked___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defaultValue] -->
  @override
  get defaultValue => (props[_$key__defaultValue___$DomPropsMixin]) as dynamic;

  /// <!-- Generated from [_$DomPropsMixin.defaultValue] -->
  @override
  set defaultValue(value) =>
      props[_$key__defaultValue___$DomPropsMixin] = value;

  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  ///
  /// <!-- Generated from [_$DomPropsMixin.autoFocus] -->
  @override
  get autoFocus => (props[_$key__autoFocus___$DomPropsMixin]) as bool?;

  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  ///
  /// <!-- Generated from [_$DomPropsMixin.autoFocus] -->
  @override
  set autoFocus(value) => props[_$key__autoFocus___$DomPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__cols___$DomPropsMixin =
      PropDescriptor(_$key__cols___$DomPropsMixin);
  static const PropDescriptor _$prop__minLength___$DomPropsMixin =
      PropDescriptor(_$key__minLength___$DomPropsMixin);
  static const PropDescriptor _$prop__rows___$DomPropsMixin =
      PropDescriptor(_$key__rows___$DomPropsMixin);
  static const PropDescriptor _$prop__size___$DomPropsMixin =
      PropDescriptor(_$key__size___$DomPropsMixin);
  static const PropDescriptor _$prop__span___$DomPropsMixin =
      PropDescriptor(_$key__span___$DomPropsMixin);
  static const PropDescriptor _$prop__start___$DomPropsMixin =
      PropDescriptor(_$key__start___$DomPropsMixin);
  static const PropDescriptor _$prop__high___$DomPropsMixin =
      PropDescriptor(_$key__high___$DomPropsMixin);
  static const PropDescriptor _$prop__low___$DomPropsMixin =
      PropDescriptor(_$key__low___$DomPropsMixin);
  static const PropDescriptor _$prop__marginHeight___$DomPropsMixin =
      PropDescriptor(_$key__marginHeight___$DomPropsMixin);
  static const PropDescriptor _$prop__marginWidth___$DomPropsMixin =
      PropDescriptor(_$key__marginWidth___$DomPropsMixin);
  static const PropDescriptor _$prop__optimum___$DomPropsMixin =
      PropDescriptor(_$key__optimum___$DomPropsMixin);
  static const PropDescriptor _$prop__htmlDefault___$DomPropsMixin =
      PropDescriptor(_$key__htmlDefault___$DomPropsMixin);
  static const PropDescriptor _$prop__htmlIs___$DomPropsMixin =
      PropDescriptor(_$key__htmlIs___$DomPropsMixin);
  static const PropDescriptor _$prop__allowFullScreen___$DomPropsMixin =
      PropDescriptor(_$key__allowFullScreen___$DomPropsMixin);
  static const PropDescriptor _$prop__async___$DomPropsMixin =
      PropDescriptor(_$key__async___$DomPropsMixin);
  static const PropDescriptor _$prop__autoPlay___$DomPropsMixin =
      PropDescriptor(_$key__autoPlay___$DomPropsMixin);
  static const PropDescriptor _$prop__checked___$DomPropsMixin =
      PropDescriptor(_$key__checked___$DomPropsMixin);
  static const PropDescriptor _$prop__controls___$DomPropsMixin =
      PropDescriptor(_$key__controls___$DomPropsMixin);
  static const PropDescriptor _$prop__defer___$DomPropsMixin =
      PropDescriptor(_$key__defer___$DomPropsMixin);
  static const PropDescriptor _$prop__disabled___$DomPropsMixin =
      PropDescriptor(_$key__disabled___$DomPropsMixin);
  static const PropDescriptor _$prop__formNoValidate___$DomPropsMixin =
      PropDescriptor(_$key__formNoValidate___$DomPropsMixin);
  static const PropDescriptor _$prop__hidden___$DomPropsMixin =
      PropDescriptor(_$key__hidden___$DomPropsMixin);
  static const PropDescriptor _$prop__loop___$DomPropsMixin =
      PropDescriptor(_$key__loop___$DomPropsMixin);
  static const PropDescriptor _$prop__multiple___$DomPropsMixin =
      PropDescriptor(_$key__multiple___$DomPropsMixin);
  static const PropDescriptor _$prop__muted___$DomPropsMixin =
      PropDescriptor(_$key__muted___$DomPropsMixin);
  static const PropDescriptor _$prop__noValidate___$DomPropsMixin =
      PropDescriptor(_$key__noValidate___$DomPropsMixin);
  static const PropDescriptor _$prop__open___$DomPropsMixin =
      PropDescriptor(_$key__open___$DomPropsMixin);
  static const PropDescriptor _$prop__readOnly___$DomPropsMixin =
      PropDescriptor(_$key__readOnly___$DomPropsMixin);
  static const PropDescriptor _$prop__required___$DomPropsMixin =
      PropDescriptor(_$key__required___$DomPropsMixin);
  static const PropDescriptor _$prop__reversed___$DomPropsMixin =
      PropDescriptor(_$key__reversed___$DomPropsMixin);
  static const PropDescriptor _$prop__scoped___$DomPropsMixin =
      PropDescriptor(_$key__scoped___$DomPropsMixin);
  static const PropDescriptor _$prop__seamless___$DomPropsMixin =
      PropDescriptor(_$key__seamless___$DomPropsMixin);
  static const PropDescriptor _$prop__selected___$DomPropsMixin =
      PropDescriptor(_$key__selected___$DomPropsMixin);
  static const PropDescriptor _$prop___raw$DomProps$style___$DomPropsMixin =
      PropDescriptor(_$key___raw$DomProps$style___$DomPropsMixin);
  static const PropDescriptor _$prop__challenge___$DomPropsMixin =
      PropDescriptor(_$key__challenge___$DomPropsMixin);
  static const PropDescriptor _$prop__cite___$DomPropsMixin =
      PropDescriptor(_$key__cite___$DomPropsMixin);
  static const PropDescriptor _$prop__className___$DomPropsMixin =
      PropDescriptor(_$key__className___$DomPropsMixin);
  static const PropDescriptor _$prop__controlsList___$DomPropsMixin =
      PropDescriptor(_$key__controlsList___$DomPropsMixin);
  static const PropDescriptor _$prop__formAction___$DomPropsMixin =
      PropDescriptor(_$key__formAction___$DomPropsMixin);
  static const PropDescriptor _$prop__formEncType___$DomPropsMixin =
      PropDescriptor(_$key__formEncType___$DomPropsMixin);
  static const PropDescriptor _$prop__formMethod___$DomPropsMixin =
      PropDescriptor(_$key__formMethod___$DomPropsMixin);
  static const PropDescriptor _$prop__formTarget___$DomPropsMixin =
      PropDescriptor(_$key__formTarget___$DomPropsMixin);
  static const PropDescriptor _$prop__headers___$DomPropsMixin =
      PropDescriptor(_$key__headers___$DomPropsMixin);
  static const PropDescriptor _$prop__id___$DomPropsMixin =
      PropDescriptor(_$key__id___$DomPropsMixin);
  static const PropDescriptor _$prop__inputMode___$DomPropsMixin =
      PropDescriptor(_$key__inputMode___$DomPropsMixin);
  static const PropDescriptor _$prop__integrity___$DomPropsMixin =
      PropDescriptor(_$key__integrity___$DomPropsMixin);
  static const PropDescriptor _$prop__keyParams___$DomPropsMixin =
      PropDescriptor(_$key__keyParams___$DomPropsMixin);
  static const PropDescriptor _$prop__keyType___$DomPropsMixin =
      PropDescriptor(_$key__keyType___$DomPropsMixin);
  static const PropDescriptor _$prop__kind___$DomPropsMixin =
      PropDescriptor(_$key__kind___$DomPropsMixin);
  static const PropDescriptor _$prop__nonce___$DomPropsMixin =
      PropDescriptor(_$key__nonce___$DomPropsMixin);
  static const PropDescriptor _$prop__srcLang___$DomPropsMixin =
      PropDescriptor(_$key__srcLang___$DomPropsMixin);
  static const PropDescriptor _$prop__summary___$DomPropsMixin =
      PropDescriptor(_$key__summary___$DomPropsMixin);
  static const PropDescriptor _$prop__title___$DomPropsMixin =
      PropDescriptor(_$key__title___$DomPropsMixin);
  static const PropDescriptor _$prop__wrap___$DomPropsMixin =
      PropDescriptor(_$key__wrap___$DomPropsMixin);
  static const PropDescriptor _$prop__accept___$DomPropsMixin =
      PropDescriptor(_$key__accept___$DomPropsMixin);
  static const PropDescriptor _$prop__acceptCharset___$DomPropsMixin =
      PropDescriptor(_$key__acceptCharset___$DomPropsMixin);
  static const PropDescriptor _$prop__accessKey___$DomPropsMixin =
      PropDescriptor(_$key__accessKey___$DomPropsMixin);
  static const PropDescriptor _$prop__action___$DomPropsMixin =
      PropDescriptor(_$key__action___$DomPropsMixin);
  static const PropDescriptor _$prop__allowTransparency___$DomPropsMixin =
      PropDescriptor(_$key__allowTransparency___$DomPropsMixin);
  static const PropDescriptor _$prop__alt___$DomPropsMixin =
      PropDescriptor(_$key__alt___$DomPropsMixin);
  static const PropDescriptor _$prop__autoComplete___$DomPropsMixin =
      PropDescriptor(_$key__autoComplete___$DomPropsMixin);
  static const PropDescriptor _$prop__capture___$DomPropsMixin =
      PropDescriptor(_$key__capture___$DomPropsMixin);
  static const PropDescriptor _$prop__cellPadding___$DomPropsMixin =
      PropDescriptor(_$key__cellPadding___$DomPropsMixin);
  static const PropDescriptor _$prop__cellSpacing___$DomPropsMixin =
      PropDescriptor(_$key__cellSpacing___$DomPropsMixin);
  static const PropDescriptor _$prop__charSet___$DomPropsMixin =
      PropDescriptor(_$key__charSet___$DomPropsMixin);
  static const PropDescriptor _$prop__classID___$DomPropsMixin =
      PropDescriptor(_$key__classID___$DomPropsMixin);
  static const PropDescriptor _$prop__colSpan___$DomPropsMixin =
      PropDescriptor(_$key__colSpan___$DomPropsMixin);
  static const PropDescriptor _$prop__content___$DomPropsMixin =
      PropDescriptor(_$key__content___$DomPropsMixin);
  static const PropDescriptor _$prop__contentEditable___$DomPropsMixin =
      PropDescriptor(_$key__contentEditable___$DomPropsMixin);
  static const PropDescriptor _$prop__contextMenu___$DomPropsMixin =
      PropDescriptor(_$key__contextMenu___$DomPropsMixin);
  static const PropDescriptor _$prop__coords___$DomPropsMixin =
      PropDescriptor(_$key__coords___$DomPropsMixin);
  static const PropDescriptor _$prop__crossOrigin___$DomPropsMixin =
      PropDescriptor(_$key__crossOrigin___$DomPropsMixin);
  static const PropDescriptor _$prop__data___$DomPropsMixin =
      PropDescriptor(_$key__data___$DomPropsMixin);
  static const PropDescriptor _$prop__dateTime___$DomPropsMixin =
      PropDescriptor(_$key__dateTime___$DomPropsMixin);
  static const PropDescriptor _$prop__dir___$DomPropsMixin =
      PropDescriptor(_$key__dir___$DomPropsMixin);
  static const PropDescriptor _$prop__download___$DomPropsMixin =
      PropDescriptor(_$key__download___$DomPropsMixin);
  static const PropDescriptor _$prop__draggable___$DomPropsMixin =
      PropDescriptor(_$key__draggable___$DomPropsMixin);
  static const PropDescriptor _$prop__encType___$DomPropsMixin =
      PropDescriptor(_$key__encType___$DomPropsMixin);
  static const PropDescriptor _$prop__form___$DomPropsMixin =
      PropDescriptor(_$key__form___$DomPropsMixin);
  static const PropDescriptor _$prop__frameBorder___$DomPropsMixin =
      PropDescriptor(_$key__frameBorder___$DomPropsMixin);
  static const PropDescriptor _$prop__height___$DomPropsMixin =
      PropDescriptor(_$key__height___$DomPropsMixin);
  static const PropDescriptor _$prop__href___$DomPropsMixin =
      PropDescriptor(_$key__href___$DomPropsMixin);
  static const PropDescriptor _$prop__hrefLang___$DomPropsMixin =
      PropDescriptor(_$key__hrefLang___$DomPropsMixin);
  static const PropDescriptor _$prop__htmlFor___$DomPropsMixin =
      PropDescriptor(_$key__htmlFor___$DomPropsMixin);
  static const PropDescriptor _$prop__httpEquiv___$DomPropsMixin =
      PropDescriptor(_$key__httpEquiv___$DomPropsMixin);
  static const PropDescriptor _$prop__icon___$DomPropsMixin =
      PropDescriptor(_$key__icon___$DomPropsMixin);
  static const PropDescriptor _$prop__label___$DomPropsMixin =
      PropDescriptor(_$key__label___$DomPropsMixin);
  static const PropDescriptor _$prop__lang___$DomPropsMixin =
      PropDescriptor(_$key__lang___$DomPropsMixin);
  static const PropDescriptor _$prop__list___$DomPropsMixin =
      PropDescriptor(_$key__list___$DomPropsMixin);
  static const PropDescriptor _$prop__manifest___$DomPropsMixin =
      PropDescriptor(_$key__manifest___$DomPropsMixin);
  static const PropDescriptor _$prop__max___$DomPropsMixin =
      PropDescriptor(_$key__max___$DomPropsMixin);
  static const PropDescriptor _$prop__maxLength___$DomPropsMixin =
      PropDescriptor(_$key__maxLength___$DomPropsMixin);
  static const PropDescriptor _$prop__media___$DomPropsMixin =
      PropDescriptor(_$key__media___$DomPropsMixin);
  static const PropDescriptor _$prop__mediaGroup___$DomPropsMixin =
      PropDescriptor(_$key__mediaGroup___$DomPropsMixin);
  static const PropDescriptor _$prop__method___$DomPropsMixin =
      PropDescriptor(_$key__method___$DomPropsMixin);
  static const PropDescriptor _$prop__min___$DomPropsMixin =
      PropDescriptor(_$key__min___$DomPropsMixin);
  static const PropDescriptor _$prop__name___$DomPropsMixin =
      PropDescriptor(_$key__name___$DomPropsMixin);
  static const PropDescriptor _$prop__pattern___$DomPropsMixin =
      PropDescriptor(_$key__pattern___$DomPropsMixin);
  static const PropDescriptor _$prop__placeholder___$DomPropsMixin =
      PropDescriptor(_$key__placeholder___$DomPropsMixin);
  static const PropDescriptor _$prop__poster___$DomPropsMixin =
      PropDescriptor(_$key__poster___$DomPropsMixin);
  static const PropDescriptor _$prop__preload___$DomPropsMixin =
      PropDescriptor(_$key__preload___$DomPropsMixin);
  static const PropDescriptor _$prop__radioGroup___$DomPropsMixin =
      PropDescriptor(_$key__radioGroup___$DomPropsMixin);
  static const PropDescriptor _$prop__rel___$DomPropsMixin =
      PropDescriptor(_$key__rel___$DomPropsMixin);
  static const PropDescriptor _$prop__role___$DomPropsMixin =
      PropDescriptor(_$key__role___$DomPropsMixin);
  static const PropDescriptor _$prop__rowSpan___$DomPropsMixin =
      PropDescriptor(_$key__rowSpan___$DomPropsMixin);
  static const PropDescriptor _$prop__sandbox___$DomPropsMixin =
      PropDescriptor(_$key__sandbox___$DomPropsMixin);
  static const PropDescriptor _$prop__scope___$DomPropsMixin =
      PropDescriptor(_$key__scope___$DomPropsMixin);
  static const PropDescriptor _$prop__scrolling___$DomPropsMixin =
      PropDescriptor(_$key__scrolling___$DomPropsMixin);
  static const PropDescriptor _$prop__shape___$DomPropsMixin =
      PropDescriptor(_$key__shape___$DomPropsMixin);
  static const PropDescriptor _$prop__sizes___$DomPropsMixin =
      PropDescriptor(_$key__sizes___$DomPropsMixin);
  static const PropDescriptor _$prop__spellCheck___$DomPropsMixin =
      PropDescriptor(_$key__spellCheck___$DomPropsMixin);
  static const PropDescriptor _$prop__src___$DomPropsMixin =
      PropDescriptor(_$key__src___$DomPropsMixin);
  static const PropDescriptor _$prop__srcDoc___$DomPropsMixin =
      PropDescriptor(_$key__srcDoc___$DomPropsMixin);
  static const PropDescriptor _$prop__srcSet___$DomPropsMixin =
      PropDescriptor(_$key__srcSet___$DomPropsMixin);
  static const PropDescriptor _$prop__step___$DomPropsMixin =
      PropDescriptor(_$key__step___$DomPropsMixin);
  static const PropDescriptor _$prop__tabIndex___$DomPropsMixin =
      PropDescriptor(_$key__tabIndex___$DomPropsMixin);
  static const PropDescriptor _$prop__target___$DomPropsMixin =
      PropDescriptor(_$key__target___$DomPropsMixin);
  static const PropDescriptor _$prop__type___$DomPropsMixin =
      PropDescriptor(_$key__type___$DomPropsMixin);
  static const PropDescriptor _$prop__useMap___$DomPropsMixin =
      PropDescriptor(_$key__useMap___$DomPropsMixin);
  static const PropDescriptor _$prop__value___$DomPropsMixin =
      PropDescriptor(_$key__value___$DomPropsMixin);
  static const PropDescriptor _$prop__width___$DomPropsMixin =
      PropDescriptor(_$key__width___$DomPropsMixin);
  static const PropDescriptor _$prop__wmode___$DomPropsMixin =
      PropDescriptor(_$key__wmode___$DomPropsMixin);
  static const PropDescriptor _$prop__onAnimationEnd___$DomPropsMixin =
      PropDescriptor(_$key__onAnimationEnd___$DomPropsMixin);
  static const PropDescriptor _$prop__onAnimationIteration___$DomPropsMixin =
      PropDescriptor(_$key__onAnimationIteration___$DomPropsMixin);
  static const PropDescriptor _$prop__onAnimationStart___$DomPropsMixin =
      PropDescriptor(_$key__onAnimationStart___$DomPropsMixin);
  static const PropDescriptor _$prop__onCopy___$DomPropsMixin =
      PropDescriptor(_$key__onCopy___$DomPropsMixin);
  static const PropDescriptor _$prop__onCut___$DomPropsMixin =
      PropDescriptor(_$key__onCut___$DomPropsMixin);
  static const PropDescriptor _$prop__onPaste___$DomPropsMixin =
      PropDescriptor(_$key__onPaste___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyDown___$DomPropsMixin =
      PropDescriptor(_$key__onKeyDown___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyPress___$DomPropsMixin =
      PropDescriptor(_$key__onKeyPress___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyUp___$DomPropsMixin =
      PropDescriptor(_$key__onKeyUp___$DomPropsMixin);
  static const PropDescriptor _$prop__onFocus___$DomPropsMixin =
      PropDescriptor(_$key__onFocus___$DomPropsMixin);
  static const PropDescriptor _$prop__onBlur___$DomPropsMixin =
      PropDescriptor(_$key__onBlur___$DomPropsMixin);
  static const PropDescriptor _$prop__onChange___$DomPropsMixin =
      PropDescriptor(_$key__onChange___$DomPropsMixin);
  static const PropDescriptor _$prop__onInput___$DomPropsMixin =
      PropDescriptor(_$key__onInput___$DomPropsMixin);
  static const PropDescriptor _$prop__onSubmit___$DomPropsMixin =
      PropDescriptor(_$key__onSubmit___$DomPropsMixin);
  static const PropDescriptor _$prop__onReset___$DomPropsMixin =
      PropDescriptor(_$key__onReset___$DomPropsMixin);
  static const PropDescriptor _$prop__onClick___$DomPropsMixin =
      PropDescriptor(_$key__onClick___$DomPropsMixin);
  static const PropDescriptor _$prop__onContextMenu___$DomPropsMixin =
      PropDescriptor(_$key__onContextMenu___$DomPropsMixin);
  static const PropDescriptor _$prop__onDoubleClick___$DomPropsMixin =
      PropDescriptor(_$key__onDoubleClick___$DomPropsMixin);
  static const PropDescriptor _$prop__onDrag___$DomPropsMixin =
      PropDescriptor(_$key__onDrag___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragEnd___$DomPropsMixin =
      PropDescriptor(_$key__onDragEnd___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragEnter___$DomPropsMixin =
      PropDescriptor(_$key__onDragEnter___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragExit___$DomPropsMixin =
      PropDescriptor(_$key__onDragExit___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragLeave___$DomPropsMixin =
      PropDescriptor(_$key__onDragLeave___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragOver___$DomPropsMixin =
      PropDescriptor(_$key__onDragOver___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragStart___$DomPropsMixin =
      PropDescriptor(_$key__onDragStart___$DomPropsMixin);
  static const PropDescriptor _$prop__onDrop___$DomPropsMixin =
      PropDescriptor(_$key__onDrop___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseDown___$DomPropsMixin =
      PropDescriptor(_$key__onMouseDown___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseEnter___$DomPropsMixin =
      PropDescriptor(_$key__onMouseEnter___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseLeave___$DomPropsMixin =
      PropDescriptor(_$key__onMouseLeave___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseMove___$DomPropsMixin =
      PropDescriptor(_$key__onMouseMove___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseOut___$DomPropsMixin =
      PropDescriptor(_$key__onMouseOut___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseOver___$DomPropsMixin =
      PropDescriptor(_$key__onMouseOver___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseUp___$DomPropsMixin =
      PropDescriptor(_$key__onMouseUp___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerCancel___$DomPropsMixin =
      PropDescriptor(_$key__onPointerCancel___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerDown___$DomPropsMixin =
      PropDescriptor(_$key__onPointerDown___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerEnter___$DomPropsMixin =
      PropDescriptor(_$key__onPointerEnter___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerLeave___$DomPropsMixin =
      PropDescriptor(_$key__onPointerLeave___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerMove___$DomPropsMixin =
      PropDescriptor(_$key__onPointerMove___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerOver___$DomPropsMixin =
      PropDescriptor(_$key__onPointerOver___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerOut___$DomPropsMixin =
      PropDescriptor(_$key__onPointerOut___$DomPropsMixin);
  static const PropDescriptor _$prop__onPointerUp___$DomPropsMixin =
      PropDescriptor(_$key__onPointerUp___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchCancel___$DomPropsMixin =
      PropDescriptor(_$key__onTouchCancel___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchEnd___$DomPropsMixin =
      PropDescriptor(_$key__onTouchEnd___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchMove___$DomPropsMixin =
      PropDescriptor(_$key__onTouchMove___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchStart___$DomPropsMixin =
      PropDescriptor(_$key__onTouchStart___$DomPropsMixin);
  static const PropDescriptor _$prop__onTransitionEnd___$DomPropsMixin =
      PropDescriptor(_$key__onTransitionEnd___$DomPropsMixin);
  static const PropDescriptor _$prop__onScroll___$DomPropsMixin =
      PropDescriptor(_$key__onScroll___$DomPropsMixin);
  static const PropDescriptor _$prop__onWheel___$DomPropsMixin =
      PropDescriptor(_$key__onWheel___$DomPropsMixin);
  static const PropDescriptor _$prop__onCopyCapture___$DomPropsMixin =
      PropDescriptor(_$key__onCopyCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onCutCapture___$DomPropsMixin =
      PropDescriptor(_$key__onCutCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onPasteCapture___$DomPropsMixin =
      PropDescriptor(_$key__onPasteCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyDownCapture___$DomPropsMixin =
      PropDescriptor(_$key__onKeyDownCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyPressCapture___$DomPropsMixin =
      PropDescriptor(_$key__onKeyPressCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onKeyUpCapture___$DomPropsMixin =
      PropDescriptor(_$key__onKeyUpCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onFocusCapture___$DomPropsMixin =
      PropDescriptor(_$key__onFocusCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onBlurCapture___$DomPropsMixin =
      PropDescriptor(_$key__onBlurCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onChangeCapture___$DomPropsMixin =
      PropDescriptor(_$key__onChangeCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onInputCapture___$DomPropsMixin =
      PropDescriptor(_$key__onInputCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onSubmitCapture___$DomPropsMixin =
      PropDescriptor(_$key__onSubmitCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onResetCapture___$DomPropsMixin =
      PropDescriptor(_$key__onResetCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onClickCapture___$DomPropsMixin =
      PropDescriptor(_$key__onClickCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onContextMenuCapture___$DomPropsMixin =
      PropDescriptor(_$key__onContextMenuCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDoubleClickCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDoubleClickCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragEndCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragEndCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragEnterCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragEnterCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragExitCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragExitCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragLeaveCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragLeaveCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragOverCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragOverCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDragStartCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDragStartCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onDropCapture___$DomPropsMixin =
      PropDescriptor(_$key__onDropCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseDownCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseDownCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseEnterCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseEnterCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseLeaveCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseLeaveCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseMoveCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseMoveCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseOutCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseOutCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseOverCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseOverCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onMouseUpCapture___$DomPropsMixin =
      PropDescriptor(_$key__onMouseUpCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onGotPointerCapture___$DomPropsMixin =
      PropDescriptor(_$key__onGotPointerCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onLostPointerCapture___$DomPropsMixin =
      PropDescriptor(_$key__onLostPointerCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchCancelCapture___$DomPropsMixin =
      PropDescriptor(_$key__onTouchCancelCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchEndCapture___$DomPropsMixin =
      PropDescriptor(_$key__onTouchEndCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchMoveCapture___$DomPropsMixin =
      PropDescriptor(_$key__onTouchMoveCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onTouchStartCapture___$DomPropsMixin =
      PropDescriptor(_$key__onTouchStartCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onScrollCapture___$DomPropsMixin =
      PropDescriptor(_$key__onScrollCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__onWheelCapture___$DomPropsMixin =
      PropDescriptor(_$key__onWheelCapture___$DomPropsMixin);
  static const PropDescriptor _$prop__defaultChecked___$DomPropsMixin =
      PropDescriptor(_$key__defaultChecked___$DomPropsMixin);
  static const PropDescriptor _$prop__defaultValue___$DomPropsMixin =
      PropDescriptor(_$key__defaultValue___$DomPropsMixin);
  static const PropDescriptor _$prop__autoFocus___$DomPropsMixin =
      PropDescriptor(_$key__autoFocus___$DomPropsMixin);
  static const String _$key__cols___$DomPropsMixin = 'cols';
  static const String _$key__minLength___$DomPropsMixin = 'minLength';
  static const String _$key__rows___$DomPropsMixin = 'rows';
  static const String _$key__size___$DomPropsMixin = 'size';
  static const String _$key__span___$DomPropsMixin = 'span';
  static const String _$key__start___$DomPropsMixin = 'start';
  static const String _$key__high___$DomPropsMixin = 'high';
  static const String _$key__low___$DomPropsMixin = 'low';
  static const String _$key__marginHeight___$DomPropsMixin = 'marginHeight';
  static const String _$key__marginWidth___$DomPropsMixin = 'marginWidth';
  static const String _$key__optimum___$DomPropsMixin = 'optimum';
  static const String _$key__htmlDefault___$DomPropsMixin = 'default';
  static const String _$key__htmlIs___$DomPropsMixin = 'is';
  static const String _$key__allowFullScreen___$DomPropsMixin =
      'allowFullScreen';
  static const String _$key__async___$DomPropsMixin = 'async';
  static const String _$key__autoPlay___$DomPropsMixin = 'autoPlay';
  static const String _$key__checked___$DomPropsMixin = 'checked';
  static const String _$key__controls___$DomPropsMixin = 'controls';
  static const String _$key__defer___$DomPropsMixin = 'defer';
  static const String _$key__disabled___$DomPropsMixin = 'disabled';
  static const String _$key__formNoValidate___$DomPropsMixin = 'formNoValidate';
  static const String _$key__hidden___$DomPropsMixin = 'hidden';
  static const String _$key__loop___$DomPropsMixin = 'loop';
  static const String _$key__multiple___$DomPropsMixin = 'multiple';
  static const String _$key__muted___$DomPropsMixin = 'muted';
  static const String _$key__noValidate___$DomPropsMixin = 'noValidate';
  static const String _$key__open___$DomPropsMixin = 'open';
  static const String _$key__readOnly___$DomPropsMixin = 'readOnly';
  static const String _$key__required___$DomPropsMixin = 'required';
  static const String _$key__reversed___$DomPropsMixin = 'reversed';
  static const String _$key__scoped___$DomPropsMixin = 'scoped';
  static const String _$key__seamless___$DomPropsMixin = 'seamless';
  static const String _$key__selected___$DomPropsMixin = 'selected';
  static const String _$key___raw$DomProps$style___$DomPropsMixin = 'style';
  static const String _$key__challenge___$DomPropsMixin = 'challenge';
  static const String _$key__cite___$DomPropsMixin = 'cite';
  static const String _$key__className___$DomPropsMixin = 'className';
  static const String _$key__controlsList___$DomPropsMixin = 'controlsList';
  static const String _$key__formAction___$DomPropsMixin = 'formAction';
  static const String _$key__formEncType___$DomPropsMixin = 'formEncType';
  static const String _$key__formMethod___$DomPropsMixin = 'formMethod';
  static const String _$key__formTarget___$DomPropsMixin = 'formTarget';
  static const String _$key__headers___$DomPropsMixin = 'headers';
  static const String _$key__id___$DomPropsMixin = 'id';
  static const String _$key__inputMode___$DomPropsMixin = 'inputMode';
  static const String _$key__integrity___$DomPropsMixin = 'integrity';
  static const String _$key__keyParams___$DomPropsMixin = 'keyParams';
  static const String _$key__keyType___$DomPropsMixin = 'keyType';
  static const String _$key__kind___$DomPropsMixin = 'kind';
  static const String _$key__nonce___$DomPropsMixin = 'nonce';
  static const String _$key__srcLang___$DomPropsMixin = 'srcLang';
  static const String _$key__summary___$DomPropsMixin = 'summary';
  static const String _$key__title___$DomPropsMixin = 'title';
  static const String _$key__wrap___$DomPropsMixin = 'wrap';
  static const String _$key__accept___$DomPropsMixin = 'accept';
  static const String _$key__acceptCharset___$DomPropsMixin = 'acceptCharset';
  static const String _$key__accessKey___$DomPropsMixin = 'accessKey';
  static const String _$key__action___$DomPropsMixin = 'action';
  static const String _$key__allowTransparency___$DomPropsMixin =
      'allowTransparency';
  static const String _$key__alt___$DomPropsMixin = 'alt';
  static const String _$key__autoComplete___$DomPropsMixin = 'autoComplete';
  static const String _$key__capture___$DomPropsMixin = 'capture';
  static const String _$key__cellPadding___$DomPropsMixin = 'cellPadding';
  static const String _$key__cellSpacing___$DomPropsMixin = 'cellSpacing';
  static const String _$key__charSet___$DomPropsMixin = 'charSet';
  static const String _$key__classID___$DomPropsMixin = 'classID';
  static const String _$key__colSpan___$DomPropsMixin = 'colSpan';
  static const String _$key__content___$DomPropsMixin = 'content';
  static const String _$key__contentEditable___$DomPropsMixin =
      'contentEditable';
  static const String _$key__contextMenu___$DomPropsMixin = 'contextMenu';
  static const String _$key__coords___$DomPropsMixin = 'coords';
  static const String _$key__crossOrigin___$DomPropsMixin = 'crossOrigin';
  static const String _$key__data___$DomPropsMixin = 'data';
  static const String _$key__dateTime___$DomPropsMixin = 'dateTime';
  static const String _$key__dir___$DomPropsMixin = 'dir';
  static const String _$key__download___$DomPropsMixin = 'download';
  static const String _$key__draggable___$DomPropsMixin = 'draggable';
  static const String _$key__encType___$DomPropsMixin = 'encType';
  static const String _$key__form___$DomPropsMixin = 'form';
  static const String _$key__frameBorder___$DomPropsMixin = 'frameBorder';
  static const String _$key__height___$DomPropsMixin = 'height';
  static const String _$key__href___$DomPropsMixin = 'href';
  static const String _$key__hrefLang___$DomPropsMixin = 'hrefLang';
  static const String _$key__htmlFor___$DomPropsMixin = 'htmlFor';
  static const String _$key__httpEquiv___$DomPropsMixin = 'httpEquiv';
  static const String _$key__icon___$DomPropsMixin = 'icon';
  static const String _$key__label___$DomPropsMixin = 'label';
  static const String _$key__lang___$DomPropsMixin = 'lang';
  static const String _$key__list___$DomPropsMixin = 'list';
  static const String _$key__manifest___$DomPropsMixin = 'manifest';
  static const String _$key__max___$DomPropsMixin = 'max';
  static const String _$key__maxLength___$DomPropsMixin = 'maxLength';
  static const String _$key__media___$DomPropsMixin = 'media';
  static const String _$key__mediaGroup___$DomPropsMixin = 'mediaGroup';
  static const String _$key__method___$DomPropsMixin = 'method';
  static const String _$key__min___$DomPropsMixin = 'min';
  static const String _$key__name___$DomPropsMixin = 'name';
  static const String _$key__pattern___$DomPropsMixin = 'pattern';
  static const String _$key__placeholder___$DomPropsMixin = 'placeholder';
  static const String _$key__poster___$DomPropsMixin = 'poster';
  static const String _$key__preload___$DomPropsMixin = 'preload';
  static const String _$key__radioGroup___$DomPropsMixin = 'radioGroup';
  static const String _$key__rel___$DomPropsMixin = 'rel';
  static const String _$key__role___$DomPropsMixin = 'role';
  static const String _$key__rowSpan___$DomPropsMixin = 'rowSpan';
  static const String _$key__sandbox___$DomPropsMixin = 'sandbox';
  static const String _$key__scope___$DomPropsMixin = 'scope';
  static const String _$key__scrolling___$DomPropsMixin = 'scrolling';
  static const String _$key__shape___$DomPropsMixin = 'shape';
  static const String _$key__sizes___$DomPropsMixin = 'sizes';
  static const String _$key__spellCheck___$DomPropsMixin = 'spellCheck';
  static const String _$key__src___$DomPropsMixin = 'src';
  static const String _$key__srcDoc___$DomPropsMixin = 'srcDoc';
  static const String _$key__srcSet___$DomPropsMixin = 'srcSet';
  static const String _$key__step___$DomPropsMixin = 'step';
  static const String _$key__tabIndex___$DomPropsMixin = 'tabIndex';
  static const String _$key__target___$DomPropsMixin = 'target';
  static const String _$key__type___$DomPropsMixin = 'type';
  static const String _$key__useMap___$DomPropsMixin = 'useMap';
  static const String _$key__value___$DomPropsMixin = 'value';
  static const String _$key__width___$DomPropsMixin = 'width';
  static const String _$key__wmode___$DomPropsMixin = 'wmode';
  static const String _$key__onAnimationEnd___$DomPropsMixin = 'onAnimationEnd';
  static const String _$key__onAnimationIteration___$DomPropsMixin =
      'onAnimationIteration';
  static const String _$key__onAnimationStart___$DomPropsMixin =
      'onAnimationStart';
  static const String _$key__onCopy___$DomPropsMixin = 'onCopy';
  static const String _$key__onCut___$DomPropsMixin = 'onCut';
  static const String _$key__onPaste___$DomPropsMixin = 'onPaste';
  static const String _$key__onKeyDown___$DomPropsMixin = 'onKeyDown';
  static const String _$key__onKeyPress___$DomPropsMixin = 'onKeyPress';
  static const String _$key__onKeyUp___$DomPropsMixin = 'onKeyUp';
  static const String _$key__onFocus___$DomPropsMixin = 'onFocus';
  static const String _$key__onBlur___$DomPropsMixin = 'onBlur';
  static const String _$key__onChange___$DomPropsMixin = 'onChange';
  static const String _$key__onInput___$DomPropsMixin = 'onInput';
  static const String _$key__onSubmit___$DomPropsMixin = 'onSubmit';
  static const String _$key__onReset___$DomPropsMixin = 'onReset';
  static const String _$key__onClick___$DomPropsMixin = 'onClick';
  static const String _$key__onContextMenu___$DomPropsMixin = 'onContextMenu';
  static const String _$key__onDoubleClick___$DomPropsMixin = 'onDoubleClick';
  static const String _$key__onDrag___$DomPropsMixin = 'onDrag';
  static const String _$key__onDragEnd___$DomPropsMixin = 'onDragEnd';
  static const String _$key__onDragEnter___$DomPropsMixin = 'onDragEnter';
  static const String _$key__onDragExit___$DomPropsMixin = 'onDragExit';
  static const String _$key__onDragLeave___$DomPropsMixin = 'onDragLeave';
  static const String _$key__onDragOver___$DomPropsMixin = 'onDragOver';
  static const String _$key__onDragStart___$DomPropsMixin = 'onDragStart';
  static const String _$key__onDrop___$DomPropsMixin = 'onDrop';
  static const String _$key__onMouseDown___$DomPropsMixin = 'onMouseDown';
  static const String _$key__onMouseEnter___$DomPropsMixin = 'onMouseEnter';
  static const String _$key__onMouseLeave___$DomPropsMixin = 'onMouseLeave';
  static const String _$key__onMouseMove___$DomPropsMixin = 'onMouseMove';
  static const String _$key__onMouseOut___$DomPropsMixin = 'onMouseOut';
  static const String _$key__onMouseOver___$DomPropsMixin = 'onMouseOver';
  static const String _$key__onMouseUp___$DomPropsMixin = 'onMouseUp';
  static const String _$key__onPointerCancel___$DomPropsMixin =
      'onPointerCancel';
  static const String _$key__onPointerDown___$DomPropsMixin = 'onPointerDown';
  static const String _$key__onPointerEnter___$DomPropsMixin = 'onPointerEnter';
  static const String _$key__onPointerLeave___$DomPropsMixin = 'onPointerLeave';
  static const String _$key__onPointerMove___$DomPropsMixin = 'onPointerMove';
  static const String _$key__onPointerOver___$DomPropsMixin = 'onPointerOver';
  static const String _$key__onPointerOut___$DomPropsMixin = 'onPointerOut';
  static const String _$key__onPointerUp___$DomPropsMixin = 'onPointerUp';
  static const String _$key__onTouchCancel___$DomPropsMixin = 'onTouchCancel';
  static const String _$key__onTouchEnd___$DomPropsMixin = 'onTouchEnd';
  static const String _$key__onTouchMove___$DomPropsMixin = 'onTouchMove';
  static const String _$key__onTouchStart___$DomPropsMixin = 'onTouchStart';
  static const String _$key__onTransitionEnd___$DomPropsMixin =
      'onTransitionEnd';
  static const String _$key__onScroll___$DomPropsMixin = 'onScroll';
  static const String _$key__onWheel___$DomPropsMixin = 'onWheel';
  static const String _$key__onCopyCapture___$DomPropsMixin = 'onCopyCapture';
  static const String _$key__onCutCapture___$DomPropsMixin = 'onCutCapture';
  static const String _$key__onPasteCapture___$DomPropsMixin = 'onPasteCapture';
  static const String _$key__onKeyDownCapture___$DomPropsMixin =
      'onKeyDownCapture';
  static const String _$key__onKeyPressCapture___$DomPropsMixin =
      'onKeyPressCapture';
  static const String _$key__onKeyUpCapture___$DomPropsMixin = 'onKeyUpCapture';
  static const String _$key__onFocusCapture___$DomPropsMixin = 'onFocusCapture';
  static const String _$key__onBlurCapture___$DomPropsMixin = 'onBlurCapture';
  static const String _$key__onChangeCapture___$DomPropsMixin =
      'onChangeCapture';
  static const String _$key__onInputCapture___$DomPropsMixin = 'onInputCapture';
  static const String _$key__onSubmitCapture___$DomPropsMixin =
      'onSubmitCapture';
  static const String _$key__onResetCapture___$DomPropsMixin = 'onResetCapture';
  static const String _$key__onClickCapture___$DomPropsMixin = 'onClickCapture';
  static const String _$key__onContextMenuCapture___$DomPropsMixin =
      'onContextMenuCapture';
  static const String _$key__onDoubleClickCapture___$DomPropsMixin =
      'onDoubleClickCapture';
  static const String _$key__onDragCapture___$DomPropsMixin = 'onDragCapture';
  static const String _$key__onDragEndCapture___$DomPropsMixin =
      'onDragEndCapture';
  static const String _$key__onDragEnterCapture___$DomPropsMixin =
      'onDragEnterCapture';
  static const String _$key__onDragExitCapture___$DomPropsMixin =
      'onDragExitCapture';
  static const String _$key__onDragLeaveCapture___$DomPropsMixin =
      'onDragLeaveCapture';
  static const String _$key__onDragOverCapture___$DomPropsMixin =
      'onDragOverCapture';
  static const String _$key__onDragStartCapture___$DomPropsMixin =
      'onDragStartCapture';
  static const String _$key__onDropCapture___$DomPropsMixin = 'onDropCapture';
  static const String _$key__onMouseDownCapture___$DomPropsMixin =
      'onMouseDownCapture';
  static const String _$key__onMouseEnterCapture___$DomPropsMixin =
      'onMouseEnterCapture';
  static const String _$key__onMouseLeaveCapture___$DomPropsMixin =
      'onMouseLeaveCapture';
  static const String _$key__onMouseMoveCapture___$DomPropsMixin =
      'onMouseMoveCapture';
  static const String _$key__onMouseOutCapture___$DomPropsMixin =
      'onMouseOutCapture';
  static const String _$key__onMouseOverCapture___$DomPropsMixin =
      'onMouseOverCapture';
  static const String _$key__onMouseUpCapture___$DomPropsMixin =
      'onMouseUpCapture';
  static const String _$key__onGotPointerCapture___$DomPropsMixin =
      'onGotPointerCapture';
  static const String _$key__onLostPointerCapture___$DomPropsMixin =
      'onLostPointerCapture';
  static const String _$key__onTouchCancelCapture___$DomPropsMixin =
      'onTouchCancelCapture';
  static const String _$key__onTouchEndCapture___$DomPropsMixin =
      'onTouchEndCapture';
  static const String _$key__onTouchMoveCapture___$DomPropsMixin =
      'onTouchMoveCapture';
  static const String _$key__onTouchStartCapture___$DomPropsMixin =
      'onTouchStartCapture';
  static const String _$key__onScrollCapture___$DomPropsMixin =
      'onScrollCapture';
  static const String _$key__onWheelCapture___$DomPropsMixin = 'onWheelCapture';
  static const String _$key__defaultChecked___$DomPropsMixin = 'defaultChecked';
  static const String _$key__defaultValue___$DomPropsMixin = 'defaultValue';
  static const String _$key__autoFocus___$DomPropsMixin = 'autoFocus';

  static const List<PropDescriptor> $props = [
    _$prop__cols___$DomPropsMixin,
    _$prop__minLength___$DomPropsMixin,
    _$prop__rows___$DomPropsMixin,
    _$prop__size___$DomPropsMixin,
    _$prop__span___$DomPropsMixin,
    _$prop__start___$DomPropsMixin,
    _$prop__high___$DomPropsMixin,
    _$prop__low___$DomPropsMixin,
    _$prop__marginHeight___$DomPropsMixin,
    _$prop__marginWidth___$DomPropsMixin,
    _$prop__optimum___$DomPropsMixin,
    _$prop__htmlDefault___$DomPropsMixin,
    _$prop__htmlIs___$DomPropsMixin,
    _$prop__allowFullScreen___$DomPropsMixin,
    _$prop__async___$DomPropsMixin,
    _$prop__autoPlay___$DomPropsMixin,
    _$prop__checked___$DomPropsMixin,
    _$prop__controls___$DomPropsMixin,
    _$prop__defer___$DomPropsMixin,
    _$prop__disabled___$DomPropsMixin,
    _$prop__formNoValidate___$DomPropsMixin,
    _$prop__hidden___$DomPropsMixin,
    _$prop__loop___$DomPropsMixin,
    _$prop__multiple___$DomPropsMixin,
    _$prop__muted___$DomPropsMixin,
    _$prop__noValidate___$DomPropsMixin,
    _$prop__open___$DomPropsMixin,
    _$prop__readOnly___$DomPropsMixin,
    _$prop__required___$DomPropsMixin,
    _$prop__reversed___$DomPropsMixin,
    _$prop__scoped___$DomPropsMixin,
    _$prop__seamless___$DomPropsMixin,
    _$prop__selected___$DomPropsMixin,
    _$prop___raw$DomProps$style___$DomPropsMixin,
    _$prop__challenge___$DomPropsMixin,
    _$prop__cite___$DomPropsMixin,
    _$prop__className___$DomPropsMixin,
    _$prop__controlsList___$DomPropsMixin,
    _$prop__formAction___$DomPropsMixin,
    _$prop__formEncType___$DomPropsMixin,
    _$prop__formMethod___$DomPropsMixin,
    _$prop__formTarget___$DomPropsMixin,
    _$prop__headers___$DomPropsMixin,
    _$prop__id___$DomPropsMixin,
    _$prop__inputMode___$DomPropsMixin,
    _$prop__integrity___$DomPropsMixin,
    _$prop__keyParams___$DomPropsMixin,
    _$prop__keyType___$DomPropsMixin,
    _$prop__kind___$DomPropsMixin,
    _$prop__nonce___$DomPropsMixin,
    _$prop__srcLang___$DomPropsMixin,
    _$prop__summary___$DomPropsMixin,
    _$prop__title___$DomPropsMixin,
    _$prop__wrap___$DomPropsMixin,
    _$prop__accept___$DomPropsMixin,
    _$prop__acceptCharset___$DomPropsMixin,
    _$prop__accessKey___$DomPropsMixin,
    _$prop__action___$DomPropsMixin,
    _$prop__allowTransparency___$DomPropsMixin,
    _$prop__alt___$DomPropsMixin,
    _$prop__autoComplete___$DomPropsMixin,
    _$prop__capture___$DomPropsMixin,
    _$prop__cellPadding___$DomPropsMixin,
    _$prop__cellSpacing___$DomPropsMixin,
    _$prop__charSet___$DomPropsMixin,
    _$prop__classID___$DomPropsMixin,
    _$prop__colSpan___$DomPropsMixin,
    _$prop__content___$DomPropsMixin,
    _$prop__contentEditable___$DomPropsMixin,
    _$prop__contextMenu___$DomPropsMixin,
    _$prop__coords___$DomPropsMixin,
    _$prop__crossOrigin___$DomPropsMixin,
    _$prop__data___$DomPropsMixin,
    _$prop__dateTime___$DomPropsMixin,
    _$prop__dir___$DomPropsMixin,
    _$prop__download___$DomPropsMixin,
    _$prop__draggable___$DomPropsMixin,
    _$prop__encType___$DomPropsMixin,
    _$prop__form___$DomPropsMixin,
    _$prop__frameBorder___$DomPropsMixin,
    _$prop__height___$DomPropsMixin,
    _$prop__href___$DomPropsMixin,
    _$prop__hrefLang___$DomPropsMixin,
    _$prop__htmlFor___$DomPropsMixin,
    _$prop__httpEquiv___$DomPropsMixin,
    _$prop__icon___$DomPropsMixin,
    _$prop__label___$DomPropsMixin,
    _$prop__lang___$DomPropsMixin,
    _$prop__list___$DomPropsMixin,
    _$prop__manifest___$DomPropsMixin,
    _$prop__max___$DomPropsMixin,
    _$prop__maxLength___$DomPropsMixin,
    _$prop__media___$DomPropsMixin,
    _$prop__mediaGroup___$DomPropsMixin,
    _$prop__method___$DomPropsMixin,
    _$prop__min___$DomPropsMixin,
    _$prop__name___$DomPropsMixin,
    _$prop__pattern___$DomPropsMixin,
    _$prop__placeholder___$DomPropsMixin,
    _$prop__poster___$DomPropsMixin,
    _$prop__preload___$DomPropsMixin,
    _$prop__radioGroup___$DomPropsMixin,
    _$prop__rel___$DomPropsMixin,
    _$prop__role___$DomPropsMixin,
    _$prop__rowSpan___$DomPropsMixin,
    _$prop__sandbox___$DomPropsMixin,
    _$prop__scope___$DomPropsMixin,
    _$prop__scrolling___$DomPropsMixin,
    _$prop__shape___$DomPropsMixin,
    _$prop__sizes___$DomPropsMixin,
    _$prop__spellCheck___$DomPropsMixin,
    _$prop__src___$DomPropsMixin,
    _$prop__srcDoc___$DomPropsMixin,
    _$prop__srcSet___$DomPropsMixin,
    _$prop__step___$DomPropsMixin,
    _$prop__tabIndex___$DomPropsMixin,
    _$prop__target___$DomPropsMixin,
    _$prop__type___$DomPropsMixin,
    _$prop__useMap___$DomPropsMixin,
    _$prop__value___$DomPropsMixin,
    _$prop__width___$DomPropsMixin,
    _$prop__wmode___$DomPropsMixin,
    _$prop__onAnimationEnd___$DomPropsMixin,
    _$prop__onAnimationIteration___$DomPropsMixin,
    _$prop__onAnimationStart___$DomPropsMixin,
    _$prop__onCopy___$DomPropsMixin,
    _$prop__onCut___$DomPropsMixin,
    _$prop__onPaste___$DomPropsMixin,
    _$prop__onKeyDown___$DomPropsMixin,
    _$prop__onKeyPress___$DomPropsMixin,
    _$prop__onKeyUp___$DomPropsMixin,
    _$prop__onFocus___$DomPropsMixin,
    _$prop__onBlur___$DomPropsMixin,
    _$prop__onChange___$DomPropsMixin,
    _$prop__onInput___$DomPropsMixin,
    _$prop__onSubmit___$DomPropsMixin,
    _$prop__onReset___$DomPropsMixin,
    _$prop__onClick___$DomPropsMixin,
    _$prop__onContextMenu___$DomPropsMixin,
    _$prop__onDoubleClick___$DomPropsMixin,
    _$prop__onDrag___$DomPropsMixin,
    _$prop__onDragEnd___$DomPropsMixin,
    _$prop__onDragEnter___$DomPropsMixin,
    _$prop__onDragExit___$DomPropsMixin,
    _$prop__onDragLeave___$DomPropsMixin,
    _$prop__onDragOver___$DomPropsMixin,
    _$prop__onDragStart___$DomPropsMixin,
    _$prop__onDrop___$DomPropsMixin,
    _$prop__onMouseDown___$DomPropsMixin,
    _$prop__onMouseEnter___$DomPropsMixin,
    _$prop__onMouseLeave___$DomPropsMixin,
    _$prop__onMouseMove___$DomPropsMixin,
    _$prop__onMouseOut___$DomPropsMixin,
    _$prop__onMouseOver___$DomPropsMixin,
    _$prop__onMouseUp___$DomPropsMixin,
    _$prop__onPointerCancel___$DomPropsMixin,
    _$prop__onPointerDown___$DomPropsMixin,
    _$prop__onPointerEnter___$DomPropsMixin,
    _$prop__onPointerLeave___$DomPropsMixin,
    _$prop__onPointerMove___$DomPropsMixin,
    _$prop__onPointerOver___$DomPropsMixin,
    _$prop__onPointerOut___$DomPropsMixin,
    _$prop__onPointerUp___$DomPropsMixin,
    _$prop__onTouchCancel___$DomPropsMixin,
    _$prop__onTouchEnd___$DomPropsMixin,
    _$prop__onTouchMove___$DomPropsMixin,
    _$prop__onTouchStart___$DomPropsMixin,
    _$prop__onTransitionEnd___$DomPropsMixin,
    _$prop__onScroll___$DomPropsMixin,
    _$prop__onWheel___$DomPropsMixin,
    _$prop__onCopyCapture___$DomPropsMixin,
    _$prop__onCutCapture___$DomPropsMixin,
    _$prop__onPasteCapture___$DomPropsMixin,
    _$prop__onKeyDownCapture___$DomPropsMixin,
    _$prop__onKeyPressCapture___$DomPropsMixin,
    _$prop__onKeyUpCapture___$DomPropsMixin,
    _$prop__onFocusCapture___$DomPropsMixin,
    _$prop__onBlurCapture___$DomPropsMixin,
    _$prop__onChangeCapture___$DomPropsMixin,
    _$prop__onInputCapture___$DomPropsMixin,
    _$prop__onSubmitCapture___$DomPropsMixin,
    _$prop__onResetCapture___$DomPropsMixin,
    _$prop__onClickCapture___$DomPropsMixin,
    _$prop__onContextMenuCapture___$DomPropsMixin,
    _$prop__onDoubleClickCapture___$DomPropsMixin,
    _$prop__onDragCapture___$DomPropsMixin,
    _$prop__onDragEndCapture___$DomPropsMixin,
    _$prop__onDragEnterCapture___$DomPropsMixin,
    _$prop__onDragExitCapture___$DomPropsMixin,
    _$prop__onDragLeaveCapture___$DomPropsMixin,
    _$prop__onDragOverCapture___$DomPropsMixin,
    _$prop__onDragStartCapture___$DomPropsMixin,
    _$prop__onDropCapture___$DomPropsMixin,
    _$prop__onMouseDownCapture___$DomPropsMixin,
    _$prop__onMouseEnterCapture___$DomPropsMixin,
    _$prop__onMouseLeaveCapture___$DomPropsMixin,
    _$prop__onMouseMoveCapture___$DomPropsMixin,
    _$prop__onMouseOutCapture___$DomPropsMixin,
    _$prop__onMouseOverCapture___$DomPropsMixin,
    _$prop__onMouseUpCapture___$DomPropsMixin,
    _$prop__onGotPointerCapture___$DomPropsMixin,
    _$prop__onLostPointerCapture___$DomPropsMixin,
    _$prop__onTouchCancelCapture___$DomPropsMixin,
    _$prop__onTouchEndCapture___$DomPropsMixin,
    _$prop__onTouchMoveCapture___$DomPropsMixin,
    _$prop__onTouchStartCapture___$DomPropsMixin,
    _$prop__onScrollCapture___$DomPropsMixin,
    _$prop__onWheelCapture___$DomPropsMixin,
    _$prop__defaultChecked___$DomPropsMixin,
    _$prop__defaultValue___$DomPropsMixin,
    _$prop__autoFocus___$DomPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__cols___$DomPropsMixin,
    _$key__minLength___$DomPropsMixin,
    _$key__rows___$DomPropsMixin,
    _$key__size___$DomPropsMixin,
    _$key__span___$DomPropsMixin,
    _$key__start___$DomPropsMixin,
    _$key__high___$DomPropsMixin,
    _$key__low___$DomPropsMixin,
    _$key__marginHeight___$DomPropsMixin,
    _$key__marginWidth___$DomPropsMixin,
    _$key__optimum___$DomPropsMixin,
    _$key__htmlDefault___$DomPropsMixin,
    _$key__htmlIs___$DomPropsMixin,
    _$key__allowFullScreen___$DomPropsMixin,
    _$key__async___$DomPropsMixin,
    _$key__autoPlay___$DomPropsMixin,
    _$key__checked___$DomPropsMixin,
    _$key__controls___$DomPropsMixin,
    _$key__defer___$DomPropsMixin,
    _$key__disabled___$DomPropsMixin,
    _$key__formNoValidate___$DomPropsMixin,
    _$key__hidden___$DomPropsMixin,
    _$key__loop___$DomPropsMixin,
    _$key__multiple___$DomPropsMixin,
    _$key__muted___$DomPropsMixin,
    _$key__noValidate___$DomPropsMixin,
    _$key__open___$DomPropsMixin,
    _$key__readOnly___$DomPropsMixin,
    _$key__required___$DomPropsMixin,
    _$key__reversed___$DomPropsMixin,
    _$key__scoped___$DomPropsMixin,
    _$key__seamless___$DomPropsMixin,
    _$key__selected___$DomPropsMixin,
    _$key___raw$DomProps$style___$DomPropsMixin,
    _$key__challenge___$DomPropsMixin,
    _$key__cite___$DomPropsMixin,
    _$key__className___$DomPropsMixin,
    _$key__controlsList___$DomPropsMixin,
    _$key__formAction___$DomPropsMixin,
    _$key__formEncType___$DomPropsMixin,
    _$key__formMethod___$DomPropsMixin,
    _$key__formTarget___$DomPropsMixin,
    _$key__headers___$DomPropsMixin,
    _$key__id___$DomPropsMixin,
    _$key__inputMode___$DomPropsMixin,
    _$key__integrity___$DomPropsMixin,
    _$key__keyParams___$DomPropsMixin,
    _$key__keyType___$DomPropsMixin,
    _$key__kind___$DomPropsMixin,
    _$key__nonce___$DomPropsMixin,
    _$key__srcLang___$DomPropsMixin,
    _$key__summary___$DomPropsMixin,
    _$key__title___$DomPropsMixin,
    _$key__wrap___$DomPropsMixin,
    _$key__accept___$DomPropsMixin,
    _$key__acceptCharset___$DomPropsMixin,
    _$key__accessKey___$DomPropsMixin,
    _$key__action___$DomPropsMixin,
    _$key__allowTransparency___$DomPropsMixin,
    _$key__alt___$DomPropsMixin,
    _$key__autoComplete___$DomPropsMixin,
    _$key__capture___$DomPropsMixin,
    _$key__cellPadding___$DomPropsMixin,
    _$key__cellSpacing___$DomPropsMixin,
    _$key__charSet___$DomPropsMixin,
    _$key__classID___$DomPropsMixin,
    _$key__colSpan___$DomPropsMixin,
    _$key__content___$DomPropsMixin,
    _$key__contentEditable___$DomPropsMixin,
    _$key__contextMenu___$DomPropsMixin,
    _$key__coords___$DomPropsMixin,
    _$key__crossOrigin___$DomPropsMixin,
    _$key__data___$DomPropsMixin,
    _$key__dateTime___$DomPropsMixin,
    _$key__dir___$DomPropsMixin,
    _$key__download___$DomPropsMixin,
    _$key__draggable___$DomPropsMixin,
    _$key__encType___$DomPropsMixin,
    _$key__form___$DomPropsMixin,
    _$key__frameBorder___$DomPropsMixin,
    _$key__height___$DomPropsMixin,
    _$key__href___$DomPropsMixin,
    _$key__hrefLang___$DomPropsMixin,
    _$key__htmlFor___$DomPropsMixin,
    _$key__httpEquiv___$DomPropsMixin,
    _$key__icon___$DomPropsMixin,
    _$key__label___$DomPropsMixin,
    _$key__lang___$DomPropsMixin,
    _$key__list___$DomPropsMixin,
    _$key__manifest___$DomPropsMixin,
    _$key__max___$DomPropsMixin,
    _$key__maxLength___$DomPropsMixin,
    _$key__media___$DomPropsMixin,
    _$key__mediaGroup___$DomPropsMixin,
    _$key__method___$DomPropsMixin,
    _$key__min___$DomPropsMixin,
    _$key__name___$DomPropsMixin,
    _$key__pattern___$DomPropsMixin,
    _$key__placeholder___$DomPropsMixin,
    _$key__poster___$DomPropsMixin,
    _$key__preload___$DomPropsMixin,
    _$key__radioGroup___$DomPropsMixin,
    _$key__rel___$DomPropsMixin,
    _$key__role___$DomPropsMixin,
    _$key__rowSpan___$DomPropsMixin,
    _$key__sandbox___$DomPropsMixin,
    _$key__scope___$DomPropsMixin,
    _$key__scrolling___$DomPropsMixin,
    _$key__shape___$DomPropsMixin,
    _$key__sizes___$DomPropsMixin,
    _$key__spellCheck___$DomPropsMixin,
    _$key__src___$DomPropsMixin,
    _$key__srcDoc___$DomPropsMixin,
    _$key__srcSet___$DomPropsMixin,
    _$key__step___$DomPropsMixin,
    _$key__tabIndex___$DomPropsMixin,
    _$key__target___$DomPropsMixin,
    _$key__type___$DomPropsMixin,
    _$key__useMap___$DomPropsMixin,
    _$key__value___$DomPropsMixin,
    _$key__width___$DomPropsMixin,
    _$key__wmode___$DomPropsMixin,
    _$key__onAnimationEnd___$DomPropsMixin,
    _$key__onAnimationIteration___$DomPropsMixin,
    _$key__onAnimationStart___$DomPropsMixin,
    _$key__onCopy___$DomPropsMixin,
    _$key__onCut___$DomPropsMixin,
    _$key__onPaste___$DomPropsMixin,
    _$key__onKeyDown___$DomPropsMixin,
    _$key__onKeyPress___$DomPropsMixin,
    _$key__onKeyUp___$DomPropsMixin,
    _$key__onFocus___$DomPropsMixin,
    _$key__onBlur___$DomPropsMixin,
    _$key__onChange___$DomPropsMixin,
    _$key__onInput___$DomPropsMixin,
    _$key__onSubmit___$DomPropsMixin,
    _$key__onReset___$DomPropsMixin,
    _$key__onClick___$DomPropsMixin,
    _$key__onContextMenu___$DomPropsMixin,
    _$key__onDoubleClick___$DomPropsMixin,
    _$key__onDrag___$DomPropsMixin,
    _$key__onDragEnd___$DomPropsMixin,
    _$key__onDragEnter___$DomPropsMixin,
    _$key__onDragExit___$DomPropsMixin,
    _$key__onDragLeave___$DomPropsMixin,
    _$key__onDragOver___$DomPropsMixin,
    _$key__onDragStart___$DomPropsMixin,
    _$key__onDrop___$DomPropsMixin,
    _$key__onMouseDown___$DomPropsMixin,
    _$key__onMouseEnter___$DomPropsMixin,
    _$key__onMouseLeave___$DomPropsMixin,
    _$key__onMouseMove___$DomPropsMixin,
    _$key__onMouseOut___$DomPropsMixin,
    _$key__onMouseOver___$DomPropsMixin,
    _$key__onMouseUp___$DomPropsMixin,
    _$key__onPointerCancel___$DomPropsMixin,
    _$key__onPointerDown___$DomPropsMixin,
    _$key__onPointerEnter___$DomPropsMixin,
    _$key__onPointerLeave___$DomPropsMixin,
    _$key__onPointerMove___$DomPropsMixin,
    _$key__onPointerOver___$DomPropsMixin,
    _$key__onPointerOut___$DomPropsMixin,
    _$key__onPointerUp___$DomPropsMixin,
    _$key__onTouchCancel___$DomPropsMixin,
    _$key__onTouchEnd___$DomPropsMixin,
    _$key__onTouchMove___$DomPropsMixin,
    _$key__onTouchStart___$DomPropsMixin,
    _$key__onTransitionEnd___$DomPropsMixin,
    _$key__onScroll___$DomPropsMixin,
    _$key__onWheel___$DomPropsMixin,
    _$key__onCopyCapture___$DomPropsMixin,
    _$key__onCutCapture___$DomPropsMixin,
    _$key__onPasteCapture___$DomPropsMixin,
    _$key__onKeyDownCapture___$DomPropsMixin,
    _$key__onKeyPressCapture___$DomPropsMixin,
    _$key__onKeyUpCapture___$DomPropsMixin,
    _$key__onFocusCapture___$DomPropsMixin,
    _$key__onBlurCapture___$DomPropsMixin,
    _$key__onChangeCapture___$DomPropsMixin,
    _$key__onInputCapture___$DomPropsMixin,
    _$key__onSubmitCapture___$DomPropsMixin,
    _$key__onResetCapture___$DomPropsMixin,
    _$key__onClickCapture___$DomPropsMixin,
    _$key__onContextMenuCapture___$DomPropsMixin,
    _$key__onDoubleClickCapture___$DomPropsMixin,
    _$key__onDragCapture___$DomPropsMixin,
    _$key__onDragEndCapture___$DomPropsMixin,
    _$key__onDragEnterCapture___$DomPropsMixin,
    _$key__onDragExitCapture___$DomPropsMixin,
    _$key__onDragLeaveCapture___$DomPropsMixin,
    _$key__onDragOverCapture___$DomPropsMixin,
    _$key__onDragStartCapture___$DomPropsMixin,
    _$key__onDropCapture___$DomPropsMixin,
    _$key__onMouseDownCapture___$DomPropsMixin,
    _$key__onMouseEnterCapture___$DomPropsMixin,
    _$key__onMouseLeaveCapture___$DomPropsMixin,
    _$key__onMouseMoveCapture___$DomPropsMixin,
    _$key__onMouseOutCapture___$DomPropsMixin,
    _$key__onMouseOverCapture___$DomPropsMixin,
    _$key__onMouseUpCapture___$DomPropsMixin,
    _$key__onGotPointerCapture___$DomPropsMixin,
    _$key__onLostPointerCapture___$DomPropsMixin,
    _$key__onTouchCancelCapture___$DomPropsMixin,
    _$key__onTouchEndCapture___$DomPropsMixin,
    _$key__onTouchMoveCapture___$DomPropsMixin,
    _$key__onTouchStartCapture___$DomPropsMixin,
    _$key__onScrollCapture___$DomPropsMixin,
    _$key__onWheelCapture___$DomPropsMixin,
    _$key__defaultChecked___$DomPropsMixin,
    _$key__defaultValue___$DomPropsMixin,
    _$key__autoFocus___$DomPropsMixin
  ];
}

const PropsMeta _$metaForDomPropsMixin = PropsMeta(
  fields: DomPropsMixin.$props,
  keys: DomPropsMixin.$propKeys,
);

abstract class SvgPropsMixin implements _$SvgPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForSvgPropsMixin;

  /// <!-- Generated from [_$SvgPropsMixin.htmlIn] -->
  @override
  @Accessor(key: 'in')
  get htmlIn => (props[_$key__htmlIn___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.htmlIn] -->
  @override
  @Accessor(key: 'in')
  set htmlIn(value) => props[_$key__htmlIn___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.htmlValues] -->
  @override
  @Accessor(key: 'values')
  get htmlValues => (props[_$key__htmlValues___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.htmlValues] -->
  @override
  @Accessor(key: 'values')
  set htmlValues(value) => props[_$key__htmlValues___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.accumulate] -->
  @override
  get accumulate => (props[_$key__accumulate___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.accumulate] -->
  @override
  set accumulate(value) => props[_$key__accumulate___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.additive] -->
  @override
  get additive => (props[_$key__additive___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.additive] -->
  @override
  set additive(value) => props[_$key__additive___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.alignmentBaseline] -->
  @override
  get alignmentBaseline =>
      (props[_$key__alignmentBaseline___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.alignmentBaseline] -->
  @override
  set alignmentBaseline(value) =>
      props[_$key__alignmentBaseline___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.allowReorder] -->
  @override
  get allowReorder => (props[_$key__allowReorder___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.allowReorder] -->
  @override
  set allowReorder(value) =>
      props[_$key__allowReorder___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.arabicForm] -->
  @override
  get arabicForm => (props[_$key__arabicForm___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.arabicForm] -->
  @override
  set arabicForm(value) => props[_$key__arabicForm___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.attributeName] -->
  @override
  get attributeName =>
      (props[_$key__attributeName___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.attributeName] -->
  @override
  set attributeName(value) =>
      props[_$key__attributeName___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.attributeType] -->
  @override
  get attributeType =>
      (props[_$key__attributeType___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.attributeType] -->
  @override
  set attributeType(value) =>
      props[_$key__attributeType___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.colorInterpolationFilters] -->
  @override
  get colorInterpolationFilters =>
      (props[_$key__colorInterpolationFilters___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.colorInterpolationFilters] -->
  @override
  set colorInterpolationFilters(value) =>
      props[_$key__colorInterpolationFilters___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fillRule] -->
  @override
  get fillRule => (props[_$key__fillRule___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.fillRule] -->
  @override
  set fillRule(value) => props[_$key__fillRule___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.filter] -->
  @override
  get filter => (props[_$key__filter___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.filter] -->
  @override
  set filter(value) => props[_$key__filter___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.mask] -->
  @override
  get mask => (props[_$key__mask___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.mask] -->
  @override
  set mask(value) => props[_$key__mask___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.result] -->
  @override
  get result => (props[_$key__result___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.result] -->
  @override
  set result(value) => props[_$key__result___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeLinejoin] -->
  @override
  get strokeLinejoin =>
      (props[_$key__strokeLinejoin___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.strokeLinejoin] -->
  @override
  set strokeLinejoin(value) =>
      props[_$key__strokeLinejoin___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xChannelSelector] -->
  @override
  get xChannelSelector =>
      (props[_$key__xChannelSelector___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.xChannelSelector] -->
  @override
  set xChannelSelector(value) =>
      props[_$key__xChannelSelector___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlns] -->
  @override
  get xmlns => (props[_$key__xmlns___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.xmlns] -->
  @override
  set xmlns(value) => props[_$key__xmlns___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlnsXlink] -->
  @override
  get xmlnsXlink => (props[_$key__xmlnsXlink___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.xmlnsXlink] -->
  @override
  set xmlnsXlink(value) => props[_$key__xmlnsXlink___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.yChannelSelector] -->
  @override
  get yChannelSelector =>
      (props[_$key__yChannelSelector___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.yChannelSelector] -->
  @override
  set yChannelSelector(value) =>
      props[_$key__yChannelSelector___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.zoomAndPan] -->
  @override
  get zoomAndPan => (props[_$key__zoomAndPan___$SvgPropsMixin]) as String?;

  /// <!-- Generated from [_$SvgPropsMixin.zoomAndPan] -->
  @override
  set zoomAndPan(value) => props[_$key__zoomAndPan___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.accentHeight] -->
  @override
  get accentHeight => (props[_$key__accentHeight___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.accentHeight] -->
  @override
  set accentHeight(value) =>
      props[_$key__accentHeight___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.alphabetic] -->
  @override
  get alphabetic => (props[_$key__alphabetic___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.alphabetic] -->
  @override
  set alphabetic(value) => props[_$key__alphabetic___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.amplitude] -->
  @override
  get amplitude => (props[_$key__amplitude___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.amplitude] -->
  @override
  set amplitude(value) => props[_$key__amplitude___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.ascent] -->
  @override
  get ascent => (props[_$key__ascent___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.ascent] -->
  @override
  set ascent(value) => props[_$key__ascent___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.autoReverse] -->
  @override
  get autoReverse => (props[_$key__autoReverse___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.autoReverse] -->
  @override
  set autoReverse(value) => props[_$key__autoReverse___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.azimuth] -->
  @override
  get azimuth => (props[_$key__azimuth___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.azimuth] -->
  @override
  set azimuth(value) => props[_$key__azimuth___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.baseFrequency] -->
  @override
  get baseFrequency =>
      (props[_$key__baseFrequency___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.baseFrequency] -->
  @override
  set baseFrequency(value) =>
      props[_$key__baseFrequency___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.baseProfile] -->
  @override
  get baseProfile => (props[_$key__baseProfile___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.baseProfile] -->
  @override
  set baseProfile(value) => props[_$key__baseProfile___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.baselineShift] -->
  @override
  get baselineShift =>
      (props[_$key__baselineShift___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.baselineShift] -->
  @override
  set baselineShift(value) =>
      props[_$key__baselineShift___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.bbox] -->
  @override
  get bbox => (props[_$key__bbox___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.bbox] -->
  @override
  set bbox(value) => props[_$key__bbox___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.begin] -->
  @override
  get begin => (props[_$key__begin___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.begin] -->
  @override
  set begin(value) => props[_$key__begin___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.bias] -->
  @override
  get bias => (props[_$key__bias___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.bias] -->
  @override
  set bias(value) => props[_$key__bias___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.by] -->
  @override
  get by => (props[_$key__by___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.by] -->
  @override
  set by(value) => props[_$key__by___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.calcMode] -->
  @override
  get calcMode => (props[_$key__calcMode___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.calcMode] -->
  @override
  set calcMode(value) => props[_$key__calcMode___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.capHeight] -->
  @override
  get capHeight => (props[_$key__capHeight___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.capHeight] -->
  @override
  set capHeight(value) => props[_$key__capHeight___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.clip] -->
  @override
  get clip => (props[_$key__clip___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.clip] -->
  @override
  set clip(value) => props[_$key__clip___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.clipPath] -->
  @override
  get clipPath => (props[_$key__clipPath___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.clipPath] -->
  @override
  set clipPath(value) => props[_$key__clipPath___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.clipPathUnits] -->
  @override
  get clipPathUnits =>
      (props[_$key__clipPathUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.clipPathUnits] -->
  @override
  set clipPathUnits(value) =>
      props[_$key__clipPathUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.clipRule] -->
  @override
  get clipRule => (props[_$key__clipRule___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.clipRule] -->
  @override
  set clipRule(value) => props[_$key__clipRule___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.colorInterpolation] -->
  @override
  get colorInterpolation =>
      (props[_$key__colorInterpolation___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.colorInterpolation] -->
  @override
  set colorInterpolation(value) =>
      props[_$key__colorInterpolation___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.colorProfile] -->
  @override
  get colorProfile => (props[_$key__colorProfile___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.colorProfile] -->
  @override
  set colorProfile(value) =>
      props[_$key__colorProfile___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.colorRendering] -->
  @override
  get colorRendering =>
      (props[_$key__colorRendering___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.colorRendering] -->
  @override
  set colorRendering(value) =>
      props[_$key__colorRendering___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.contentScriptType] -->
  @override
  get contentScriptType =>
      (props[_$key__contentScriptType___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.contentScriptType] -->
  @override
  set contentScriptType(value) =>
      props[_$key__contentScriptType___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.contentStyleType] -->
  @override
  get contentStyleType =>
      (props[_$key__contentStyleType___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.contentStyleType] -->
  @override
  set contentStyleType(value) =>
      props[_$key__contentStyleType___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.cursor] -->
  @override
  get cursor => (props[_$key__cursor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.cursor] -->
  @override
  set cursor(value) => props[_$key__cursor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.cx] -->
  @override
  get cx => (props[_$key__cx___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.cx] -->
  @override
  set cx(value) => props[_$key__cx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.cy] -->
  @override
  get cy => (props[_$key__cy___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.cy] -->
  @override
  set cy(value) => props[_$key__cy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.d] -->
  @override
  get d => (props[_$key__d___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.d] -->
  @override
  set d(value) => props[_$key__d___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.decelerate] -->
  @override
  get decelerate => (props[_$key__decelerate___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.decelerate] -->
  @override
  set decelerate(value) => props[_$key__decelerate___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.descent] -->
  @override
  get descent => (props[_$key__descent___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.descent] -->
  @override
  set descent(value) => props[_$key__descent___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.diffuseConstant] -->
  @override
  get diffuseConstant =>
      (props[_$key__diffuseConstant___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.diffuseConstant] -->
  @override
  set diffuseConstant(value) =>
      props[_$key__diffuseConstant___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.direction] -->
  @override
  get direction => (props[_$key__direction___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.direction] -->
  @override
  set direction(value) => props[_$key__direction___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.display] -->
  @override
  get display => (props[_$key__display___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.display] -->
  @override
  set display(value) => props[_$key__display___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.divisor] -->
  @override
  get divisor => (props[_$key__divisor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.divisor] -->
  @override
  set divisor(value) => props[_$key__divisor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dominantBaseline] -->
  @override
  get dominantBaseline =>
      (props[_$key__dominantBaseline___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.dominantBaseline] -->
  @override
  set dominantBaseline(value) =>
      props[_$key__dominantBaseline___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dur] -->
  @override
  get dur => (props[_$key__dur___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.dur] -->
  @override
  set dur(value) => props[_$key__dur___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dx] -->
  @override
  get dx => (props[_$key__dx___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.dx] -->
  @override
  set dx(value) => props[_$key__dx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dy] -->
  @override
  get dy => (props[_$key__dy___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.dy] -->
  @override
  set dy(value) => props[_$key__dy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.edgeMode] -->
  @override
  get edgeMode => (props[_$key__edgeMode___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.edgeMode] -->
  @override
  set edgeMode(value) => props[_$key__edgeMode___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.elevation] -->
  @override
  get elevation => (props[_$key__elevation___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.elevation] -->
  @override
  set elevation(value) => props[_$key__elevation___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.enableBackground] -->
  @override
  get enableBackground =>
      (props[_$key__enableBackground___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.enableBackground] -->
  @override
  set enableBackground(value) =>
      props[_$key__enableBackground___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.end] -->
  @override
  get end => (props[_$key__end___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.end] -->
  @override
  set end(value) => props[_$key__end___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.exponent] -->
  @override
  get exponent => (props[_$key__exponent___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.exponent] -->
  @override
  set exponent(value) => props[_$key__exponent___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.externalResourcesRequired] -->
  @override
  get externalResourcesRequired =>
      (props[_$key__externalResourcesRequired___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.externalResourcesRequired] -->
  @override
  set externalResourcesRequired(value) =>
      props[_$key__externalResourcesRequired___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fill] -->
  @override
  get fill => (props[_$key__fill___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fill] -->
  @override
  set fill(value) => props[_$key__fill___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fillOpacity] -->
  @override
  get fillOpacity => (props[_$key__fillOpacity___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fillOpacity] -->
  @override
  set fillOpacity(value) => props[_$key__fillOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.filterRes] -->
  @override
  get filterRes => (props[_$key__filterRes___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.filterRes] -->
  @override
  set filterRes(value) => props[_$key__filterRes___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.filterUnits] -->
  @override
  get filterUnits => (props[_$key__filterUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.filterUnits] -->
  @override
  set filterUnits(value) => props[_$key__filterUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.floodColor] -->
  @override
  get floodColor => (props[_$key__floodColor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.floodColor] -->
  @override
  set floodColor(value) => props[_$key__floodColor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.floodOpacity] -->
  @override
  get floodOpacity => (props[_$key__floodOpacity___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.floodOpacity] -->
  @override
  set floodOpacity(value) =>
      props[_$key__floodOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.focusable] -->
  @override
  get focusable => (props[_$key__focusable___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.focusable] -->
  @override
  set focusable(value) => props[_$key__focusable___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontFamily] -->
  @override
  get fontFamily => (props[_$key__fontFamily___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontFamily] -->
  @override
  set fontFamily(value) => props[_$key__fontFamily___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontSize] -->
  @override
  get fontSize => (props[_$key__fontSize___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontSize] -->
  @override
  set fontSize(value) => props[_$key__fontSize___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontSizeAdjust] -->
  @override
  get fontSizeAdjust =>
      (props[_$key__fontSizeAdjust___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontSizeAdjust] -->
  @override
  set fontSizeAdjust(value) =>
      props[_$key__fontSizeAdjust___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontStretch] -->
  @override
  get fontStretch => (props[_$key__fontStretch___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontStretch] -->
  @override
  set fontStretch(value) => props[_$key__fontStretch___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontStyle] -->
  @override
  get fontStyle => (props[_$key__fontStyle___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontStyle] -->
  @override
  set fontStyle(value) => props[_$key__fontStyle___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontVariant] -->
  @override
  get fontVariant => (props[_$key__fontVariant___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontVariant] -->
  @override
  set fontVariant(value) => props[_$key__fontVariant___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontWeight] -->
  @override
  get fontWeight => (props[_$key__fontWeight___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fontWeight] -->
  @override
  set fontWeight(value) => props[_$key__fontWeight___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.format] -->
  @override
  get format => (props[_$key__format___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.format] -->
  @override
  set format(value) => props[_$key__format___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.from] -->
  @override
  get from => (props[_$key__from___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.from] -->
  @override
  set from(value) => props[_$key__from___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fx] -->
  @override
  get fx => (props[_$key__fx___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fx] -->
  @override
  set fx(value) => props[_$key__fx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fy] -->
  @override
  get fy => (props[_$key__fy___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.fy] -->
  @override
  set fy(value) => props[_$key__fy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.g1] -->
  @override
  get g1 => (props[_$key__g1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.g1] -->
  @override
  set g1(value) => props[_$key__g1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.g2] -->
  @override
  get g2 => (props[_$key__g2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.g2] -->
  @override
  set g2(value) => props[_$key__g2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.glyphName] -->
  @override
  get glyphName => (props[_$key__glyphName___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.glyphName] -->
  @override
  set glyphName(value) => props[_$key__glyphName___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.glyphOrientationHorizontal] -->
  @override
  get glyphOrientationHorizontal =>
      (props[_$key__glyphOrientationHorizontal___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.glyphOrientationHorizontal] -->
  @override
  set glyphOrientationHorizontal(value) =>
      props[_$key__glyphOrientationHorizontal___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.glyphOrientationVertical] -->
  @override
  get glyphOrientationVertical =>
      (props[_$key__glyphOrientationVertical___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.glyphOrientationVertical] -->
  @override
  set glyphOrientationVertical(value) =>
      props[_$key__glyphOrientationVertical___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.glyphRef] -->
  @override
  get glyphRef => (props[_$key__glyphRef___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.glyphRef] -->
  @override
  set glyphRef(value) => props[_$key__glyphRef___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.gradientTransform] -->
  @override
  get gradientTransform =>
      (props[_$key__gradientTransform___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.gradientTransform] -->
  @override
  set gradientTransform(value) =>
      props[_$key__gradientTransform___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.gradientUnits] -->
  @override
  get gradientUnits =>
      (props[_$key__gradientUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.gradientUnits] -->
  @override
  set gradientUnits(value) =>
      props[_$key__gradientUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.hanging] -->
  @override
  get hanging => (props[_$key__hanging___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.hanging] -->
  @override
  set hanging(value) => props[_$key__hanging___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.horizAdvX] -->
  @override
  get horizAdvX => (props[_$key__horizAdvX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.horizAdvX] -->
  @override
  set horizAdvX(value) => props[_$key__horizAdvX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.horizOriginX] -->
  @override
  get horizOriginX => (props[_$key__horizOriginX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.horizOriginX] -->
  @override
  set horizOriginX(value) =>
      props[_$key__horizOriginX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.ideographic] -->
  @override
  get ideographic => (props[_$key__ideographic___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.ideographic] -->
  @override
  set ideographic(value) => props[_$key__ideographic___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.imageRendering] -->
  @override
  get imageRendering =>
      (props[_$key__imageRendering___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.imageRendering] -->
  @override
  set imageRendering(value) =>
      props[_$key__imageRendering___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.in2] -->
  @override
  get in2 => (props[_$key__in2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.in2] -->
  @override
  set in2(value) => props[_$key__in2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.intercept] -->
  @override
  get intercept => (props[_$key__intercept___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.intercept] -->
  @override
  set intercept(value) => props[_$key__intercept___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.k] -->
  @override
  get k => (props[_$key__k___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.k] -->
  @override
  set k(value) => props[_$key__k___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.k1] -->
  @override
  get k1 => (props[_$key__k1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.k1] -->
  @override
  set k1(value) => props[_$key__k1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.k2] -->
  @override
  get k2 => (props[_$key__k2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.k2] -->
  @override
  set k2(value) => props[_$key__k2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.k3] -->
  @override
  get k3 => (props[_$key__k3___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.k3] -->
  @override
  set k3(value) => props[_$key__k3___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.k4] -->
  @override
  get k4 => (props[_$key__k4___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.k4] -->
  @override
  set k4(value) => props[_$key__k4___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.kernelMatrix] -->
  @override
  get kernelMatrix => (props[_$key__kernelMatrix___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.kernelMatrix] -->
  @override
  set kernelMatrix(value) =>
      props[_$key__kernelMatrix___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.kernelUnitLength] -->
  @override
  get kernelUnitLength =>
      (props[_$key__kernelUnitLength___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.kernelUnitLength] -->
  @override
  set kernelUnitLength(value) =>
      props[_$key__kernelUnitLength___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.kerning] -->
  @override
  get kerning => (props[_$key__kerning___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.kerning] -->
  @override
  set kerning(value) => props[_$key__kerning___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.keyPoints] -->
  @override
  get keyPoints => (props[_$key__keyPoints___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.keyPoints] -->
  @override
  set keyPoints(value) => props[_$key__keyPoints___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.keySplines] -->
  @override
  get keySplines => (props[_$key__keySplines___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.keySplines] -->
  @override
  set keySplines(value) => props[_$key__keySplines___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.keyTimes] -->
  @override
  get keyTimes => (props[_$key__keyTimes___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.keyTimes] -->
  @override
  set keyTimes(value) => props[_$key__keyTimes___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.lengthAdjust] -->
  @override
  get lengthAdjust => (props[_$key__lengthAdjust___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.lengthAdjust] -->
  @override
  set lengthAdjust(value) =>
      props[_$key__lengthAdjust___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.letterSpacing] -->
  @override
  get letterSpacing =>
      (props[_$key__letterSpacing___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.letterSpacing] -->
  @override
  set letterSpacing(value) =>
      props[_$key__letterSpacing___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.lightingColor] -->
  @override
  get lightingColor =>
      (props[_$key__lightingColor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.lightingColor] -->
  @override
  set lightingColor(value) =>
      props[_$key__lightingColor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.limitingConeAngle] -->
  @override
  get limitingConeAngle =>
      (props[_$key__limitingConeAngle___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.limitingConeAngle] -->
  @override
  set limitingConeAngle(value) =>
      props[_$key__limitingConeAngle___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.local] -->
  @override
  get local => (props[_$key__local___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.local] -->
  @override
  set local(value) => props[_$key__local___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerEnd] -->
  @override
  get markerEnd => (props[_$key__markerEnd___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerEnd] -->
  @override
  set markerEnd(value) => props[_$key__markerEnd___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerHeight] -->
  @override
  get markerHeight => (props[_$key__markerHeight___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerHeight] -->
  @override
  set markerHeight(value) =>
      props[_$key__markerHeight___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerMid] -->
  @override
  get markerMid => (props[_$key__markerMid___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerMid] -->
  @override
  set markerMid(value) => props[_$key__markerMid___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerStart] -->
  @override
  get markerStart => (props[_$key__markerStart___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerStart] -->
  @override
  set markerStart(value) => props[_$key__markerStart___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerUnits] -->
  @override
  get markerUnits => (props[_$key__markerUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerUnits] -->
  @override
  set markerUnits(value) => props[_$key__markerUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerWidth] -->
  @override
  get markerWidth => (props[_$key__markerWidth___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.markerWidth] -->
  @override
  set markerWidth(value) => props[_$key__markerWidth___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.maskContentUnits] -->
  @override
  get maskContentUnits =>
      (props[_$key__maskContentUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.maskContentUnits] -->
  @override
  set maskContentUnits(value) =>
      props[_$key__maskContentUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.maskUnits] -->
  @override
  get maskUnits => (props[_$key__maskUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.maskUnits] -->
  @override
  set maskUnits(value) => props[_$key__maskUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.mathematical] -->
  @override
  get mathematical => (props[_$key__mathematical___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.mathematical] -->
  @override
  set mathematical(value) =>
      props[_$key__mathematical___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.mode] -->
  @override
  get mode => (props[_$key__mode___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.mode] -->
  @override
  set mode(value) => props[_$key__mode___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.numOctaves] -->
  @override
  get numOctaves => (props[_$key__numOctaves___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.numOctaves] -->
  @override
  set numOctaves(value) => props[_$key__numOctaves___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.offset] -->
  @override
  get offset => (props[_$key__offset___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.offset] -->
  @override
  set offset(value) => props[_$key__offset___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.opacity] -->
  @override
  get opacity => (props[_$key__opacity___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.opacity] -->
  @override
  set opacity(value) => props[_$key__opacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.operator] -->
  @override
  get operator => (props[_$key__operator___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.operator] -->
  @override
  set operator(value) => props[_$key__operator___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.order] -->
  @override
  get order => (props[_$key__order___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.order] -->
  @override
  set order(value) => props[_$key__order___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.orient] -->
  @override
  get orient => (props[_$key__orient___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.orient] -->
  @override
  set orient(value) => props[_$key__orient___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.orientation] -->
  @override
  get orientation => (props[_$key__orientation___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.orientation] -->
  @override
  set orientation(value) => props[_$key__orientation___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.origin] -->
  @override
  get origin => (props[_$key__origin___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.origin] -->
  @override
  set origin(value) => props[_$key__origin___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.overflow] -->
  @override
  get overflow => (props[_$key__overflow___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.overflow] -->
  @override
  set overflow(value) => props[_$key__overflow___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.overlinePosition] -->
  @override
  get overlinePosition =>
      (props[_$key__overlinePosition___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.overlinePosition] -->
  @override
  set overlinePosition(value) =>
      props[_$key__overlinePosition___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.overlineThickness] -->
  @override
  get overlineThickness =>
      (props[_$key__overlineThickness___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.overlineThickness] -->
  @override
  set overlineThickness(value) =>
      props[_$key__overlineThickness___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.paintOrder] -->
  @override
  get paintOrder => (props[_$key__paintOrder___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.paintOrder] -->
  @override
  set paintOrder(value) => props[_$key__paintOrder___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.panose1] -->
  @override
  get panose1 => (props[_$key__panose1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.panose1] -->
  @override
  set panose1(value) => props[_$key__panose1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.pathLength] -->
  @override
  get pathLength => (props[_$key__pathLength___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.pathLength] -->
  @override
  set pathLength(value) => props[_$key__pathLength___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.patternContentUnits] -->
  @override
  get patternContentUnits =>
      (props[_$key__patternContentUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.patternContentUnits] -->
  @override
  set patternContentUnits(value) =>
      props[_$key__patternContentUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.patternTransform] -->
  @override
  get patternTransform =>
      (props[_$key__patternTransform___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.patternTransform] -->
  @override
  set patternTransform(value) =>
      props[_$key__patternTransform___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.patternUnits] -->
  @override
  get patternUnits => (props[_$key__patternUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.patternUnits] -->
  @override
  set patternUnits(value) =>
      props[_$key__patternUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.pointerEvents] -->
  @override
  get pointerEvents =>
      (props[_$key__pointerEvents___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.pointerEvents] -->
  @override
  set pointerEvents(value) =>
      props[_$key__pointerEvents___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.points] -->
  @override
  get points => (props[_$key__points___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.points] -->
  @override
  set points(value) => props[_$key__points___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtX] -->
  @override
  get pointsAtX => (props[_$key__pointsAtX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtX] -->
  @override
  set pointsAtX(value) => props[_$key__pointsAtX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtY] -->
  @override
  get pointsAtY => (props[_$key__pointsAtY___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtY] -->
  @override
  set pointsAtY(value) => props[_$key__pointsAtY___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtZ] -->
  @override
  get pointsAtZ => (props[_$key__pointsAtZ___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.pointsAtZ] -->
  @override
  set pointsAtZ(value) => props[_$key__pointsAtZ___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.preserveAlpha] -->
  @override
  get preserveAlpha =>
      (props[_$key__preserveAlpha___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.preserveAlpha] -->
  @override
  set preserveAlpha(value) =>
      props[_$key__preserveAlpha___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.preserveAspectRatio] -->
  @override
  get preserveAspectRatio =>
      (props[_$key__preserveAspectRatio___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.preserveAspectRatio] -->
  @override
  set preserveAspectRatio(value) =>
      props[_$key__preserveAspectRatio___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.primitiveUnits] -->
  @override
  get primitiveUnits =>
      (props[_$key__primitiveUnits___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.primitiveUnits] -->
  @override
  set primitiveUnits(value) =>
      props[_$key__primitiveUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.r] -->
  @override
  get r => (props[_$key__r___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.r] -->
  @override
  set r(value) => props[_$key__r___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.radius] -->
  @override
  get radius => (props[_$key__radius___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.radius] -->
  @override
  set radius(value) => props[_$key__radius___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.refX] -->
  @override
  get refX => (props[_$key__refX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.refX] -->
  @override
  set refX(value) => props[_$key__refX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.refY] -->
  @override
  get refY => (props[_$key__refY___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.refY] -->
  @override
  set refY(value) => props[_$key__refY___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.renderingIntent] -->
  @override
  get renderingIntent =>
      (props[_$key__renderingIntent___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.renderingIntent] -->
  @override
  set renderingIntent(value) =>
      props[_$key__renderingIntent___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.repeatCount] -->
  @override
  get repeatCount => (props[_$key__repeatCount___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.repeatCount] -->
  @override
  set repeatCount(value) => props[_$key__repeatCount___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.repeatDur] -->
  @override
  get repeatDur => (props[_$key__repeatDur___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.repeatDur] -->
  @override
  set repeatDur(value) => props[_$key__repeatDur___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.requiredExtensions] -->
  @override
  get requiredExtensions =>
      (props[_$key__requiredExtensions___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.requiredExtensions] -->
  @override
  set requiredExtensions(value) =>
      props[_$key__requiredExtensions___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.requiredFeatures] -->
  @override
  get requiredFeatures =>
      (props[_$key__requiredFeatures___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.requiredFeatures] -->
  @override
  set requiredFeatures(value) =>
      props[_$key__requiredFeatures___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.restart] -->
  @override
  get restart => (props[_$key__restart___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.restart] -->
  @override
  set restart(value) => props[_$key__restart___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.rotate] -->
  @override
  get rotate => (props[_$key__rotate___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.rotate] -->
  @override
  set rotate(value) => props[_$key__rotate___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.rx] -->
  @override
  get rx => (props[_$key__rx___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.rx] -->
  @override
  set rx(value) => props[_$key__rx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.ry] -->
  @override
  get ry => (props[_$key__ry___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.ry] -->
  @override
  set ry(value) => props[_$key__ry___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.scale] -->
  @override
  get scale => (props[_$key__scale___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.scale] -->
  @override
  set scale(value) => props[_$key__scale___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.seed] -->
  @override
  get seed => (props[_$key__seed___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.seed] -->
  @override
  set seed(value) => props[_$key__seed___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.shapeRendering] -->
  @override
  get shapeRendering =>
      (props[_$key__shapeRendering___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.shapeRendering] -->
  @override
  set shapeRendering(value) =>
      props[_$key__shapeRendering___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.slope] -->
  @override
  get slope => (props[_$key__slope___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.slope] -->
  @override
  set slope(value) => props[_$key__slope___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.spacing] -->
  @override
  get spacing => (props[_$key__spacing___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.spacing] -->
  @override
  set spacing(value) => props[_$key__spacing___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.specularConstant] -->
  @override
  get specularConstant =>
      (props[_$key__specularConstant___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.specularConstant] -->
  @override
  set specularConstant(value) =>
      props[_$key__specularConstant___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.specularExponent] -->
  @override
  get specularExponent =>
      (props[_$key__specularExponent___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.specularExponent] -->
  @override
  set specularExponent(value) =>
      props[_$key__specularExponent___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.speed] -->
  @override
  get speed => (props[_$key__speed___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.speed] -->
  @override
  set speed(value) => props[_$key__speed___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.spreadMethod] -->
  @override
  get spreadMethod => (props[_$key__spreadMethod___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.spreadMethod] -->
  @override
  set spreadMethod(value) =>
      props[_$key__spreadMethod___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.startOffset] -->
  @override
  get startOffset => (props[_$key__startOffset___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.startOffset] -->
  @override
  set startOffset(value) => props[_$key__startOffset___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stdDeviation] -->
  @override
  get stdDeviation => (props[_$key__stdDeviation___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stdDeviation] -->
  @override
  set stdDeviation(value) =>
      props[_$key__stdDeviation___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stemh] -->
  @override
  get stemh => (props[_$key__stemh___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stemh] -->
  @override
  set stemh(value) => props[_$key__stemh___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stemv] -->
  @override
  get stemv => (props[_$key__stemv___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stemv] -->
  @override
  set stemv(value) => props[_$key__stemv___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stitchTiles] -->
  @override
  get stitchTiles => (props[_$key__stitchTiles___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stitchTiles] -->
  @override
  set stitchTiles(value) => props[_$key__stitchTiles___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stopColor] -->
  @override
  get stopColor => (props[_$key__stopColor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stopColor] -->
  @override
  set stopColor(value) => props[_$key__stopColor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stopOpacity] -->
  @override
  get stopOpacity => (props[_$key__stopOpacity___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stopOpacity] -->
  @override
  set stopOpacity(value) => props[_$key__stopOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strikethroughPosition] -->
  @override
  get strikethroughPosition =>
      (props[_$key__strikethroughPosition___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strikethroughPosition] -->
  @override
  set strikethroughPosition(value) =>
      props[_$key__strikethroughPosition___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strikethroughThickness] -->
  @override
  get strikethroughThickness =>
      (props[_$key__strikethroughThickness___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strikethroughThickness] -->
  @override
  set strikethroughThickness(value) =>
      props[_$key__strikethroughThickness___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.string] -->
  @override
  get string => (props[_$key__string___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.string] -->
  @override
  set string(value) => props[_$key__string___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stroke] -->
  @override
  get stroke => (props[_$key__stroke___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.stroke] -->
  @override
  set stroke(value) => props[_$key__stroke___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeDasharray] -->
  @override
  get strokeDasharray =>
      (props[_$key__strokeDasharray___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeDasharray] -->
  @override
  set strokeDasharray(value) =>
      props[_$key__strokeDasharray___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeDashoffset] -->
  @override
  get strokeDashoffset =>
      (props[_$key__strokeDashoffset___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeDashoffset] -->
  @override
  set strokeDashoffset(value) =>
      props[_$key__strokeDashoffset___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeLinecap] -->
  @override
  get strokeLinecap =>
      (props[_$key__strokeLinecap___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeLinecap] -->
  @override
  set strokeLinecap(value) =>
      props[_$key__strokeLinecap___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeMiterlimit] -->
  @override
  get strokeMiterlimit =>
      (props[_$key__strokeMiterlimit___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeMiterlimit] -->
  @override
  set strokeMiterlimit(value) =>
      props[_$key__strokeMiterlimit___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeOpacity] -->
  @override
  get strokeOpacity =>
      (props[_$key__strokeOpacity___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeOpacity] -->
  @override
  set strokeOpacity(value) =>
      props[_$key__strokeOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeWidth] -->
  @override
  get strokeWidth => (props[_$key__strokeWidth___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.strokeWidth] -->
  @override
  set strokeWidth(value) => props[_$key__strokeWidth___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.surfaceScale] -->
  @override
  get surfaceScale => (props[_$key__surfaceScale___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.surfaceScale] -->
  @override
  set surfaceScale(value) =>
      props[_$key__surfaceScale___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.systemLanguage] -->
  @override
  get systemLanguage =>
      (props[_$key__systemLanguage___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.systemLanguage] -->
  @override
  set systemLanguage(value) =>
      props[_$key__systemLanguage___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.tableValues] -->
  @override
  get tableValues => (props[_$key__tableValues___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.tableValues] -->
  @override
  set tableValues(value) => props[_$key__tableValues___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.targetX] -->
  @override
  get targetX => (props[_$key__targetX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.targetX] -->
  @override
  set targetX(value) => props[_$key__targetX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.targetY] -->
  @override
  get targetY => (props[_$key__targetY___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.targetY] -->
  @override
  set targetY(value) => props[_$key__targetY___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.textAnchor] -->
  @override
  get textAnchor => (props[_$key__textAnchor___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.textAnchor] -->
  @override
  set textAnchor(value) => props[_$key__textAnchor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.textDecoration] -->
  @override
  get textDecoration =>
      (props[_$key__textDecoration___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.textDecoration] -->
  @override
  set textDecoration(value) =>
      props[_$key__textDecoration___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.textLength] -->
  @override
  get textLength => (props[_$key__textLength___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.textLength] -->
  @override
  set textLength(value) => props[_$key__textLength___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.textRendering] -->
  @override
  get textRendering =>
      (props[_$key__textRendering___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.textRendering] -->
  @override
  set textRendering(value) =>
      props[_$key__textRendering___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.to] -->
  @override
  get to => (props[_$key__to___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.to] -->
  @override
  set to(value) => props[_$key__to___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.transform] -->
  @override
  get transform => (props[_$key__transform___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.transform] -->
  @override
  set transform(value) => props[_$key__transform___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.u1] -->
  @override
  get u1 => (props[_$key__u1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.u1] -->
  @override
  set u1(value) => props[_$key__u1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.u2] -->
  @override
  get u2 => (props[_$key__u2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.u2] -->
  @override
  set u2(value) => props[_$key__u2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.underlinePosition] -->
  @override
  get underlinePosition =>
      (props[_$key__underlinePosition___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.underlinePosition] -->
  @override
  set underlinePosition(value) =>
      props[_$key__underlinePosition___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.underlineThickness] -->
  @override
  get underlineThickness =>
      (props[_$key__underlineThickness___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.underlineThickness] -->
  @override
  set underlineThickness(value) =>
      props[_$key__underlineThickness___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.unicode] -->
  @override
  get unicode => (props[_$key__unicode___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.unicode] -->
  @override
  set unicode(value) => props[_$key__unicode___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.unicodeBidi] -->
  @override
  get unicodeBidi => (props[_$key__unicodeBidi___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.unicodeBidi] -->
  @override
  set unicodeBidi(value) => props[_$key__unicodeBidi___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.unicodeRange] -->
  @override
  get unicodeRange => (props[_$key__unicodeRange___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.unicodeRange] -->
  @override
  set unicodeRange(value) =>
      props[_$key__unicodeRange___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.unitsPerEm] -->
  @override
  get unitsPerEm => (props[_$key__unitsPerEm___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.unitsPerEm] -->
  @override
  set unitsPerEm(value) => props[_$key__unitsPerEm___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vAlphabetic] -->
  @override
  get vAlphabetic => (props[_$key__vAlphabetic___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vAlphabetic] -->
  @override
  set vAlphabetic(value) => props[_$key__vAlphabetic___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vHanging] -->
  @override
  get vHanging => (props[_$key__vHanging___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vHanging] -->
  @override
  set vHanging(value) => props[_$key__vHanging___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vIdeographic] -->
  @override
  get vIdeographic => (props[_$key__vIdeographic___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vIdeographic] -->
  @override
  set vIdeographic(value) =>
      props[_$key__vIdeographic___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vMathematical] -->
  @override
  get vMathematical =>
      (props[_$key__vMathematical___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vMathematical] -->
  @override
  set vMathematical(value) =>
      props[_$key__vMathematical___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vectorEffect] -->
  @override
  get vectorEffect => (props[_$key__vectorEffect___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vectorEffect] -->
  @override
  set vectorEffect(value) =>
      props[_$key__vectorEffect___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.version] -->
  @override
  get version => (props[_$key__version___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.version] -->
  @override
  set version(value) => props[_$key__version___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vertAdvY] -->
  @override
  get vertAdvY => (props[_$key__vertAdvY___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vertAdvY] -->
  @override
  set vertAdvY(value) => props[_$key__vertAdvY___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vertOriginX] -->
  @override
  get vertOriginX => (props[_$key__vertOriginX___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vertOriginX] -->
  @override
  set vertOriginX(value) => props[_$key__vertOriginX___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.vertOriginY] -->
  @override
  get vertOriginY => (props[_$key__vertOriginY___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.vertOriginY] -->
  @override
  set vertOriginY(value) => props[_$key__vertOriginY___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.viewBox] -->
  @override
  get viewBox => (props[_$key__viewBox___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.viewBox] -->
  @override
  set viewBox(value) => props[_$key__viewBox___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.viewTarget] -->
  @override
  get viewTarget => (props[_$key__viewTarget___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.viewTarget] -->
  @override
  set viewTarget(value) => props[_$key__viewTarget___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.visibility] -->
  @override
  get visibility => (props[_$key__visibility___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.visibility] -->
  @override
  set visibility(value) => props[_$key__visibility___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.widths] -->
  @override
  get widths => (props[_$key__widths___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.widths] -->
  @override
  set widths(value) => props[_$key__widths___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.wordSpacing] -->
  @override
  get wordSpacing => (props[_$key__wordSpacing___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.wordSpacing] -->
  @override
  set wordSpacing(value) => props[_$key__wordSpacing___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.writingMode] -->
  @override
  get writingMode => (props[_$key__writingMode___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.writingMode] -->
  @override
  set writingMode(value) => props[_$key__writingMode___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x] -->
  @override
  get x => (props[_$key__x___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.x] -->
  @override
  set x(value) => props[_$key__x___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x1] -->
  @override
  get x1 => (props[_$key__x1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.x1] -->
  @override
  set x1(value) => props[_$key__x1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x2] -->
  @override
  get x2 => (props[_$key__x2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.x2] -->
  @override
  set x2(value) => props[_$key__x2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xHeight] -->
  @override
  get xHeight => (props[_$key__xHeight___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xHeight] -->
  @override
  set xHeight(value) => props[_$key__xHeight___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkActuate] -->
  @override
  get xlinkActuate => (props[_$key__xlinkActuate___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkActuate] -->
  @override
  set xlinkActuate(value) =>
      props[_$key__xlinkActuate___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkArcrole] -->
  @override
  get xlinkArcrole => (props[_$key__xlinkArcrole___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkArcrole] -->
  @override
  set xlinkArcrole(value) =>
      props[_$key__xlinkArcrole___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkHref] -->
  @override
  get xlinkHref => (props[_$key__xlinkHref___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkHref] -->
  @override
  set xlinkHref(value) => props[_$key__xlinkHref___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkRole] -->
  @override
  get xlinkRole => (props[_$key__xlinkRole___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkRole] -->
  @override
  set xlinkRole(value) => props[_$key__xlinkRole___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkShow] -->
  @override
  get xlinkShow => (props[_$key__xlinkShow___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkShow] -->
  @override
  set xlinkShow(value) => props[_$key__xlinkShow___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkTitle] -->
  @override
  get xlinkTitle => (props[_$key__xlinkTitle___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkTitle] -->
  @override
  set xlinkTitle(value) => props[_$key__xlinkTitle___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkType] -->
  @override
  get xlinkType => (props[_$key__xlinkType___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkType] -->
  @override
  set xlinkType(value) => props[_$key__xlinkType___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlBase] -->
  @override
  get xmlBase => (props[_$key__xmlBase___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xmlBase] -->
  @override
  set xmlBase(value) => props[_$key__xmlBase___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlLang] -->
  @override
  get xmlLang => (props[_$key__xmlLang___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xmlLang] -->
  @override
  set xmlLang(value) => props[_$key__xmlLang___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlSpace] -->
  @override
  get xmlSpace => (props[_$key__xmlSpace___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.xmlSpace] -->
  @override
  set xmlSpace(value) => props[_$key__xmlSpace___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y1] -->
  @override
  get y1 => (props[_$key__y1___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.y1] -->
  @override
  set y1(value) => props[_$key__y1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y2] -->
  @override
  get y2 => (props[_$key__y2___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.y2] -->
  @override
  set y2(value) => props[_$key__y2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y] -->
  @override
  get y => (props[_$key__y___$SvgPropsMixin]) as dynamic;

  /// <!-- Generated from [_$SvgPropsMixin.y] -->
  @override
  set y(value) => props[_$key__y___$SvgPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__htmlIn___$SvgPropsMixin =
      PropDescriptor(_$key__htmlIn___$SvgPropsMixin);
  static const PropDescriptor _$prop__htmlValues___$SvgPropsMixin =
      PropDescriptor(_$key__htmlValues___$SvgPropsMixin);
  static const PropDescriptor _$prop__accumulate___$SvgPropsMixin =
      PropDescriptor(_$key__accumulate___$SvgPropsMixin);
  static const PropDescriptor _$prop__additive___$SvgPropsMixin =
      PropDescriptor(_$key__additive___$SvgPropsMixin);
  static const PropDescriptor _$prop__alignmentBaseline___$SvgPropsMixin =
      PropDescriptor(_$key__alignmentBaseline___$SvgPropsMixin);
  static const PropDescriptor _$prop__allowReorder___$SvgPropsMixin =
      PropDescriptor(_$key__allowReorder___$SvgPropsMixin);
  static const PropDescriptor _$prop__arabicForm___$SvgPropsMixin =
      PropDescriptor(_$key__arabicForm___$SvgPropsMixin);
  static const PropDescriptor _$prop__attributeName___$SvgPropsMixin =
      PropDescriptor(_$key__attributeName___$SvgPropsMixin);
  static const PropDescriptor _$prop__attributeType___$SvgPropsMixin =
      PropDescriptor(_$key__attributeType___$SvgPropsMixin);
  static const PropDescriptor
      _$prop__colorInterpolationFilters___$SvgPropsMixin =
      PropDescriptor(_$key__colorInterpolationFilters___$SvgPropsMixin);
  static const PropDescriptor _$prop__fillRule___$SvgPropsMixin =
      PropDescriptor(_$key__fillRule___$SvgPropsMixin);
  static const PropDescriptor _$prop__filter___$SvgPropsMixin =
      PropDescriptor(_$key__filter___$SvgPropsMixin);
  static const PropDescriptor _$prop__mask___$SvgPropsMixin =
      PropDescriptor(_$key__mask___$SvgPropsMixin);
  static const PropDescriptor _$prop__result___$SvgPropsMixin =
      PropDescriptor(_$key__result___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeLinejoin___$SvgPropsMixin =
      PropDescriptor(_$key__strokeLinejoin___$SvgPropsMixin);
  static const PropDescriptor _$prop__xChannelSelector___$SvgPropsMixin =
      PropDescriptor(_$key__xChannelSelector___$SvgPropsMixin);
  static const PropDescriptor _$prop__xmlns___$SvgPropsMixin =
      PropDescriptor(_$key__xmlns___$SvgPropsMixin);
  static const PropDescriptor _$prop__xmlnsXlink___$SvgPropsMixin =
      PropDescriptor(_$key__xmlnsXlink___$SvgPropsMixin);
  static const PropDescriptor _$prop__yChannelSelector___$SvgPropsMixin =
      PropDescriptor(_$key__yChannelSelector___$SvgPropsMixin);
  static const PropDescriptor _$prop__zoomAndPan___$SvgPropsMixin =
      PropDescriptor(_$key__zoomAndPan___$SvgPropsMixin);
  static const PropDescriptor _$prop__accentHeight___$SvgPropsMixin =
      PropDescriptor(_$key__accentHeight___$SvgPropsMixin);
  static const PropDescriptor _$prop__alphabetic___$SvgPropsMixin =
      PropDescriptor(_$key__alphabetic___$SvgPropsMixin);
  static const PropDescriptor _$prop__amplitude___$SvgPropsMixin =
      PropDescriptor(_$key__amplitude___$SvgPropsMixin);
  static const PropDescriptor _$prop__ascent___$SvgPropsMixin =
      PropDescriptor(_$key__ascent___$SvgPropsMixin);
  static const PropDescriptor _$prop__autoReverse___$SvgPropsMixin =
      PropDescriptor(_$key__autoReverse___$SvgPropsMixin);
  static const PropDescriptor _$prop__azimuth___$SvgPropsMixin =
      PropDescriptor(_$key__azimuth___$SvgPropsMixin);
  static const PropDescriptor _$prop__baseFrequency___$SvgPropsMixin =
      PropDescriptor(_$key__baseFrequency___$SvgPropsMixin);
  static const PropDescriptor _$prop__baseProfile___$SvgPropsMixin =
      PropDescriptor(_$key__baseProfile___$SvgPropsMixin);
  static const PropDescriptor _$prop__baselineShift___$SvgPropsMixin =
      PropDescriptor(_$key__baselineShift___$SvgPropsMixin);
  static const PropDescriptor _$prop__bbox___$SvgPropsMixin =
      PropDescriptor(_$key__bbox___$SvgPropsMixin);
  static const PropDescriptor _$prop__begin___$SvgPropsMixin =
      PropDescriptor(_$key__begin___$SvgPropsMixin);
  static const PropDescriptor _$prop__bias___$SvgPropsMixin =
      PropDescriptor(_$key__bias___$SvgPropsMixin);
  static const PropDescriptor _$prop__by___$SvgPropsMixin =
      PropDescriptor(_$key__by___$SvgPropsMixin);
  static const PropDescriptor _$prop__calcMode___$SvgPropsMixin =
      PropDescriptor(_$key__calcMode___$SvgPropsMixin);
  static const PropDescriptor _$prop__capHeight___$SvgPropsMixin =
      PropDescriptor(_$key__capHeight___$SvgPropsMixin);
  static const PropDescriptor _$prop__clip___$SvgPropsMixin =
      PropDescriptor(_$key__clip___$SvgPropsMixin);
  static const PropDescriptor _$prop__clipPath___$SvgPropsMixin =
      PropDescriptor(_$key__clipPath___$SvgPropsMixin);
  static const PropDescriptor _$prop__clipPathUnits___$SvgPropsMixin =
      PropDescriptor(_$key__clipPathUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__clipRule___$SvgPropsMixin =
      PropDescriptor(_$key__clipRule___$SvgPropsMixin);
  static const PropDescriptor _$prop__colorInterpolation___$SvgPropsMixin =
      PropDescriptor(_$key__colorInterpolation___$SvgPropsMixin);
  static const PropDescriptor _$prop__colorProfile___$SvgPropsMixin =
      PropDescriptor(_$key__colorProfile___$SvgPropsMixin);
  static const PropDescriptor _$prop__colorRendering___$SvgPropsMixin =
      PropDescriptor(_$key__colorRendering___$SvgPropsMixin);
  static const PropDescriptor _$prop__contentScriptType___$SvgPropsMixin =
      PropDescriptor(_$key__contentScriptType___$SvgPropsMixin);
  static const PropDescriptor _$prop__contentStyleType___$SvgPropsMixin =
      PropDescriptor(_$key__contentStyleType___$SvgPropsMixin);
  static const PropDescriptor _$prop__cursor___$SvgPropsMixin =
      PropDescriptor(_$key__cursor___$SvgPropsMixin);
  static const PropDescriptor _$prop__cx___$SvgPropsMixin =
      PropDescriptor(_$key__cx___$SvgPropsMixin);
  static const PropDescriptor _$prop__cy___$SvgPropsMixin =
      PropDescriptor(_$key__cy___$SvgPropsMixin);
  static const PropDescriptor _$prop__d___$SvgPropsMixin =
      PropDescriptor(_$key__d___$SvgPropsMixin);
  static const PropDescriptor _$prop__decelerate___$SvgPropsMixin =
      PropDescriptor(_$key__decelerate___$SvgPropsMixin);
  static const PropDescriptor _$prop__descent___$SvgPropsMixin =
      PropDescriptor(_$key__descent___$SvgPropsMixin);
  static const PropDescriptor _$prop__diffuseConstant___$SvgPropsMixin =
      PropDescriptor(_$key__diffuseConstant___$SvgPropsMixin);
  static const PropDescriptor _$prop__direction___$SvgPropsMixin =
      PropDescriptor(_$key__direction___$SvgPropsMixin);
  static const PropDescriptor _$prop__display___$SvgPropsMixin =
      PropDescriptor(_$key__display___$SvgPropsMixin);
  static const PropDescriptor _$prop__divisor___$SvgPropsMixin =
      PropDescriptor(_$key__divisor___$SvgPropsMixin);
  static const PropDescriptor _$prop__dominantBaseline___$SvgPropsMixin =
      PropDescriptor(_$key__dominantBaseline___$SvgPropsMixin);
  static const PropDescriptor _$prop__dur___$SvgPropsMixin =
      PropDescriptor(_$key__dur___$SvgPropsMixin);
  static const PropDescriptor _$prop__dx___$SvgPropsMixin =
      PropDescriptor(_$key__dx___$SvgPropsMixin);
  static const PropDescriptor _$prop__dy___$SvgPropsMixin =
      PropDescriptor(_$key__dy___$SvgPropsMixin);
  static const PropDescriptor _$prop__edgeMode___$SvgPropsMixin =
      PropDescriptor(_$key__edgeMode___$SvgPropsMixin);
  static const PropDescriptor _$prop__elevation___$SvgPropsMixin =
      PropDescriptor(_$key__elevation___$SvgPropsMixin);
  static const PropDescriptor _$prop__enableBackground___$SvgPropsMixin =
      PropDescriptor(_$key__enableBackground___$SvgPropsMixin);
  static const PropDescriptor _$prop__end___$SvgPropsMixin =
      PropDescriptor(_$key__end___$SvgPropsMixin);
  static const PropDescriptor _$prop__exponent___$SvgPropsMixin =
      PropDescriptor(_$key__exponent___$SvgPropsMixin);
  static const PropDescriptor
      _$prop__externalResourcesRequired___$SvgPropsMixin =
      PropDescriptor(_$key__externalResourcesRequired___$SvgPropsMixin);
  static const PropDescriptor _$prop__fill___$SvgPropsMixin =
      PropDescriptor(_$key__fill___$SvgPropsMixin);
  static const PropDescriptor _$prop__fillOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__fillOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__filterRes___$SvgPropsMixin =
      PropDescriptor(_$key__filterRes___$SvgPropsMixin);
  static const PropDescriptor _$prop__filterUnits___$SvgPropsMixin =
      PropDescriptor(_$key__filterUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__floodColor___$SvgPropsMixin =
      PropDescriptor(_$key__floodColor___$SvgPropsMixin);
  static const PropDescriptor _$prop__floodOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__floodOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__focusable___$SvgPropsMixin =
      PropDescriptor(_$key__focusable___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontFamily___$SvgPropsMixin =
      PropDescriptor(_$key__fontFamily___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontSize___$SvgPropsMixin =
      PropDescriptor(_$key__fontSize___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontSizeAdjust___$SvgPropsMixin =
      PropDescriptor(_$key__fontSizeAdjust___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontStretch___$SvgPropsMixin =
      PropDescriptor(_$key__fontStretch___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontStyle___$SvgPropsMixin =
      PropDescriptor(_$key__fontStyle___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontVariant___$SvgPropsMixin =
      PropDescriptor(_$key__fontVariant___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontWeight___$SvgPropsMixin =
      PropDescriptor(_$key__fontWeight___$SvgPropsMixin);
  static const PropDescriptor _$prop__format___$SvgPropsMixin =
      PropDescriptor(_$key__format___$SvgPropsMixin);
  static const PropDescriptor _$prop__from___$SvgPropsMixin =
      PropDescriptor(_$key__from___$SvgPropsMixin);
  static const PropDescriptor _$prop__fx___$SvgPropsMixin =
      PropDescriptor(_$key__fx___$SvgPropsMixin);
  static const PropDescriptor _$prop__fy___$SvgPropsMixin =
      PropDescriptor(_$key__fy___$SvgPropsMixin);
  static const PropDescriptor _$prop__g1___$SvgPropsMixin =
      PropDescriptor(_$key__g1___$SvgPropsMixin);
  static const PropDescriptor _$prop__g2___$SvgPropsMixin =
      PropDescriptor(_$key__g2___$SvgPropsMixin);
  static const PropDescriptor _$prop__glyphName___$SvgPropsMixin =
      PropDescriptor(_$key__glyphName___$SvgPropsMixin);
  static const PropDescriptor
      _$prop__glyphOrientationHorizontal___$SvgPropsMixin =
      PropDescriptor(_$key__glyphOrientationHorizontal___$SvgPropsMixin);
  static const PropDescriptor
      _$prop__glyphOrientationVertical___$SvgPropsMixin =
      PropDescriptor(_$key__glyphOrientationVertical___$SvgPropsMixin);
  static const PropDescriptor _$prop__glyphRef___$SvgPropsMixin =
      PropDescriptor(_$key__glyphRef___$SvgPropsMixin);
  static const PropDescriptor _$prop__gradientTransform___$SvgPropsMixin =
      PropDescriptor(_$key__gradientTransform___$SvgPropsMixin);
  static const PropDescriptor _$prop__gradientUnits___$SvgPropsMixin =
      PropDescriptor(_$key__gradientUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__hanging___$SvgPropsMixin =
      PropDescriptor(_$key__hanging___$SvgPropsMixin);
  static const PropDescriptor _$prop__horizAdvX___$SvgPropsMixin =
      PropDescriptor(_$key__horizAdvX___$SvgPropsMixin);
  static const PropDescriptor _$prop__horizOriginX___$SvgPropsMixin =
      PropDescriptor(_$key__horizOriginX___$SvgPropsMixin);
  static const PropDescriptor _$prop__ideographic___$SvgPropsMixin =
      PropDescriptor(_$key__ideographic___$SvgPropsMixin);
  static const PropDescriptor _$prop__imageRendering___$SvgPropsMixin =
      PropDescriptor(_$key__imageRendering___$SvgPropsMixin);
  static const PropDescriptor _$prop__in2___$SvgPropsMixin =
      PropDescriptor(_$key__in2___$SvgPropsMixin);
  static const PropDescriptor _$prop__intercept___$SvgPropsMixin =
      PropDescriptor(_$key__intercept___$SvgPropsMixin);
  static const PropDescriptor _$prop__k___$SvgPropsMixin =
      PropDescriptor(_$key__k___$SvgPropsMixin);
  static const PropDescriptor _$prop__k1___$SvgPropsMixin =
      PropDescriptor(_$key__k1___$SvgPropsMixin);
  static const PropDescriptor _$prop__k2___$SvgPropsMixin =
      PropDescriptor(_$key__k2___$SvgPropsMixin);
  static const PropDescriptor _$prop__k3___$SvgPropsMixin =
      PropDescriptor(_$key__k3___$SvgPropsMixin);
  static const PropDescriptor _$prop__k4___$SvgPropsMixin =
      PropDescriptor(_$key__k4___$SvgPropsMixin);
  static const PropDescriptor _$prop__kernelMatrix___$SvgPropsMixin =
      PropDescriptor(_$key__kernelMatrix___$SvgPropsMixin);
  static const PropDescriptor _$prop__kernelUnitLength___$SvgPropsMixin =
      PropDescriptor(_$key__kernelUnitLength___$SvgPropsMixin);
  static const PropDescriptor _$prop__kerning___$SvgPropsMixin =
      PropDescriptor(_$key__kerning___$SvgPropsMixin);
  static const PropDescriptor _$prop__keyPoints___$SvgPropsMixin =
      PropDescriptor(_$key__keyPoints___$SvgPropsMixin);
  static const PropDescriptor _$prop__keySplines___$SvgPropsMixin =
      PropDescriptor(_$key__keySplines___$SvgPropsMixin);
  static const PropDescriptor _$prop__keyTimes___$SvgPropsMixin =
      PropDescriptor(_$key__keyTimes___$SvgPropsMixin);
  static const PropDescriptor _$prop__lengthAdjust___$SvgPropsMixin =
      PropDescriptor(_$key__lengthAdjust___$SvgPropsMixin);
  static const PropDescriptor _$prop__letterSpacing___$SvgPropsMixin =
      PropDescriptor(_$key__letterSpacing___$SvgPropsMixin);
  static const PropDescriptor _$prop__lightingColor___$SvgPropsMixin =
      PropDescriptor(_$key__lightingColor___$SvgPropsMixin);
  static const PropDescriptor _$prop__limitingConeAngle___$SvgPropsMixin =
      PropDescriptor(_$key__limitingConeAngle___$SvgPropsMixin);
  static const PropDescriptor _$prop__local___$SvgPropsMixin =
      PropDescriptor(_$key__local___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerEnd___$SvgPropsMixin =
      PropDescriptor(_$key__markerEnd___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerHeight___$SvgPropsMixin =
      PropDescriptor(_$key__markerHeight___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerMid___$SvgPropsMixin =
      PropDescriptor(_$key__markerMid___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerStart___$SvgPropsMixin =
      PropDescriptor(_$key__markerStart___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerUnits___$SvgPropsMixin =
      PropDescriptor(_$key__markerUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerWidth___$SvgPropsMixin =
      PropDescriptor(_$key__markerWidth___$SvgPropsMixin);
  static const PropDescriptor _$prop__maskContentUnits___$SvgPropsMixin =
      PropDescriptor(_$key__maskContentUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__maskUnits___$SvgPropsMixin =
      PropDescriptor(_$key__maskUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__mathematical___$SvgPropsMixin =
      PropDescriptor(_$key__mathematical___$SvgPropsMixin);
  static const PropDescriptor _$prop__mode___$SvgPropsMixin =
      PropDescriptor(_$key__mode___$SvgPropsMixin);
  static const PropDescriptor _$prop__numOctaves___$SvgPropsMixin =
      PropDescriptor(_$key__numOctaves___$SvgPropsMixin);
  static const PropDescriptor _$prop__offset___$SvgPropsMixin =
      PropDescriptor(_$key__offset___$SvgPropsMixin);
  static const PropDescriptor _$prop__opacity___$SvgPropsMixin =
      PropDescriptor(_$key__opacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__operator___$SvgPropsMixin =
      PropDescriptor(_$key__operator___$SvgPropsMixin);
  static const PropDescriptor _$prop__order___$SvgPropsMixin =
      PropDescriptor(_$key__order___$SvgPropsMixin);
  static const PropDescriptor _$prop__orient___$SvgPropsMixin =
      PropDescriptor(_$key__orient___$SvgPropsMixin);
  static const PropDescriptor _$prop__orientation___$SvgPropsMixin =
      PropDescriptor(_$key__orientation___$SvgPropsMixin);
  static const PropDescriptor _$prop__origin___$SvgPropsMixin =
      PropDescriptor(_$key__origin___$SvgPropsMixin);
  static const PropDescriptor _$prop__overflow___$SvgPropsMixin =
      PropDescriptor(_$key__overflow___$SvgPropsMixin);
  static const PropDescriptor _$prop__overlinePosition___$SvgPropsMixin =
      PropDescriptor(_$key__overlinePosition___$SvgPropsMixin);
  static const PropDescriptor _$prop__overlineThickness___$SvgPropsMixin =
      PropDescriptor(_$key__overlineThickness___$SvgPropsMixin);
  static const PropDescriptor _$prop__paintOrder___$SvgPropsMixin =
      PropDescriptor(_$key__paintOrder___$SvgPropsMixin);
  static const PropDescriptor _$prop__panose1___$SvgPropsMixin =
      PropDescriptor(_$key__panose1___$SvgPropsMixin);
  static const PropDescriptor _$prop__pathLength___$SvgPropsMixin =
      PropDescriptor(_$key__pathLength___$SvgPropsMixin);
  static const PropDescriptor _$prop__patternContentUnits___$SvgPropsMixin =
      PropDescriptor(_$key__patternContentUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__patternTransform___$SvgPropsMixin =
      PropDescriptor(_$key__patternTransform___$SvgPropsMixin);
  static const PropDescriptor _$prop__patternUnits___$SvgPropsMixin =
      PropDescriptor(_$key__patternUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__pointerEvents___$SvgPropsMixin =
      PropDescriptor(_$key__pointerEvents___$SvgPropsMixin);
  static const PropDescriptor _$prop__points___$SvgPropsMixin =
      PropDescriptor(_$key__points___$SvgPropsMixin);
  static const PropDescriptor _$prop__pointsAtX___$SvgPropsMixin =
      PropDescriptor(_$key__pointsAtX___$SvgPropsMixin);
  static const PropDescriptor _$prop__pointsAtY___$SvgPropsMixin =
      PropDescriptor(_$key__pointsAtY___$SvgPropsMixin);
  static const PropDescriptor _$prop__pointsAtZ___$SvgPropsMixin =
      PropDescriptor(_$key__pointsAtZ___$SvgPropsMixin);
  static const PropDescriptor _$prop__preserveAlpha___$SvgPropsMixin =
      PropDescriptor(_$key__preserveAlpha___$SvgPropsMixin);
  static const PropDescriptor _$prop__preserveAspectRatio___$SvgPropsMixin =
      PropDescriptor(_$key__preserveAspectRatio___$SvgPropsMixin);
  static const PropDescriptor _$prop__primitiveUnits___$SvgPropsMixin =
      PropDescriptor(_$key__primitiveUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__r___$SvgPropsMixin =
      PropDescriptor(_$key__r___$SvgPropsMixin);
  static const PropDescriptor _$prop__radius___$SvgPropsMixin =
      PropDescriptor(_$key__radius___$SvgPropsMixin);
  static const PropDescriptor _$prop__refX___$SvgPropsMixin =
      PropDescriptor(_$key__refX___$SvgPropsMixin);
  static const PropDescriptor _$prop__refY___$SvgPropsMixin =
      PropDescriptor(_$key__refY___$SvgPropsMixin);
  static const PropDescriptor _$prop__renderingIntent___$SvgPropsMixin =
      PropDescriptor(_$key__renderingIntent___$SvgPropsMixin);
  static const PropDescriptor _$prop__repeatCount___$SvgPropsMixin =
      PropDescriptor(_$key__repeatCount___$SvgPropsMixin);
  static const PropDescriptor _$prop__repeatDur___$SvgPropsMixin =
      PropDescriptor(_$key__repeatDur___$SvgPropsMixin);
  static const PropDescriptor _$prop__requiredExtensions___$SvgPropsMixin =
      PropDescriptor(_$key__requiredExtensions___$SvgPropsMixin);
  static const PropDescriptor _$prop__requiredFeatures___$SvgPropsMixin =
      PropDescriptor(_$key__requiredFeatures___$SvgPropsMixin);
  static const PropDescriptor _$prop__restart___$SvgPropsMixin =
      PropDescriptor(_$key__restart___$SvgPropsMixin);
  static const PropDescriptor _$prop__rotate___$SvgPropsMixin =
      PropDescriptor(_$key__rotate___$SvgPropsMixin);
  static const PropDescriptor _$prop__rx___$SvgPropsMixin =
      PropDescriptor(_$key__rx___$SvgPropsMixin);
  static const PropDescriptor _$prop__ry___$SvgPropsMixin =
      PropDescriptor(_$key__ry___$SvgPropsMixin);
  static const PropDescriptor _$prop__scale___$SvgPropsMixin =
      PropDescriptor(_$key__scale___$SvgPropsMixin);
  static const PropDescriptor _$prop__seed___$SvgPropsMixin =
      PropDescriptor(_$key__seed___$SvgPropsMixin);
  static const PropDescriptor _$prop__shapeRendering___$SvgPropsMixin =
      PropDescriptor(_$key__shapeRendering___$SvgPropsMixin);
  static const PropDescriptor _$prop__slope___$SvgPropsMixin =
      PropDescriptor(_$key__slope___$SvgPropsMixin);
  static const PropDescriptor _$prop__spacing___$SvgPropsMixin =
      PropDescriptor(_$key__spacing___$SvgPropsMixin);
  static const PropDescriptor _$prop__specularConstant___$SvgPropsMixin =
      PropDescriptor(_$key__specularConstant___$SvgPropsMixin);
  static const PropDescriptor _$prop__specularExponent___$SvgPropsMixin =
      PropDescriptor(_$key__specularExponent___$SvgPropsMixin);
  static const PropDescriptor _$prop__speed___$SvgPropsMixin =
      PropDescriptor(_$key__speed___$SvgPropsMixin);
  static const PropDescriptor _$prop__spreadMethod___$SvgPropsMixin =
      PropDescriptor(_$key__spreadMethod___$SvgPropsMixin);
  static const PropDescriptor _$prop__startOffset___$SvgPropsMixin =
      PropDescriptor(_$key__startOffset___$SvgPropsMixin);
  static const PropDescriptor _$prop__stdDeviation___$SvgPropsMixin =
      PropDescriptor(_$key__stdDeviation___$SvgPropsMixin);
  static const PropDescriptor _$prop__stemh___$SvgPropsMixin =
      PropDescriptor(_$key__stemh___$SvgPropsMixin);
  static const PropDescriptor _$prop__stemv___$SvgPropsMixin =
      PropDescriptor(_$key__stemv___$SvgPropsMixin);
  static const PropDescriptor _$prop__stitchTiles___$SvgPropsMixin =
      PropDescriptor(_$key__stitchTiles___$SvgPropsMixin);
  static const PropDescriptor _$prop__stopColor___$SvgPropsMixin =
      PropDescriptor(_$key__stopColor___$SvgPropsMixin);
  static const PropDescriptor _$prop__stopOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__stopOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__strikethroughPosition___$SvgPropsMixin =
      PropDescriptor(_$key__strikethroughPosition___$SvgPropsMixin);
  static const PropDescriptor _$prop__strikethroughThickness___$SvgPropsMixin =
      PropDescriptor(_$key__strikethroughThickness___$SvgPropsMixin);
  static const PropDescriptor _$prop__string___$SvgPropsMixin =
      PropDescriptor(_$key__string___$SvgPropsMixin);
  static const PropDescriptor _$prop__stroke___$SvgPropsMixin =
      PropDescriptor(_$key__stroke___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeDasharray___$SvgPropsMixin =
      PropDescriptor(_$key__strokeDasharray___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeDashoffset___$SvgPropsMixin =
      PropDescriptor(_$key__strokeDashoffset___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeLinecap___$SvgPropsMixin =
      PropDescriptor(_$key__strokeLinecap___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeMiterlimit___$SvgPropsMixin =
      PropDescriptor(_$key__strokeMiterlimit___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__strokeOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeWidth___$SvgPropsMixin =
      PropDescriptor(_$key__strokeWidth___$SvgPropsMixin);
  static const PropDescriptor _$prop__surfaceScale___$SvgPropsMixin =
      PropDescriptor(_$key__surfaceScale___$SvgPropsMixin);
  static const PropDescriptor _$prop__systemLanguage___$SvgPropsMixin =
      PropDescriptor(_$key__systemLanguage___$SvgPropsMixin);
  static const PropDescriptor _$prop__tableValues___$SvgPropsMixin =
      PropDescriptor(_$key__tableValues___$SvgPropsMixin);
  static const PropDescriptor _$prop__targetX___$SvgPropsMixin =
      PropDescriptor(_$key__targetX___$SvgPropsMixin);
  static const PropDescriptor _$prop__targetY___$SvgPropsMixin =
      PropDescriptor(_$key__targetY___$SvgPropsMixin);
  static const PropDescriptor _$prop__textAnchor___$SvgPropsMixin =
      PropDescriptor(_$key__textAnchor___$SvgPropsMixin);
  static const PropDescriptor _$prop__textDecoration___$SvgPropsMixin =
      PropDescriptor(_$key__textDecoration___$SvgPropsMixin);
  static const PropDescriptor _$prop__textLength___$SvgPropsMixin =
      PropDescriptor(_$key__textLength___$SvgPropsMixin);
  static const PropDescriptor _$prop__textRendering___$SvgPropsMixin =
      PropDescriptor(_$key__textRendering___$SvgPropsMixin);
  static const PropDescriptor _$prop__to___$SvgPropsMixin =
      PropDescriptor(_$key__to___$SvgPropsMixin);
  static const PropDescriptor _$prop__transform___$SvgPropsMixin =
      PropDescriptor(_$key__transform___$SvgPropsMixin);
  static const PropDescriptor _$prop__u1___$SvgPropsMixin =
      PropDescriptor(_$key__u1___$SvgPropsMixin);
  static const PropDescriptor _$prop__u2___$SvgPropsMixin =
      PropDescriptor(_$key__u2___$SvgPropsMixin);
  static const PropDescriptor _$prop__underlinePosition___$SvgPropsMixin =
      PropDescriptor(_$key__underlinePosition___$SvgPropsMixin);
  static const PropDescriptor _$prop__underlineThickness___$SvgPropsMixin =
      PropDescriptor(_$key__underlineThickness___$SvgPropsMixin);
  static const PropDescriptor _$prop__unicode___$SvgPropsMixin =
      PropDescriptor(_$key__unicode___$SvgPropsMixin);
  static const PropDescriptor _$prop__unicodeBidi___$SvgPropsMixin =
      PropDescriptor(_$key__unicodeBidi___$SvgPropsMixin);
  static const PropDescriptor _$prop__unicodeRange___$SvgPropsMixin =
      PropDescriptor(_$key__unicodeRange___$SvgPropsMixin);
  static const PropDescriptor _$prop__unitsPerEm___$SvgPropsMixin =
      PropDescriptor(_$key__unitsPerEm___$SvgPropsMixin);
  static const PropDescriptor _$prop__vAlphabetic___$SvgPropsMixin =
      PropDescriptor(_$key__vAlphabetic___$SvgPropsMixin);
  static const PropDescriptor _$prop__vHanging___$SvgPropsMixin =
      PropDescriptor(_$key__vHanging___$SvgPropsMixin);
  static const PropDescriptor _$prop__vIdeographic___$SvgPropsMixin =
      PropDescriptor(_$key__vIdeographic___$SvgPropsMixin);
  static const PropDescriptor _$prop__vMathematical___$SvgPropsMixin =
      PropDescriptor(_$key__vMathematical___$SvgPropsMixin);
  static const PropDescriptor _$prop__vectorEffect___$SvgPropsMixin =
      PropDescriptor(_$key__vectorEffect___$SvgPropsMixin);
  static const PropDescriptor _$prop__version___$SvgPropsMixin =
      PropDescriptor(_$key__version___$SvgPropsMixin);
  static const PropDescriptor _$prop__vertAdvY___$SvgPropsMixin =
      PropDescriptor(_$key__vertAdvY___$SvgPropsMixin);
  static const PropDescriptor _$prop__vertOriginX___$SvgPropsMixin =
      PropDescriptor(_$key__vertOriginX___$SvgPropsMixin);
  static const PropDescriptor _$prop__vertOriginY___$SvgPropsMixin =
      PropDescriptor(_$key__vertOriginY___$SvgPropsMixin);
  static const PropDescriptor _$prop__viewBox___$SvgPropsMixin =
      PropDescriptor(_$key__viewBox___$SvgPropsMixin);
  static const PropDescriptor _$prop__viewTarget___$SvgPropsMixin =
      PropDescriptor(_$key__viewTarget___$SvgPropsMixin);
  static const PropDescriptor _$prop__visibility___$SvgPropsMixin =
      PropDescriptor(_$key__visibility___$SvgPropsMixin);
  static const PropDescriptor _$prop__widths___$SvgPropsMixin =
      PropDescriptor(_$key__widths___$SvgPropsMixin);
  static const PropDescriptor _$prop__wordSpacing___$SvgPropsMixin =
      PropDescriptor(_$key__wordSpacing___$SvgPropsMixin);
  static const PropDescriptor _$prop__writingMode___$SvgPropsMixin =
      PropDescriptor(_$key__writingMode___$SvgPropsMixin);
  static const PropDescriptor _$prop__x___$SvgPropsMixin =
      PropDescriptor(_$key__x___$SvgPropsMixin);
  static const PropDescriptor _$prop__x1___$SvgPropsMixin =
      PropDescriptor(_$key__x1___$SvgPropsMixin);
  static const PropDescriptor _$prop__x2___$SvgPropsMixin =
      PropDescriptor(_$key__x2___$SvgPropsMixin);
  static const PropDescriptor _$prop__xHeight___$SvgPropsMixin =
      PropDescriptor(_$key__xHeight___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkActuate___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkActuate___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkArcrole___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkArcrole___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkHref___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkHref___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkRole___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkRole___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkShow___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkShow___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkTitle___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkTitle___$SvgPropsMixin);
  static const PropDescriptor _$prop__xlinkType___$SvgPropsMixin =
      PropDescriptor(_$key__xlinkType___$SvgPropsMixin);
  static const PropDescriptor _$prop__xmlBase___$SvgPropsMixin =
      PropDescriptor(_$key__xmlBase___$SvgPropsMixin);
  static const PropDescriptor _$prop__xmlLang___$SvgPropsMixin =
      PropDescriptor(_$key__xmlLang___$SvgPropsMixin);
  static const PropDescriptor _$prop__xmlSpace___$SvgPropsMixin =
      PropDescriptor(_$key__xmlSpace___$SvgPropsMixin);
  static const PropDescriptor _$prop__y1___$SvgPropsMixin =
      PropDescriptor(_$key__y1___$SvgPropsMixin);
  static const PropDescriptor _$prop__y2___$SvgPropsMixin =
      PropDescriptor(_$key__y2___$SvgPropsMixin);
  static const PropDescriptor _$prop__y___$SvgPropsMixin =
      PropDescriptor(_$key__y___$SvgPropsMixin);
  static const String _$key__htmlIn___$SvgPropsMixin = 'in';
  static const String _$key__htmlValues___$SvgPropsMixin = 'values';
  static const String _$key__accumulate___$SvgPropsMixin = 'accumulate';
  static const String _$key__additive___$SvgPropsMixin = 'additive';
  static const String _$key__alignmentBaseline___$SvgPropsMixin =
      'alignmentBaseline';
  static const String _$key__allowReorder___$SvgPropsMixin = 'allowReorder';
  static const String _$key__arabicForm___$SvgPropsMixin = 'arabicForm';
  static const String _$key__attributeName___$SvgPropsMixin = 'attributeName';
  static const String _$key__attributeType___$SvgPropsMixin = 'attributeType';
  static const String _$key__colorInterpolationFilters___$SvgPropsMixin =
      'colorInterpolationFilters';
  static const String _$key__fillRule___$SvgPropsMixin = 'fillRule';
  static const String _$key__filter___$SvgPropsMixin = 'filter';
  static const String _$key__mask___$SvgPropsMixin = 'mask';
  static const String _$key__result___$SvgPropsMixin = 'result';
  static const String _$key__strokeLinejoin___$SvgPropsMixin = 'strokeLinejoin';
  static const String _$key__xChannelSelector___$SvgPropsMixin =
      'xChannelSelector';
  static const String _$key__xmlns___$SvgPropsMixin = 'xmlns';
  static const String _$key__xmlnsXlink___$SvgPropsMixin = 'xmlnsXlink';
  static const String _$key__yChannelSelector___$SvgPropsMixin =
      'yChannelSelector';
  static const String _$key__zoomAndPan___$SvgPropsMixin = 'zoomAndPan';
  static const String _$key__accentHeight___$SvgPropsMixin = 'accentHeight';
  static const String _$key__alphabetic___$SvgPropsMixin = 'alphabetic';
  static const String _$key__amplitude___$SvgPropsMixin = 'amplitude';
  static const String _$key__ascent___$SvgPropsMixin = 'ascent';
  static const String _$key__autoReverse___$SvgPropsMixin = 'autoReverse';
  static const String _$key__azimuth___$SvgPropsMixin = 'azimuth';
  static const String _$key__baseFrequency___$SvgPropsMixin = 'baseFrequency';
  static const String _$key__baseProfile___$SvgPropsMixin = 'baseProfile';
  static const String _$key__baselineShift___$SvgPropsMixin = 'baselineShift';
  static const String _$key__bbox___$SvgPropsMixin = 'bbox';
  static const String _$key__begin___$SvgPropsMixin = 'begin';
  static const String _$key__bias___$SvgPropsMixin = 'bias';
  static const String _$key__by___$SvgPropsMixin = 'by';
  static const String _$key__calcMode___$SvgPropsMixin = 'calcMode';
  static const String _$key__capHeight___$SvgPropsMixin = 'capHeight';
  static const String _$key__clip___$SvgPropsMixin = 'clip';
  static const String _$key__clipPath___$SvgPropsMixin = 'clipPath';
  static const String _$key__clipPathUnits___$SvgPropsMixin = 'clipPathUnits';
  static const String _$key__clipRule___$SvgPropsMixin = 'clipRule';
  static const String _$key__colorInterpolation___$SvgPropsMixin =
      'colorInterpolation';
  static const String _$key__colorProfile___$SvgPropsMixin = 'colorProfile';
  static const String _$key__colorRendering___$SvgPropsMixin = 'colorRendering';
  static const String _$key__contentScriptType___$SvgPropsMixin =
      'contentScriptType';
  static const String _$key__contentStyleType___$SvgPropsMixin =
      'contentStyleType';
  static const String _$key__cursor___$SvgPropsMixin = 'cursor';
  static const String _$key__cx___$SvgPropsMixin = 'cx';
  static const String _$key__cy___$SvgPropsMixin = 'cy';
  static const String _$key__d___$SvgPropsMixin = 'd';
  static const String _$key__decelerate___$SvgPropsMixin = 'decelerate';
  static const String _$key__descent___$SvgPropsMixin = 'descent';
  static const String _$key__diffuseConstant___$SvgPropsMixin =
      'diffuseConstant';
  static const String _$key__direction___$SvgPropsMixin = 'direction';
  static const String _$key__display___$SvgPropsMixin = 'display';
  static const String _$key__divisor___$SvgPropsMixin = 'divisor';
  static const String _$key__dominantBaseline___$SvgPropsMixin =
      'dominantBaseline';
  static const String _$key__dur___$SvgPropsMixin = 'dur';
  static const String _$key__dx___$SvgPropsMixin = 'dx';
  static const String _$key__dy___$SvgPropsMixin = 'dy';
  static const String _$key__edgeMode___$SvgPropsMixin = 'edgeMode';
  static const String _$key__elevation___$SvgPropsMixin = 'elevation';
  static const String _$key__enableBackground___$SvgPropsMixin =
      'enableBackground';
  static const String _$key__end___$SvgPropsMixin = 'end';
  static const String _$key__exponent___$SvgPropsMixin = 'exponent';
  static const String _$key__externalResourcesRequired___$SvgPropsMixin =
      'externalResourcesRequired';
  static const String _$key__fill___$SvgPropsMixin = 'fill';
  static const String _$key__fillOpacity___$SvgPropsMixin = 'fillOpacity';
  static const String _$key__filterRes___$SvgPropsMixin = 'filterRes';
  static const String _$key__filterUnits___$SvgPropsMixin = 'filterUnits';
  static const String _$key__floodColor___$SvgPropsMixin = 'floodColor';
  static const String _$key__floodOpacity___$SvgPropsMixin = 'floodOpacity';
  static const String _$key__focusable___$SvgPropsMixin = 'focusable';
  static const String _$key__fontFamily___$SvgPropsMixin = 'fontFamily';
  static const String _$key__fontSize___$SvgPropsMixin = 'fontSize';
  static const String _$key__fontSizeAdjust___$SvgPropsMixin = 'fontSizeAdjust';
  static const String _$key__fontStretch___$SvgPropsMixin = 'fontStretch';
  static const String _$key__fontStyle___$SvgPropsMixin = 'fontStyle';
  static const String _$key__fontVariant___$SvgPropsMixin = 'fontVariant';
  static const String _$key__fontWeight___$SvgPropsMixin = 'fontWeight';
  static const String _$key__format___$SvgPropsMixin = 'format';
  static const String _$key__from___$SvgPropsMixin = 'from';
  static const String _$key__fx___$SvgPropsMixin = 'fx';
  static const String _$key__fy___$SvgPropsMixin = 'fy';
  static const String _$key__g1___$SvgPropsMixin = 'g1';
  static const String _$key__g2___$SvgPropsMixin = 'g2';
  static const String _$key__glyphName___$SvgPropsMixin = 'glyphName';
  static const String _$key__glyphOrientationHorizontal___$SvgPropsMixin =
      'glyphOrientationHorizontal';
  static const String _$key__glyphOrientationVertical___$SvgPropsMixin =
      'glyphOrientationVertical';
  static const String _$key__glyphRef___$SvgPropsMixin = 'glyphRef';
  static const String _$key__gradientTransform___$SvgPropsMixin =
      'gradientTransform';
  static const String _$key__gradientUnits___$SvgPropsMixin = 'gradientUnits';
  static const String _$key__hanging___$SvgPropsMixin = 'hanging';
  static const String _$key__horizAdvX___$SvgPropsMixin = 'horizAdvX';
  static const String _$key__horizOriginX___$SvgPropsMixin = 'horizOriginX';
  static const String _$key__ideographic___$SvgPropsMixin = 'ideographic';
  static const String _$key__imageRendering___$SvgPropsMixin = 'imageRendering';
  static const String _$key__in2___$SvgPropsMixin = 'in2';
  static const String _$key__intercept___$SvgPropsMixin = 'intercept';
  static const String _$key__k___$SvgPropsMixin = 'k';
  static const String _$key__k1___$SvgPropsMixin = 'k1';
  static const String _$key__k2___$SvgPropsMixin = 'k2';
  static const String _$key__k3___$SvgPropsMixin = 'k3';
  static const String _$key__k4___$SvgPropsMixin = 'k4';
  static const String _$key__kernelMatrix___$SvgPropsMixin = 'kernelMatrix';
  static const String _$key__kernelUnitLength___$SvgPropsMixin =
      'kernelUnitLength';
  static const String _$key__kerning___$SvgPropsMixin = 'kerning';
  static const String _$key__keyPoints___$SvgPropsMixin = 'keyPoints';
  static const String _$key__keySplines___$SvgPropsMixin = 'keySplines';
  static const String _$key__keyTimes___$SvgPropsMixin = 'keyTimes';
  static const String _$key__lengthAdjust___$SvgPropsMixin = 'lengthAdjust';
  static const String _$key__letterSpacing___$SvgPropsMixin = 'letterSpacing';
  static const String _$key__lightingColor___$SvgPropsMixin = 'lightingColor';
  static const String _$key__limitingConeAngle___$SvgPropsMixin =
      'limitingConeAngle';
  static const String _$key__local___$SvgPropsMixin = 'local';
  static const String _$key__markerEnd___$SvgPropsMixin = 'markerEnd';
  static const String _$key__markerHeight___$SvgPropsMixin = 'markerHeight';
  static const String _$key__markerMid___$SvgPropsMixin = 'markerMid';
  static const String _$key__markerStart___$SvgPropsMixin = 'markerStart';
  static const String _$key__markerUnits___$SvgPropsMixin = 'markerUnits';
  static const String _$key__markerWidth___$SvgPropsMixin = 'markerWidth';
  static const String _$key__maskContentUnits___$SvgPropsMixin =
      'maskContentUnits';
  static const String _$key__maskUnits___$SvgPropsMixin = 'maskUnits';
  static const String _$key__mathematical___$SvgPropsMixin = 'mathematical';
  static const String _$key__mode___$SvgPropsMixin = 'mode';
  static const String _$key__numOctaves___$SvgPropsMixin = 'numOctaves';
  static const String _$key__offset___$SvgPropsMixin = 'offset';
  static const String _$key__opacity___$SvgPropsMixin = 'opacity';
  static const String _$key__operator___$SvgPropsMixin = 'operator';
  static const String _$key__order___$SvgPropsMixin = 'order';
  static const String _$key__orient___$SvgPropsMixin = 'orient';
  static const String _$key__orientation___$SvgPropsMixin = 'orientation';
  static const String _$key__origin___$SvgPropsMixin = 'origin';
  static const String _$key__overflow___$SvgPropsMixin = 'overflow';
  static const String _$key__overlinePosition___$SvgPropsMixin =
      'overlinePosition';
  static const String _$key__overlineThickness___$SvgPropsMixin =
      'overlineThickness';
  static const String _$key__paintOrder___$SvgPropsMixin = 'paintOrder';
  static const String _$key__panose1___$SvgPropsMixin = 'panose1';
  static const String _$key__pathLength___$SvgPropsMixin = 'pathLength';
  static const String _$key__patternContentUnits___$SvgPropsMixin =
      'patternContentUnits';
  static const String _$key__patternTransform___$SvgPropsMixin =
      'patternTransform';
  static const String _$key__patternUnits___$SvgPropsMixin = 'patternUnits';
  static const String _$key__pointerEvents___$SvgPropsMixin = 'pointerEvents';
  static const String _$key__points___$SvgPropsMixin = 'points';
  static const String _$key__pointsAtX___$SvgPropsMixin = 'pointsAtX';
  static const String _$key__pointsAtY___$SvgPropsMixin = 'pointsAtY';
  static const String _$key__pointsAtZ___$SvgPropsMixin = 'pointsAtZ';
  static const String _$key__preserveAlpha___$SvgPropsMixin = 'preserveAlpha';
  static const String _$key__preserveAspectRatio___$SvgPropsMixin =
      'preserveAspectRatio';
  static const String _$key__primitiveUnits___$SvgPropsMixin = 'primitiveUnits';
  static const String _$key__r___$SvgPropsMixin = 'r';
  static const String _$key__radius___$SvgPropsMixin = 'radius';
  static const String _$key__refX___$SvgPropsMixin = 'refX';
  static const String _$key__refY___$SvgPropsMixin = 'refY';
  static const String _$key__renderingIntent___$SvgPropsMixin =
      'renderingIntent';
  static const String _$key__repeatCount___$SvgPropsMixin = 'repeatCount';
  static const String _$key__repeatDur___$SvgPropsMixin = 'repeatDur';
  static const String _$key__requiredExtensions___$SvgPropsMixin =
      'requiredExtensions';
  static const String _$key__requiredFeatures___$SvgPropsMixin =
      'requiredFeatures';
  static const String _$key__restart___$SvgPropsMixin = 'restart';
  static const String _$key__rotate___$SvgPropsMixin = 'rotate';
  static const String _$key__rx___$SvgPropsMixin = 'rx';
  static const String _$key__ry___$SvgPropsMixin = 'ry';
  static const String _$key__scale___$SvgPropsMixin = 'scale';
  static const String _$key__seed___$SvgPropsMixin = 'seed';
  static const String _$key__shapeRendering___$SvgPropsMixin = 'shapeRendering';
  static const String _$key__slope___$SvgPropsMixin = 'slope';
  static const String _$key__spacing___$SvgPropsMixin = 'spacing';
  static const String _$key__specularConstant___$SvgPropsMixin =
      'specularConstant';
  static const String _$key__specularExponent___$SvgPropsMixin =
      'specularExponent';
  static const String _$key__speed___$SvgPropsMixin = 'speed';
  static const String _$key__spreadMethod___$SvgPropsMixin = 'spreadMethod';
  static const String _$key__startOffset___$SvgPropsMixin = 'startOffset';
  static const String _$key__stdDeviation___$SvgPropsMixin = 'stdDeviation';
  static const String _$key__stemh___$SvgPropsMixin = 'stemh';
  static const String _$key__stemv___$SvgPropsMixin = 'stemv';
  static const String _$key__stitchTiles___$SvgPropsMixin = 'stitchTiles';
  static const String _$key__stopColor___$SvgPropsMixin = 'stopColor';
  static const String _$key__stopOpacity___$SvgPropsMixin = 'stopOpacity';
  static const String _$key__strikethroughPosition___$SvgPropsMixin =
      'strikethroughPosition';
  static const String _$key__strikethroughThickness___$SvgPropsMixin =
      'strikethroughThickness';
  static const String _$key__string___$SvgPropsMixin = 'string';
  static const String _$key__stroke___$SvgPropsMixin = 'stroke';
  static const String _$key__strokeDasharray___$SvgPropsMixin =
      'strokeDasharray';
  static const String _$key__strokeDashoffset___$SvgPropsMixin =
      'strokeDashoffset';
  static const String _$key__strokeLinecap___$SvgPropsMixin = 'strokeLinecap';
  static const String _$key__strokeMiterlimit___$SvgPropsMixin =
      'strokeMiterlimit';
  static const String _$key__strokeOpacity___$SvgPropsMixin = 'strokeOpacity';
  static const String _$key__strokeWidth___$SvgPropsMixin = 'strokeWidth';
  static const String _$key__surfaceScale___$SvgPropsMixin = 'surfaceScale';
  static const String _$key__systemLanguage___$SvgPropsMixin = 'systemLanguage';
  static const String _$key__tableValues___$SvgPropsMixin = 'tableValues';
  static const String _$key__targetX___$SvgPropsMixin = 'targetX';
  static const String _$key__targetY___$SvgPropsMixin = 'targetY';
  static const String _$key__textAnchor___$SvgPropsMixin = 'textAnchor';
  static const String _$key__textDecoration___$SvgPropsMixin = 'textDecoration';
  static const String _$key__textLength___$SvgPropsMixin = 'textLength';
  static const String _$key__textRendering___$SvgPropsMixin = 'textRendering';
  static const String _$key__to___$SvgPropsMixin = 'to';
  static const String _$key__transform___$SvgPropsMixin = 'transform';
  static const String _$key__u1___$SvgPropsMixin = 'u1';
  static const String _$key__u2___$SvgPropsMixin = 'u2';
  static const String _$key__underlinePosition___$SvgPropsMixin =
      'underlinePosition';
  static const String _$key__underlineThickness___$SvgPropsMixin =
      'underlineThickness';
  static const String _$key__unicode___$SvgPropsMixin = 'unicode';
  static const String _$key__unicodeBidi___$SvgPropsMixin = 'unicodeBidi';
  static const String _$key__unicodeRange___$SvgPropsMixin = 'unicodeRange';
  static const String _$key__unitsPerEm___$SvgPropsMixin = 'unitsPerEm';
  static const String _$key__vAlphabetic___$SvgPropsMixin = 'vAlphabetic';
  static const String _$key__vHanging___$SvgPropsMixin = 'vHanging';
  static const String _$key__vIdeographic___$SvgPropsMixin = 'vIdeographic';
  static const String _$key__vMathematical___$SvgPropsMixin = 'vMathematical';
  static const String _$key__vectorEffect___$SvgPropsMixin = 'vectorEffect';
  static const String _$key__version___$SvgPropsMixin = 'version';
  static const String _$key__vertAdvY___$SvgPropsMixin = 'vertAdvY';
  static const String _$key__vertOriginX___$SvgPropsMixin = 'vertOriginX';
  static const String _$key__vertOriginY___$SvgPropsMixin = 'vertOriginY';
  static const String _$key__viewBox___$SvgPropsMixin = 'viewBox';
  static const String _$key__viewTarget___$SvgPropsMixin = 'viewTarget';
  static const String _$key__visibility___$SvgPropsMixin = 'visibility';
  static const String _$key__widths___$SvgPropsMixin = 'widths';
  static const String _$key__wordSpacing___$SvgPropsMixin = 'wordSpacing';
  static const String _$key__writingMode___$SvgPropsMixin = 'writingMode';
  static const String _$key__x___$SvgPropsMixin = 'x';
  static const String _$key__x1___$SvgPropsMixin = 'x1';
  static const String _$key__x2___$SvgPropsMixin = 'x2';
  static const String _$key__xHeight___$SvgPropsMixin = 'xHeight';
  static const String _$key__xlinkActuate___$SvgPropsMixin = 'xlinkActuate';
  static const String _$key__xlinkArcrole___$SvgPropsMixin = 'xlinkArcrole';
  static const String _$key__xlinkHref___$SvgPropsMixin = 'xlinkHref';
  static const String _$key__xlinkRole___$SvgPropsMixin = 'xlinkRole';
  static const String _$key__xlinkShow___$SvgPropsMixin = 'xlinkShow';
  static const String _$key__xlinkTitle___$SvgPropsMixin = 'xlinkTitle';
  static const String _$key__xlinkType___$SvgPropsMixin = 'xlinkType';
  static const String _$key__xmlBase___$SvgPropsMixin = 'xmlBase';
  static const String _$key__xmlLang___$SvgPropsMixin = 'xmlLang';
  static const String _$key__xmlSpace___$SvgPropsMixin = 'xmlSpace';
  static const String _$key__y1___$SvgPropsMixin = 'y1';
  static const String _$key__y2___$SvgPropsMixin = 'y2';
  static const String _$key__y___$SvgPropsMixin = 'y';

  static const List<PropDescriptor> $props = [
    _$prop__htmlIn___$SvgPropsMixin,
    _$prop__htmlValues___$SvgPropsMixin,
    _$prop__accumulate___$SvgPropsMixin,
    _$prop__additive___$SvgPropsMixin,
    _$prop__alignmentBaseline___$SvgPropsMixin,
    _$prop__allowReorder___$SvgPropsMixin,
    _$prop__arabicForm___$SvgPropsMixin,
    _$prop__attributeName___$SvgPropsMixin,
    _$prop__attributeType___$SvgPropsMixin,
    _$prop__colorInterpolationFilters___$SvgPropsMixin,
    _$prop__fillRule___$SvgPropsMixin,
    _$prop__filter___$SvgPropsMixin,
    _$prop__mask___$SvgPropsMixin,
    _$prop__result___$SvgPropsMixin,
    _$prop__strokeLinejoin___$SvgPropsMixin,
    _$prop__xChannelSelector___$SvgPropsMixin,
    _$prop__xmlns___$SvgPropsMixin,
    _$prop__xmlnsXlink___$SvgPropsMixin,
    _$prop__yChannelSelector___$SvgPropsMixin,
    _$prop__zoomAndPan___$SvgPropsMixin,
    _$prop__accentHeight___$SvgPropsMixin,
    _$prop__alphabetic___$SvgPropsMixin,
    _$prop__amplitude___$SvgPropsMixin,
    _$prop__ascent___$SvgPropsMixin,
    _$prop__autoReverse___$SvgPropsMixin,
    _$prop__azimuth___$SvgPropsMixin,
    _$prop__baseFrequency___$SvgPropsMixin,
    _$prop__baseProfile___$SvgPropsMixin,
    _$prop__baselineShift___$SvgPropsMixin,
    _$prop__bbox___$SvgPropsMixin,
    _$prop__begin___$SvgPropsMixin,
    _$prop__bias___$SvgPropsMixin,
    _$prop__by___$SvgPropsMixin,
    _$prop__calcMode___$SvgPropsMixin,
    _$prop__capHeight___$SvgPropsMixin,
    _$prop__clip___$SvgPropsMixin,
    _$prop__clipPath___$SvgPropsMixin,
    _$prop__clipPathUnits___$SvgPropsMixin,
    _$prop__clipRule___$SvgPropsMixin,
    _$prop__colorInterpolation___$SvgPropsMixin,
    _$prop__colorProfile___$SvgPropsMixin,
    _$prop__colorRendering___$SvgPropsMixin,
    _$prop__contentScriptType___$SvgPropsMixin,
    _$prop__contentStyleType___$SvgPropsMixin,
    _$prop__cursor___$SvgPropsMixin,
    _$prop__cx___$SvgPropsMixin,
    _$prop__cy___$SvgPropsMixin,
    _$prop__d___$SvgPropsMixin,
    _$prop__decelerate___$SvgPropsMixin,
    _$prop__descent___$SvgPropsMixin,
    _$prop__diffuseConstant___$SvgPropsMixin,
    _$prop__direction___$SvgPropsMixin,
    _$prop__display___$SvgPropsMixin,
    _$prop__divisor___$SvgPropsMixin,
    _$prop__dominantBaseline___$SvgPropsMixin,
    _$prop__dur___$SvgPropsMixin,
    _$prop__dx___$SvgPropsMixin,
    _$prop__dy___$SvgPropsMixin,
    _$prop__edgeMode___$SvgPropsMixin,
    _$prop__elevation___$SvgPropsMixin,
    _$prop__enableBackground___$SvgPropsMixin,
    _$prop__end___$SvgPropsMixin,
    _$prop__exponent___$SvgPropsMixin,
    _$prop__externalResourcesRequired___$SvgPropsMixin,
    _$prop__fill___$SvgPropsMixin,
    _$prop__fillOpacity___$SvgPropsMixin,
    _$prop__filterRes___$SvgPropsMixin,
    _$prop__filterUnits___$SvgPropsMixin,
    _$prop__floodColor___$SvgPropsMixin,
    _$prop__floodOpacity___$SvgPropsMixin,
    _$prop__focusable___$SvgPropsMixin,
    _$prop__fontFamily___$SvgPropsMixin,
    _$prop__fontSize___$SvgPropsMixin,
    _$prop__fontSizeAdjust___$SvgPropsMixin,
    _$prop__fontStretch___$SvgPropsMixin,
    _$prop__fontStyle___$SvgPropsMixin,
    _$prop__fontVariant___$SvgPropsMixin,
    _$prop__fontWeight___$SvgPropsMixin,
    _$prop__format___$SvgPropsMixin,
    _$prop__from___$SvgPropsMixin,
    _$prop__fx___$SvgPropsMixin,
    _$prop__fy___$SvgPropsMixin,
    _$prop__g1___$SvgPropsMixin,
    _$prop__g2___$SvgPropsMixin,
    _$prop__glyphName___$SvgPropsMixin,
    _$prop__glyphOrientationHorizontal___$SvgPropsMixin,
    _$prop__glyphOrientationVertical___$SvgPropsMixin,
    _$prop__glyphRef___$SvgPropsMixin,
    _$prop__gradientTransform___$SvgPropsMixin,
    _$prop__gradientUnits___$SvgPropsMixin,
    _$prop__hanging___$SvgPropsMixin,
    _$prop__horizAdvX___$SvgPropsMixin,
    _$prop__horizOriginX___$SvgPropsMixin,
    _$prop__ideographic___$SvgPropsMixin,
    _$prop__imageRendering___$SvgPropsMixin,
    _$prop__in2___$SvgPropsMixin,
    _$prop__intercept___$SvgPropsMixin,
    _$prop__k___$SvgPropsMixin,
    _$prop__k1___$SvgPropsMixin,
    _$prop__k2___$SvgPropsMixin,
    _$prop__k3___$SvgPropsMixin,
    _$prop__k4___$SvgPropsMixin,
    _$prop__kernelMatrix___$SvgPropsMixin,
    _$prop__kernelUnitLength___$SvgPropsMixin,
    _$prop__kerning___$SvgPropsMixin,
    _$prop__keyPoints___$SvgPropsMixin,
    _$prop__keySplines___$SvgPropsMixin,
    _$prop__keyTimes___$SvgPropsMixin,
    _$prop__lengthAdjust___$SvgPropsMixin,
    _$prop__letterSpacing___$SvgPropsMixin,
    _$prop__lightingColor___$SvgPropsMixin,
    _$prop__limitingConeAngle___$SvgPropsMixin,
    _$prop__local___$SvgPropsMixin,
    _$prop__markerEnd___$SvgPropsMixin,
    _$prop__markerHeight___$SvgPropsMixin,
    _$prop__markerMid___$SvgPropsMixin,
    _$prop__markerStart___$SvgPropsMixin,
    _$prop__markerUnits___$SvgPropsMixin,
    _$prop__markerWidth___$SvgPropsMixin,
    _$prop__maskContentUnits___$SvgPropsMixin,
    _$prop__maskUnits___$SvgPropsMixin,
    _$prop__mathematical___$SvgPropsMixin,
    _$prop__mode___$SvgPropsMixin,
    _$prop__numOctaves___$SvgPropsMixin,
    _$prop__offset___$SvgPropsMixin,
    _$prop__opacity___$SvgPropsMixin,
    _$prop__operator___$SvgPropsMixin,
    _$prop__order___$SvgPropsMixin,
    _$prop__orient___$SvgPropsMixin,
    _$prop__orientation___$SvgPropsMixin,
    _$prop__origin___$SvgPropsMixin,
    _$prop__overflow___$SvgPropsMixin,
    _$prop__overlinePosition___$SvgPropsMixin,
    _$prop__overlineThickness___$SvgPropsMixin,
    _$prop__paintOrder___$SvgPropsMixin,
    _$prop__panose1___$SvgPropsMixin,
    _$prop__pathLength___$SvgPropsMixin,
    _$prop__patternContentUnits___$SvgPropsMixin,
    _$prop__patternTransform___$SvgPropsMixin,
    _$prop__patternUnits___$SvgPropsMixin,
    _$prop__pointerEvents___$SvgPropsMixin,
    _$prop__points___$SvgPropsMixin,
    _$prop__pointsAtX___$SvgPropsMixin,
    _$prop__pointsAtY___$SvgPropsMixin,
    _$prop__pointsAtZ___$SvgPropsMixin,
    _$prop__preserveAlpha___$SvgPropsMixin,
    _$prop__preserveAspectRatio___$SvgPropsMixin,
    _$prop__primitiveUnits___$SvgPropsMixin,
    _$prop__r___$SvgPropsMixin,
    _$prop__radius___$SvgPropsMixin,
    _$prop__refX___$SvgPropsMixin,
    _$prop__refY___$SvgPropsMixin,
    _$prop__renderingIntent___$SvgPropsMixin,
    _$prop__repeatCount___$SvgPropsMixin,
    _$prop__repeatDur___$SvgPropsMixin,
    _$prop__requiredExtensions___$SvgPropsMixin,
    _$prop__requiredFeatures___$SvgPropsMixin,
    _$prop__restart___$SvgPropsMixin,
    _$prop__rotate___$SvgPropsMixin,
    _$prop__rx___$SvgPropsMixin,
    _$prop__ry___$SvgPropsMixin,
    _$prop__scale___$SvgPropsMixin,
    _$prop__seed___$SvgPropsMixin,
    _$prop__shapeRendering___$SvgPropsMixin,
    _$prop__slope___$SvgPropsMixin,
    _$prop__spacing___$SvgPropsMixin,
    _$prop__specularConstant___$SvgPropsMixin,
    _$prop__specularExponent___$SvgPropsMixin,
    _$prop__speed___$SvgPropsMixin,
    _$prop__spreadMethod___$SvgPropsMixin,
    _$prop__startOffset___$SvgPropsMixin,
    _$prop__stdDeviation___$SvgPropsMixin,
    _$prop__stemh___$SvgPropsMixin,
    _$prop__stemv___$SvgPropsMixin,
    _$prop__stitchTiles___$SvgPropsMixin,
    _$prop__stopColor___$SvgPropsMixin,
    _$prop__stopOpacity___$SvgPropsMixin,
    _$prop__strikethroughPosition___$SvgPropsMixin,
    _$prop__strikethroughThickness___$SvgPropsMixin,
    _$prop__string___$SvgPropsMixin,
    _$prop__stroke___$SvgPropsMixin,
    _$prop__strokeDasharray___$SvgPropsMixin,
    _$prop__strokeDashoffset___$SvgPropsMixin,
    _$prop__strokeLinecap___$SvgPropsMixin,
    _$prop__strokeMiterlimit___$SvgPropsMixin,
    _$prop__strokeOpacity___$SvgPropsMixin,
    _$prop__strokeWidth___$SvgPropsMixin,
    _$prop__surfaceScale___$SvgPropsMixin,
    _$prop__systemLanguage___$SvgPropsMixin,
    _$prop__tableValues___$SvgPropsMixin,
    _$prop__targetX___$SvgPropsMixin,
    _$prop__targetY___$SvgPropsMixin,
    _$prop__textAnchor___$SvgPropsMixin,
    _$prop__textDecoration___$SvgPropsMixin,
    _$prop__textLength___$SvgPropsMixin,
    _$prop__textRendering___$SvgPropsMixin,
    _$prop__to___$SvgPropsMixin,
    _$prop__transform___$SvgPropsMixin,
    _$prop__u1___$SvgPropsMixin,
    _$prop__u2___$SvgPropsMixin,
    _$prop__underlinePosition___$SvgPropsMixin,
    _$prop__underlineThickness___$SvgPropsMixin,
    _$prop__unicode___$SvgPropsMixin,
    _$prop__unicodeBidi___$SvgPropsMixin,
    _$prop__unicodeRange___$SvgPropsMixin,
    _$prop__unitsPerEm___$SvgPropsMixin,
    _$prop__vAlphabetic___$SvgPropsMixin,
    _$prop__vHanging___$SvgPropsMixin,
    _$prop__vIdeographic___$SvgPropsMixin,
    _$prop__vMathematical___$SvgPropsMixin,
    _$prop__vectorEffect___$SvgPropsMixin,
    _$prop__version___$SvgPropsMixin,
    _$prop__vertAdvY___$SvgPropsMixin,
    _$prop__vertOriginX___$SvgPropsMixin,
    _$prop__vertOriginY___$SvgPropsMixin,
    _$prop__viewBox___$SvgPropsMixin,
    _$prop__viewTarget___$SvgPropsMixin,
    _$prop__visibility___$SvgPropsMixin,
    _$prop__widths___$SvgPropsMixin,
    _$prop__wordSpacing___$SvgPropsMixin,
    _$prop__writingMode___$SvgPropsMixin,
    _$prop__x___$SvgPropsMixin,
    _$prop__x1___$SvgPropsMixin,
    _$prop__x2___$SvgPropsMixin,
    _$prop__xHeight___$SvgPropsMixin,
    _$prop__xlinkActuate___$SvgPropsMixin,
    _$prop__xlinkArcrole___$SvgPropsMixin,
    _$prop__xlinkHref___$SvgPropsMixin,
    _$prop__xlinkRole___$SvgPropsMixin,
    _$prop__xlinkShow___$SvgPropsMixin,
    _$prop__xlinkTitle___$SvgPropsMixin,
    _$prop__xlinkType___$SvgPropsMixin,
    _$prop__xmlBase___$SvgPropsMixin,
    _$prop__xmlLang___$SvgPropsMixin,
    _$prop__xmlSpace___$SvgPropsMixin,
    _$prop__y1___$SvgPropsMixin,
    _$prop__y2___$SvgPropsMixin,
    _$prop__y___$SvgPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__htmlIn___$SvgPropsMixin,
    _$key__htmlValues___$SvgPropsMixin,
    _$key__accumulate___$SvgPropsMixin,
    _$key__additive___$SvgPropsMixin,
    _$key__alignmentBaseline___$SvgPropsMixin,
    _$key__allowReorder___$SvgPropsMixin,
    _$key__arabicForm___$SvgPropsMixin,
    _$key__attributeName___$SvgPropsMixin,
    _$key__attributeType___$SvgPropsMixin,
    _$key__colorInterpolationFilters___$SvgPropsMixin,
    _$key__fillRule___$SvgPropsMixin,
    _$key__filter___$SvgPropsMixin,
    _$key__mask___$SvgPropsMixin,
    _$key__result___$SvgPropsMixin,
    _$key__strokeLinejoin___$SvgPropsMixin,
    _$key__xChannelSelector___$SvgPropsMixin,
    _$key__xmlns___$SvgPropsMixin,
    _$key__xmlnsXlink___$SvgPropsMixin,
    _$key__yChannelSelector___$SvgPropsMixin,
    _$key__zoomAndPan___$SvgPropsMixin,
    _$key__accentHeight___$SvgPropsMixin,
    _$key__alphabetic___$SvgPropsMixin,
    _$key__amplitude___$SvgPropsMixin,
    _$key__ascent___$SvgPropsMixin,
    _$key__autoReverse___$SvgPropsMixin,
    _$key__azimuth___$SvgPropsMixin,
    _$key__baseFrequency___$SvgPropsMixin,
    _$key__baseProfile___$SvgPropsMixin,
    _$key__baselineShift___$SvgPropsMixin,
    _$key__bbox___$SvgPropsMixin,
    _$key__begin___$SvgPropsMixin,
    _$key__bias___$SvgPropsMixin,
    _$key__by___$SvgPropsMixin,
    _$key__calcMode___$SvgPropsMixin,
    _$key__capHeight___$SvgPropsMixin,
    _$key__clip___$SvgPropsMixin,
    _$key__clipPath___$SvgPropsMixin,
    _$key__clipPathUnits___$SvgPropsMixin,
    _$key__clipRule___$SvgPropsMixin,
    _$key__colorInterpolation___$SvgPropsMixin,
    _$key__colorProfile___$SvgPropsMixin,
    _$key__colorRendering___$SvgPropsMixin,
    _$key__contentScriptType___$SvgPropsMixin,
    _$key__contentStyleType___$SvgPropsMixin,
    _$key__cursor___$SvgPropsMixin,
    _$key__cx___$SvgPropsMixin,
    _$key__cy___$SvgPropsMixin,
    _$key__d___$SvgPropsMixin,
    _$key__decelerate___$SvgPropsMixin,
    _$key__descent___$SvgPropsMixin,
    _$key__diffuseConstant___$SvgPropsMixin,
    _$key__direction___$SvgPropsMixin,
    _$key__display___$SvgPropsMixin,
    _$key__divisor___$SvgPropsMixin,
    _$key__dominantBaseline___$SvgPropsMixin,
    _$key__dur___$SvgPropsMixin,
    _$key__dx___$SvgPropsMixin,
    _$key__dy___$SvgPropsMixin,
    _$key__edgeMode___$SvgPropsMixin,
    _$key__elevation___$SvgPropsMixin,
    _$key__enableBackground___$SvgPropsMixin,
    _$key__end___$SvgPropsMixin,
    _$key__exponent___$SvgPropsMixin,
    _$key__externalResourcesRequired___$SvgPropsMixin,
    _$key__fill___$SvgPropsMixin,
    _$key__fillOpacity___$SvgPropsMixin,
    _$key__filterRes___$SvgPropsMixin,
    _$key__filterUnits___$SvgPropsMixin,
    _$key__floodColor___$SvgPropsMixin,
    _$key__floodOpacity___$SvgPropsMixin,
    _$key__focusable___$SvgPropsMixin,
    _$key__fontFamily___$SvgPropsMixin,
    _$key__fontSize___$SvgPropsMixin,
    _$key__fontSizeAdjust___$SvgPropsMixin,
    _$key__fontStretch___$SvgPropsMixin,
    _$key__fontStyle___$SvgPropsMixin,
    _$key__fontVariant___$SvgPropsMixin,
    _$key__fontWeight___$SvgPropsMixin,
    _$key__format___$SvgPropsMixin,
    _$key__from___$SvgPropsMixin,
    _$key__fx___$SvgPropsMixin,
    _$key__fy___$SvgPropsMixin,
    _$key__g1___$SvgPropsMixin,
    _$key__g2___$SvgPropsMixin,
    _$key__glyphName___$SvgPropsMixin,
    _$key__glyphOrientationHorizontal___$SvgPropsMixin,
    _$key__glyphOrientationVertical___$SvgPropsMixin,
    _$key__glyphRef___$SvgPropsMixin,
    _$key__gradientTransform___$SvgPropsMixin,
    _$key__gradientUnits___$SvgPropsMixin,
    _$key__hanging___$SvgPropsMixin,
    _$key__horizAdvX___$SvgPropsMixin,
    _$key__horizOriginX___$SvgPropsMixin,
    _$key__ideographic___$SvgPropsMixin,
    _$key__imageRendering___$SvgPropsMixin,
    _$key__in2___$SvgPropsMixin,
    _$key__intercept___$SvgPropsMixin,
    _$key__k___$SvgPropsMixin,
    _$key__k1___$SvgPropsMixin,
    _$key__k2___$SvgPropsMixin,
    _$key__k3___$SvgPropsMixin,
    _$key__k4___$SvgPropsMixin,
    _$key__kernelMatrix___$SvgPropsMixin,
    _$key__kernelUnitLength___$SvgPropsMixin,
    _$key__kerning___$SvgPropsMixin,
    _$key__keyPoints___$SvgPropsMixin,
    _$key__keySplines___$SvgPropsMixin,
    _$key__keyTimes___$SvgPropsMixin,
    _$key__lengthAdjust___$SvgPropsMixin,
    _$key__letterSpacing___$SvgPropsMixin,
    _$key__lightingColor___$SvgPropsMixin,
    _$key__limitingConeAngle___$SvgPropsMixin,
    _$key__local___$SvgPropsMixin,
    _$key__markerEnd___$SvgPropsMixin,
    _$key__markerHeight___$SvgPropsMixin,
    _$key__markerMid___$SvgPropsMixin,
    _$key__markerStart___$SvgPropsMixin,
    _$key__markerUnits___$SvgPropsMixin,
    _$key__markerWidth___$SvgPropsMixin,
    _$key__maskContentUnits___$SvgPropsMixin,
    _$key__maskUnits___$SvgPropsMixin,
    _$key__mathematical___$SvgPropsMixin,
    _$key__mode___$SvgPropsMixin,
    _$key__numOctaves___$SvgPropsMixin,
    _$key__offset___$SvgPropsMixin,
    _$key__opacity___$SvgPropsMixin,
    _$key__operator___$SvgPropsMixin,
    _$key__order___$SvgPropsMixin,
    _$key__orient___$SvgPropsMixin,
    _$key__orientation___$SvgPropsMixin,
    _$key__origin___$SvgPropsMixin,
    _$key__overflow___$SvgPropsMixin,
    _$key__overlinePosition___$SvgPropsMixin,
    _$key__overlineThickness___$SvgPropsMixin,
    _$key__paintOrder___$SvgPropsMixin,
    _$key__panose1___$SvgPropsMixin,
    _$key__pathLength___$SvgPropsMixin,
    _$key__patternContentUnits___$SvgPropsMixin,
    _$key__patternTransform___$SvgPropsMixin,
    _$key__patternUnits___$SvgPropsMixin,
    _$key__pointerEvents___$SvgPropsMixin,
    _$key__points___$SvgPropsMixin,
    _$key__pointsAtX___$SvgPropsMixin,
    _$key__pointsAtY___$SvgPropsMixin,
    _$key__pointsAtZ___$SvgPropsMixin,
    _$key__preserveAlpha___$SvgPropsMixin,
    _$key__preserveAspectRatio___$SvgPropsMixin,
    _$key__primitiveUnits___$SvgPropsMixin,
    _$key__r___$SvgPropsMixin,
    _$key__radius___$SvgPropsMixin,
    _$key__refX___$SvgPropsMixin,
    _$key__refY___$SvgPropsMixin,
    _$key__renderingIntent___$SvgPropsMixin,
    _$key__repeatCount___$SvgPropsMixin,
    _$key__repeatDur___$SvgPropsMixin,
    _$key__requiredExtensions___$SvgPropsMixin,
    _$key__requiredFeatures___$SvgPropsMixin,
    _$key__restart___$SvgPropsMixin,
    _$key__rotate___$SvgPropsMixin,
    _$key__rx___$SvgPropsMixin,
    _$key__ry___$SvgPropsMixin,
    _$key__scale___$SvgPropsMixin,
    _$key__seed___$SvgPropsMixin,
    _$key__shapeRendering___$SvgPropsMixin,
    _$key__slope___$SvgPropsMixin,
    _$key__spacing___$SvgPropsMixin,
    _$key__specularConstant___$SvgPropsMixin,
    _$key__specularExponent___$SvgPropsMixin,
    _$key__speed___$SvgPropsMixin,
    _$key__spreadMethod___$SvgPropsMixin,
    _$key__startOffset___$SvgPropsMixin,
    _$key__stdDeviation___$SvgPropsMixin,
    _$key__stemh___$SvgPropsMixin,
    _$key__stemv___$SvgPropsMixin,
    _$key__stitchTiles___$SvgPropsMixin,
    _$key__stopColor___$SvgPropsMixin,
    _$key__stopOpacity___$SvgPropsMixin,
    _$key__strikethroughPosition___$SvgPropsMixin,
    _$key__strikethroughThickness___$SvgPropsMixin,
    _$key__string___$SvgPropsMixin,
    _$key__stroke___$SvgPropsMixin,
    _$key__strokeDasharray___$SvgPropsMixin,
    _$key__strokeDashoffset___$SvgPropsMixin,
    _$key__strokeLinecap___$SvgPropsMixin,
    _$key__strokeMiterlimit___$SvgPropsMixin,
    _$key__strokeOpacity___$SvgPropsMixin,
    _$key__strokeWidth___$SvgPropsMixin,
    _$key__surfaceScale___$SvgPropsMixin,
    _$key__systemLanguage___$SvgPropsMixin,
    _$key__tableValues___$SvgPropsMixin,
    _$key__targetX___$SvgPropsMixin,
    _$key__targetY___$SvgPropsMixin,
    _$key__textAnchor___$SvgPropsMixin,
    _$key__textDecoration___$SvgPropsMixin,
    _$key__textLength___$SvgPropsMixin,
    _$key__textRendering___$SvgPropsMixin,
    _$key__to___$SvgPropsMixin,
    _$key__transform___$SvgPropsMixin,
    _$key__u1___$SvgPropsMixin,
    _$key__u2___$SvgPropsMixin,
    _$key__underlinePosition___$SvgPropsMixin,
    _$key__underlineThickness___$SvgPropsMixin,
    _$key__unicode___$SvgPropsMixin,
    _$key__unicodeBidi___$SvgPropsMixin,
    _$key__unicodeRange___$SvgPropsMixin,
    _$key__unitsPerEm___$SvgPropsMixin,
    _$key__vAlphabetic___$SvgPropsMixin,
    _$key__vHanging___$SvgPropsMixin,
    _$key__vIdeographic___$SvgPropsMixin,
    _$key__vMathematical___$SvgPropsMixin,
    _$key__vectorEffect___$SvgPropsMixin,
    _$key__version___$SvgPropsMixin,
    _$key__vertAdvY___$SvgPropsMixin,
    _$key__vertOriginX___$SvgPropsMixin,
    _$key__vertOriginY___$SvgPropsMixin,
    _$key__viewBox___$SvgPropsMixin,
    _$key__viewTarget___$SvgPropsMixin,
    _$key__visibility___$SvgPropsMixin,
    _$key__widths___$SvgPropsMixin,
    _$key__wordSpacing___$SvgPropsMixin,
    _$key__writingMode___$SvgPropsMixin,
    _$key__x___$SvgPropsMixin,
    _$key__x1___$SvgPropsMixin,
    _$key__x2___$SvgPropsMixin,
    _$key__xHeight___$SvgPropsMixin,
    _$key__xlinkActuate___$SvgPropsMixin,
    _$key__xlinkArcrole___$SvgPropsMixin,
    _$key__xlinkHref___$SvgPropsMixin,
    _$key__xlinkRole___$SvgPropsMixin,
    _$key__xlinkShow___$SvgPropsMixin,
    _$key__xlinkTitle___$SvgPropsMixin,
    _$key__xlinkType___$SvgPropsMixin,
    _$key__xmlBase___$SvgPropsMixin,
    _$key__xmlLang___$SvgPropsMixin,
    _$key__xmlSpace___$SvgPropsMixin,
    _$key__y1___$SvgPropsMixin,
    _$key__y2___$SvgPropsMixin,
    _$key__y___$SvgPropsMixin
  ];
}

const PropsMeta _$metaForSvgPropsMixin = PropsMeta(
  fields: SvgPropsMixin.$props,
  keys: SvgPropsMixin.$propKeys,
);

abstract class UbiquitousDomPropsMixin implements _$UbiquitousDomPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForUbiquitousDomPropsMixin;
  @override
  @Accessor(doNotGenerate: true)
  AriaPropsMapView? _aria;
  @override
  @Accessor(doNotGenerate: true)
  DomProps? _dom;
  @override
  AriaPropsMixin get aria {
    return _aria ??= AriaPropsMapView(props);
  }

  @override
  DomPropsMixin get dom {
    return _dom ??= DomProps(null, props);
  }

  @override
  Map<String, dynamic>? get style =>
      _conditionallyUnconvertStyle(_raw$UbiquitousDomProps$style);
  @override
  set style(Map<String, dynamic>? value) =>
      _raw$UbiquitousDomProps$style = value;

  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.tabIndex] -->
  @override
  get tabIndex =>
      (props[_$key__tabIndex___$UbiquitousDomPropsMixin]) as dynamic;

  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.tabIndex] -->
  @override
  set tabIndex(value) =>
      props[_$key__tabIndex___$UbiquitousDomPropsMixin] = value;

  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.id] -->
  @override
  get id => (props[_$key__id___$UbiquitousDomPropsMixin]) as String?;

  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.id] -->
  @override
  set id(value) => props[_$key__id___$UbiquitousDomPropsMixin] = value;

  /// Represents advisory information about the element.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.title] -->
  @override
  get title => (props[_$key__title___$UbiquitousDomPropsMixin]) as String?;

  /// Represents advisory information about the element.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.title] -->
  @override
  set title(value) => props[_$key__title___$UbiquitousDomPropsMixin] = value;

  /// <!-- Generated from [_$UbiquitousDomPropsMixin._raw$UbiquitousDomProps$style] -->
  @override
  @Accessor(key: 'style')
  get _raw$UbiquitousDomProps$style =>
      (props[_$key___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin])
          as dynamic;

  /// <!-- Generated from [_$UbiquitousDomPropsMixin._raw$UbiquitousDomProps$style] -->
  @override
  @Accessor(key: 'style')
  set _raw$UbiquitousDomProps$style(value) =>
      props[_$key___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin] =
          value;

  /// Callback for when a CSS Animation has completed.
  ///
  /// > Related: [onAnimationIteration], [onAnimationStart], [onTransitionEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationEnd] -->
  @override
  get onAnimationEnd =>
      (props[_$key__onAnimationEnd___$UbiquitousDomPropsMixin])
          as AnimationEventCallback?;

  /// Callback for when a CSS Animation has completed.
  ///
  /// > Related: [onAnimationIteration], [onAnimationStart], [onTransitionEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationEnd] -->
  @override
  set onAnimationEnd(value) =>
      props[_$key__onAnimationEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an iteration of a CSS Animation ends, and another one begins.
  ///
  /// > Related: [onAnimationEnd], [onAnimationStart]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationIteration] -->
  @override
  get onAnimationIteration =>
      (props[_$key__onAnimationIteration___$UbiquitousDomPropsMixin])
          as AnimationEventCallback?;

  /// Callback for when an iteration of a CSS Animation ends, and another one begins.
  ///
  /// > Related: [onAnimationEnd], [onAnimationStart]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationIteration] -->
  @override
  set onAnimationIteration(value) =>
      props[_$key__onAnimationIteration___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a CSS animation has started.
  ///
  /// > Related: [onAnimationEnd], [onAnimationIteration]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationStart] -->
  @override
  get onAnimationStart =>
      (props[_$key__onAnimationStart___$UbiquitousDomPropsMixin])
          as AnimationEventCallback?;

  /// Callback for when a CSS animation has started.
  ///
  /// > Related: [onAnimationEnd], [onAnimationIteration]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationStart] -->
  @override
  set onAnimationStart(value) =>
      props[_$key__onAnimationStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user copies the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCopy] -->
  @override
  get onCopy => (props[_$key__onCopy___$UbiquitousDomPropsMixin])
      as ClipboardEventCallback?;

  /// Callback for when the user copies the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCopy] -->
  @override
  set onCopy(value) => props[_$key__onCopy___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user cuts the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCut] -->
  @override
  get onCut => (props[_$key__onCut___$UbiquitousDomPropsMixin])
      as ClipboardEventCallback?;

  /// Callback for when the user cuts the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCut] -->
  @override
  set onCut(value) => props[_$key__onCut___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user pastes some content in an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPaste] -->
  @override
  get onPaste => (props[_$key__onPaste___$UbiquitousDomPropsMixin])
      as ClipboardEventCallback?;

  /// Callback for when the user pastes some content in an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPaste] -->
  @override
  set onPaste(value) =>
      props[_$key__onPaste___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user is pressing a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyDown] -->
  @override
  get onKeyDown => (props[_$key__onKeyDown___$UbiquitousDomPropsMixin])
      as KeyboardEventCallback?;

  /// Callback for when the user is pressing a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyDown] -->
  @override
  set onKeyDown(value) =>
      props[_$key__onKeyDown___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user presses a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyPress] -->
  @override
  get onKeyPress => (props[_$key__onKeyPress___$UbiquitousDomPropsMixin])
      as KeyboardEventCallback?;

  /// Callback for when the user presses a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyPress] -->
  @override
  set onKeyPress(value) =>
      props[_$key__onKeyPress___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user releases a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyUp] -->
  @override
  get onKeyUp => (props[_$key__onKeyUp___$UbiquitousDomPropsMixin])
      as KeyboardEventCallback?;

  /// Callback for when the user releases a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyUp] -->
  @override
  set onKeyUp(value) =>
      props[_$key__onKeyUp___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element gets focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onFocus] -->
  @override
  get onFocus =>
      (props[_$key__onFocus___$UbiquitousDomPropsMixin]) as FocusEventCallback?;

  /// Callback for when an element gets focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onFocus] -->
  @override
  set onFocus(value) =>
      props[_$key__onFocus___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element loses focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onBlur] -->
  @override
  get onBlur =>
      (props[_$key__onBlur___$UbiquitousDomPropsMixin]) as FocusEventCallback?;

  /// Callback for when an element loses focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onBlur] -->
  @override
  set onBlur(value) => props[_$key__onBlur___$UbiquitousDomPropsMixin] = value;

  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onChange] -->
  @override
  get onChange =>
      (props[_$key__onChange___$UbiquitousDomPropsMixin]) as FormEventCallback?;

  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onChange] -->
  @override
  set onChange(value) =>
      props[_$key__onChange___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element gets user input
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onInput] -->
  @override
  get onInput =>
      (props[_$key__onInput___$UbiquitousDomPropsMixin]) as FormEventCallback?;

  /// Callback for when an element gets user input
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onInput] -->
  @override
  set onInput(value) =>
      props[_$key__onInput___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a form is submitted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onSubmit] -->
  @override
  get onSubmit =>
      (props[_$key__onSubmit___$UbiquitousDomPropsMixin]) as FormEventCallback?;

  /// Callback for when a form is submitted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onSubmit] -->
  @override
  set onSubmit(value) =>
      props[_$key__onSubmit___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a form is reset
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onReset] -->
  @override
  get onReset =>
      (props[_$key__onReset___$UbiquitousDomPropsMixin]) as FormEventCallback?;

  /// Callback for when a form is reset
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onReset] -->
  @override
  set onReset(value) =>
      props[_$key__onReset___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onClick] -->
  @override
  get onClick =>
      (props[_$key__onClick___$UbiquitousDomPropsMixin]) as MouseEventCallback?;

  /// Callback for when the user clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onClick] -->
  @override
  set onClick(value) =>
      props[_$key__onClick___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user right-clicks on an element to open a context menu
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onContextMenu] -->
  @override
  get onContextMenu => (props[_$key__onContextMenu___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the user right-clicks on an element to open a context menu
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onContextMenu] -->
  @override
  set onContextMenu(value) =>
      props[_$key__onContextMenu___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user double-clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDoubleClick] -->
  @override
  get onDoubleClick => (props[_$key__onDoubleClick___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the user double-clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDoubleClick] -->
  @override
  set onDoubleClick(value) =>
      props[_$key__onDoubleClick___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element is being dragged
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrag] -->
  @override
  get onDrag =>
      (props[_$key__onDrag___$UbiquitousDomPropsMixin]) as MouseEventCallback?;

  /// Callback for when an element is being dragged
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrag] -->
  @override
  set onDrag(value) => props[_$key__onDrag___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user has finished dragging an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnd] -->
  @override
  get onDragEnd => (props[_$key__onDragEnd___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the user has finished dragging an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnd] -->
  @override
  set onDragEnd(value) =>
      props[_$key__onDragEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element enters the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnter] -->
  @override
  get onDragEnter => (props[_$key__onDragEnter___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the dragged element enters the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnter] -->
  @override
  set onDragEnter(value) =>
      props[_$key__onDragEnter___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element exits the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragExit] -->
  @override
  get onDragExit => (props[_$key__onDragExit___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the dragged element exits the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragExit] -->
  @override
  set onDragExit(value) =>
      props[_$key__onDragExit___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element leaves the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragLeave] -->
  @override
  get onDragLeave => (props[_$key__onDragLeave___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the dragged element leaves the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragLeave] -->
  @override
  set onDragLeave(value) =>
      props[_$key__onDragLeave___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element is over the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragOver] -->
  @override
  get onDragOver => (props[_$key__onDragOver___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the dragged element is over the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragOver] -->
  @override
  set onDragOver(value) =>
      props[_$key__onDragOver___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user starts to drag an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragStart] -->
  @override
  get onDragStart => (props[_$key__onDragStart___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the user starts to drag an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragStart] -->
  @override
  set onDragStart(value) =>
      props[_$key__onDragStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element is dropped on the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrop] -->
  @override
  get onDrop =>
      (props[_$key__onDrop___$UbiquitousDomPropsMixin]) as MouseEventCallback?;

  /// Callback for when the dragged element is dropped on the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrop] -->
  @override
  set onDrop(value) => props[_$key__onDrop___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user presses a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseDown] -->
  @override
  get onMouseDown => (props[_$key__onMouseDown___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the user presses a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseDown] -->
  @override
  set onMouseDown(value) =>
      props[_$key__onMouseDown___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseEnter] -->
  @override
  get onMouseEnter => (props[_$key__onMouseEnter___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseEnter] -->
  @override
  set onMouseEnter(value) =>
      props[_$key__onMouseEnter___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseLeave] -->
  @override
  get onMouseLeave => (props[_$key__onMouseLeave___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseLeave] -->
  @override
  set onMouseLeave(value) =>
      props[_$key__onMouseLeave___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseMove] -->
  @override
  get onMouseMove => (props[_$key__onMouseMove___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseMove] -->
  @override
  set onMouseMove(value) =>
      props[_$key__onMouseMove___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOut] -->
  @override
  get onMouseOut => (props[_$key__onMouseOut___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOut] -->
  @override
  set onMouseOut(value) =>
      props[_$key__onMouseOut___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOver] -->
  @override
  get onMouseOver => (props[_$key__onMouseOver___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOver] -->
  @override
  set onMouseOver(value) =>
      props[_$key__onMouseOver___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a user releases a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseUp] -->
  @override
  get onMouseUp => (props[_$key__onMouseUp___$UbiquitousDomPropsMixin])
      as MouseEventCallback?;

  /// Callback for when a user releases a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseUp] -->
  @override
  set onMouseUp(value) =>
      props[_$key__onMouseUp___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointing device is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerCancel] -->
  @override
  get onPointerCancel =>
      (props[_$key__onPointerCancel___$UbiquitousDomPropsMixin])
          as PointerEventCallback?;

  /// Callback for when the pointing device is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerCancel] -->
  @override
  set onPointerCancel(value) =>
      props[_$key__onPointerCancel___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer becomes active over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerDown] -->
  @override
  get onPointerDown => (props[_$key__onPointerDown___$UbiquitousDomPropsMixin])
      as PointerEventCallback?;

  /// Callback for when the pointer becomes active over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerDown] -->
  @override
  set onPointerDown(value) =>
      props[_$key__onPointerDown___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerEnter] -->
  @override
  get onPointerEnter =>
      (props[_$key__onPointerEnter___$UbiquitousDomPropsMixin])
          as PointerEventCallback?;

  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerEnter] -->
  @override
  set onPointerEnter(value) =>
      props[_$key__onPointerEnter___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerLeave] -->
  @override
  get onPointerLeave =>
      (props[_$key__onPointerLeave___$UbiquitousDomPropsMixin])
          as PointerEventCallback?;

  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerLeave] -->
  @override
  set onPointerLeave(value) =>
      props[_$key__onPointerLeave___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerMove] -->
  @override
  get onPointerMove => (props[_$key__onPointerMove___$UbiquitousDomPropsMixin])
      as PointerEventCallback?;

  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerMove] -->
  @override
  set onPointerMove(value) =>
      props[_$key__onPointerMove___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerOver] -->
  @override
  get onPointerOver => (props[_$key__onPointerOver___$UbiquitousDomPropsMixin])
      as PointerEventCallback?;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerOver] -->
  @override
  set onPointerOver(value) =>
      props[_$key__onPointerOver___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerOut] -->
  @override
  get onPointerOut => (props[_$key__onPointerOut___$UbiquitousDomPropsMixin])
      as PointerEventCallback?;

  /// Callback for when the pointer is moved out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerOut] -->
  @override
  set onPointerOut(value) =>
      props[_$key__onPointerOut___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer becomes inactive over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerUp] -->
  @override
  get onPointerUp => (props[_$key__onPointerUp___$UbiquitousDomPropsMixin])
      as PointerEventCallback?;

  /// Callback for when the pointer becomes inactive over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPointerUp] -->
  @override
  set onPointerUp(value) =>
      props[_$key__onPointerUp___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the touch is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchCancel] -->
  @override
  get onTouchCancel => (props[_$key__onTouchCancel___$UbiquitousDomPropsMixin])
      as TouchEventCallback?;

  /// Callback for when the touch is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchCancel] -->
  @override
  set onTouchCancel(value) =>
      props[_$key__onTouchCancel___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is removed from a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchEnd] -->
  @override
  get onTouchEnd => (props[_$key__onTouchEnd___$UbiquitousDomPropsMixin])
      as TouchEventCallback?;

  /// Callback for when a finger is removed from a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchEnd] -->
  @override
  set onTouchEnd(value) =>
      props[_$key__onTouchEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is dragged across the screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchMove] -->
  @override
  get onTouchMove => (props[_$key__onTouchMove___$UbiquitousDomPropsMixin])
      as TouchEventCallback?;

  /// Callback for when a finger is dragged across the screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchMove] -->
  @override
  set onTouchMove(value) =>
      props[_$key__onTouchMove___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is placed on a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchStart] -->
  @override
  get onTouchStart => (props[_$key__onTouchStart___$UbiquitousDomPropsMixin])
      as TouchEventCallback?;

  /// Callback for when a finger is placed on a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchStart] -->
  @override
  set onTouchStart(value) =>
      props[_$key__onTouchStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a CSS transition has completed.
  ///
  /// > Related: [onAnimationEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTransitionEnd] -->
  @override
  get onTransitionEnd =>
      (props[_$key__onTransitionEnd___$UbiquitousDomPropsMixin])
          as TransitionEventCallback?;

  /// Callback for when a CSS transition has completed.
  ///
  /// > Related: [onAnimationEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTransitionEnd] -->
  @override
  set onTransitionEnd(value) =>
      props[_$key__onTransitionEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element's scrollbar is being scrolled
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onScroll] -->
  @override
  get onScroll =>
      (props[_$key__onScroll___$UbiquitousDomPropsMixin]) as UIEventCallback?;

  /// Callback for when an element's scrollbar is being scrolled
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onScroll] -->
  @override
  set onScroll(value) =>
      props[_$key__onScroll___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the mouse wheel rolls up or down over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onWheel] -->
  @override
  get onWheel =>
      (props[_$key__onWheel___$UbiquitousDomPropsMixin]) as WheelEventCallback?;

  /// Callback for when the mouse wheel rolls up or down over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onWheel] -->
  @override
  set onWheel(value) =>
      props[_$key__onWheel___$UbiquitousDomPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__tabIndex___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__tabIndex___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__id___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__id___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__title___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__title___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin =
      PropDescriptor(
          _$key___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onAnimationEnd___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onAnimationEnd___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onAnimationIteration___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onAnimationIteration___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onAnimationStart___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onAnimationStart___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onCopy___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onCopy___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onCut___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onCut___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPaste___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPaste___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onKeyDown___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onKeyDown___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onKeyPress___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onKeyPress___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onKeyUp___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onKeyUp___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onFocus___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onFocus___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onBlur___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onBlur___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onChange___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onChange___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onInput___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onInput___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onSubmit___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onSubmit___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onReset___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onReset___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onClick___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onClick___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onContextMenu___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onContextMenu___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDoubleClick___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDoubleClick___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDrag___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDrag___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragEnd___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragEnd___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragEnter___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragEnter___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragExit___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragExit___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragLeave___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragLeave___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragOver___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragOver___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDragStart___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDragStart___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onDrop___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onDrop___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseDown___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseDown___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseEnter___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseEnter___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseLeave___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseLeave___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseMove___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseMove___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseOut___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseOut___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseOver___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseOver___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onMouseUp___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onMouseUp___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onPointerCancel___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerCancel___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPointerDown___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerDown___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onPointerEnter___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerEnter___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onPointerLeave___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerLeave___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPointerMove___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerMove___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPointerOver___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerOver___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPointerOut___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerOut___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onPointerUp___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onPointerUp___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onTouchCancel___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onTouchCancel___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onTouchEnd___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onTouchEnd___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onTouchMove___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onTouchMove___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onTouchStart___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onTouchStart___$UbiquitousDomPropsMixin);
  static const PropDescriptor
      _$prop__onTransitionEnd___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onTransitionEnd___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onScroll___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onScroll___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__onWheel___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__onWheel___$UbiquitousDomPropsMixin);
  static const String _$key__tabIndex___$UbiquitousDomPropsMixin = 'tabIndex';
  static const String _$key__id___$UbiquitousDomPropsMixin = 'id';
  static const String _$key__title___$UbiquitousDomPropsMixin = 'title';
  static const String
      _$key___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin = 'style';
  static const String _$key__onAnimationEnd___$UbiquitousDomPropsMixin =
      'onAnimationEnd';
  static const String _$key__onAnimationIteration___$UbiquitousDomPropsMixin =
      'onAnimationIteration';
  static const String _$key__onAnimationStart___$UbiquitousDomPropsMixin =
      'onAnimationStart';
  static const String _$key__onCopy___$UbiquitousDomPropsMixin = 'onCopy';
  static const String _$key__onCut___$UbiquitousDomPropsMixin = 'onCut';
  static const String _$key__onPaste___$UbiquitousDomPropsMixin = 'onPaste';
  static const String _$key__onKeyDown___$UbiquitousDomPropsMixin = 'onKeyDown';
  static const String _$key__onKeyPress___$UbiquitousDomPropsMixin =
      'onKeyPress';
  static const String _$key__onKeyUp___$UbiquitousDomPropsMixin = 'onKeyUp';
  static const String _$key__onFocus___$UbiquitousDomPropsMixin = 'onFocus';
  static const String _$key__onBlur___$UbiquitousDomPropsMixin = 'onBlur';
  static const String _$key__onChange___$UbiquitousDomPropsMixin = 'onChange';
  static const String _$key__onInput___$UbiquitousDomPropsMixin = 'onInput';
  static const String _$key__onSubmit___$UbiquitousDomPropsMixin = 'onSubmit';
  static const String _$key__onReset___$UbiquitousDomPropsMixin = 'onReset';
  static const String _$key__onClick___$UbiquitousDomPropsMixin = 'onClick';
  static const String _$key__onContextMenu___$UbiquitousDomPropsMixin =
      'onContextMenu';
  static const String _$key__onDoubleClick___$UbiquitousDomPropsMixin =
      'onDoubleClick';
  static const String _$key__onDrag___$UbiquitousDomPropsMixin = 'onDrag';
  static const String _$key__onDragEnd___$UbiquitousDomPropsMixin = 'onDragEnd';
  static const String _$key__onDragEnter___$UbiquitousDomPropsMixin =
      'onDragEnter';
  static const String _$key__onDragExit___$UbiquitousDomPropsMixin =
      'onDragExit';
  static const String _$key__onDragLeave___$UbiquitousDomPropsMixin =
      'onDragLeave';
  static const String _$key__onDragOver___$UbiquitousDomPropsMixin =
      'onDragOver';
  static const String _$key__onDragStart___$UbiquitousDomPropsMixin =
      'onDragStart';
  static const String _$key__onDrop___$UbiquitousDomPropsMixin = 'onDrop';
  static const String _$key__onMouseDown___$UbiquitousDomPropsMixin =
      'onMouseDown';
  static const String _$key__onMouseEnter___$UbiquitousDomPropsMixin =
      'onMouseEnter';
  static const String _$key__onMouseLeave___$UbiquitousDomPropsMixin =
      'onMouseLeave';
  static const String _$key__onMouseMove___$UbiquitousDomPropsMixin =
      'onMouseMove';
  static const String _$key__onMouseOut___$UbiquitousDomPropsMixin =
      'onMouseOut';
  static const String _$key__onMouseOver___$UbiquitousDomPropsMixin =
      'onMouseOver';
  static const String _$key__onMouseUp___$UbiquitousDomPropsMixin = 'onMouseUp';
  static const String _$key__onPointerCancel___$UbiquitousDomPropsMixin =
      'onPointerCancel';
  static const String _$key__onPointerDown___$UbiquitousDomPropsMixin =
      'onPointerDown';
  static const String _$key__onPointerEnter___$UbiquitousDomPropsMixin =
      'onPointerEnter';
  static const String _$key__onPointerLeave___$UbiquitousDomPropsMixin =
      'onPointerLeave';
  static const String _$key__onPointerMove___$UbiquitousDomPropsMixin =
      'onPointerMove';
  static const String _$key__onPointerOver___$UbiquitousDomPropsMixin =
      'onPointerOver';
  static const String _$key__onPointerOut___$UbiquitousDomPropsMixin =
      'onPointerOut';
  static const String _$key__onPointerUp___$UbiquitousDomPropsMixin =
      'onPointerUp';
  static const String _$key__onTouchCancel___$UbiquitousDomPropsMixin =
      'onTouchCancel';
  static const String _$key__onTouchEnd___$UbiquitousDomPropsMixin =
      'onTouchEnd';
  static const String _$key__onTouchMove___$UbiquitousDomPropsMixin =
      'onTouchMove';
  static const String _$key__onTouchStart___$UbiquitousDomPropsMixin =
      'onTouchStart';
  static const String _$key__onTransitionEnd___$UbiquitousDomPropsMixin =
      'onTransitionEnd';
  static const String _$key__onScroll___$UbiquitousDomPropsMixin = 'onScroll';
  static const String _$key__onWheel___$UbiquitousDomPropsMixin = 'onWheel';

  static const List<PropDescriptor> $props = [
    _$prop__tabIndex___$UbiquitousDomPropsMixin,
    _$prop__id___$UbiquitousDomPropsMixin,
    _$prop__title___$UbiquitousDomPropsMixin,
    _$prop___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin,
    _$prop__onAnimationEnd___$UbiquitousDomPropsMixin,
    _$prop__onAnimationIteration___$UbiquitousDomPropsMixin,
    _$prop__onAnimationStart___$UbiquitousDomPropsMixin,
    _$prop__onCopy___$UbiquitousDomPropsMixin,
    _$prop__onCut___$UbiquitousDomPropsMixin,
    _$prop__onPaste___$UbiquitousDomPropsMixin,
    _$prop__onKeyDown___$UbiquitousDomPropsMixin,
    _$prop__onKeyPress___$UbiquitousDomPropsMixin,
    _$prop__onKeyUp___$UbiquitousDomPropsMixin,
    _$prop__onFocus___$UbiquitousDomPropsMixin,
    _$prop__onBlur___$UbiquitousDomPropsMixin,
    _$prop__onChange___$UbiquitousDomPropsMixin,
    _$prop__onInput___$UbiquitousDomPropsMixin,
    _$prop__onSubmit___$UbiquitousDomPropsMixin,
    _$prop__onReset___$UbiquitousDomPropsMixin,
    _$prop__onClick___$UbiquitousDomPropsMixin,
    _$prop__onContextMenu___$UbiquitousDomPropsMixin,
    _$prop__onDoubleClick___$UbiquitousDomPropsMixin,
    _$prop__onDrag___$UbiquitousDomPropsMixin,
    _$prop__onDragEnd___$UbiquitousDomPropsMixin,
    _$prop__onDragEnter___$UbiquitousDomPropsMixin,
    _$prop__onDragExit___$UbiquitousDomPropsMixin,
    _$prop__onDragLeave___$UbiquitousDomPropsMixin,
    _$prop__onDragOver___$UbiquitousDomPropsMixin,
    _$prop__onDragStart___$UbiquitousDomPropsMixin,
    _$prop__onDrop___$UbiquitousDomPropsMixin,
    _$prop__onMouseDown___$UbiquitousDomPropsMixin,
    _$prop__onMouseEnter___$UbiquitousDomPropsMixin,
    _$prop__onMouseLeave___$UbiquitousDomPropsMixin,
    _$prop__onMouseMove___$UbiquitousDomPropsMixin,
    _$prop__onMouseOut___$UbiquitousDomPropsMixin,
    _$prop__onMouseOver___$UbiquitousDomPropsMixin,
    _$prop__onMouseUp___$UbiquitousDomPropsMixin,
    _$prop__onPointerCancel___$UbiquitousDomPropsMixin,
    _$prop__onPointerDown___$UbiquitousDomPropsMixin,
    _$prop__onPointerEnter___$UbiquitousDomPropsMixin,
    _$prop__onPointerLeave___$UbiquitousDomPropsMixin,
    _$prop__onPointerMove___$UbiquitousDomPropsMixin,
    _$prop__onPointerOver___$UbiquitousDomPropsMixin,
    _$prop__onPointerOut___$UbiquitousDomPropsMixin,
    _$prop__onPointerUp___$UbiquitousDomPropsMixin,
    _$prop__onTouchCancel___$UbiquitousDomPropsMixin,
    _$prop__onTouchEnd___$UbiquitousDomPropsMixin,
    _$prop__onTouchMove___$UbiquitousDomPropsMixin,
    _$prop__onTouchStart___$UbiquitousDomPropsMixin,
    _$prop__onTransitionEnd___$UbiquitousDomPropsMixin,
    _$prop__onScroll___$UbiquitousDomPropsMixin,
    _$prop__onWheel___$UbiquitousDomPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__tabIndex___$UbiquitousDomPropsMixin,
    _$key__id___$UbiquitousDomPropsMixin,
    _$key__title___$UbiquitousDomPropsMixin,
    _$key___raw$UbiquitousDomProps$style___$UbiquitousDomPropsMixin,
    _$key__onAnimationEnd___$UbiquitousDomPropsMixin,
    _$key__onAnimationIteration___$UbiquitousDomPropsMixin,
    _$key__onAnimationStart___$UbiquitousDomPropsMixin,
    _$key__onCopy___$UbiquitousDomPropsMixin,
    _$key__onCut___$UbiquitousDomPropsMixin,
    _$key__onPaste___$UbiquitousDomPropsMixin,
    _$key__onKeyDown___$UbiquitousDomPropsMixin,
    _$key__onKeyPress___$UbiquitousDomPropsMixin,
    _$key__onKeyUp___$UbiquitousDomPropsMixin,
    _$key__onFocus___$UbiquitousDomPropsMixin,
    _$key__onBlur___$UbiquitousDomPropsMixin,
    _$key__onChange___$UbiquitousDomPropsMixin,
    _$key__onInput___$UbiquitousDomPropsMixin,
    _$key__onSubmit___$UbiquitousDomPropsMixin,
    _$key__onReset___$UbiquitousDomPropsMixin,
    _$key__onClick___$UbiquitousDomPropsMixin,
    _$key__onContextMenu___$UbiquitousDomPropsMixin,
    _$key__onDoubleClick___$UbiquitousDomPropsMixin,
    _$key__onDrag___$UbiquitousDomPropsMixin,
    _$key__onDragEnd___$UbiquitousDomPropsMixin,
    _$key__onDragEnter___$UbiquitousDomPropsMixin,
    _$key__onDragExit___$UbiquitousDomPropsMixin,
    _$key__onDragLeave___$UbiquitousDomPropsMixin,
    _$key__onDragOver___$UbiquitousDomPropsMixin,
    _$key__onDragStart___$UbiquitousDomPropsMixin,
    _$key__onDrop___$UbiquitousDomPropsMixin,
    _$key__onMouseDown___$UbiquitousDomPropsMixin,
    _$key__onMouseEnter___$UbiquitousDomPropsMixin,
    _$key__onMouseLeave___$UbiquitousDomPropsMixin,
    _$key__onMouseMove___$UbiquitousDomPropsMixin,
    _$key__onMouseOut___$UbiquitousDomPropsMixin,
    _$key__onMouseOver___$UbiquitousDomPropsMixin,
    _$key__onMouseUp___$UbiquitousDomPropsMixin,
    _$key__onPointerCancel___$UbiquitousDomPropsMixin,
    _$key__onPointerDown___$UbiquitousDomPropsMixin,
    _$key__onPointerEnter___$UbiquitousDomPropsMixin,
    _$key__onPointerLeave___$UbiquitousDomPropsMixin,
    _$key__onPointerMove___$UbiquitousDomPropsMixin,
    _$key__onPointerOver___$UbiquitousDomPropsMixin,
    _$key__onPointerOut___$UbiquitousDomPropsMixin,
    _$key__onPointerUp___$UbiquitousDomPropsMixin,
    _$key__onTouchCancel___$UbiquitousDomPropsMixin,
    _$key__onTouchEnd___$UbiquitousDomPropsMixin,
    _$key__onTouchMove___$UbiquitousDomPropsMixin,
    _$key__onTouchStart___$UbiquitousDomPropsMixin,
    _$key__onTransitionEnd___$UbiquitousDomPropsMixin,
    _$key__onScroll___$UbiquitousDomPropsMixin,
    _$key__onWheel___$UbiquitousDomPropsMixin
  ];
}

const PropsMeta _$metaForUbiquitousDomPropsMixin = PropsMeta(
  fields: UbiquitousDomPropsMixin.$props,
  keys: UbiquitousDomPropsMixin.$propKeys,
);
