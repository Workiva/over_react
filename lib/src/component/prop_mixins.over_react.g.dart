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
  String get key => props['key'];
  @override
  set key(Object value) =>
      props['key'] = value == null ? null : value.toString();

  /// The children that were passed in to this component when it was built.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.children] -->
  @override
  List get children =>
      props[_$key__children___$ReactPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The children that were passed in to this component when it was built.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.children] -->
  @override
  set children(List value) => props[_$key__children___$ReactPropsMixin] = value;

  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.ref] -->
  @override
  dynamic get ref =>
      props[_$key__ref___$ReactPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  ///
  /// <!-- Generated from [_$ReactPropsMixin.ref] -->
  @override
  set ref(dynamic value) => props[_$key__ref___$ReactPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__children___$ReactPropsMixin =
      PropDescriptor(_$key__children___$ReactPropsMixin);
  static const PropDescriptor _$prop__ref___$ReactPropsMixin =
      PropDescriptor(_$key__ref___$ReactPropsMixin);
  static const String _$key__children___$ReactPropsMixin = 'children';
  static const String _$key__ref___$ReactPropsMixin = 'ref';

  static const List<PropDescriptor> $props = [
    _$prop__children___$ReactPropsMixin,
    _$prop__ref___$ReactPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__children___$ReactPropsMixin,
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

  /// <!-- Generated from [_$DomPropsMixin.cols] -->
  @override
  int get cols =>
      props[_$key__cols___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.cols] -->
  @override
  set cols(int value) => props[_$key__cols___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rows] -->
  @override
  int get rows =>
      props[_$key__rows___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.rows] -->
  @override
  set rows(int value) => props[_$key__rows___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.size] -->
  @override
  int get size =>
      props[_$key__size___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.size] -->
  @override
  set size(int value) => props[_$key__size___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.span] -->
  @override
  int get span =>
      props[_$key__span___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.span] -->
  @override
  set span(int value) => props[_$key__span___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.start] -->
  @override
  int get start =>
      props[_$key__start___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.start] -->
  @override
  set start(int value) => props[_$key__start___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.allowFullScreen] -->
  @override
  bool get allowFullScreen =>
      props[_$key__allowFullScreen___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.allowFullScreen] -->
  @override
  set allowFullScreen(bool value) =>
      props[_$key__allowFullScreen___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.async] -->
  @override
  bool get async =>
      props[_$key__async___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.async] -->
  @override
  set async(bool value) => props[_$key__async___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.autoPlay] -->
  @override
  bool get autoPlay =>
      props[_$key__autoPlay___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.autoPlay] -->
  @override
  set autoPlay(bool value) => props[_$key__autoPlay___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.checked] -->
  @override
  bool get checked =>
      props[_$key__checked___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.checked] -->
  @override
  set checked(bool value) => props[_$key__checked___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.controls] -->
  @override
  bool get controls =>
      props[_$key__controls___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.controls] -->
  @override
  set controls(bool value) => props[_$key__controls___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defer] -->
  @override
  bool get defer =>
      props[_$key__defer___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.defer] -->
  @override
  set defer(bool value) => props[_$key__defer___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.disabled] -->
  @override
  bool get disabled =>
      props[_$key__disabled___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.disabled] -->
  @override
  set disabled(bool value) => props[_$key__disabled___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.formNoValidate] -->
  @override
  bool get formNoValidate =>
      props[_$key__formNoValidate___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.formNoValidate] -->
  @override
  set formNoValidate(bool value) =>
      props[_$key__formNoValidate___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.hidden] -->
  @override
  bool get hidden =>
      props[_$key__hidden___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.hidden] -->
  @override
  set hidden(bool value) => props[_$key__hidden___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.loop] -->
  @override
  bool get loop =>
      props[_$key__loop___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.loop] -->
  @override
  set loop(bool value) => props[_$key__loop___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.multiple] -->
  @override
  bool get multiple =>
      props[_$key__multiple___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.multiple] -->
  @override
  set multiple(bool value) => props[_$key__multiple___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.muted] -->
  @override
  bool get muted =>
      props[_$key__muted___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.muted] -->
  @override
  set muted(bool value) => props[_$key__muted___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.noValidate] -->
  @override
  bool get noValidate =>
      props[_$key__noValidate___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.noValidate] -->
  @override
  set noValidate(bool value) =>
      props[_$key__noValidate___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.open] -->
  @override
  bool get open =>
      props[_$key__open___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.open] -->
  @override
  set open(bool value) => props[_$key__open___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.readOnly] -->
  @override
  bool get readOnly =>
      props[_$key__readOnly___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.readOnly] -->
  @override
  set readOnly(bool value) => props[_$key__readOnly___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.required] -->
  @override
  bool get required =>
      props[_$key__required___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.required] -->
  @override
  set required(bool value) => props[_$key__required___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.seamless] -->
  @override
  bool get seamless =>
      props[_$key__seamless___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.seamless] -->
  @override
  set seamless(bool value) => props[_$key__seamless___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.selected] -->
  @override
  bool get selected =>
      props[_$key__selected___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.selected] -->
  @override
  set selected(bool value) => props[_$key__selected___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.style] -->
  @override
  Map<String, dynamic> get style =>
      props[_$key__style___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.style] -->
  @override
  set style(Map<String, dynamic> value) =>
      props[_$key__style___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.className] -->
  @override
  String get className =>
      props[_$key__className___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.className] -->
  @override
  set className(String value) =>
      props[_$key__className___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.title] -->
  @override
  String get title =>
      props[_$key__title___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.title] -->
  @override
  set title(String value) => props[_$key__title___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.id] -->
  @override
  String get id =>
      props[_$key__id___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.id] -->
  @override
  set id(String value) => props[_$key__id___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.accept] -->
  @override
  dynamic get accept =>
      props[_$key__accept___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.accept] -->
  @override
  set accept(dynamic value) => props[_$key__accept___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.acceptCharset] -->
  @override
  dynamic get acceptCharset =>
      props[_$key__acceptCharset___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.acceptCharset] -->
  @override
  set acceptCharset(dynamic value) =>
      props[_$key__acceptCharset___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.accessKey] -->
  @override
  dynamic get accessKey =>
      props[_$key__accessKey___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.accessKey] -->
  @override
  set accessKey(dynamic value) =>
      props[_$key__accessKey___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.action] -->
  @override
  dynamic get action =>
      props[_$key__action___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.action] -->
  @override
  set action(dynamic value) => props[_$key__action___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.allowTransparency] -->
  @override
  dynamic get allowTransparency =>
      props[_$key__allowTransparency___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.allowTransparency] -->
  @override
  set allowTransparency(dynamic value) =>
      props[_$key__allowTransparency___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.alt] -->
  @override
  dynamic get alt =>
      props[_$key__alt___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.alt] -->
  @override
  set alt(dynamic value) => props[_$key__alt___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.autoComplete] -->
  @override
  dynamic get autoComplete =>
      props[_$key__autoComplete___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.autoComplete] -->
  @override
  set autoComplete(dynamic value) =>
      props[_$key__autoComplete___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.cellPadding] -->
  @override
  dynamic get cellPadding =>
      props[_$key__cellPadding___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.cellPadding] -->
  @override
  set cellPadding(dynamic value) =>
      props[_$key__cellPadding___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.cellSpacing] -->
  @override
  dynamic get cellSpacing =>
      props[_$key__cellSpacing___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.cellSpacing] -->
  @override
  set cellSpacing(dynamic value) =>
      props[_$key__cellSpacing___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.charSet] -->
  @override
  dynamic get charSet =>
      props[_$key__charSet___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.charSet] -->
  @override
  set charSet(dynamic value) => props[_$key__charSet___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.classID] -->
  @override
  dynamic get classID =>
      props[_$key__classID___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.classID] -->
  @override
  set classID(dynamic value) => props[_$key__classID___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.colSpan] -->
  @override
  dynamic get colSpan =>
      props[_$key__colSpan___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.colSpan] -->
  @override
  set colSpan(dynamic value) => props[_$key__colSpan___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.content] -->
  @override
  dynamic get content =>
      props[_$key__content___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.content] -->
  @override
  set content(dynamic value) => props[_$key__content___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.contentEditable] -->
  @override
  dynamic get contentEditable =>
      props[_$key__contentEditable___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.contentEditable] -->
  @override
  set contentEditable(dynamic value) =>
      props[_$key__contentEditable___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.contextMenu] -->
  @override
  dynamic get contextMenu =>
      props[_$key__contextMenu___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.contextMenu] -->
  @override
  set contextMenu(dynamic value) =>
      props[_$key__contextMenu___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.coords] -->
  @override
  dynamic get coords =>
      props[_$key__coords___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.coords] -->
  @override
  set coords(dynamic value) => props[_$key__coords___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.crossOrigin] -->
  @override
  dynamic get crossOrigin =>
      props[_$key__crossOrigin___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.crossOrigin] -->
  @override
  set crossOrigin(dynamic value) =>
      props[_$key__crossOrigin___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.data] -->
  @override
  dynamic get data =>
      props[_$key__data___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.data] -->
  @override
  set data(dynamic value) => props[_$key__data___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.dateTime] -->
  @override
  dynamic get dateTime =>
      props[_$key__dateTime___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.dateTime] -->
  @override
  set dateTime(dynamic value) =>
      props[_$key__dateTime___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.dir] -->
  @override
  dynamic get dir =>
      props[_$key__dir___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.dir] -->
  @override
  set dir(dynamic value) => props[_$key__dir___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.download] -->
  @override
  dynamic get download =>
      props[_$key__download___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.download] -->
  @override
  set download(dynamic value) =>
      props[_$key__download___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.draggable] -->
  @override
  dynamic get draggable =>
      props[_$key__draggable___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.draggable] -->
  @override
  set draggable(dynamic value) =>
      props[_$key__draggable___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.encType] -->
  @override
  dynamic get encType =>
      props[_$key__encType___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.encType] -->
  @override
  set encType(dynamic value) => props[_$key__encType___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.form] -->
  @override
  dynamic get form =>
      props[_$key__form___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.form] -->
  @override
  set form(dynamic value) => props[_$key__form___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.frameBorder] -->
  @override
  dynamic get frameBorder =>
      props[_$key__frameBorder___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.frameBorder] -->
  @override
  set frameBorder(dynamic value) =>
      props[_$key__frameBorder___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.height] -->
  @override
  dynamic get height =>
      props[_$key__height___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.height] -->
  @override
  set height(dynamic value) => props[_$key__height___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.href] -->
  @override
  dynamic get href =>
      props[_$key__href___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.href] -->
  @override
  set href(dynamic value) => props[_$key__href___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.hrefLang] -->
  @override
  dynamic get hrefLang =>
      props[_$key__hrefLang___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.hrefLang] -->
  @override
  set hrefLang(dynamic value) =>
      props[_$key__hrefLang___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.htmlFor] -->
  @override
  dynamic get htmlFor =>
      props[_$key__htmlFor___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.htmlFor] -->
  @override
  set htmlFor(dynamic value) => props[_$key__htmlFor___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.httpEquiv] -->
  @override
  dynamic get httpEquiv =>
      props[_$key__httpEquiv___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.httpEquiv] -->
  @override
  set httpEquiv(dynamic value) =>
      props[_$key__httpEquiv___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.icon] -->
  @override
  dynamic get icon =>
      props[_$key__icon___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.icon] -->
  @override
  set icon(dynamic value) => props[_$key__icon___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.label] -->
  @override
  dynamic get label =>
      props[_$key__label___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.label] -->
  @override
  set label(dynamic value) => props[_$key__label___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.lang] -->
  @override
  dynamic get lang =>
      props[_$key__lang___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.lang] -->
  @override
  set lang(dynamic value) => props[_$key__lang___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.list] -->
  @override
  dynamic get list =>
      props[_$key__list___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.list] -->
  @override
  set list(dynamic value) => props[_$key__list___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.manifest] -->
  @override
  dynamic get manifest =>
      props[_$key__manifest___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.manifest] -->
  @override
  set manifest(dynamic value) =>
      props[_$key__manifest___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.max] -->
  @override
  dynamic get max =>
      props[_$key__max___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.max] -->
  @override
  set max(dynamic value) => props[_$key__max___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.maxLength] -->
  @override
  dynamic get maxLength =>
      props[_$key__maxLength___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.maxLength] -->
  @override
  set maxLength(dynamic value) =>
      props[_$key__maxLength___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.media] -->
  @override
  dynamic get media =>
      props[_$key__media___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.media] -->
  @override
  set media(dynamic value) => props[_$key__media___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.mediaGroup] -->
  @override
  dynamic get mediaGroup =>
      props[_$key__mediaGroup___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.mediaGroup] -->
  @override
  set mediaGroup(dynamic value) =>
      props[_$key__mediaGroup___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.method] -->
  @override
  dynamic get method =>
      props[_$key__method___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.method] -->
  @override
  set method(dynamic value) => props[_$key__method___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.min] -->
  @override
  dynamic get min =>
      props[_$key__min___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.min] -->
  @override
  set min(dynamic value) => props[_$key__min___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.name] -->
  @override
  dynamic get name =>
      props[_$key__name___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.name] -->
  @override
  set name(dynamic value) => props[_$key__name___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.pattern] -->
  @override
  dynamic get pattern =>
      props[_$key__pattern___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.pattern] -->
  @override
  set pattern(dynamic value) => props[_$key__pattern___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.placeholder] -->
  @override
  dynamic get placeholder =>
      props[_$key__placeholder___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.placeholder] -->
  @override
  set placeholder(dynamic value) =>
      props[_$key__placeholder___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.poster] -->
  @override
  dynamic get poster =>
      props[_$key__poster___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.poster] -->
  @override
  set poster(dynamic value) => props[_$key__poster___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.preload] -->
  @override
  dynamic get preload =>
      props[_$key__preload___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.preload] -->
  @override
  set preload(dynamic value) => props[_$key__preload___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.radioGroup] -->
  @override
  dynamic get radioGroup =>
      props[_$key__radioGroup___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.radioGroup] -->
  @override
  set radioGroup(dynamic value) =>
      props[_$key__radioGroup___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rel] -->
  @override
  dynamic get rel =>
      props[_$key__rel___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.rel] -->
  @override
  set rel(dynamic value) => props[_$key__rel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.role] -->
  @override
  dynamic get role =>
      props[_$key__role___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.role] -->
  @override
  set role(dynamic value) => props[_$key__role___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.rowSpan] -->
  @override
  dynamic get rowSpan =>
      props[_$key__rowSpan___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.rowSpan] -->
  @override
  set rowSpan(dynamic value) => props[_$key__rowSpan___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.sandbox] -->
  @override
  dynamic get sandbox =>
      props[_$key__sandbox___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.sandbox] -->
  @override
  set sandbox(dynamic value) => props[_$key__sandbox___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.scope] -->
  @override
  dynamic get scope =>
      props[_$key__scope___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.scope] -->
  @override
  set scope(dynamic value) => props[_$key__scope___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.scrolling] -->
  @override
  dynamic get scrolling =>
      props[_$key__scrolling___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.scrolling] -->
  @override
  set scrolling(dynamic value) =>
      props[_$key__scrolling___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.shape] -->
  @override
  dynamic get shape =>
      props[_$key__shape___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.shape] -->
  @override
  set shape(dynamic value) => props[_$key__shape___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.sizes] -->
  @override
  dynamic get sizes =>
      props[_$key__sizes___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.sizes] -->
  @override
  set sizes(dynamic value) => props[_$key__sizes___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.spellCheck] -->
  @override
  dynamic get spellCheck =>
      props[_$key__spellCheck___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.spellCheck] -->
  @override
  set spellCheck(dynamic value) =>
      props[_$key__spellCheck___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.src] -->
  @override
  dynamic get src =>
      props[_$key__src___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.src] -->
  @override
  set src(dynamic value) => props[_$key__src___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.srcDoc] -->
  @override
  dynamic get srcDoc =>
      props[_$key__srcDoc___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.srcDoc] -->
  @override
  set srcDoc(dynamic value) => props[_$key__srcDoc___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.srcSet] -->
  @override
  dynamic get srcSet =>
      props[_$key__srcSet___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.srcSet] -->
  @override
  set srcSet(dynamic value) => props[_$key__srcSet___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.step] -->
  @override
  dynamic get step =>
      props[_$key__step___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.step] -->
  @override
  set step(dynamic value) => props[_$key__step___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.tabIndex] -->
  @override
  dynamic get tabIndex =>
      props[_$key__tabIndex___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.tabIndex] -->
  @override
  set tabIndex(dynamic value) =>
      props[_$key__tabIndex___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.target] -->
  @override
  dynamic get target =>
      props[_$key__target___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.target] -->
  @override
  set target(dynamic value) => props[_$key__target___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.type] -->
  @override
  dynamic get type =>
      props[_$key__type___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.type] -->
  @override
  set type(dynamic value) => props[_$key__type___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.useMap] -->
  @override
  dynamic get useMap =>
      props[_$key__useMap___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.useMap] -->
  @override
  set useMap(dynamic value) => props[_$key__useMap___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.value] -->
  @override
  dynamic get value =>
      props[_$key__value___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.value] -->
  @override
  set value(dynamic value) => props[_$key__value___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.width] -->
  @override
  dynamic get width =>
      props[_$key__width___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.width] -->
  @override
  set width(dynamic value) => props[_$key__width___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.wmode] -->
  @override
  dynamic get wmode =>
      props[_$key__wmode___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.wmode] -->
  @override
  set wmode(dynamic value) => props[_$key__wmode___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationEnd] -->
  @override
  AnimationEventCallback get onAnimationEnd =>
      props[_$key__onAnimationEnd___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onAnimationEnd] -->
  @override
  set onAnimationEnd(AnimationEventCallback value) =>
      props[_$key__onAnimationEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationIteration] -->
  @override
  AnimationEventCallback get onAnimationIteration =>
      props[_$key__onAnimationIteration___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onAnimationIteration] -->
  @override
  set onAnimationIteration(AnimationEventCallback value) =>
      props[_$key__onAnimationIteration___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onAnimationStart] -->
  @override
  AnimationEventCallback get onAnimationStart =>
      props[_$key__onAnimationStart___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onAnimationStart] -->
  @override
  set onAnimationStart(AnimationEventCallback value) =>
      props[_$key__onAnimationStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCopy] -->
  @override
  ClipboardEventCallback get onCopy =>
      props[_$key__onCopy___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onCopy] -->
  @override
  set onCopy(ClipboardEventCallback value) =>
      props[_$key__onCopy___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCut] -->
  @override
  ClipboardEventCallback get onCut =>
      props[_$key__onCut___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onCut] -->
  @override
  set onCut(ClipboardEventCallback value) =>
      props[_$key__onCut___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPaste] -->
  @override
  ClipboardEventCallback get onPaste =>
      props[_$key__onPaste___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onPaste] -->
  @override
  set onPaste(ClipboardEventCallback value) =>
      props[_$key__onPaste___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDown] -->
  @override
  KeyboardEventCallback get onKeyDown =>
      props[_$key__onKeyDown___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyDown] -->
  @override
  set onKeyDown(KeyboardEventCallback value) =>
      props[_$key__onKeyDown___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPress] -->
  @override
  KeyboardEventCallback get onKeyPress =>
      props[_$key__onKeyPress___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyPress] -->
  @override
  set onKeyPress(KeyboardEventCallback value) =>
      props[_$key__onKeyPress___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUp] -->
  @override
  KeyboardEventCallback get onKeyUp =>
      props[_$key__onKeyUp___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyUp] -->
  @override
  set onKeyUp(KeyboardEventCallback value) =>
      props[_$key__onKeyUp___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onFocus] -->
  @override
  FocusEventCallback get onFocus =>
      props[_$key__onFocus___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onFocus] -->
  @override
  set onFocus(FocusEventCallback value) =>
      props[_$key__onFocus___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onBlur] -->
  @override
  FocusEventCallback get onBlur =>
      props[_$key__onBlur___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onBlur] -->
  @override
  set onBlur(FocusEventCallback value) =>
      props[_$key__onBlur___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onChange] -->
  @override
  FormEventCallback get onChange =>
      props[_$key__onChange___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onChange] -->
  @override
  set onChange(FormEventCallback value) =>
      props[_$key__onChange___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onInput] -->
  @override
  FormEventCallback get onInput =>
      props[_$key__onInput___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onInput] -->
  @override
  set onInput(FormEventCallback value) =>
      props[_$key__onInput___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onSubmit] -->
  @override
  FormEventCallback get onSubmit =>
      props[_$key__onSubmit___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onSubmit] -->
  @override
  set onSubmit(FormEventCallback value) =>
      props[_$key__onSubmit___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onReset] -->
  @override
  FormEventCallback get onReset =>
      props[_$key__onReset___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onReset] -->
  @override
  set onReset(FormEventCallback value) =>
      props[_$key__onReset___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onClick] -->
  @override
  MouseEventCallback get onClick =>
      props[_$key__onClick___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onClick] -->
  @override
  set onClick(MouseEventCallback value) =>
      props[_$key__onClick___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenu] -->
  @override
  MouseEventCallback get onContextMenu =>
      props[_$key__onContextMenu___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onContextMenu] -->
  @override
  set onContextMenu(MouseEventCallback value) =>
      props[_$key__onContextMenu___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClick] -->
  @override
  MouseEventCallback get onDoubleClick =>
      props[_$key__onDoubleClick___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDoubleClick] -->
  @override
  set onDoubleClick(MouseEventCallback value) =>
      props[_$key__onDoubleClick___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDrag] -->
  @override
  MouseEventCallback get onDrag =>
      props[_$key__onDrag___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDrag] -->
  @override
  set onDrag(MouseEventCallback value) =>
      props[_$key__onDrag___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnd] -->
  @override
  MouseEventCallback get onDragEnd =>
      props[_$key__onDragEnd___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragEnd] -->
  @override
  set onDragEnd(MouseEventCallback value) =>
      props[_$key__onDragEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnter] -->
  @override
  MouseEventCallback get onDragEnter =>
      props[_$key__onDragEnter___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragEnter] -->
  @override
  set onDragEnter(MouseEventCallback value) =>
      props[_$key__onDragEnter___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragExit] -->
  @override
  MouseEventCallback get onDragExit =>
      props[_$key__onDragExit___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragExit] -->
  @override
  set onDragExit(MouseEventCallback value) =>
      props[_$key__onDragExit___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeave] -->
  @override
  MouseEventCallback get onDragLeave =>
      props[_$key__onDragLeave___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragLeave] -->
  @override
  set onDragLeave(MouseEventCallback value) =>
      props[_$key__onDragLeave___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragOver] -->
  @override
  MouseEventCallback get onDragOver =>
      props[_$key__onDragOver___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragOver] -->
  @override
  set onDragOver(MouseEventCallback value) =>
      props[_$key__onDragOver___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragStart] -->
  @override
  MouseEventCallback get onDragStart =>
      props[_$key__onDragStart___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragStart] -->
  @override
  set onDragStart(MouseEventCallback value) =>
      props[_$key__onDragStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDrop] -->
  @override
  MouseEventCallback get onDrop =>
      props[_$key__onDrop___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDrop] -->
  @override
  set onDrop(MouseEventCallback value) =>
      props[_$key__onDrop___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDown] -->
  @override
  MouseEventCallback get onMouseDown =>
      props[_$key__onMouseDown___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseDown] -->
  @override
  set onMouseDown(MouseEventCallback value) =>
      props[_$key__onMouseDown___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnter] -->
  @override
  MouseEventCallback get onMouseEnter =>
      props[_$key__onMouseEnter___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseEnter] -->
  @override
  set onMouseEnter(MouseEventCallback value) =>
      props[_$key__onMouseEnter___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeave] -->
  @override
  MouseEventCallback get onMouseLeave =>
      props[_$key__onMouseLeave___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseLeave] -->
  @override
  set onMouseLeave(MouseEventCallback value) =>
      props[_$key__onMouseLeave___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMove] -->
  @override
  MouseEventCallback get onMouseMove =>
      props[_$key__onMouseMove___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseMove] -->
  @override
  set onMouseMove(MouseEventCallback value) =>
      props[_$key__onMouseMove___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOut] -->
  @override
  MouseEventCallback get onMouseOut =>
      props[_$key__onMouseOut___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseOut] -->
  @override
  set onMouseOut(MouseEventCallback value) =>
      props[_$key__onMouseOut___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOver] -->
  @override
  MouseEventCallback get onMouseOver =>
      props[_$key__onMouseOver___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseOver] -->
  @override
  set onMouseOver(MouseEventCallback value) =>
      props[_$key__onMouseOver___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUp] -->
  @override
  MouseEventCallback get onMouseUp =>
      props[_$key__onMouseUp___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseUp] -->
  @override
  set onMouseUp(MouseEventCallback value) =>
      props[_$key__onMouseUp___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancel] -->
  @override
  TouchEventCallback get onTouchCancel =>
      props[_$key__onTouchCancel___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchCancel] -->
  @override
  set onTouchCancel(TouchEventCallback value) =>
      props[_$key__onTouchCancel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEnd] -->
  @override
  TouchEventCallback get onTouchEnd =>
      props[_$key__onTouchEnd___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchEnd] -->
  @override
  set onTouchEnd(TouchEventCallback value) =>
      props[_$key__onTouchEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMove] -->
  @override
  TouchEventCallback get onTouchMove =>
      props[_$key__onTouchMove___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchMove] -->
  @override
  set onTouchMove(TouchEventCallback value) =>
      props[_$key__onTouchMove___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStart] -->
  @override
  TouchEventCallback get onTouchStart =>
      props[_$key__onTouchStart___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchStart] -->
  @override
  set onTouchStart(TouchEventCallback value) =>
      props[_$key__onTouchStart___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTransitionEnd] -->
  @override
  TransitionEventCallback get onTransitionEnd =>
      props[_$key__onTransitionEnd___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTransitionEnd] -->
  @override
  set onTransitionEnd(TransitionEventCallback value) =>
      props[_$key__onTransitionEnd___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onScroll] -->
  @override
  UIEventCallback get onScroll =>
      props[_$key__onScroll___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onScroll] -->
  @override
  set onScroll(UIEventCallback value) =>
      props[_$key__onScroll___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onWheel] -->
  @override
  WheelEventCallback get onWheel =>
      props[_$key__onWheel___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onWheel] -->
  @override
  set onWheel(WheelEventCallback value) =>
      props[_$key__onWheel___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCopyCapture] -->
  @override
  ClipboardEventCallback get onCopyCapture =>
      props[_$key__onCopyCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onCopyCapture] -->
  @override
  set onCopyCapture(ClipboardEventCallback value) =>
      props[_$key__onCopyCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onCutCapture] -->
  @override
  ClipboardEventCallback get onCutCapture =>
      props[_$key__onCutCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onCutCapture] -->
  @override
  set onCutCapture(ClipboardEventCallback value) =>
      props[_$key__onCutCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onPasteCapture] -->
  @override
  ClipboardEventCallback get onPasteCapture =>
      props[_$key__onPasteCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onPasteCapture] -->
  @override
  set onPasteCapture(ClipboardEventCallback value) =>
      props[_$key__onPasteCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyDownCapture] -->
  @override
  KeyboardEventCallback get onKeyDownCapture =>
      props[_$key__onKeyDownCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyDownCapture] -->
  @override
  set onKeyDownCapture(KeyboardEventCallback value) =>
      props[_$key__onKeyDownCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyPressCapture] -->
  @override
  KeyboardEventCallback get onKeyPressCapture =>
      props[_$key__onKeyPressCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyPressCapture] -->
  @override
  set onKeyPressCapture(KeyboardEventCallback value) =>
      props[_$key__onKeyPressCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onKeyUpCapture] -->
  @override
  KeyboardEventCallback get onKeyUpCapture =>
      props[_$key__onKeyUpCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onKeyUpCapture] -->
  @override
  set onKeyUpCapture(KeyboardEventCallback value) =>
      props[_$key__onKeyUpCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onFocusCapture] -->
  @override
  FocusEventCallback get onFocusCapture =>
      props[_$key__onFocusCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onFocusCapture] -->
  @override
  set onFocusCapture(FocusEventCallback value) =>
      props[_$key__onFocusCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onBlurCapture] -->
  @override
  FocusEventCallback get onBlurCapture =>
      props[_$key__onBlurCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onBlurCapture] -->
  @override
  set onBlurCapture(FocusEventCallback value) =>
      props[_$key__onBlurCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onChangeCapture] -->
  @override
  FormEventCallback get onChangeCapture =>
      props[_$key__onChangeCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onChangeCapture] -->
  @override
  set onChangeCapture(FormEventCallback value) =>
      props[_$key__onChangeCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onInputCapture] -->
  @override
  FormEventCallback get onInputCapture =>
      props[_$key__onInputCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onInputCapture] -->
  @override
  set onInputCapture(FormEventCallback value) =>
      props[_$key__onInputCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onSubmitCapture] -->
  @override
  FormEventCallback get onSubmitCapture =>
      props[_$key__onSubmitCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onSubmitCapture] -->
  @override
  set onSubmitCapture(FormEventCallback value) =>
      props[_$key__onSubmitCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onResetCapture] -->
  @override
  FormEventCallback get onResetCapture =>
      props[_$key__onResetCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onResetCapture] -->
  @override
  set onResetCapture(FormEventCallback value) =>
      props[_$key__onResetCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onClickCapture] -->
  @override
  MouseEventCallback get onClickCapture =>
      props[_$key__onClickCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onClickCapture] -->
  @override
  set onClickCapture(MouseEventCallback value) =>
      props[_$key__onClickCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onContextMenuCapture] -->
  @override
  MouseEventCallback get onContextMenuCapture =>
      props[_$key__onContextMenuCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onContextMenuCapture] -->
  @override
  set onContextMenuCapture(MouseEventCallback value) =>
      props[_$key__onContextMenuCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDoubleClickCapture] -->
  @override
  MouseEventCallback get onDoubleClickCapture =>
      props[_$key__onDoubleClickCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDoubleClickCapture] -->
  @override
  set onDoubleClickCapture(MouseEventCallback value) =>
      props[_$key__onDoubleClickCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragCapture] -->
  @override
  MouseEventCallback get onDragCapture =>
      props[_$key__onDragCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragCapture] -->
  @override
  set onDragCapture(MouseEventCallback value) =>
      props[_$key__onDragCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEndCapture] -->
  @override
  MouseEventCallback get onDragEndCapture =>
      props[_$key__onDragEndCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragEndCapture] -->
  @override
  set onDragEndCapture(MouseEventCallback value) =>
      props[_$key__onDragEndCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragEnterCapture] -->
  @override
  MouseEventCallback get onDragEnterCapture =>
      props[_$key__onDragEnterCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragEnterCapture] -->
  @override
  set onDragEnterCapture(MouseEventCallback value) =>
      props[_$key__onDragEnterCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragExitCapture] -->
  @override
  MouseEventCallback get onDragExitCapture =>
      props[_$key__onDragExitCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragExitCapture] -->
  @override
  set onDragExitCapture(MouseEventCallback value) =>
      props[_$key__onDragExitCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragLeaveCapture] -->
  @override
  MouseEventCallback get onDragLeaveCapture =>
      props[_$key__onDragLeaveCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragLeaveCapture] -->
  @override
  set onDragLeaveCapture(MouseEventCallback value) =>
      props[_$key__onDragLeaveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragOverCapture] -->
  @override
  MouseEventCallback get onDragOverCapture =>
      props[_$key__onDragOverCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragOverCapture] -->
  @override
  set onDragOverCapture(MouseEventCallback value) =>
      props[_$key__onDragOverCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDragStartCapture] -->
  @override
  MouseEventCallback get onDragStartCapture =>
      props[_$key__onDragStartCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDragStartCapture] -->
  @override
  set onDragStartCapture(MouseEventCallback value) =>
      props[_$key__onDragStartCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onDropCapture] -->
  @override
  MouseEventCallback get onDropCapture =>
      props[_$key__onDropCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onDropCapture] -->
  @override
  set onDropCapture(MouseEventCallback value) =>
      props[_$key__onDropCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseDownCapture] -->
  @override
  MouseEventCallback get onMouseDownCapture =>
      props[_$key__onMouseDownCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseDownCapture] -->
  @override
  set onMouseDownCapture(MouseEventCallback value) =>
      props[_$key__onMouseDownCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseEnterCapture] -->
  @override
  MouseEventCallback get onMouseEnterCapture =>
      props[_$key__onMouseEnterCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseEnterCapture] -->
  @override
  set onMouseEnterCapture(MouseEventCallback value) =>
      props[_$key__onMouseEnterCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseLeaveCapture] -->
  @override
  MouseEventCallback get onMouseLeaveCapture =>
      props[_$key__onMouseLeaveCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseLeaveCapture] -->
  @override
  set onMouseLeaveCapture(MouseEventCallback value) =>
      props[_$key__onMouseLeaveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseMoveCapture] -->
  @override
  MouseEventCallback get onMouseMoveCapture =>
      props[_$key__onMouseMoveCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseMoveCapture] -->
  @override
  set onMouseMoveCapture(MouseEventCallback value) =>
      props[_$key__onMouseMoveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOutCapture] -->
  @override
  MouseEventCallback get onMouseOutCapture =>
      props[_$key__onMouseOutCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseOutCapture] -->
  @override
  set onMouseOutCapture(MouseEventCallback value) =>
      props[_$key__onMouseOutCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseOverCapture] -->
  @override
  MouseEventCallback get onMouseOverCapture =>
      props[_$key__onMouseOverCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseOverCapture] -->
  @override
  set onMouseOverCapture(MouseEventCallback value) =>
      props[_$key__onMouseOverCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onMouseUpCapture] -->
  @override
  MouseEventCallback get onMouseUpCapture =>
      props[_$key__onMouseUpCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onMouseUpCapture] -->
  @override
  set onMouseUpCapture(MouseEventCallback value) =>
      props[_$key__onMouseUpCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchCancelCapture] -->
  @override
  TouchEventCallback get onTouchCancelCapture =>
      props[_$key__onTouchCancelCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchCancelCapture] -->
  @override
  set onTouchCancelCapture(TouchEventCallback value) =>
      props[_$key__onTouchCancelCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchEndCapture] -->
  @override
  TouchEventCallback get onTouchEndCapture =>
      props[_$key__onTouchEndCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchEndCapture] -->
  @override
  set onTouchEndCapture(TouchEventCallback value) =>
      props[_$key__onTouchEndCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchMoveCapture] -->
  @override
  TouchEventCallback get onTouchMoveCapture =>
      props[_$key__onTouchMoveCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchMoveCapture] -->
  @override
  set onTouchMoveCapture(TouchEventCallback value) =>
      props[_$key__onTouchMoveCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onTouchStartCapture] -->
  @override
  TouchEventCallback get onTouchStartCapture =>
      props[_$key__onTouchStartCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onTouchStartCapture] -->
  @override
  set onTouchStartCapture(TouchEventCallback value) =>
      props[_$key__onTouchStartCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onScrollCapture] -->
  @override
  UIEventCallback get onScrollCapture =>
      props[_$key__onScrollCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onScrollCapture] -->
  @override
  set onScrollCapture(UIEventCallback value) =>
      props[_$key__onScrollCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.onWheelCapture] -->
  @override
  WheelEventCallback get onWheelCapture =>
      props[_$key__onWheelCapture___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.onWheelCapture] -->
  @override
  set onWheelCapture(WheelEventCallback value) =>
      props[_$key__onWheelCapture___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defaultChecked] -->
  @override
  bool get defaultChecked =>
      props[_$key__defaultChecked___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.defaultChecked] -->
  @override
  set defaultChecked(bool value) =>
      props[_$key__defaultChecked___$DomPropsMixin] = value;

  /// <!-- Generated from [_$DomPropsMixin.defaultValue] -->
  @override
  dynamic get defaultValue =>
      props[_$key__defaultValue___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$DomPropsMixin.defaultValue] -->
  @override
  set defaultValue(dynamic value) =>
      props[_$key__defaultValue___$DomPropsMixin] = value;

  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  ///
  /// <!-- Generated from [_$DomPropsMixin.autoFocus] -->
  @override
  bool get autoFocus =>
      props[_$key__autoFocus___$DomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  ///
  /// <!-- Generated from [_$DomPropsMixin.autoFocus] -->
  @override
  set autoFocus(bool value) => props[_$key__autoFocus___$DomPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__cols___$DomPropsMixin =
      PropDescriptor(_$key__cols___$DomPropsMixin);
  static const PropDescriptor _$prop__rows___$DomPropsMixin =
      PropDescriptor(_$key__rows___$DomPropsMixin);
  static const PropDescriptor _$prop__size___$DomPropsMixin =
      PropDescriptor(_$key__size___$DomPropsMixin);
  static const PropDescriptor _$prop__span___$DomPropsMixin =
      PropDescriptor(_$key__span___$DomPropsMixin);
  static const PropDescriptor _$prop__start___$DomPropsMixin =
      PropDescriptor(_$key__start___$DomPropsMixin);
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
  static const PropDescriptor _$prop__seamless___$DomPropsMixin =
      PropDescriptor(_$key__seamless___$DomPropsMixin);
  static const PropDescriptor _$prop__selected___$DomPropsMixin =
      PropDescriptor(_$key__selected___$DomPropsMixin);
  static const PropDescriptor _$prop__style___$DomPropsMixin =
      PropDescriptor(_$key__style___$DomPropsMixin);
  static const PropDescriptor _$prop__className___$DomPropsMixin =
      PropDescriptor(_$key__className___$DomPropsMixin);
  static const PropDescriptor _$prop__title___$DomPropsMixin =
      PropDescriptor(_$key__title___$DomPropsMixin);
  static const PropDescriptor _$prop__id___$DomPropsMixin =
      PropDescriptor(_$key__id___$DomPropsMixin);
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
  static const String _$key__rows___$DomPropsMixin = 'rows';
  static const String _$key__size___$DomPropsMixin = 'size';
  static const String _$key__span___$DomPropsMixin = 'span';
  static const String _$key__start___$DomPropsMixin = 'start';
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
  static const String _$key__seamless___$DomPropsMixin = 'seamless';
  static const String _$key__selected___$DomPropsMixin = 'selected';
  static const String _$key__style___$DomPropsMixin = 'style';
  static const String _$key__className___$DomPropsMixin = 'className';
  static const String _$key__title___$DomPropsMixin = 'title';
  static const String _$key__id___$DomPropsMixin = 'id';
  static const String _$key__accept___$DomPropsMixin = 'accept';
  static const String _$key__acceptCharset___$DomPropsMixin = 'acceptCharset';
  static const String _$key__accessKey___$DomPropsMixin = 'accessKey';
  static const String _$key__action___$DomPropsMixin = 'action';
  static const String _$key__allowTransparency___$DomPropsMixin =
      'allowTransparency';
  static const String _$key__alt___$DomPropsMixin = 'alt';
  static const String _$key__autoComplete___$DomPropsMixin = 'autoComplete';
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
    _$prop__rows___$DomPropsMixin,
    _$prop__size___$DomPropsMixin,
    _$prop__span___$DomPropsMixin,
    _$prop__start___$DomPropsMixin,
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
    _$prop__seamless___$DomPropsMixin,
    _$prop__selected___$DomPropsMixin,
    _$prop__style___$DomPropsMixin,
    _$prop__className___$DomPropsMixin,
    _$prop__title___$DomPropsMixin,
    _$prop__id___$DomPropsMixin,
    _$prop__accept___$DomPropsMixin,
    _$prop__acceptCharset___$DomPropsMixin,
    _$prop__accessKey___$DomPropsMixin,
    _$prop__action___$DomPropsMixin,
    _$prop__allowTransparency___$DomPropsMixin,
    _$prop__alt___$DomPropsMixin,
    _$prop__autoComplete___$DomPropsMixin,
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
    _$key__rows___$DomPropsMixin,
    _$key__size___$DomPropsMixin,
    _$key__span___$DomPropsMixin,
    _$key__start___$DomPropsMixin,
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
    _$key__seamless___$DomPropsMixin,
    _$key__selected___$DomPropsMixin,
    _$key__style___$DomPropsMixin,
    _$key__className___$DomPropsMixin,
    _$key__title___$DomPropsMixin,
    _$key__id___$DomPropsMixin,
    _$key__accept___$DomPropsMixin,
    _$key__acceptCharset___$DomPropsMixin,
    _$key__accessKey___$DomPropsMixin,
    _$key__action___$DomPropsMixin,
    _$key__allowTransparency___$DomPropsMixin,
    _$key__alt___$DomPropsMixin,
    _$key__autoComplete___$DomPropsMixin,
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

  /// <!-- Generated from [_$SvgPropsMixin.clipPath] -->
  @override
  dynamic get clipPath =>
      props[_$key__clipPath___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.clipPath] -->
  @override
  set clipPath(dynamic value) =>
      props[_$key__clipPath___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.cx] -->
  @override
  dynamic get cx =>
      props[_$key__cx___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.cx] -->
  @override
  set cx(dynamic value) => props[_$key__cx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.cy] -->
  @override
  dynamic get cy =>
      props[_$key__cy___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.cy] -->
  @override
  set cy(dynamic value) => props[_$key__cy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.d] -->
  @override
  dynamic get d =>
      props[_$key__d___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.d] -->
  @override
  set d(dynamic value) => props[_$key__d___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dx] -->
  @override
  dynamic get dx =>
      props[_$key__dx___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.dx] -->
  @override
  set dx(dynamic value) => props[_$key__dx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.dy] -->
  @override
  dynamic get dy =>
      props[_$key__dy___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.dy] -->
  @override
  set dy(dynamic value) => props[_$key__dy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fill] -->
  @override
  dynamic get fill =>
      props[_$key__fill___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fill] -->
  @override
  set fill(dynamic value) => props[_$key__fill___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fillOpacity] -->
  @override
  dynamic get fillOpacity =>
      props[_$key__fillOpacity___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fillOpacity] -->
  @override
  set fillOpacity(dynamic value) =>
      props[_$key__fillOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontFamily] -->
  @override
  dynamic get fontFamily =>
      props[_$key__fontFamily___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fontFamily] -->
  @override
  set fontFamily(dynamic value) =>
      props[_$key__fontFamily___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fontSize] -->
  @override
  dynamic get fontSize =>
      props[_$key__fontSize___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fontSize] -->
  @override
  set fontSize(dynamic value) =>
      props[_$key__fontSize___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fx] -->
  @override
  dynamic get fx =>
      props[_$key__fx___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fx] -->
  @override
  set fx(dynamic value) => props[_$key__fx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.fy] -->
  @override
  dynamic get fy =>
      props[_$key__fy___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.fy] -->
  @override
  set fy(dynamic value) => props[_$key__fy___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.gradientTransform] -->
  @override
  dynamic get gradientTransform =>
      props[_$key__gradientTransform___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.gradientTransform] -->
  @override
  set gradientTransform(dynamic value) =>
      props[_$key__gradientTransform___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.gradientUnits] -->
  @override
  dynamic get gradientUnits =>
      props[_$key__gradientUnits___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.gradientUnits] -->
  @override
  set gradientUnits(dynamic value) =>
      props[_$key__gradientUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerEnd] -->
  @override
  dynamic get markerEnd =>
      props[_$key__markerEnd___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.markerEnd] -->
  @override
  set markerEnd(dynamic value) =>
      props[_$key__markerEnd___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerMid] -->
  @override
  dynamic get markerMid =>
      props[_$key__markerMid___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.markerMid] -->
  @override
  set markerMid(dynamic value) =>
      props[_$key__markerMid___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.markerStart] -->
  @override
  dynamic get markerStart =>
      props[_$key__markerStart___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.markerStart] -->
  @override
  set markerStart(dynamic value) =>
      props[_$key__markerStart___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.offset] -->
  @override
  dynamic get offset =>
      props[_$key__offset___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.offset] -->
  @override
  set offset(dynamic value) => props[_$key__offset___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.opacity] -->
  @override
  dynamic get opacity =>
      props[_$key__opacity___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.opacity] -->
  @override
  set opacity(dynamic value) => props[_$key__opacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.patternContentUnits] -->
  @override
  dynamic get patternContentUnits =>
      props[_$key__patternContentUnits___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.patternContentUnits] -->
  @override
  set patternContentUnits(dynamic value) =>
      props[_$key__patternContentUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.patternUnits] -->
  @override
  dynamic get patternUnits =>
      props[_$key__patternUnits___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.patternUnits] -->
  @override
  set patternUnits(dynamic value) =>
      props[_$key__patternUnits___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.points] -->
  @override
  dynamic get points =>
      props[_$key__points___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.points] -->
  @override
  set points(dynamic value) => props[_$key__points___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.preserveAspectRatio] -->
  @override
  dynamic get preserveAspectRatio =>
      props[_$key__preserveAspectRatio___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.preserveAspectRatio] -->
  @override
  set preserveAspectRatio(dynamic value) =>
      props[_$key__preserveAspectRatio___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.r] -->
  @override
  dynamic get r =>
      props[_$key__r___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.r] -->
  @override
  set r(dynamic value) => props[_$key__r___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.rx] -->
  @override
  dynamic get rx =>
      props[_$key__rx___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.rx] -->
  @override
  set rx(dynamic value) => props[_$key__rx___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.ry] -->
  @override
  dynamic get ry =>
      props[_$key__ry___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.ry] -->
  @override
  set ry(dynamic value) => props[_$key__ry___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.spreadMethod] -->
  @override
  dynamic get spreadMethod =>
      props[_$key__spreadMethod___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.spreadMethod] -->
  @override
  set spreadMethod(dynamic value) =>
      props[_$key__spreadMethod___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stopColor] -->
  @override
  dynamic get stopColor =>
      props[_$key__stopColor___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.stopColor] -->
  @override
  set stopColor(dynamic value) =>
      props[_$key__stopColor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stopOpacity] -->
  @override
  dynamic get stopOpacity =>
      props[_$key__stopOpacity___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.stopOpacity] -->
  @override
  set stopOpacity(dynamic value) =>
      props[_$key__stopOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.stroke] -->
  @override
  dynamic get stroke =>
      props[_$key__stroke___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.stroke] -->
  @override
  set stroke(dynamic value) => props[_$key__stroke___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeDasharray] -->
  @override
  dynamic get strokeDasharray =>
      props[_$key__strokeDasharray___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.strokeDasharray] -->
  @override
  set strokeDasharray(dynamic value) =>
      props[_$key__strokeDasharray___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeLinecap] -->
  @override
  dynamic get strokeLinecap =>
      props[_$key__strokeLinecap___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.strokeLinecap] -->
  @override
  set strokeLinecap(dynamic value) =>
      props[_$key__strokeLinecap___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeOpacity] -->
  @override
  dynamic get strokeOpacity =>
      props[_$key__strokeOpacity___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.strokeOpacity] -->
  @override
  set strokeOpacity(dynamic value) =>
      props[_$key__strokeOpacity___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.strokeWidth] -->
  @override
  dynamic get strokeWidth =>
      props[_$key__strokeWidth___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.strokeWidth] -->
  @override
  set strokeWidth(dynamic value) =>
      props[_$key__strokeWidth___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.textAnchor] -->
  @override
  dynamic get textAnchor =>
      props[_$key__textAnchor___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.textAnchor] -->
  @override
  set textAnchor(dynamic value) =>
      props[_$key__textAnchor___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.transform] -->
  @override
  dynamic get transform =>
      props[_$key__transform___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.transform] -->
  @override
  set transform(dynamic value) =>
      props[_$key__transform___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.version] -->
  @override
  dynamic get version =>
      props[_$key__version___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.version] -->
  @override
  set version(dynamic value) => props[_$key__version___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.viewBox] -->
  @override
  dynamic get viewBox =>
      props[_$key__viewBox___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.viewBox] -->
  @override
  set viewBox(dynamic value) => props[_$key__viewBox___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x1] -->
  @override
  dynamic get x1 =>
      props[_$key__x1___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.x1] -->
  @override
  set x1(dynamic value) => props[_$key__x1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x2] -->
  @override
  dynamic get x2 =>
      props[_$key__x2___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.x2] -->
  @override
  set x2(dynamic value) => props[_$key__x2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.x] -->
  @override
  dynamic get x =>
      props[_$key__x___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.x] -->
  @override
  set x(dynamic value) => props[_$key__x___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkActuate] -->
  @override
  dynamic get xlinkActuate =>
      props[_$key__xlinkActuate___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkActuate] -->
  @override
  set xlinkActuate(dynamic value) =>
      props[_$key__xlinkActuate___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkArcrole] -->
  @override
  dynamic get xlinkArcrole =>
      props[_$key__xlinkArcrole___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkArcrole] -->
  @override
  set xlinkArcrole(dynamic value) =>
      props[_$key__xlinkArcrole___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkHref] -->
  @override
  dynamic get xlinkHref =>
      props[_$key__xlinkHref___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkHref] -->
  @override
  set xlinkHref(dynamic value) =>
      props[_$key__xlinkHref___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkRole] -->
  @override
  dynamic get xlinkRole =>
      props[_$key__xlinkRole___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkRole] -->
  @override
  set xlinkRole(dynamic value) =>
      props[_$key__xlinkRole___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkShow] -->
  @override
  dynamic get xlinkShow =>
      props[_$key__xlinkShow___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkShow] -->
  @override
  set xlinkShow(dynamic value) =>
      props[_$key__xlinkShow___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkTitle] -->
  @override
  dynamic get xlinkTitle =>
      props[_$key__xlinkTitle___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkTitle] -->
  @override
  set xlinkTitle(dynamic value) =>
      props[_$key__xlinkTitle___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xlinkType] -->
  @override
  dynamic get xlinkType =>
      props[_$key__xlinkType___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xlinkType] -->
  @override
  set xlinkType(dynamic value) =>
      props[_$key__xlinkType___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlBase] -->
  @override
  dynamic get xmlBase =>
      props[_$key__xmlBase___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xmlBase] -->
  @override
  set xmlBase(dynamic value) => props[_$key__xmlBase___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlLang] -->
  @override
  dynamic get xmlLang =>
      props[_$key__xmlLang___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xmlLang] -->
  @override
  set xmlLang(dynamic value) => props[_$key__xmlLang___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.xmlSpace] -->
  @override
  dynamic get xmlSpace =>
      props[_$key__xmlSpace___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.xmlSpace] -->
  @override
  set xmlSpace(dynamic value) =>
      props[_$key__xmlSpace___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y1] -->
  @override
  dynamic get y1 =>
      props[_$key__y1___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.y1] -->
  @override
  set y1(dynamic value) => props[_$key__y1___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y2] -->
  @override
  dynamic get y2 =>
      props[_$key__y2___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.y2] -->
  @override
  set y2(dynamic value) => props[_$key__y2___$SvgPropsMixin] = value;

  /// <!-- Generated from [_$SvgPropsMixin.y] -->
  @override
  dynamic get y =>
      props[_$key__y___$SvgPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SvgPropsMixin.y] -->
  @override
  set y(dynamic value) => props[_$key__y___$SvgPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__clipPath___$SvgPropsMixin =
      PropDescriptor(_$key__clipPath___$SvgPropsMixin);
  static const PropDescriptor _$prop__cx___$SvgPropsMixin =
      PropDescriptor(_$key__cx___$SvgPropsMixin);
  static const PropDescriptor _$prop__cy___$SvgPropsMixin =
      PropDescriptor(_$key__cy___$SvgPropsMixin);
  static const PropDescriptor _$prop__d___$SvgPropsMixin =
      PropDescriptor(_$key__d___$SvgPropsMixin);
  static const PropDescriptor _$prop__dx___$SvgPropsMixin =
      PropDescriptor(_$key__dx___$SvgPropsMixin);
  static const PropDescriptor _$prop__dy___$SvgPropsMixin =
      PropDescriptor(_$key__dy___$SvgPropsMixin);
  static const PropDescriptor _$prop__fill___$SvgPropsMixin =
      PropDescriptor(_$key__fill___$SvgPropsMixin);
  static const PropDescriptor _$prop__fillOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__fillOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontFamily___$SvgPropsMixin =
      PropDescriptor(_$key__fontFamily___$SvgPropsMixin);
  static const PropDescriptor _$prop__fontSize___$SvgPropsMixin =
      PropDescriptor(_$key__fontSize___$SvgPropsMixin);
  static const PropDescriptor _$prop__fx___$SvgPropsMixin =
      PropDescriptor(_$key__fx___$SvgPropsMixin);
  static const PropDescriptor _$prop__fy___$SvgPropsMixin =
      PropDescriptor(_$key__fy___$SvgPropsMixin);
  static const PropDescriptor _$prop__gradientTransform___$SvgPropsMixin =
      PropDescriptor(_$key__gradientTransform___$SvgPropsMixin);
  static const PropDescriptor _$prop__gradientUnits___$SvgPropsMixin =
      PropDescriptor(_$key__gradientUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerEnd___$SvgPropsMixin =
      PropDescriptor(_$key__markerEnd___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerMid___$SvgPropsMixin =
      PropDescriptor(_$key__markerMid___$SvgPropsMixin);
  static const PropDescriptor _$prop__markerStart___$SvgPropsMixin =
      PropDescriptor(_$key__markerStart___$SvgPropsMixin);
  static const PropDescriptor _$prop__offset___$SvgPropsMixin =
      PropDescriptor(_$key__offset___$SvgPropsMixin);
  static const PropDescriptor _$prop__opacity___$SvgPropsMixin =
      PropDescriptor(_$key__opacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__patternContentUnits___$SvgPropsMixin =
      PropDescriptor(_$key__patternContentUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__patternUnits___$SvgPropsMixin =
      PropDescriptor(_$key__patternUnits___$SvgPropsMixin);
  static const PropDescriptor _$prop__points___$SvgPropsMixin =
      PropDescriptor(_$key__points___$SvgPropsMixin);
  static const PropDescriptor _$prop__preserveAspectRatio___$SvgPropsMixin =
      PropDescriptor(_$key__preserveAspectRatio___$SvgPropsMixin);
  static const PropDescriptor _$prop__r___$SvgPropsMixin =
      PropDescriptor(_$key__r___$SvgPropsMixin);
  static const PropDescriptor _$prop__rx___$SvgPropsMixin =
      PropDescriptor(_$key__rx___$SvgPropsMixin);
  static const PropDescriptor _$prop__ry___$SvgPropsMixin =
      PropDescriptor(_$key__ry___$SvgPropsMixin);
  static const PropDescriptor _$prop__spreadMethod___$SvgPropsMixin =
      PropDescriptor(_$key__spreadMethod___$SvgPropsMixin);
  static const PropDescriptor _$prop__stopColor___$SvgPropsMixin =
      PropDescriptor(_$key__stopColor___$SvgPropsMixin);
  static const PropDescriptor _$prop__stopOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__stopOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__stroke___$SvgPropsMixin =
      PropDescriptor(_$key__stroke___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeDasharray___$SvgPropsMixin =
      PropDescriptor(_$key__strokeDasharray___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeLinecap___$SvgPropsMixin =
      PropDescriptor(_$key__strokeLinecap___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeOpacity___$SvgPropsMixin =
      PropDescriptor(_$key__strokeOpacity___$SvgPropsMixin);
  static const PropDescriptor _$prop__strokeWidth___$SvgPropsMixin =
      PropDescriptor(_$key__strokeWidth___$SvgPropsMixin);
  static const PropDescriptor _$prop__textAnchor___$SvgPropsMixin =
      PropDescriptor(_$key__textAnchor___$SvgPropsMixin);
  static const PropDescriptor _$prop__transform___$SvgPropsMixin =
      PropDescriptor(_$key__transform___$SvgPropsMixin);
  static const PropDescriptor _$prop__version___$SvgPropsMixin =
      PropDescriptor(_$key__version___$SvgPropsMixin);
  static const PropDescriptor _$prop__viewBox___$SvgPropsMixin =
      PropDescriptor(_$key__viewBox___$SvgPropsMixin);
  static const PropDescriptor _$prop__x1___$SvgPropsMixin =
      PropDescriptor(_$key__x1___$SvgPropsMixin);
  static const PropDescriptor _$prop__x2___$SvgPropsMixin =
      PropDescriptor(_$key__x2___$SvgPropsMixin);
  static const PropDescriptor _$prop__x___$SvgPropsMixin =
      PropDescriptor(_$key__x___$SvgPropsMixin);
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
  static const String _$key__clipPath___$SvgPropsMixin = 'clipPath';
  static const String _$key__cx___$SvgPropsMixin = 'cx';
  static const String _$key__cy___$SvgPropsMixin = 'cy';
  static const String _$key__d___$SvgPropsMixin = 'd';
  static const String _$key__dx___$SvgPropsMixin = 'dx';
  static const String _$key__dy___$SvgPropsMixin = 'dy';
  static const String _$key__fill___$SvgPropsMixin = 'fill';
  static const String _$key__fillOpacity___$SvgPropsMixin = 'fillOpacity';
  static const String _$key__fontFamily___$SvgPropsMixin = 'fontFamily';
  static const String _$key__fontSize___$SvgPropsMixin = 'fontSize';
  static const String _$key__fx___$SvgPropsMixin = 'fx';
  static const String _$key__fy___$SvgPropsMixin = 'fy';
  static const String _$key__gradientTransform___$SvgPropsMixin =
      'gradientTransform';
  static const String _$key__gradientUnits___$SvgPropsMixin = 'gradientUnits';
  static const String _$key__markerEnd___$SvgPropsMixin = 'markerEnd';
  static const String _$key__markerMid___$SvgPropsMixin = 'markerMid';
  static const String _$key__markerStart___$SvgPropsMixin = 'markerStart';
  static const String _$key__offset___$SvgPropsMixin = 'offset';
  static const String _$key__opacity___$SvgPropsMixin = 'opacity';
  static const String _$key__patternContentUnits___$SvgPropsMixin =
      'patternContentUnits';
  static const String _$key__patternUnits___$SvgPropsMixin = 'patternUnits';
  static const String _$key__points___$SvgPropsMixin = 'points';
  static const String _$key__preserveAspectRatio___$SvgPropsMixin =
      'preserveAspectRatio';
  static const String _$key__r___$SvgPropsMixin = 'r';
  static const String _$key__rx___$SvgPropsMixin = 'rx';
  static const String _$key__ry___$SvgPropsMixin = 'ry';
  static const String _$key__spreadMethod___$SvgPropsMixin = 'spreadMethod';
  static const String _$key__stopColor___$SvgPropsMixin = 'stopColor';
  static const String _$key__stopOpacity___$SvgPropsMixin = 'stopOpacity';
  static const String _$key__stroke___$SvgPropsMixin = 'stroke';
  static const String _$key__strokeDasharray___$SvgPropsMixin =
      'strokeDasharray';
  static const String _$key__strokeLinecap___$SvgPropsMixin = 'strokeLinecap';
  static const String _$key__strokeOpacity___$SvgPropsMixin = 'strokeOpacity';
  static const String _$key__strokeWidth___$SvgPropsMixin = 'strokeWidth';
  static const String _$key__textAnchor___$SvgPropsMixin = 'textAnchor';
  static const String _$key__transform___$SvgPropsMixin = 'transform';
  static const String _$key__version___$SvgPropsMixin = 'version';
  static const String _$key__viewBox___$SvgPropsMixin = 'viewBox';
  static const String _$key__x1___$SvgPropsMixin = 'x1';
  static const String _$key__x2___$SvgPropsMixin = 'x2';
  static const String _$key__x___$SvgPropsMixin = 'x';
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
    _$prop__clipPath___$SvgPropsMixin,
    _$prop__cx___$SvgPropsMixin,
    _$prop__cy___$SvgPropsMixin,
    _$prop__d___$SvgPropsMixin,
    _$prop__dx___$SvgPropsMixin,
    _$prop__dy___$SvgPropsMixin,
    _$prop__fill___$SvgPropsMixin,
    _$prop__fillOpacity___$SvgPropsMixin,
    _$prop__fontFamily___$SvgPropsMixin,
    _$prop__fontSize___$SvgPropsMixin,
    _$prop__fx___$SvgPropsMixin,
    _$prop__fy___$SvgPropsMixin,
    _$prop__gradientTransform___$SvgPropsMixin,
    _$prop__gradientUnits___$SvgPropsMixin,
    _$prop__markerEnd___$SvgPropsMixin,
    _$prop__markerMid___$SvgPropsMixin,
    _$prop__markerStart___$SvgPropsMixin,
    _$prop__offset___$SvgPropsMixin,
    _$prop__opacity___$SvgPropsMixin,
    _$prop__patternContentUnits___$SvgPropsMixin,
    _$prop__patternUnits___$SvgPropsMixin,
    _$prop__points___$SvgPropsMixin,
    _$prop__preserveAspectRatio___$SvgPropsMixin,
    _$prop__r___$SvgPropsMixin,
    _$prop__rx___$SvgPropsMixin,
    _$prop__ry___$SvgPropsMixin,
    _$prop__spreadMethod___$SvgPropsMixin,
    _$prop__stopColor___$SvgPropsMixin,
    _$prop__stopOpacity___$SvgPropsMixin,
    _$prop__stroke___$SvgPropsMixin,
    _$prop__strokeDasharray___$SvgPropsMixin,
    _$prop__strokeLinecap___$SvgPropsMixin,
    _$prop__strokeOpacity___$SvgPropsMixin,
    _$prop__strokeWidth___$SvgPropsMixin,
    _$prop__textAnchor___$SvgPropsMixin,
    _$prop__transform___$SvgPropsMixin,
    _$prop__version___$SvgPropsMixin,
    _$prop__viewBox___$SvgPropsMixin,
    _$prop__x1___$SvgPropsMixin,
    _$prop__x2___$SvgPropsMixin,
    _$prop__x___$SvgPropsMixin,
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
    _$key__clipPath___$SvgPropsMixin,
    _$key__cx___$SvgPropsMixin,
    _$key__cy___$SvgPropsMixin,
    _$key__d___$SvgPropsMixin,
    _$key__dx___$SvgPropsMixin,
    _$key__dy___$SvgPropsMixin,
    _$key__fill___$SvgPropsMixin,
    _$key__fillOpacity___$SvgPropsMixin,
    _$key__fontFamily___$SvgPropsMixin,
    _$key__fontSize___$SvgPropsMixin,
    _$key__fx___$SvgPropsMixin,
    _$key__fy___$SvgPropsMixin,
    _$key__gradientTransform___$SvgPropsMixin,
    _$key__gradientUnits___$SvgPropsMixin,
    _$key__markerEnd___$SvgPropsMixin,
    _$key__markerMid___$SvgPropsMixin,
    _$key__markerStart___$SvgPropsMixin,
    _$key__offset___$SvgPropsMixin,
    _$key__opacity___$SvgPropsMixin,
    _$key__patternContentUnits___$SvgPropsMixin,
    _$key__patternUnits___$SvgPropsMixin,
    _$key__points___$SvgPropsMixin,
    _$key__preserveAspectRatio___$SvgPropsMixin,
    _$key__r___$SvgPropsMixin,
    _$key__rx___$SvgPropsMixin,
    _$key__ry___$SvgPropsMixin,
    _$key__spreadMethod___$SvgPropsMixin,
    _$key__stopColor___$SvgPropsMixin,
    _$key__stopOpacity___$SvgPropsMixin,
    _$key__stroke___$SvgPropsMixin,
    _$key__strokeDasharray___$SvgPropsMixin,
    _$key__strokeLinecap___$SvgPropsMixin,
    _$key__strokeOpacity___$SvgPropsMixin,
    _$key__strokeWidth___$SvgPropsMixin,
    _$key__textAnchor___$SvgPropsMixin,
    _$key__transform___$SvgPropsMixin,
    _$key__version___$SvgPropsMixin,
    _$key__viewBox___$SvgPropsMixin,
    _$key__x1___$SvgPropsMixin,
    _$key__x2___$SvgPropsMixin,
    _$key__x___$SvgPropsMixin,
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
  AriaPropsMapView _aria;
  @override
  @Accessor(doNotGenerate: true)
  DomProps _dom;
  @override
  AriaPropsMixin get aria {
    return _aria ??= AriaPropsMapView(props);
  }

  @override
  DomPropsMixin get dom {
    return _dom ??= DomProps(null, props);
  }

  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.tabIndex] -->
  @override
  dynamic get tabIndex =>
      props[_$key__tabIndex___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.tabIndex] -->
  @override
  set tabIndex(dynamic value) =>
      props[_$key__tabIndex___$UbiquitousDomPropsMixin] = value;

  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.id] -->
  @override
  String get id =>
      props[_$key__id___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.id] -->
  @override
  set id(String value) => props[_$key__id___$UbiquitousDomPropsMixin] = value;

  /// Represents advisory information about the element.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.title] -->
  @override
  String get title =>
      props[_$key__title___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Represents advisory information about the element.
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.title] -->
  @override
  set title(String value) =>
      props[_$key__title___$UbiquitousDomPropsMixin] = value;

  /// An inline CSS style for the element.
  ///
  ///     ..style = {
  ///       'width': '${state.progress * 100}%',
  ///       'display': state.isHidden ? 'none' : '',
  ///     }
  ///
  /// See: <https://facebook.github.io/react/tips/inline-styles.html>
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.style] -->
  @override
  Map<String, dynamic> get style =>
      props[_$key__style___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An inline CSS style for the element.
  ///
  ///     ..style = {
  ///       'width': '${state.progress * 100}%',
  ///       'display': state.isHidden ? 'none' : '',
  ///     }
  ///
  /// See: <https://facebook.github.io/react/tips/inline-styles.html>
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.style] -->
  @override
  set style(Map<String, dynamic> value) =>
      props[_$key__style___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a CSS Animation has completed.
  ///
  /// > Related: [onAnimationIteration], [onAnimationStart], [onTransitionEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationEnd] -->
  @override
  AnimationEventCallback get onAnimationEnd =>
      props[_$key__onAnimationEnd___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a CSS Animation has completed.
  ///
  /// > Related: [onAnimationIteration], [onAnimationStart], [onTransitionEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationEnd] -->
  @override
  set onAnimationEnd(AnimationEventCallback value) =>
      props[_$key__onAnimationEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an iteration of a CSS Animation ends, and another one begins.
  ///
  /// > Related: [onAnimationEnd], [onAnimationStart]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationIteration] -->
  @override
  AnimationEventCallback get onAnimationIteration =>
      props[_$key__onAnimationIteration___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an iteration of a CSS Animation ends, and another one begins.
  ///
  /// > Related: [onAnimationEnd], [onAnimationStart]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationIteration] -->
  @override
  set onAnimationIteration(AnimationEventCallback value) =>
      props[_$key__onAnimationIteration___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a CSS animation has started.
  ///
  /// > Related: [onAnimationEnd], [onAnimationIteration]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationStart] -->
  @override
  AnimationEventCallback get onAnimationStart =>
      props[_$key__onAnimationStart___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a CSS animation has started.
  ///
  /// > Related: [onAnimationEnd], [onAnimationIteration]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onAnimationStart] -->
  @override
  set onAnimationStart(AnimationEventCallback value) =>
      props[_$key__onAnimationStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user copies the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCopy] -->
  @override
  ClipboardEventCallback get onCopy =>
      props[_$key__onCopy___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user copies the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCopy] -->
  @override
  set onCopy(ClipboardEventCallback value) =>
      props[_$key__onCopy___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user cuts the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCut] -->
  @override
  ClipboardEventCallback get onCut =>
      props[_$key__onCut___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user cuts the content of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onCut] -->
  @override
  set onCut(ClipboardEventCallback value) =>
      props[_$key__onCut___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user pastes some content in an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPaste] -->
  @override
  ClipboardEventCallback get onPaste =>
      props[_$key__onPaste___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user pastes some content in an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onPaste] -->
  @override
  set onPaste(ClipboardEventCallback value) =>
      props[_$key__onPaste___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user is pressing a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyDown] -->
  @override
  KeyboardEventCallback get onKeyDown =>
      props[_$key__onKeyDown___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user is pressing a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyDown] -->
  @override
  set onKeyDown(KeyboardEventCallback value) =>
      props[_$key__onKeyDown___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user presses a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyPress] -->
  @override
  KeyboardEventCallback get onKeyPress =>
      props[_$key__onKeyPress___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user presses a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyPress] -->
  @override
  set onKeyPress(KeyboardEventCallback value) =>
      props[_$key__onKeyPress___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user releases a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyUp] -->
  @override
  KeyboardEventCallback get onKeyUp =>
      props[_$key__onKeyUp___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user releases a key
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onKeyUp] -->
  @override
  set onKeyUp(KeyboardEventCallback value) =>
      props[_$key__onKeyUp___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element gets focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onFocus] -->
  @override
  FocusEventCallback get onFocus =>
      props[_$key__onFocus___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an element gets focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onFocus] -->
  @override
  set onFocus(FocusEventCallback value) =>
      props[_$key__onFocus___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element loses focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onBlur] -->
  @override
  FocusEventCallback get onBlur =>
      props[_$key__onBlur___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an element loses focus
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onBlur] -->
  @override
  set onBlur(FocusEventCallback value) =>
      props[_$key__onBlur___$UbiquitousDomPropsMixin] = value;

  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onChange] -->
  @override
  FormEventCallback get onChange =>
      props[_$key__onChange___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onChange] -->
  @override
  set onChange(FormEventCallback value) =>
      props[_$key__onChange___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element gets user input
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onInput] -->
  @override
  FormEventCallback get onInput =>
      props[_$key__onInput___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an element gets user input
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onInput] -->
  @override
  set onInput(FormEventCallback value) =>
      props[_$key__onInput___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a form is submitted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onSubmit] -->
  @override
  FormEventCallback get onSubmit =>
      props[_$key__onSubmit___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a form is submitted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onSubmit] -->
  @override
  set onSubmit(FormEventCallback value) =>
      props[_$key__onSubmit___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a form is reset
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onReset] -->
  @override
  FormEventCallback get onReset =>
      props[_$key__onReset___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a form is reset
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onReset] -->
  @override
  set onReset(FormEventCallback value) =>
      props[_$key__onReset___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onClick] -->
  @override
  MouseEventCallback get onClick =>
      props[_$key__onClick___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onClick] -->
  @override
  set onClick(MouseEventCallback value) =>
      props[_$key__onClick___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user right-clicks on an element to open a context menu
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onContextMenu] -->
  @override
  MouseEventCallback get onContextMenu =>
      props[_$key__onContextMenu___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user right-clicks on an element to open a context menu
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onContextMenu] -->
  @override
  set onContextMenu(MouseEventCallback value) =>
      props[_$key__onContextMenu___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user double-clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDoubleClick] -->
  @override
  MouseEventCallback get onDoubleClick =>
      props[_$key__onDoubleClick___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user double-clicks on an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDoubleClick] -->
  @override
  set onDoubleClick(MouseEventCallback value) =>
      props[_$key__onDoubleClick___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element is being dragged
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrag] -->
  @override
  MouseEventCallback get onDrag =>
      props[_$key__onDrag___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an element is being dragged
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrag] -->
  @override
  set onDrag(MouseEventCallback value) =>
      props[_$key__onDrag___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user has finished dragging an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnd] -->
  @override
  MouseEventCallback get onDragEnd =>
      props[_$key__onDragEnd___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user has finished dragging an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnd] -->
  @override
  set onDragEnd(MouseEventCallback value) =>
      props[_$key__onDragEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element enters the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnter] -->
  @override
  MouseEventCallback get onDragEnter =>
      props[_$key__onDragEnter___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the dragged element enters the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragEnter] -->
  @override
  set onDragEnter(MouseEventCallback value) =>
      props[_$key__onDragEnter___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element exits the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragExit] -->
  @override
  MouseEventCallback get onDragExit =>
      props[_$key__onDragExit___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the dragged element exits the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragExit] -->
  @override
  set onDragExit(MouseEventCallback value) =>
      props[_$key__onDragExit___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element leaves the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragLeave] -->
  @override
  MouseEventCallback get onDragLeave =>
      props[_$key__onDragLeave___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the dragged element leaves the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragLeave] -->
  @override
  set onDragLeave(MouseEventCallback value) =>
      props[_$key__onDragLeave___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element is over the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragOver] -->
  @override
  MouseEventCallback get onDragOver =>
      props[_$key__onDragOver___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the dragged element is over the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragOver] -->
  @override
  set onDragOver(MouseEventCallback value) =>
      props[_$key__onDragOver___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user starts to drag an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragStart] -->
  @override
  MouseEventCallback get onDragStart =>
      props[_$key__onDragStart___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user starts to drag an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDragStart] -->
  @override
  set onDragStart(MouseEventCallback value) =>
      props[_$key__onDragStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the dragged element is dropped on the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrop] -->
  @override
  MouseEventCallback get onDrop =>
      props[_$key__onDrop___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the dragged element is dropped on the drop target
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onDrop] -->
  @override
  set onDrop(MouseEventCallback value) =>
      props[_$key__onDrop___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the user presses a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseDown] -->
  @override
  MouseEventCallback get onMouseDown =>
      props[_$key__onMouseDown___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the user presses a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseDown] -->
  @override
  set onMouseDown(MouseEventCallback value) =>
      props[_$key__onMouseDown___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseEnter] -->
  @override
  MouseEventCallback get onMouseEnter =>
      props[_$key__onMouseEnter___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the pointer is moved onto an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseEnter] -->
  @override
  set onMouseEnter(MouseEventCallback value) =>
      props[_$key__onMouseEnter___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseLeave] -->
  @override
  MouseEventCallback get onMouseLeave =>
      props[_$key__onMouseLeave___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the pointer is moved out of an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseLeave] -->
  @override
  set onMouseLeave(MouseEventCallback value) =>
      props[_$key__onMouseLeave___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseMove] -->
  @override
  MouseEventCallback get onMouseMove =>
      props[_$key__onMouseMove___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the pointer is moving while it is over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseMove] -->
  @override
  set onMouseMove(MouseEventCallback value) =>
      props[_$key__onMouseMove___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOut] -->
  @override
  MouseEventCallback get onMouseOut =>
      props[_$key__onMouseOut___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOut] -->
  @override
  set onMouseOut(MouseEventCallback value) =>
      props[_$key__onMouseOut___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOver] -->
  @override
  MouseEventCallback get onMouseOver =>
      props[_$key__onMouseOver___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the pointer is moved onto an element, or onto one of its children
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseOver] -->
  @override
  set onMouseOver(MouseEventCallback value) =>
      props[_$key__onMouseOver___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a user releases a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseUp] -->
  @override
  MouseEventCallback get onMouseUp =>
      props[_$key__onMouseUp___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a user releases a mouse button over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onMouseUp] -->
  @override
  set onMouseUp(MouseEventCallback value) =>
      props[_$key__onMouseUp___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the touch is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchCancel] -->
  @override
  TouchEventCallback get onTouchCancel =>
      props[_$key__onTouchCancel___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the touch is interrupted
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchCancel] -->
  @override
  set onTouchCancel(TouchEventCallback value) =>
      props[_$key__onTouchCancel___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is removed from a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchEnd] -->
  @override
  TouchEventCallback get onTouchEnd =>
      props[_$key__onTouchEnd___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a finger is removed from a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchEnd] -->
  @override
  set onTouchEnd(TouchEventCallback value) =>
      props[_$key__onTouchEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is dragged across the screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchMove] -->
  @override
  TouchEventCallback get onTouchMove =>
      props[_$key__onTouchMove___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a finger is dragged across the screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchMove] -->
  @override
  set onTouchMove(TouchEventCallback value) =>
      props[_$key__onTouchMove___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a finger is placed on a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchStart] -->
  @override
  TouchEventCallback get onTouchStart =>
      props[_$key__onTouchStart___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a finger is placed on a touch screen
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTouchStart] -->
  @override
  set onTouchStart(TouchEventCallback value) =>
      props[_$key__onTouchStart___$UbiquitousDomPropsMixin] = value;

  /// Callback for when a CSS transition has completed.
  ///
  /// > Related: [onAnimationEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTransitionEnd] -->
  @override
  TransitionEventCallback get onTransitionEnd =>
      props[_$key__onTransitionEnd___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when a CSS transition has completed.
  ///
  /// > Related: [onAnimationEnd]
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onTransitionEnd] -->
  @override
  set onTransitionEnd(TransitionEventCallback value) =>
      props[_$key__onTransitionEnd___$UbiquitousDomPropsMixin] = value;

  /// Callback for when an element's scrollbar is being scrolled
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onScroll] -->
  @override
  UIEventCallback get onScroll =>
      props[_$key__onScroll___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when an element's scrollbar is being scrolled
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onScroll] -->
  @override
  set onScroll(UIEventCallback value) =>
      props[_$key__onScroll___$UbiquitousDomPropsMixin] = value;

  /// Callback for when the mouse wheel rolls up or down over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onWheel] -->
  @override
  WheelEventCallback get onWheel =>
      props[_$key__onWheel___$UbiquitousDomPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Callback for when the mouse wheel rolls up or down over an element
  ///
  /// <!-- Generated from [_$UbiquitousDomPropsMixin.onWheel] -->
  @override
  set onWheel(WheelEventCallback value) =>
      props[_$key__onWheel___$UbiquitousDomPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__tabIndex___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__tabIndex___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__id___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__id___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__title___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__title___$UbiquitousDomPropsMixin);
  static const PropDescriptor _$prop__style___$UbiquitousDomPropsMixin =
      PropDescriptor(_$key__style___$UbiquitousDomPropsMixin);
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
  static const String _$key__style___$UbiquitousDomPropsMixin = 'style';
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
    _$prop__style___$UbiquitousDomPropsMixin,
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
    _$key__style___$UbiquitousDomPropsMixin,
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
