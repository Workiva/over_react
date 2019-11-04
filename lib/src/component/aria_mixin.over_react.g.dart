// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'aria_mixin.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class AriaPropsMixin implements _$AriaPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForAriaPropsMixin;

  /// Identifies the currently active descendant of a compositewidget.
  ///
  /// This is used when a composite widget is responsible for managing its current active child
  /// to reduce the overhead of having all children be focusable. Examples include: multi-level
  /// lists, trees, and grids. In some implementations the user agent may use aria-activedescendant
  /// to tell assistive technologies that the active descendant has focus. Authors MAY use the aria-activedescendant
  /// attribute on the focused descendant of a composite widget; for example, on a textbox descendant
  /// of a combo box.
  ///
  /// Authors SHOULD ensure that the element targeted by the aria-activedescendant attribute is
  /// either a descendant of the container in the DOM, or is a logical descendant as indicated by
  /// the aria-owns attribute. The user agent is not expected to validate that the active descendant
  /// is a descendant of the container. Authors SHOULD ensure that the currently active descendant
  /// is visible and in view (or scrolls into view) when focused.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-activedescendant>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.activedescendant] -->
  @override
  @Accessor(key: 'aria-activedescendant')
  String get activedescendant =>
      props[_$key__activedescendant___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies the currently active descendant of a compositewidget.
  ///
  /// This is used when a composite widget is responsible for managing its current active child
  /// to reduce the overhead of having all children be focusable. Examples include: multi-level
  /// lists, trees, and grids. In some implementations the user agent may use aria-activedescendant
  /// to tell assistive technologies that the active descendant has focus. Authors MAY use the aria-activedescendant
  /// attribute on the focused descendant of a composite widget; for example, on a textbox descendant
  /// of a combo box.
  ///
  /// Authors SHOULD ensure that the element targeted by the aria-activedescendant attribute is
  /// either a descendant of the container in the DOM, or is a logical descendant as indicated by
  /// the aria-owns attribute. The user agent is not expected to validate that the active descendant
  /// is a descendant of the container. Authors SHOULD ensure that the currently active descendant
  /// is visible and in view (or scrolls into view) when focused.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-activedescendant>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.activedescendant] -->
  @override
  @Accessor(key: 'aria-activedescendant')
  set activedescendant(String value) =>
      props[_$key__activedescendant___$AriaPropsMixin] = value;

  /// Indicates whether assistive technologies will present all, or only parts of, the changed region
  /// based on the change notifications defined by the aria-relevant attribute. See related aria-relevant.
  ///
  /// Both accessibility APIs and the Document Object Model `DOM` provide events to allow the assistive
  /// technologies to determine changed areas of the document.
  ///
  /// When the content of a live region changes, user agents SHOULD examine the changed element
  /// and traverse the ancestors to find the first element with aria-atomic set, and apply the appropriate
  /// behavior for the cases below.
  ///
  /// If none of the ancestors have explicitly set aria-atomic, the default is that aria-atomic
  /// is false, and assistive technologies will only present the changed node to the user.If aria-atomic
  /// is explicitly set to false, assistive technologies will stop searching up the ancestor chain
  /// and present only the changed node to the user.If aria-atomic is explicitly set to true, assistive
  /// technologies will present the entire contents of the element.
  ///
  /// When aria-atomic is true, assistive technologies MAY choose to combine several changes and
  /// present the entire changed region at once.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-atomic>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.atomic] -->
  @override
  @Accessor(key: 'aria-atomic')
  bool get atomic =>
      props[_$key__atomic___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether assistive technologies will present all, or only parts of, the changed region
  /// based on the change notifications defined by the aria-relevant attribute. See related aria-relevant.
  ///
  /// Both accessibility APIs and the Document Object Model `DOM` provide events to allow the assistive
  /// technologies to determine changed areas of the document.
  ///
  /// When the content of a live region changes, user agents SHOULD examine the changed element
  /// and traverse the ancestors to find the first element with aria-atomic set, and apply the appropriate
  /// behavior for the cases below.
  ///
  /// If none of the ancestors have explicitly set aria-atomic, the default is that aria-atomic
  /// is false, and assistive technologies will only present the changed node to the user.If aria-atomic
  /// is explicitly set to false, assistive technologies will stop searching up the ancestor chain
  /// and present only the changed node to the user.If aria-atomic is explicitly set to true, assistive
  /// technologies will present the entire contents of the element.
  ///
  /// When aria-atomic is true, assistive technologies MAY choose to combine several changes and
  /// present the entire changed region at once.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-atomic>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.atomic] -->
  @override
  @Accessor(key: 'aria-atomic')
  set atomic(bool value) => props[_$key__atomic___$AriaPropsMixin] = value;

  /// Indicates whether user input completion suggestions are provided.
  ///
  /// For a textbox with the aria-autocomplete attribute set to either inline or both, authors SHOULD
  /// ensure that any auto-completed text is selected, so the user can type over it.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-autocomplete>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.autocomplete] -->
  @override
  @Accessor(key: 'aria-autocomplete')
  dynamic get autocomplete =>
      props[_$key__autocomplete___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether user input completion suggestions are provided.
  ///
  /// For a textbox with the aria-autocomplete attribute set to either inline or both, authors SHOULD
  /// ensure that any auto-completed text is selected, so the user can type over it.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-autocomplete>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.autocomplete] -->
  @override
  @Accessor(key: 'aria-autocomplete')
  set autocomplete(dynamic value) =>
      props[_$key__autocomplete___$AriaPropsMixin] = value;

  /// Indicates whether an element, and its subtree, are currently being updated.
  ///
  /// The default is that aria-busy is false. If authors know that multiple parts of the same element
  /// need to be loaded or modified, they can set aria-busy to true when the first part is loaded,
  /// and then set aria-busy to false when the last part is loaded. When a widget is missing required
  /// owned elements due to script execution or loading, authors MUST mark a containing element
  /// with aria-busy equal to true. For example, until a page is fully initialized and complete,
  /// an author could mark the document element as busy. If there is an error updating the element,
  /// author MAY set the aria-invalid attribute to true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-busy>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.busy] -->
  @override
  @Accessor(key: 'aria-busy')
  bool get busy =>
      props[_$key__busy___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether an element, and its subtree, are currently being updated.
  ///
  /// The default is that aria-busy is false. If authors know that multiple parts of the same element
  /// need to be loaded or modified, they can set aria-busy to true when the first part is loaded,
  /// and then set aria-busy to false when the last part is loaded. When a widget is missing required
  /// owned elements due to script execution or loading, authors MUST mark a containing element
  /// with aria-busy equal to true. For example, until a page is fully initialized and complete,
  /// an author could mark the document element as busy. If there is an error updating the element,
  /// author MAY set the aria-invalid attribute to true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-busy>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.busy] -->
  @override
  @Accessor(key: 'aria-busy')
  set busy(bool value) => props[_$key__busy___$AriaPropsMixin] = value;

  /// Indicates the current 'checked' state of checkboxes, radio buttons, and other widgets. See
  /// related aria-pressed and aria-selected.
  ///
  /// The aria-checked attribute indicates whether the element is checked (true), unchecked (false),
  /// or represents a group of other elements that have a mixture of checked and unchecked values
  /// (mixed). Most inputs only support values of true and false, but the mixed value is supported
  /// by certain tri-state inputs such as a checkbox or menuitemcheckbox.
  ///
  /// The mixed value is not supported on radio or menuitemradio or any element that inherits from
  /// these in the taxonomy, and user agents MUST treat a mixed value as equivalent to false for
  /// those roles.
  ///
  /// Examples using the mixed value of tri-state inputs are covered in WAI-ARIA Authoring Practices
  /// [ARIA-PRACTICES]
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-checked>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.checked] -->
  @override
  @Accessor(key: 'aria-checked')
  dynamic get checked =>
      props[_$key__checked___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates the current 'checked' state of checkboxes, radio buttons, and other widgets. See
  /// related aria-pressed and aria-selected.
  ///
  /// The aria-checked attribute indicates whether the element is checked (true), unchecked (false),
  /// or represents a group of other elements that have a mixture of checked and unchecked values
  /// (mixed). Most inputs only support values of true and false, but the mixed value is supported
  /// by certain tri-state inputs such as a checkbox or menuitemcheckbox.
  ///
  /// The mixed value is not supported on radio or menuitemradio or any element that inherits from
  /// these in the taxonomy, and user agents MUST treat a mixed value as equivalent to false for
  /// those roles.
  ///
  /// Examples using the mixed value of tri-state inputs are covered in WAI-ARIA Authoring Practices
  /// [ARIA-PRACTICES]
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-checked>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.checked] -->
  @override
  @Accessor(key: 'aria-checked')
  set checked(dynamic value) => props[_$key__checked___$AriaPropsMixin] = value;

  /// Identifies the element (or elements) whose contents or presence are controlled by the current
  /// element. See related aria-owns.
  ///
  /// For example:
  ///
  /// A table of contents tree view may control the content of a neighboring document pane.A group
  /// of checkboxes may control what commodity prices are tracked live in a table or graph.A tab
  /// controls the display of its associated tab panel.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-controls>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.controls] -->
  @override
  @Accessor(key: 'aria-controls')
  dynamic get controls =>
      props[_$key__controls___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies the element (or elements) whose contents or presence are controlled by the current
  /// element. See related aria-owns.
  ///
  /// For example:
  ///
  /// A table of contents tree view may control the content of a neighboring document pane.A group
  /// of checkboxes may control what commodity prices are tracked live in a table or graph.A tab
  /// controls the display of its associated tab panel.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-controls>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.controls] -->
  @override
  @Accessor(key: 'aria-controls')
  set controls(dynamic value) =>
      props[_$key__controls___$AriaPropsMixin] = value;

  /// Identifies the element (or elements) that describes the object. See related aria-labelledby.
  ///
  /// The aria-labelledby attribute is similar to aria-describedby in that both reference other
  /// elements to calculate a text alternative, but a label should be concise, where a description
  /// is intended to provide more verbose information.
  ///
  /// The element or elements referenced by the aria-describedby comprise the entire description.
  /// Include ID references to multiple elements if necessary, or enclose a set of elements (e.g.,
  /// paragraphs) with the element referenced by the ID.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-describedby>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.describedby] -->
  @override
  @Accessor(key: 'aria-describedby')
  dynamic get describedby =>
      props[_$key__describedby___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies the element (or elements) that describes the object. See related aria-labelledby.
  ///
  /// The aria-labelledby attribute is similar to aria-describedby in that both reference other
  /// elements to calculate a text alternative, but a label should be concise, where a description
  /// is intended to provide more verbose information.
  ///
  /// The element or elements referenced by the aria-describedby comprise the entire description.
  /// Include ID references to multiple elements if necessary, or enclose a set of elements (e.g.,
  /// paragraphs) with the element referenced by the ID.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-describedby>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.describedby] -->
  @override
  @Accessor(key: 'aria-describedby')
  set describedby(dynamic value) =>
      props[_$key__describedby___$AriaPropsMixin] = value;

  /// Indicates that the element is perceivable but disabled, so it is not editable or otherwise
  /// operable. See related aria-hidden and aria-readonly.
  ///
  /// For example, irrelevant options in a radio group may be disabled. Disabled elements might
  /// not receive focus from the tab order. For some disabled elements, applications might choose
  /// not to support navigation to descendants. In addition to setting the aria-disabled attribute,
  /// authors SHOULD change the appearance (grayed out, etc.) to indicate that the item has been
  /// disabled.
  ///
  /// The state of being disabled applies to the current element and all focusable descendant elements
  /// of the element on which the aria-disabled attribute is applied.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-disabled>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.disabled] -->
  @override
  @Accessor(key: 'aria-disabled')
  bool get disabled =>
      props[_$key__disabled___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that the element is perceivable but disabled, so it is not editable or otherwise
  /// operable. See related aria-hidden and aria-readonly.
  ///
  /// For example, irrelevant options in a radio group may be disabled. Disabled elements might
  /// not receive focus from the tab order. For some disabled elements, applications might choose
  /// not to support navigation to descendants. In addition to setting the aria-disabled attribute,
  /// authors SHOULD change the appearance (grayed out, etc.) to indicate that the item has been
  /// disabled.
  ///
  /// The state of being disabled applies to the current element and all focusable descendant elements
  /// of the element on which the aria-disabled attribute is applied.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-disabled>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.disabled] -->
  @override
  @Accessor(key: 'aria-disabled')
  set disabled(bool value) => props[_$key__disabled___$AriaPropsMixin] = value;

  /// Indicates what functions can be performed when the dragged object is released on the drop
  /// target. This allows assistive technologies to convey the possible drag options available to
  /// users, including whether a pop-up menu of choices is provided by the application. Typically,
  /// drop effect functions can only be provided once an object has been grabbed for a drag operation
  /// as the drop effect functions available are dependent on the object being dragged.
  ///
  /// More than one drop effect may be supported for a given element. Therefore, the value of this
  /// attribute is a space-delimited set of tokens indicating the possible effects, or none if there
  /// is no supported operation. In addition to setting the aria-dropeffect attribute, authors SHOULD
  /// show a visual indication of potential drop targets.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-dropeffect>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.dropeffect] -->
  @override
  @Accessor(key: 'aria-dropeffect')
  dynamic get dropeffect =>
      props[_$key__dropeffect___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates what functions can be performed when the dragged object is released on the drop
  /// target. This allows assistive technologies to convey the possible drag options available to
  /// users, including whether a pop-up menu of choices is provided by the application. Typically,
  /// drop effect functions can only be provided once an object has been grabbed for a drag operation
  /// as the drop effect functions available are dependent on the object being dragged.
  ///
  /// More than one drop effect may be supported for a given element. Therefore, the value of this
  /// attribute is a space-delimited set of tokens indicating the possible effects, or none if there
  /// is no supported operation. In addition to setting the aria-dropeffect attribute, authors SHOULD
  /// show a visual indication of potential drop targets.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-dropeffect>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.dropeffect] -->
  @override
  @Accessor(key: 'aria-dropeffect')
  set dropeffect(dynamic value) =>
      props[_$key__dropeffect___$AriaPropsMixin] = value;

  /// Indicates whether the element, or another grouping element it controls, is currently expanded
  /// or collapsed.
  ///
  /// For example, this indicates whether a portion of a tree is expanded or collapsed. In other
  /// instances, this may be applied to page sections to mark expandable and collapsible regions
  /// that are flexible for managing content density. Simplifying the user interface by collapsing
  /// sections may improve usability for all, including those with cognitive or developmental disabilities.
  ///
  /// If the element with the aria-expanded attribute controls the expansion of another grouping
  /// container that is not 'owned by' the element, the author SHOULD reference the container by
  /// using the aria-controls attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-expanded>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.expanded] -->
  @override
  @Accessor(key: 'aria-expanded')
  dynamic get expanded =>
      props[_$key__expanded___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether the element, or another grouping element it controls, is currently expanded
  /// or collapsed.
  ///
  /// For example, this indicates whether a portion of a tree is expanded or collapsed. In other
  /// instances, this may be applied to page sections to mark expandable and collapsible regions
  /// that are flexible for managing content density. Simplifying the user interface by collapsing
  /// sections may improve usability for all, including those with cognitive or developmental disabilities.
  ///
  /// If the element with the aria-expanded attribute controls the expansion of another grouping
  /// container that is not 'owned by' the element, the author SHOULD reference the container by
  /// using the aria-controls attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-expanded>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.expanded] -->
  @override
  @Accessor(key: 'aria-expanded')
  set expanded(dynamic value) =>
      props[_$key__expanded___$AriaPropsMixin] = value;

  /// Identifies the next element (or elements) in an alternate reading order of content which,
  /// at the user's discretion, allows assistive technology to override the general default of reading
  /// in document source order.
  ///
  /// When aria-flowto has a single IDREF, it allows assistive technologies to, at the user's request,
  /// forego normal document reading order and go to the targeted object.  However, when aria-flowto
  /// is provided with multiple IDREFS, assistive technologies SHOULD present the referenced elements
  /// as path choices.
  ///
  /// In the case of one or more IDREFS, user agents or assistive technologies SHOULD give the user
  /// the option of navigating to any of the targeted elements. The name of the path can be determined
  /// by the name of the target element of the aria-flowto attribute. Accessibility APIs can provide
  /// named path relationships.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-flowto>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.flowto] -->
  @override
  @Accessor(key: 'aria-flowto')
  dynamic get flowto =>
      props[_$key__flowto___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies the next element (or elements) in an alternate reading order of content which,
  /// at the user's discretion, allows assistive technology to override the general default of reading
  /// in document source order.
  ///
  /// When aria-flowto has a single IDREF, it allows assistive technologies to, at the user's request,
  /// forego normal document reading order and go to the targeted object.  However, when aria-flowto
  /// is provided with multiple IDREFS, assistive technologies SHOULD present the referenced elements
  /// as path choices.
  ///
  /// In the case of one or more IDREFS, user agents or assistive technologies SHOULD give the user
  /// the option of navigating to any of the targeted elements. The name of the path can be determined
  /// by the name of the target element of the aria-flowto attribute. Accessibility APIs can provide
  /// named path relationships.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-flowto>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.flowto] -->
  @override
  @Accessor(key: 'aria-flowto')
  set flowto(dynamic value) => props[_$key__flowto___$AriaPropsMixin] = value;

  /// Indicates an element's 'grabbed' state in a drag-and-drop operation.
  ///
  /// When it is set to true it has been selected for dragging, false indicates that the element
  /// can be grabbed for a drag-and-drop operation, but is not currently grabbed, and undefined
  /// (or no value) indicates the element cannot be grabbed (default).
  ///
  /// When aria-grabbed is set to true, authors SHOULD update the aria-dropeffect attribute of all
  /// potential drop targets. When an element is not grabbed (the value is set to false, undefined,
  /// or the attribute is removed), authors SHOULD revert the aria-dropeffect attributes of the
  /// associated drop targets to none.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-grabbed>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.grabbed] -->
  @override
  @Accessor(key: 'aria-grabbed')
  dynamic get grabbed =>
      props[_$key__grabbed___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates an element's 'grabbed' state in a drag-and-drop operation.
  ///
  /// When it is set to true it has been selected for dragging, false indicates that the element
  /// can be grabbed for a drag-and-drop operation, but is not currently grabbed, and undefined
  /// (or no value) indicates the element cannot be grabbed (default).
  ///
  /// When aria-grabbed is set to true, authors SHOULD update the aria-dropeffect attribute of all
  /// potential drop targets. When an element is not grabbed (the value is set to false, undefined,
  /// or the attribute is removed), authors SHOULD revert the aria-dropeffect attributes of the
  /// associated drop targets to none.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-grabbed>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.grabbed] -->
  @override
  @Accessor(key: 'aria-grabbed')
  set grabbed(dynamic value) => props[_$key__grabbed___$AriaPropsMixin] = value;

  /// Indicates that the element has a popup context menu or sub-level menu.
  ///
  /// This means that activation renders conditional content. Note that ordinary tooltips are not
  /// considered popups in this context.
  ///
  /// A popup is generally presented visually as a group of items that appears to be on top of the
  /// main page content.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-haspopup>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.haspopup] -->
  @override
  @Accessor(key: 'aria-haspopup')
  bool get haspopup =>
      props[_$key__haspopup___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that the element has a popup context menu or sub-level menu.
  ///
  /// This means that activation renders conditional content. Note that ordinary tooltips are not
  /// considered popups in this context.
  ///
  /// A popup is generally presented visually as a group of items that appears to be on top of the
  /// main page content.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-haspopup>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.haspopup] -->
  @override
  @Accessor(key: 'aria-haspopup')
  set haspopup(bool value) => props[_$key__haspopup___$AriaPropsMixin] = value;

  /// Indicates that the element and all of its descendants are not visible or perceivable to any
  /// user as implemented by the author. See related aria-disabled.
  ///
  /// If an element is only visible after some user action, authors MUST set the aria-hidden attribute
  /// to true. When the element is presented, authors MUST set the aria-hidden attribute to false
  /// or remove the attribute, indicating that the element is visible. Some assistive technologies
  /// access WAI-ARIA information directly through the DOM and not through platform accessibility
  /// supported by the browser. Authors MUST set aria-hidden='true' on content that is not displayed,
  /// regardless of the mechanism used to hide it. This allows assistive technologies or user agents
  /// to properly skip hidden elements in the document.
  ///
  /// It is recommended that authors key visibility of elements off this attribute, rather than
  /// change visibility and separately have to remember to update this property. CSS 2 provides
  /// a way to select on attribute values (`CSS`). The following CSS declaration makes content visible
  /// unless the aria-hidden attribute is true; scripts need only update the value of this attribute
  /// to change visibility:
  ///
  /// [aria-hidden='true'] { visibility: hidden; }
  ///
  /// Note: Authors are reminded that visibility:hidden and display:none apply to all CSS media
  /// types; therefore, use of either will hide the content from assistive technologies that access
  /// the DOM through a rendering engine. However, in order to support assistive technologies that
  /// access the DOM directly, or other authoring techniques to visibly hide content (for example,
  /// opacity or off-screen positioning), authors need to ensure the aria-hidden attribute is always
  /// updated accordingly when an element is shown or hidden, unless the intent of using off-screen
  /// positioning is to make the content visible only to screen reader users and not others.
  ///
  /// Authors MAY, with caution, use aria-hidden to hide visibly rendered content from assistive
  /// technologies only if the act of hiding this content is intended to improve the experience
  /// for users of assistive technologies by removing redundant or extraneous content. Authors using
  /// aria-hidden to hide visible content from screen readers MUST ensure that identical or equivalent
  /// meaning and functionality is exposed to assistive technologies.
  ///
  /// Note: Authors are advised to use extreme caution and consider a wide range of disabilities
  /// when hiding visibly rendered content from assistive technologies. For example, a sighted,
  /// dexterity-impaired individual may use voice-controlled assistive technologies to access a
  /// visual interface. If an author hides visible link text "Go to checkout" and exposes similar,
  /// yet non-identical link text "Check out now" to the accessibility API, the user may be unable
  /// to access the interface they perceive using voice control. Similar problems may also arise
  /// for screen reader users. For example, a sighted telephone support technician may attempt to
  /// have the blind screen reader user click the "Go to checkout" link, which they may be unable
  /// to find using a type-ahead item search ("Go to…").
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-hidden>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.hidden] -->
  @override
  @Accessor(key: 'aria-hidden')
  bool get hidden =>
      props[_$key__hidden___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that the element and all of its descendants are not visible or perceivable to any
  /// user as implemented by the author. See related aria-disabled.
  ///
  /// If an element is only visible after some user action, authors MUST set the aria-hidden attribute
  /// to true. When the element is presented, authors MUST set the aria-hidden attribute to false
  /// or remove the attribute, indicating that the element is visible. Some assistive technologies
  /// access WAI-ARIA information directly through the DOM and not through platform accessibility
  /// supported by the browser. Authors MUST set aria-hidden='true' on content that is not displayed,
  /// regardless of the mechanism used to hide it. This allows assistive technologies or user agents
  /// to properly skip hidden elements in the document.
  ///
  /// It is recommended that authors key visibility of elements off this attribute, rather than
  /// change visibility and separately have to remember to update this property. CSS 2 provides
  /// a way to select on attribute values (`CSS`). The following CSS declaration makes content visible
  /// unless the aria-hidden attribute is true; scripts need only update the value of this attribute
  /// to change visibility:
  ///
  /// [aria-hidden='true'] { visibility: hidden; }
  ///
  /// Note: Authors are reminded that visibility:hidden and display:none apply to all CSS media
  /// types; therefore, use of either will hide the content from assistive technologies that access
  /// the DOM through a rendering engine. However, in order to support assistive technologies that
  /// access the DOM directly, or other authoring techniques to visibly hide content (for example,
  /// opacity or off-screen positioning), authors need to ensure the aria-hidden attribute is always
  /// updated accordingly when an element is shown or hidden, unless the intent of using off-screen
  /// positioning is to make the content visible only to screen reader users and not others.
  ///
  /// Authors MAY, with caution, use aria-hidden to hide visibly rendered content from assistive
  /// technologies only if the act of hiding this content is intended to improve the experience
  /// for users of assistive technologies by removing redundant or extraneous content. Authors using
  /// aria-hidden to hide visible content from screen readers MUST ensure that identical or equivalent
  /// meaning and functionality is exposed to assistive technologies.
  ///
  /// Note: Authors are advised to use extreme caution and consider a wide range of disabilities
  /// when hiding visibly rendered content from assistive technologies. For example, a sighted,
  /// dexterity-impaired individual may use voice-controlled assistive technologies to access a
  /// visual interface. If an author hides visible link text "Go to checkout" and exposes similar,
  /// yet non-identical link text "Check out now" to the accessibility API, the user may be unable
  /// to access the interface they perceive using voice control. Similar problems may also arise
  /// for screen reader users. For example, a sighted telephone support technician may attempt to
  /// have the blind screen reader user click the "Go to checkout" link, which they may be unable
  /// to find using a type-ahead item search ("Go to…").
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-hidden>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.hidden] -->
  @override
  @Accessor(key: 'aria-hidden')
  set hidden(bool value) => props[_$key__hidden___$AriaPropsMixin] = value;

  /// Indicates the entered value does not conform to the format expected by the application.
  ///
  /// If the value is computed to be invalid or out-of-range, the application author SHOULD set
  /// this attribute to true. User agents SHOULD inform the user of the error. Application authors
  /// SHOULD provide suggestions for corrections if they are known. Authors MAY prevent form submission
  /// when an associated form element has its aria-invalid attribute set to true.
  ///
  /// When the user attempts to submit data involving a field for which aria-required is true, authors
  /// MAY use the aria-invalid attribute to signal there is an error. However, if the user has not
  /// attempted to submit the form, authors SHOULD NOT set the aria-invalid attribute on required
  /// widgets simply because the user has not yet entered data.
  ///
  /// For future expansion, the aria-invalid attribute is an enumerated type. Any value not recognized
  /// in the list of allowed values MUST be treated by user agents as if the value true had been
  /// provided. If the attribute is not present, or its value is false, or its value is an empty
  /// string, the default value of false applies.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-invalid>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.invalid] -->
  @override
  @Accessor(key: 'aria-invalid')
  dynamic get invalid =>
      props[_$key__invalid___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates the entered value does not conform to the format expected by the application.
  ///
  /// If the value is computed to be invalid or out-of-range, the application author SHOULD set
  /// this attribute to true. User agents SHOULD inform the user of the error. Application authors
  /// SHOULD provide suggestions for corrections if they are known. Authors MAY prevent form submission
  /// when an associated form element has its aria-invalid attribute set to true.
  ///
  /// When the user attempts to submit data involving a field for which aria-required is true, authors
  /// MAY use the aria-invalid attribute to signal there is an error. However, if the user has not
  /// attempted to submit the form, authors SHOULD NOT set the aria-invalid attribute on required
  /// widgets simply because the user has not yet entered data.
  ///
  /// For future expansion, the aria-invalid attribute is an enumerated type. Any value not recognized
  /// in the list of allowed values MUST be treated by user agents as if the value true had been
  /// provided. If the attribute is not present, or its value is false, or its value is an empty
  /// string, the default value of false applies.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-invalid>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.invalid] -->
  @override
  @Accessor(key: 'aria-invalid')
  set invalid(dynamic value) => props[_$key__invalid___$AriaPropsMixin] = value;

  /// Defines a string value that labels the current element. See related aria-labelledby.
  ///
  /// The purpose of aria-label is the same as that of aria-labelledby. It provides the user with
  /// a recognizable name of the object. The most common accessibility API mapping for a label is
  /// the accessible name property.
  ///
  /// If the label text is visible on screen, authors SHOULD use aria-labelledby and SHOULD NOT
  /// use aria-label. There may be instances where the name of an element cannot be determined programmatically
  /// from the content of the element, and there are cases where providing a visible label is not
  /// the desired user experience. Most host languages provide an attribute that could be used to
  /// name the element (e.g., the title attribute in HTML `HTML`), yet this could present a browser
  /// tooltip. In the cases where a visible label or visible tooltip is undesirable, authors MAY
  /// set the accessible name of the element using aria-label. As required by the text alternative
  /// computation, user agents give precedence to aria-labelledby over aria-label when computing
  /// the accessible name property.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-label>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.label] -->
  @override
  @Accessor(key: 'aria-label')
  String get label =>
      props[_$key__label___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines a string value that labels the current element. See related aria-labelledby.
  ///
  /// The purpose of aria-label is the same as that of aria-labelledby. It provides the user with
  /// a recognizable name of the object. The most common accessibility API mapping for a label is
  /// the accessible name property.
  ///
  /// If the label text is visible on screen, authors SHOULD use aria-labelledby and SHOULD NOT
  /// use aria-label. There may be instances where the name of an element cannot be determined programmatically
  /// from the content of the element, and there are cases where providing a visible label is not
  /// the desired user experience. Most host languages provide an attribute that could be used to
  /// name the element (e.g., the title attribute in HTML `HTML`), yet this could present a browser
  /// tooltip. In the cases where a visible label or visible tooltip is undesirable, authors MAY
  /// set the accessible name of the element using aria-label. As required by the text alternative
  /// computation, user agents give precedence to aria-labelledby over aria-label when computing
  /// the accessible name property.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-label>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.label] -->
  @override
  @Accessor(key: 'aria-label')
  set label(String value) => props[_$key__label___$AriaPropsMixin] = value;

  /// Identifies the element (or elements) that labels the current element. See related aria-label
  /// and aria-describedby.
  ///
  /// The purpose of aria-labelledby is the same as that of aria-label. It provides the user with
  /// a recognizable name of the object. The most common accessibility API mapping for a label is
  /// the accessible name property.
  ///
  /// If the label text is visible on screen, authors SHOULD use aria-labelledby and SHOULD NOT
  /// use aria-label. Use aria-label only if the interface is such that it is not possible to have
  /// a visible label on the screen. As required by the text alternative computation, user agents
  /// give precedence to aria-labelledby over aria-label when computing the accessible name property.
  ///
  /// The aria-labelledby attribute is similar to aria-describedby in that both reference other
  /// elements to calculate a text alternative, but a label should be concise, where a description
  /// is intended to provide more verbose information.
  ///
  /// Note: The expected spelling of this property in U.S. English is "labeledby." However, the
  /// accessibility API features to which this property is mapped have established the 'labelledby'
  /// spelling. This property is spelled that way to match the convention and minimize the difficulty
  /// for developers.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-labelledby>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.labelledby] -->
  @override
  @Accessor(key: 'aria-labelledby')
  dynamic get labelledby =>
      props[_$key__labelledby___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies the element (or elements) that labels the current element. See related aria-label
  /// and aria-describedby.
  ///
  /// The purpose of aria-labelledby is the same as that of aria-label. It provides the user with
  /// a recognizable name of the object. The most common accessibility API mapping for a label is
  /// the accessible name property.
  ///
  /// If the label text is visible on screen, authors SHOULD use aria-labelledby and SHOULD NOT
  /// use aria-label. Use aria-label only if the interface is such that it is not possible to have
  /// a visible label on the screen. As required by the text alternative computation, user agents
  /// give precedence to aria-labelledby over aria-label when computing the accessible name property.
  ///
  /// The aria-labelledby attribute is similar to aria-describedby in that both reference other
  /// elements to calculate a text alternative, but a label should be concise, where a description
  /// is intended to provide more verbose information.
  ///
  /// Note: The expected spelling of this property in U.S. English is "labeledby." However, the
  /// accessibility API features to which this property is mapped have established the 'labelledby'
  /// spelling. This property is spelled that way to match the convention and minimize the difficulty
  /// for developers.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-labelledby>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.labelledby] -->
  @override
  @Accessor(key: 'aria-labelledby')
  set labelledby(dynamic value) =>
      props[_$key__labelledby___$AriaPropsMixin] = value;

  /// Defines the hierarchical level of an element within a structure.
  ///
  /// This can be applied inside trees to tree items, to headings inside a document, to nested grids,
  /// nested tablists and to other structural items that may appear inside a container or participate
  /// in an ownership hierarchy. The value for aria-level is an integer greater than or equal to
  /// 1.
  ///
  /// Levels increase with depth. If the DOM ancestry does not accurately represent the level, authors
  /// SHOULD explicitly define the aria-level attribute.
  ///
  /// This attribute is applied to elements that act as leaf nodes within the orientation of the
  /// set, for example, on elements with role treeitem rather than elements with role group. This
  /// means that multiple elements in a set may have the same value for this attribute. Although
  /// it would be less repetitive to provide a single value on the container, restricting this to
  /// leaf nodes ensures that there is a single way for assistive technologies to use the attribute.
  ///
  /// If the DOM ancestry accurately represents the level, the user agent can calculate the level
  /// of an item from the document structure. This attribute can be used to provide an explicit
  /// indication of the level when that is not possible to calculate from the document structure
  /// or the aria-owns attribute. User agent support for automatic calculation of level may vary;
  /// authors SHOULD test with user agents and assistive technologies to determine whether this
  /// attribute is needed. If the author intends for the user agent to calculate the level, the
  /// author SHOULD omit this attribute.
  ///
  /// Note: In the case of a treegrid, aria-level is supported on elements with the role row, not
  /// elements with role gridcell. At first glance, this may seem inconsistent with the application
  /// of aria-level on treeitem elements, but it is consistent in that the row acts as the leaf
  /// node within the vertical orientation of the grid, whereas the gridcell is a leaf node within
  /// the horizontal orientation of each row. Level is not supported on sets of cells within rows,
  /// so the aria-level attribute is applied to the element with the role row.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-level>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.level] -->
  @override
  @Accessor(key: 'aria-level')
  int get level =>
      props[_$key__level___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the hierarchical level of an element within a structure.
  ///
  /// This can be applied inside trees to tree items, to headings inside a document, to nested grids,
  /// nested tablists and to other structural items that may appear inside a container or participate
  /// in an ownership hierarchy. The value for aria-level is an integer greater than or equal to
  /// 1.
  ///
  /// Levels increase with depth. If the DOM ancestry does not accurately represent the level, authors
  /// SHOULD explicitly define the aria-level attribute.
  ///
  /// This attribute is applied to elements that act as leaf nodes within the orientation of the
  /// set, for example, on elements with role treeitem rather than elements with role group. This
  /// means that multiple elements in a set may have the same value for this attribute. Although
  /// it would be less repetitive to provide a single value on the container, restricting this to
  /// leaf nodes ensures that there is a single way for assistive technologies to use the attribute.
  ///
  /// If the DOM ancestry accurately represents the level, the user agent can calculate the level
  /// of an item from the document structure. This attribute can be used to provide an explicit
  /// indication of the level when that is not possible to calculate from the document structure
  /// or the aria-owns attribute. User agent support for automatic calculation of level may vary;
  /// authors SHOULD test with user agents and assistive technologies to determine whether this
  /// attribute is needed. If the author intends for the user agent to calculate the level, the
  /// author SHOULD omit this attribute.
  ///
  /// Note: In the case of a treegrid, aria-level is supported on elements with the role row, not
  /// elements with role gridcell. At first glance, this may seem inconsistent with the application
  /// of aria-level on treeitem elements, but it is consistent in that the row acts as the leaf
  /// node within the vertical orientation of the grid, whereas the gridcell is a leaf node within
  /// the horizontal orientation of each row. Level is not supported on sets of cells within rows,
  /// so the aria-level attribute is applied to the element with the role row.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-level>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.level] -->
  @override
  @Accessor(key: 'aria-level')
  set level(int value) => props[_$key__level___$AriaPropsMixin] = value;

  /// Indicates that an element will be updated, and describes the types of updates the user agents,
  /// assistive technologies, and user can expect from the live region.
  ///
  /// The values of this attribute are expressed in degrees of importance. When regions are specified
  /// as polite, assistive technologies will notify users of updates but generally do not interrupt
  /// the current task, and updates take low priority. When regions are specified as assertive,
  /// assistive technologies will immediately notify the user, and could potentially clear the speech
  /// queue of previous updates. Please refer to Live Region Properties and How to Use Them ([ARIA-PRACTICES],
  /// Section 5.2.1).
  ///
  /// Politeness levels are essentially an ordering mechanism for updates and serve as a strong
  /// suggestion to user agents or assistive technologies. The value may be overridden by user agents,
  /// assistive technologies, or the user. For example, if assistive technologies can determine
  /// that a change occurred in response to a key press or a mouse click, the assistive technologies
  /// may present that change immediately even if the value of the aria-live attribute states otherwise.
  ///
  /// Since different users have different needs, it is up to the user to tweak his or her assistive
  /// technologies' response to a live region with a certain politeness level from the commonly
  /// defined baseline. Assistive technologies may choose to implement increasing and decreasing
  /// levels of granularity so that the user can exercise control over queues and interruptions.
  ///
  /// When the property is not set on an object that needs to send updates, the politeness level
  /// is the value of the nearest ancestor that sets the aria-live attribute.
  ///
  /// The aria-live attribute is the primary determination for the order of presentation of changes
  /// to live regions. Implementations will also consider the default level of politeness in a role
  /// when the aria-live attribute is not set in the ancestor chain (e.g., log changes are polite
  /// by default). Items which are assertive will be presented immediately, followed by polite items.
  /// User agents or assistive technologies MAY choose to clear queued changes when an assertive
  /// change occurs. (e.g., changes in an assertive region may remove all currently queued changes)
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-live>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.live] -->
  @override
  @Accessor(key: 'aria-live')
  dynamic get live =>
      props[_$key__live___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that an element will be updated, and describes the types of updates the user agents,
  /// assistive technologies, and user can expect from the live region.
  ///
  /// The values of this attribute are expressed in degrees of importance. When regions are specified
  /// as polite, assistive technologies will notify users of updates but generally do not interrupt
  /// the current task, and updates take low priority. When regions are specified as assertive,
  /// assistive technologies will immediately notify the user, and could potentially clear the speech
  /// queue of previous updates. Please refer to Live Region Properties and How to Use Them ([ARIA-PRACTICES],
  /// Section 5.2.1).
  ///
  /// Politeness levels are essentially an ordering mechanism for updates and serve as a strong
  /// suggestion to user agents or assistive technologies. The value may be overridden by user agents,
  /// assistive technologies, or the user. For example, if assistive technologies can determine
  /// that a change occurred in response to a key press or a mouse click, the assistive technologies
  /// may present that change immediately even if the value of the aria-live attribute states otherwise.
  ///
  /// Since different users have different needs, it is up to the user to tweak his or her assistive
  /// technologies' response to a live region with a certain politeness level from the commonly
  /// defined baseline. Assistive technologies may choose to implement increasing and decreasing
  /// levels of granularity so that the user can exercise control over queues and interruptions.
  ///
  /// When the property is not set on an object that needs to send updates, the politeness level
  /// is the value of the nearest ancestor that sets the aria-live attribute.
  ///
  /// The aria-live attribute is the primary determination for the order of presentation of changes
  /// to live regions. Implementations will also consider the default level of politeness in a role
  /// when the aria-live attribute is not set in the ancestor chain (e.g., log changes are polite
  /// by default). Items which are assertive will be presented immediately, followed by polite items.
  /// User agents or assistive technologies MAY choose to clear queued changes when an assertive
  /// change occurs. (e.g., changes in an assertive region may remove all currently queued changes)
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-live>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.live] -->
  @override
  @Accessor(key: 'aria-live')
  set live(dynamic value) => props[_$key__live___$AriaPropsMixin] = value;

  /// Indicates whether a text box accepts multiple lines of input or only a single line.
  ///
  /// Note: In most user agent implementations, the default behavior of the ENTER or RETURN key
  /// is different between the single-line and multi-line text fields in HTML. When user has focus
  /// in a single-line &lt;input type='text'&gt; element, the keystroke usually submits the form.
  /// When user has focus in a multi-line &lt;textarea&gt; element, the keystroke inserts a line
  /// break. The WAI-ARIA textbox role differentiates these types of boxes with the aria-multiline
  /// attribute, so authors are advised to be aware of this distinction when designing the field.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiline>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.multiline] -->
  @override
  @Accessor(key: 'aria-multiline')
  bool get multiline =>
      props[_$key__multiline___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether a text box accepts multiple lines of input or only a single line.
  ///
  /// Note: In most user agent implementations, the default behavior of the ENTER or RETURN key
  /// is different between the single-line and multi-line text fields in HTML. When user has focus
  /// in a single-line &lt;input type='text'&gt; element, the keystroke usually submits the form.
  /// When user has focus in a multi-line &lt;textarea&gt; element, the keystroke inserts a line
  /// break. The WAI-ARIA textbox role differentiates these types of boxes with the aria-multiline
  /// attribute, so authors are advised to be aware of this distinction when designing the field.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiline>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.multiline] -->
  @override
  @Accessor(key: 'aria-multiline')
  set multiline(bool value) =>
      props[_$key__multiline___$AriaPropsMixin] = value;

  /// Indicates that the user may select more than one item from the current selectable descendants.
  ///
  /// Authors SHOULD ensure that selected descendants have the aria-selected attribute set to true,
  /// and selectable descendant have the aria-selected attribute set to false. Authors SHOULD NOT
  /// use the aria-selected attribute on descendants that are not selectable.
  ///
  /// Note: Lists and trees are examples of roles that might allow users to select more than one
  /// item at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiselectable>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.multiselectable] -->
  @override
  @Accessor(key: 'aria-multiselectable')
  bool get multiselectable =>
      props[_$key__multiselectable___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that the user may select more than one item from the current selectable descendants.
  ///
  /// Authors SHOULD ensure that selected descendants have the aria-selected attribute set to true,
  /// and selectable descendant have the aria-selected attribute set to false. Authors SHOULD NOT
  /// use the aria-selected attribute on descendants that are not selectable.
  ///
  /// Note: Lists and trees are examples of roles that might allow users to select more than one
  /// item at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiselectable>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.multiselectable] -->
  @override
  @Accessor(key: 'aria-multiselectable')
  set multiselectable(bool value) =>
      props[_$key__multiselectable___$AriaPropsMixin] = value;

  /// Indicates whether the element and orientation is horizontal or vertical.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-orientation>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.orientation] -->
  @override
  @Accessor(key: 'aria-orientation')
  dynamic get orientation =>
      props[_$key__orientation___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates whether the element and orientation is horizontal or vertical.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-orientation>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.orientation] -->
  @override
  @Accessor(key: 'aria-orientation')
  set orientation(dynamic value) =>
      props[_$key__orientation___$AriaPropsMixin] = value;

  /// Identifies an element (or elements) in order to define a visual, functional, or contextual
  /// parent/child relationship between DOM elements where the DOM hierarchy cannot be used to represent
  /// the relationship. See related aria-controls.
  ///
  /// The value of the aria-owns attribute is a space-separated list of IDREFS that reference one
  /// or more elements in the document by ID. The reason for adding aria-owns is to expose a parent/child
  /// contextual relationship to assistive technologies that is otherwise impossible to infer from
  /// the DOM.
  ///
  /// Authors SHOULD NOT use aria-owns as a replacement for the DOM hierarchy. If the relationship
  /// is represented in the DOM, do not use aria-owns. Authors MUST ensure that an element's ID
  /// is not specified in more than one other element's aria-owns attribute at any time. In other
  /// words, an element can have only one explicit owner.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-owns>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.owns] -->
  @override
  @Accessor(key: 'aria-owns')
  dynamic get owns =>
      props[_$key__owns___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Identifies an element (or elements) in order to define a visual, functional, or contextual
  /// parent/child relationship between DOM elements where the DOM hierarchy cannot be used to represent
  /// the relationship. See related aria-controls.
  ///
  /// The value of the aria-owns attribute is a space-separated list of IDREFS that reference one
  /// or more elements in the document by ID. The reason for adding aria-owns is to expose a parent/child
  /// contextual relationship to assistive technologies that is otherwise impossible to infer from
  /// the DOM.
  ///
  /// Authors SHOULD NOT use aria-owns as a replacement for the DOM hierarchy. If the relationship
  /// is represented in the DOM, do not use aria-owns. Authors MUST ensure that an element's ID
  /// is not specified in more than one other element's aria-owns attribute at any time. In other
  /// words, an element can have only one explicit owner.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-owns>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.owns] -->
  @override
  @Accessor(key: 'aria-owns')
  set owns(dynamic value) => props[_$key__owns___$AriaPropsMixin] = value;

  /// Defines an element's number or position in the current set of listitems or treeitems. Not
  /// required if all elements in the set are present in the DOM. See related aria-setsize.
  ///
  /// If all items in a set are present in the document structure, it is not necessary to set this
  /// attribute, as the user agent can automatically calculate the set size and position for each
  /// item. However, if only a portion of the set is present in the document structure at a given
  /// moment, this property is needed to provide an explicit indication of an element's position.
  ///
  /// Authors MUST set the value for aria-posinset to an integer greater than or equal to 1, and
  /// less than or equal to the size of the set. Authors SHOULD use aria-posinset in conjunction
  /// with aria-setsize.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-posinset>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.posinset] -->
  @override
  @Accessor(key: 'aria-posinset')
  int get posinset =>
      props[_$key__posinset___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines an element's number or position in the current set of listitems or treeitems. Not
  /// required if all elements in the set are present in the DOM. See related aria-setsize.
  ///
  /// If all items in a set are present in the document structure, it is not necessary to set this
  /// attribute, as the user agent can automatically calculate the set size and position for each
  /// item. However, if only a portion of the set is present in the document structure at a given
  /// moment, this property is needed to provide an explicit indication of an element's position.
  ///
  /// Authors MUST set the value for aria-posinset to an integer greater than or equal to 1, and
  /// less than or equal to the size of the set. Authors SHOULD use aria-posinset in conjunction
  /// with aria-setsize.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-posinset>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.posinset] -->
  @override
  @Accessor(key: 'aria-posinset')
  set posinset(int value) => props[_$key__posinset___$AriaPropsMixin] = value;

  /// Indicates the current 'pressed' state of toggle buttons. See related aria-checked and aria-selected.
  ///
  /// Toggle buttons require a full press-and-release cycle to change their value. Activating it
  /// once changes the value to true, and activating it another time changes the value back to false.
  /// A value of mixed means that the values of more than one item controlled by the button do not
  /// all share the same value. Examples of mixed-state buttons are described in WAI-ARIA Authoring
  /// Practices [ARIA-PRACTICES]. If the attribute is not present, the button is not a toggle button.
  ///
  /// The aria-pressed attribute is similar but not identical to the aria-checked attribute. Operating
  /// systems support pressed on buttons and checked on checkboxes.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-pressed>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.pressed] -->
  @override
  @Accessor(key: 'aria-pressed')
  dynamic get pressed =>
      props[_$key__pressed___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates the current 'pressed' state of toggle buttons. See related aria-checked and aria-selected.
  ///
  /// Toggle buttons require a full press-and-release cycle to change their value. Activating it
  /// once changes the value to true, and activating it another time changes the value back to false.
  /// A value of mixed means that the values of more than one item controlled by the button do not
  /// all share the same value. Examples of mixed-state buttons are described in WAI-ARIA Authoring
  /// Practices [ARIA-PRACTICES]. If the attribute is not present, the button is not a toggle button.
  ///
  /// The aria-pressed attribute is similar but not identical to the aria-checked attribute. Operating
  /// systems support pressed on buttons and checked on checkboxes.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-pressed>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.pressed] -->
  @override
  @Accessor(key: 'aria-pressed')
  set pressed(dynamic value) => props[_$key__pressed___$AriaPropsMixin] = value;

  ///  Indicates that the element is not editable, but is otherwise operable. See related aria-disabled.
  ///
  /// This means the user can read but not set the value of the widget. Readonly elements are relevant
  /// to the user, and application authors SHOULD NOT restrict navigation to the element or its
  /// focusable descendants. Other actions such as copying the value of the element are also supported.
  /// This is in contrast to disabled elements, to which applications might not allow user navigation
  /// to descendants.
  ///
  /// Examples include:
  ///
  /// A form element which represents a constant.Row or column headers in a spreadsheet grid.The
  /// result of a calculation such as a shopping cart total.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-readonly>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.readonly] -->
  @override
  @Accessor(key: 'aria-readonly')
  bool get readonly =>
      props[_$key__readonly___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  ///  Indicates that the element is not editable, but is otherwise operable. See related aria-disabled.
  ///
  /// This means the user can read but not set the value of the widget. Readonly elements are relevant
  /// to the user, and application authors SHOULD NOT restrict navigation to the element or its
  /// focusable descendants. Other actions such as copying the value of the element are also supported.
  /// This is in contrast to disabled elements, to which applications might not allow user navigation
  /// to descendants.
  ///
  /// Examples include:
  ///
  /// A form element which represents a constant.Row or column headers in a spreadsheet grid.The
  /// result of a calculation such as a shopping cart total.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-readonly>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.readonly] -->
  @override
  @Accessor(key: 'aria-readonly')
  set readonly(bool value) => props[_$key__readonly___$AriaPropsMixin] = value;

  /// Indicates what user agent change notifications (additions, removals, etc.) assistive technologies
  /// will receive within a live region. See related aria-atomic.
  ///
  /// The attribute is represented as a space delimited list of the following values: additions,
  /// removals, text; or a single catch-all value all.
  ///
  /// This is used to describe semantically meaningful changes, as opposed to merely presentational
  /// ones. For example, nodes that are removed from the top of a log are merely removed for purposes
  /// of creating room for other entries, and the removal of them does not have meaning. However,
  /// in the case of a buddy list, removal of a buddy name indicates that they are no longer online,
  /// and this is a meaningful event. In that case aria-relevant will be set to all. When the aria-relevant
  /// attribute is not provided, the default value, additions text, indicates that text modifications
  /// and node additions are relevant, but that node removals are irrelevant.
  ///
  /// Note: aria-relevant values of removals or all are to be used sparingly. Assistive technologies
  /// only need to be informed of content removal when its removal represents an important change,
  /// such as a buddy leaving a chat room.
  ///
  /// Note: Text removals should only be considered relevant if one of the specified values is 'removals'
  /// or 'all'. For example, for a text change from 'foo' to 'bar' in a live region with a default
  /// aria-relevant value, the text addition ('bar"') would be spoken, but the text removal ('foo')
  /// would not.
  ///
  /// aria-relevant is an optional attribute of live regions. This is a suggestion to assistive
  /// technologies, but assistive technologies are not required to present changes of all the relevant
  /// types.
  ///
  /// Both accessibility APIs and Document Object Model Level 2 Events `DOM` provides events to
  /// allow assistive technologies to determine changed areas of the document.
  ///
  /// When aria-relevant is not defined, an element's value is inherited from the nearest ancestor
  /// with a defined value. Although the value is a token list, inherited values are not additive;
  /// the value provided on a descendant element completely overrides any inherited value from an
  /// ancestor element.
  ///
  /// When text changes are denoted as relevant, user agents MUST monitor any descendant node change
  /// that affects the text alternative computation of the live region as if the accessible name
  /// were determined from contents (nameFrom: contents). For example, a text change would be triggered
  /// if the HTML alt attribute of a contained image changed. However, no change would be triggered
  /// if there was a text change to a node outside the live region, even if that node was referenced
  /// (via aria-labelledby) by an element contained in the live region.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-relevant>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.relevant] -->
  @override
  @Accessor(key: 'aria-relevant')
  dynamic get relevant =>
      props[_$key__relevant___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates what user agent change notifications (additions, removals, etc.) assistive technologies
  /// will receive within a live region. See related aria-atomic.
  ///
  /// The attribute is represented as a space delimited list of the following values: additions,
  /// removals, text; or a single catch-all value all.
  ///
  /// This is used to describe semantically meaningful changes, as opposed to merely presentational
  /// ones. For example, nodes that are removed from the top of a log are merely removed for purposes
  /// of creating room for other entries, and the removal of them does not have meaning. However,
  /// in the case of a buddy list, removal of a buddy name indicates that they are no longer online,
  /// and this is a meaningful event. In that case aria-relevant will be set to all. When the aria-relevant
  /// attribute is not provided, the default value, additions text, indicates that text modifications
  /// and node additions are relevant, but that node removals are irrelevant.
  ///
  /// Note: aria-relevant values of removals or all are to be used sparingly. Assistive technologies
  /// only need to be informed of content removal when its removal represents an important change,
  /// such as a buddy leaving a chat room.
  ///
  /// Note: Text removals should only be considered relevant if one of the specified values is 'removals'
  /// or 'all'. For example, for a text change from 'foo' to 'bar' in a live region with a default
  /// aria-relevant value, the text addition ('bar"') would be spoken, but the text removal ('foo')
  /// would not.
  ///
  /// aria-relevant is an optional attribute of live regions. This is a suggestion to assistive
  /// technologies, but assistive technologies are not required to present changes of all the relevant
  /// types.
  ///
  /// Both accessibility APIs and Document Object Model Level 2 Events `DOM` provides events to
  /// allow assistive technologies to determine changed areas of the document.
  ///
  /// When aria-relevant is not defined, an element's value is inherited from the nearest ancestor
  /// with a defined value. Although the value is a token list, inherited values are not additive;
  /// the value provided on a descendant element completely overrides any inherited value from an
  /// ancestor element.
  ///
  /// When text changes are denoted as relevant, user agents MUST monitor any descendant node change
  /// that affects the text alternative computation of the live region as if the accessible name
  /// were determined from contents (nameFrom: contents). For example, a text change would be triggered
  /// if the HTML alt attribute of a contained image changed. However, no change would be triggered
  /// if there was a text change to a node outside the live region, even if that node was referenced
  /// (via aria-labelledby) by an element contained in the live region.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-relevant>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.relevant] -->
  @override
  @Accessor(key: 'aria-relevant')
  set relevant(dynamic value) =>
      props[_$key__relevant___$AriaPropsMixin] = value;

  /// Indicates that user input is required on the element before a form may be submitted.
  ///
  /// For example, if the user needs to fill in an address field, the author will need to set the
  /// field's aria-required attribute to true.
  ///
  /// Note: The fact that the element is required is often presented visually (such as a sign or
  /// symbol after the widget). Using the aria-required attribute allows the author to explicitly
  /// convey to assistive technologies that an element is required.
  ///
  /// Unless an exactly equivalent native attribute is available, host languages SHOULD allow authors
  /// to use the aria-required attribute on host language form elements that require input or selection
  /// by the user.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-required>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.required] -->
  @override
  @Accessor(key: 'aria-required')
  bool get required =>
      props[_$key__required___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates that user input is required on the element before a form may be submitted.
  ///
  /// For example, if the user needs to fill in an address field, the author will need to set the
  /// field's aria-required attribute to true.
  ///
  /// Note: The fact that the element is required is often presented visually (such as a sign or
  /// symbol after the widget). Using the aria-required attribute allows the author to explicitly
  /// convey to assistive technologies that an element is required.
  ///
  /// Unless an exactly equivalent native attribute is available, host languages SHOULD allow authors
  /// to use the aria-required attribute on host language form elements that require input or selection
  /// by the user.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-required>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.required] -->
  @override
  @Accessor(key: 'aria-required')
  set required(bool value) => props[_$key__required___$AriaPropsMixin] = value;

  /// Specifies the the type defining a user interface element. Enriches the semantics of markup and
  /// gives assistive technologies information about how to handle each element.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/usage#usage_intro>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.role] -->
  @override
  String get role =>
      props[_$key__role___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Specifies the the type defining a user interface element. Enriches the semantics of markup and
  /// gives assistive technologies information about how to handle each element.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/usage#usage_intro>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.role] -->
  @override
  set role(String value) => props[_$key__role___$AriaPropsMixin] = value;

  /// Indicates the current 'selected' state of various widgets. See related aria-checked and aria-pressed.
  ///
  /// This attribute is used with single-selection and multiple-selection widgets:
  ///
  /// Single-selection containers where the currently focused item is not selected. The selection
  /// normally follows the focus, and is managed by the user agent.Multiple-selection containers.
  /// Authors SHOULD ensure that any selectable descendant of a container in which the aria-multiselectable
  /// attribute is true specifies a value of either true or false for the aria-selected attribute.
  ///
  /// Any explicit assignment of aria-selected takes precedence over the implicit selection based
  /// on focus. If no DOM element in the widget is explicitly marked as selected, assistive technologies
  /// MAY convey implicit selection which follows the keyboard focus of the managed focus widget.
  /// If any DOM element in the widget is explicitly marked as selected, the user agent MUST NOT
  /// convey implicit selection for the widget.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-selected>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.selected] -->
  @override
  @Accessor(key: 'aria-selected')
  dynamic get selected =>
      props[_$key__selected___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates the current 'selected' state of various widgets. See related aria-checked and aria-pressed.
  ///
  /// This attribute is used with single-selection and multiple-selection widgets:
  ///
  /// Single-selection containers where the currently focused item is not selected. The selection
  /// normally follows the focus, and is managed by the user agent.Multiple-selection containers.
  /// Authors SHOULD ensure that any selectable descendant of a container in which the aria-multiselectable
  /// attribute is true specifies a value of either true or false for the aria-selected attribute.
  ///
  /// Any explicit assignment of aria-selected takes precedence over the implicit selection based
  /// on focus. If no DOM element in the widget is explicitly marked as selected, assistive technologies
  /// MAY convey implicit selection which follows the keyboard focus of the managed focus widget.
  /// If any DOM element in the widget is explicitly marked as selected, the user agent MUST NOT
  /// convey implicit selection for the widget.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-selected>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.selected] -->
  @override
  @Accessor(key: 'aria-selected')
  set selected(dynamic value) =>
      props[_$key__selected___$AriaPropsMixin] = value;

  /// Defines the number of items in the current set of listitems or treeitems. Not required if
  /// all elements in the set are present in the DOM. See related aria-posinset.
  ///
  /// This property is marked on the members of a set, not the container element that collects the
  /// members of the set. To orient the user by saying an element is "item X out of Y," the assistive
  /// technologies would use X equal to the aria-posinset attribute and Y equal to the aria-setsize
  /// attribute.
  ///
  /// If all items in a set are present in the document structure, it is not necessary to set this
  /// property, as the user agent can automatically calculate the set size and position for each
  /// item. However, if only a portion of the set is present in the document structure at a given
  /// moment (in order to reduce document size), this property is needed to provide an explicit
  /// indication of set size.
  ///
  /// Authors SHOULD use aria-setsize in conjunction with aria-posinset.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-setsize>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.setsize] -->
  @override
  @Accessor(key: 'aria-setsize')
  int get setsize =>
      props[_$key__setsize___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the number of items in the current set of listitems or treeitems. Not required if
  /// all elements in the set are present in the DOM. See related aria-posinset.
  ///
  /// This property is marked on the members of a set, not the container element that collects the
  /// members of the set. To orient the user by saying an element is "item X out of Y," the assistive
  /// technologies would use X equal to the aria-posinset attribute and Y equal to the aria-setsize
  /// attribute.
  ///
  /// If all items in a set are present in the document structure, it is not necessary to set this
  /// property, as the user agent can automatically calculate the set size and position for each
  /// item. However, if only a portion of the set is present in the document structure at a given
  /// moment (in order to reduce document size), this property is needed to provide an explicit
  /// indication of set size.
  ///
  /// Authors SHOULD use aria-setsize in conjunction with aria-posinset.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-setsize>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.setsize] -->
  @override
  @Accessor(key: 'aria-setsize')
  set setsize(int value) => props[_$key__setsize___$AriaPropsMixin] = value;

  /// Indicates if items in a table or grid are sorted in ascending or descending order.
  ///
  /// Authors SHOULD only apply this property to table headers or grid headers. If the property
  /// is not provided, there is no defined sort order. For each table or grid, authors SHOULD apply
  /// aria-sort to only one header at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-sort>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.sort] -->
  @override
  @Accessor(key: 'aria-sort')
  dynamic get sort =>
      props[_$key__sort___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Indicates if items in a table or grid are sorted in ascending or descending order.
  ///
  /// Authors SHOULD only apply this property to table headers or grid headers. If the property
  /// is not provided, there is no defined sort order. For each table or grid, authors SHOULD apply
  /// aria-sort to only one header at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-sort>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.sort] -->
  @override
  @Accessor(key: 'aria-sort')
  set sort(dynamic value) => props[_$key__sort___$AriaPropsMixin] = value;

  /// Defines the maximum allowed value for a range widget.
  ///
  /// A range widget may start with a given value, which can be increased until a maximum value,
  /// defined by this property, is reached.
  ///
  /// Declaring the minimum and maximum values allows alternate devices to react to arrow keys,
  /// validate the current value, or simply let the user know the size of the range. If the aria-valuenow
  /// has a known maximum and minimum, the author SHOULD provide properties for aria-valuemax and
  /// aria-valuemin. Authors MUST ensure the value of aria-valuemax is greater than or equal to
  /// the value of aria-valuemin.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuemax>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuemax] -->
  @override
  @Accessor(key: 'aria-valuemax')
  num get valuemax =>
      props[_$key__valuemax___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the maximum allowed value for a range widget.
  ///
  /// A range widget may start with a given value, which can be increased until a maximum value,
  /// defined by this property, is reached.
  ///
  /// Declaring the minimum and maximum values allows alternate devices to react to arrow keys,
  /// validate the current value, or simply let the user know the size of the range. If the aria-valuenow
  /// has a known maximum and minimum, the author SHOULD provide properties for aria-valuemax and
  /// aria-valuemin. Authors MUST ensure the value of aria-valuemax is greater than or equal to
  /// the value of aria-valuemin.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuemax>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuemax] -->
  @override
  @Accessor(key: 'aria-valuemax')
  set valuemax(num value) => props[_$key__valuemax___$AriaPropsMixin] = value;

  /// Defines the minimum allowed value for a range widget.
  ///
  /// A range widget may start with a given value, which can be decreased until a minimum value,
  /// defined by this property, is reached.
  ///
  /// Declaring the minimum and maximum values allows alternate devices to react to arrow keys,
  /// validate the current value, or simply let the user know the size of the range. If the aria-valuenow
  /// has a known maximum and minimum, the author SHOULD provide properties for aria-valuemax and
  /// aria-valuemin.
  ///
  /// Authors MUST ensure the value of aria-valuemin is less than or equal to the value of aria-valuemax.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuemin>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuemin] -->
  @override
  @Accessor(key: 'aria-valuemin')
  num get valuemin =>
      props[_$key__valuemin___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the minimum allowed value for a range widget.
  ///
  /// A range widget may start with a given value, which can be decreased until a minimum value,
  /// defined by this property, is reached.
  ///
  /// Declaring the minimum and maximum values allows alternate devices to react to arrow keys,
  /// validate the current value, or simply let the user know the size of the range. If the aria-valuenow
  /// has a known maximum and minimum, the author SHOULD provide properties for aria-valuemax and
  /// aria-valuemin.
  ///
  /// Authors MUST ensure the value of aria-valuemin is less than or equal to the value of aria-valuemax.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuemin>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuemin] -->
  @override
  @Accessor(key: 'aria-valuemin')
  set valuemin(num value) => props[_$key__valuemin___$AriaPropsMixin] = value;

  /// Defines the current value for a range widget. See related aria-valuetext.
  ///
  /// This property is used, for example, on a range widget such as a slider or progress bar.
  ///
  /// If the current value is not known (for example, an indeterminate progress bar), the author
  /// SHOULD NOT set the aria-valuenow attribute. If the aria-valuenow attribute is absent, no information
  /// is implied about the current value. If the aria-valuenow has a known maximum and minimum,
  /// the author SHOULD provide properties for aria-valuemax and aria-valuemin.
  ///
  /// The value of aria-valuenow is a decimal number. If the range is a set of numeric values, then
  /// aria-valuenow is one of those values. For example, if the range is [0, 1], a valid aria-valuenow
  /// is 0.5. A value outside the range, such as -2.5 or 1.1, is invalid.
  ///
  /// For progressbar elements and scrollbar elements, assistive technologies SHOULD render the
  /// value to users as a percent, calculated as a position on the range from aria-valuemin to aria-valuemax
  /// if both are defined, otherwise the actual value with a percent indicator. For elements with
  /// role slider and spinbutton, assistive technologies SHOULD render the actual value to users.
  ///
  ///
  /// When the rendered value cannot be accurately represented as a number, authors SHOULD use the
  /// aria-valuetext attribute in conjunction with aria-valuenow to provide a user-friendly representation
  /// of the range's current value. For example, a slider may have rendered values of small, medium,
  /// and large. In this case, the values of aria-valuenow could range from 1 through 3, which indicate
  /// the position of each value in the value space, but the aria-valuetext would be one of the
  /// strings: small, medium, or large.
  ///
  /// Note: If aria-valuetext is specified, assistive technologies render that instead of the value
  /// of aria-valuenow.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuenow>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuenow] -->
  @override
  @Accessor(key: 'aria-valuenow')
  num get valuenow =>
      props[_$key__valuenow___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the current value for a range widget. See related aria-valuetext.
  ///
  /// This property is used, for example, on a range widget such as a slider or progress bar.
  ///
  /// If the current value is not known (for example, an indeterminate progress bar), the author
  /// SHOULD NOT set the aria-valuenow attribute. If the aria-valuenow attribute is absent, no information
  /// is implied about the current value. If the aria-valuenow has a known maximum and minimum,
  /// the author SHOULD provide properties for aria-valuemax and aria-valuemin.
  ///
  /// The value of aria-valuenow is a decimal number. If the range is a set of numeric values, then
  /// aria-valuenow is one of those values. For example, if the range is [0, 1], a valid aria-valuenow
  /// is 0.5. A value outside the range, such as -2.5 or 1.1, is invalid.
  ///
  /// For progressbar elements and scrollbar elements, assistive technologies SHOULD render the
  /// value to users as a percent, calculated as a position on the range from aria-valuemin to aria-valuemax
  /// if both are defined, otherwise the actual value with a percent indicator. For elements with
  /// role slider and spinbutton, assistive technologies SHOULD render the actual value to users.
  ///
  ///
  /// When the rendered value cannot be accurately represented as a number, authors SHOULD use the
  /// aria-valuetext attribute in conjunction with aria-valuenow to provide a user-friendly representation
  /// of the range's current value. For example, a slider may have rendered values of small, medium,
  /// and large. In this case, the values of aria-valuenow could range from 1 through 3, which indicate
  /// the position of each value in the value space, but the aria-valuetext would be one of the
  /// strings: small, medium, or large.
  ///
  /// Note: If aria-valuetext is specified, assistive technologies render that instead of the value
  /// of aria-valuenow.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuenow>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuenow] -->
  @override
  @Accessor(key: 'aria-valuenow')
  set valuenow(num value) => props[_$key__valuenow___$AriaPropsMixin] = value;

  /// Defines the human readable text alternative of aria-valuenow for a range widget.
  ///
  /// This property is used, for example, on a range widget such as a slider or progress bar.
  ///
  /// If the aria-valuetext attribute is set, authors SHOULD also set the aria-valuenow attribute,
  /// unless that value is unknown (for example, on an indeterminate progressbar).
  ///
  /// Authors SHOULD only set the aria-valuetext attribute when the rendered value cannot be meaningfully
  /// represented as a number. For example, a slider may have rendered values of small, medium,
  /// and large. In this case, the values of aria-valuenow could range from 1 through 3, which indicate
  /// the position of each value in the value space, but the aria-valuetext would be one of the
  /// strings: small, medium, or large. If the aria-valuetext attribute is absent, the assistive
  /// technologies will rely solely on the aria-valuenow attribute for the current value.
  ///
  /// If aria-valuetext is specified, assistive technologies SHOULD render that value instead of
  /// the value of aria-valuenow.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuetext>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuetext] -->
  @override
  @Accessor(key: 'aria-valuetext')
  String get valuetext =>
      props[_$key__valuetext___$AriaPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Defines the human readable text alternative of aria-valuenow for a range widget.
  ///
  /// This property is used, for example, on a range widget such as a slider or progress bar.
  ///
  /// If the aria-valuetext attribute is set, authors SHOULD also set the aria-valuenow attribute,
  /// unless that value is unknown (for example, on an indeterminate progressbar).
  ///
  /// Authors SHOULD only set the aria-valuetext attribute when the rendered value cannot be meaningfully
  /// represented as a number. For example, a slider may have rendered values of small, medium,
  /// and large. In this case, the values of aria-valuenow could range from 1 through 3, which indicate
  /// the position of each value in the value space, but the aria-valuetext would be one of the
  /// strings: small, medium, or large. If the aria-valuetext attribute is absent, the assistive
  /// technologies will rely solely on the aria-valuenow attribute for the current value.
  ///
  /// If aria-valuetext is specified, assistive technologies SHOULD render that value instead of
  /// the value of aria-valuenow.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuetext>
  ///
  /// <!-- Generated from [_$AriaPropsMixin.valuetext] -->
  @override
  @Accessor(key: 'aria-valuetext')
  set valuetext(String value) =>
      props[_$key__valuetext___$AriaPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__activedescendant___$AriaPropsMixin =
      PropDescriptor(_$key__activedescendant___$AriaPropsMixin);
  static const PropDescriptor _$prop__atomic___$AriaPropsMixin =
      PropDescriptor(_$key__atomic___$AriaPropsMixin);
  static const PropDescriptor _$prop__autocomplete___$AriaPropsMixin =
      PropDescriptor(_$key__autocomplete___$AriaPropsMixin);
  static const PropDescriptor _$prop__busy___$AriaPropsMixin =
      PropDescriptor(_$key__busy___$AriaPropsMixin);
  static const PropDescriptor _$prop__checked___$AriaPropsMixin =
      PropDescriptor(_$key__checked___$AriaPropsMixin);
  static const PropDescriptor _$prop__controls___$AriaPropsMixin =
      PropDescriptor(_$key__controls___$AriaPropsMixin);
  static const PropDescriptor _$prop__describedby___$AriaPropsMixin =
      PropDescriptor(_$key__describedby___$AriaPropsMixin);
  static const PropDescriptor _$prop__disabled___$AriaPropsMixin =
      PropDescriptor(_$key__disabled___$AriaPropsMixin);
  static const PropDescriptor _$prop__dropeffect___$AriaPropsMixin =
      PropDescriptor(_$key__dropeffect___$AriaPropsMixin);
  static const PropDescriptor _$prop__expanded___$AriaPropsMixin =
      PropDescriptor(_$key__expanded___$AriaPropsMixin);
  static const PropDescriptor _$prop__flowto___$AriaPropsMixin =
      PropDescriptor(_$key__flowto___$AriaPropsMixin);
  static const PropDescriptor _$prop__grabbed___$AriaPropsMixin =
      PropDescriptor(_$key__grabbed___$AriaPropsMixin);
  static const PropDescriptor _$prop__haspopup___$AriaPropsMixin =
      PropDescriptor(_$key__haspopup___$AriaPropsMixin);
  static const PropDescriptor _$prop__hidden___$AriaPropsMixin =
      PropDescriptor(_$key__hidden___$AriaPropsMixin);
  static const PropDescriptor _$prop__invalid___$AriaPropsMixin =
      PropDescriptor(_$key__invalid___$AriaPropsMixin);
  static const PropDescriptor _$prop__label___$AriaPropsMixin =
      PropDescriptor(_$key__label___$AriaPropsMixin);
  static const PropDescriptor _$prop__labelledby___$AriaPropsMixin =
      PropDescriptor(_$key__labelledby___$AriaPropsMixin);
  static const PropDescriptor _$prop__level___$AriaPropsMixin =
      PropDescriptor(_$key__level___$AriaPropsMixin);
  static const PropDescriptor _$prop__live___$AriaPropsMixin =
      PropDescriptor(_$key__live___$AriaPropsMixin);
  static const PropDescriptor _$prop__multiline___$AriaPropsMixin =
      PropDescriptor(_$key__multiline___$AriaPropsMixin);
  static const PropDescriptor _$prop__multiselectable___$AriaPropsMixin =
      PropDescriptor(_$key__multiselectable___$AriaPropsMixin);
  static const PropDescriptor _$prop__orientation___$AriaPropsMixin =
      PropDescriptor(_$key__orientation___$AriaPropsMixin);
  static const PropDescriptor _$prop__owns___$AriaPropsMixin =
      PropDescriptor(_$key__owns___$AriaPropsMixin);
  static const PropDescriptor _$prop__posinset___$AriaPropsMixin =
      PropDescriptor(_$key__posinset___$AriaPropsMixin);
  static const PropDescriptor _$prop__pressed___$AriaPropsMixin =
      PropDescriptor(_$key__pressed___$AriaPropsMixin);
  static const PropDescriptor _$prop__readonly___$AriaPropsMixin =
      PropDescriptor(_$key__readonly___$AriaPropsMixin);
  static const PropDescriptor _$prop__relevant___$AriaPropsMixin =
      PropDescriptor(_$key__relevant___$AriaPropsMixin);
  static const PropDescriptor _$prop__required___$AriaPropsMixin =
      PropDescriptor(_$key__required___$AriaPropsMixin);
  static const PropDescriptor _$prop__role___$AriaPropsMixin =
      PropDescriptor(_$key__role___$AriaPropsMixin);
  static const PropDescriptor _$prop__selected___$AriaPropsMixin =
      PropDescriptor(_$key__selected___$AriaPropsMixin);
  static const PropDescriptor _$prop__setsize___$AriaPropsMixin =
      PropDescriptor(_$key__setsize___$AriaPropsMixin);
  static const PropDescriptor _$prop__sort___$AriaPropsMixin =
      PropDescriptor(_$key__sort___$AriaPropsMixin);
  static const PropDescriptor _$prop__valuemax___$AriaPropsMixin =
      PropDescriptor(_$key__valuemax___$AriaPropsMixin);
  static const PropDescriptor _$prop__valuemin___$AriaPropsMixin =
      PropDescriptor(_$key__valuemin___$AriaPropsMixin);
  static const PropDescriptor _$prop__valuenow___$AriaPropsMixin =
      PropDescriptor(_$key__valuenow___$AriaPropsMixin);
  static const PropDescriptor _$prop__valuetext___$AriaPropsMixin =
      PropDescriptor(_$key__valuetext___$AriaPropsMixin);
  static const String _$key__activedescendant___$AriaPropsMixin =
      'aria-activedescendant';
  static const String _$key__atomic___$AriaPropsMixin = 'aria-atomic';
  static const String _$key__autocomplete___$AriaPropsMixin =
      'aria-autocomplete';
  static const String _$key__busy___$AriaPropsMixin = 'aria-busy';
  static const String _$key__checked___$AriaPropsMixin = 'aria-checked';
  static const String _$key__controls___$AriaPropsMixin = 'aria-controls';
  static const String _$key__describedby___$AriaPropsMixin = 'aria-describedby';
  static const String _$key__disabled___$AriaPropsMixin = 'aria-disabled';
  static const String _$key__dropeffect___$AriaPropsMixin = 'aria-dropeffect';
  static const String _$key__expanded___$AriaPropsMixin = 'aria-expanded';
  static const String _$key__flowto___$AriaPropsMixin = 'aria-flowto';
  static const String _$key__grabbed___$AriaPropsMixin = 'aria-grabbed';
  static const String _$key__haspopup___$AriaPropsMixin = 'aria-haspopup';
  static const String _$key__hidden___$AriaPropsMixin = 'aria-hidden';
  static const String _$key__invalid___$AriaPropsMixin = 'aria-invalid';
  static const String _$key__label___$AriaPropsMixin = 'aria-label';
  static const String _$key__labelledby___$AriaPropsMixin = 'aria-labelledby';
  static const String _$key__level___$AriaPropsMixin = 'aria-level';
  static const String _$key__live___$AriaPropsMixin = 'aria-live';
  static const String _$key__multiline___$AriaPropsMixin = 'aria-multiline';
  static const String _$key__multiselectable___$AriaPropsMixin =
      'aria-multiselectable';
  static const String _$key__orientation___$AriaPropsMixin = 'aria-orientation';
  static const String _$key__owns___$AriaPropsMixin = 'aria-owns';
  static const String _$key__posinset___$AriaPropsMixin = 'aria-posinset';
  static const String _$key__pressed___$AriaPropsMixin = 'aria-pressed';
  static const String _$key__readonly___$AriaPropsMixin = 'aria-readonly';
  static const String _$key__relevant___$AriaPropsMixin = 'aria-relevant';
  static const String _$key__required___$AriaPropsMixin = 'aria-required';
  static const String _$key__role___$AriaPropsMixin = 'role';
  static const String _$key__selected___$AriaPropsMixin = 'aria-selected';
  static const String _$key__setsize___$AriaPropsMixin = 'aria-setsize';
  static const String _$key__sort___$AriaPropsMixin = 'aria-sort';
  static const String _$key__valuemax___$AriaPropsMixin = 'aria-valuemax';
  static const String _$key__valuemin___$AriaPropsMixin = 'aria-valuemin';
  static const String _$key__valuenow___$AriaPropsMixin = 'aria-valuenow';
  static const String _$key__valuetext___$AriaPropsMixin = 'aria-valuetext';

  static const List<PropDescriptor> $props = [
    _$prop__activedescendant___$AriaPropsMixin,
    _$prop__atomic___$AriaPropsMixin,
    _$prop__autocomplete___$AriaPropsMixin,
    _$prop__busy___$AriaPropsMixin,
    _$prop__checked___$AriaPropsMixin,
    _$prop__controls___$AriaPropsMixin,
    _$prop__describedby___$AriaPropsMixin,
    _$prop__disabled___$AriaPropsMixin,
    _$prop__dropeffect___$AriaPropsMixin,
    _$prop__expanded___$AriaPropsMixin,
    _$prop__flowto___$AriaPropsMixin,
    _$prop__grabbed___$AriaPropsMixin,
    _$prop__haspopup___$AriaPropsMixin,
    _$prop__hidden___$AriaPropsMixin,
    _$prop__invalid___$AriaPropsMixin,
    _$prop__label___$AriaPropsMixin,
    _$prop__labelledby___$AriaPropsMixin,
    _$prop__level___$AriaPropsMixin,
    _$prop__live___$AriaPropsMixin,
    _$prop__multiline___$AriaPropsMixin,
    _$prop__multiselectable___$AriaPropsMixin,
    _$prop__orientation___$AriaPropsMixin,
    _$prop__owns___$AriaPropsMixin,
    _$prop__posinset___$AriaPropsMixin,
    _$prop__pressed___$AriaPropsMixin,
    _$prop__readonly___$AriaPropsMixin,
    _$prop__relevant___$AriaPropsMixin,
    _$prop__required___$AriaPropsMixin,
    _$prop__role___$AriaPropsMixin,
    _$prop__selected___$AriaPropsMixin,
    _$prop__setsize___$AriaPropsMixin,
    _$prop__sort___$AriaPropsMixin,
    _$prop__valuemax___$AriaPropsMixin,
    _$prop__valuemin___$AriaPropsMixin,
    _$prop__valuenow___$AriaPropsMixin,
    _$prop__valuetext___$AriaPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__activedescendant___$AriaPropsMixin,
    _$key__atomic___$AriaPropsMixin,
    _$key__autocomplete___$AriaPropsMixin,
    _$key__busy___$AriaPropsMixin,
    _$key__checked___$AriaPropsMixin,
    _$key__controls___$AriaPropsMixin,
    _$key__describedby___$AriaPropsMixin,
    _$key__disabled___$AriaPropsMixin,
    _$key__dropeffect___$AriaPropsMixin,
    _$key__expanded___$AriaPropsMixin,
    _$key__flowto___$AriaPropsMixin,
    _$key__grabbed___$AriaPropsMixin,
    _$key__haspopup___$AriaPropsMixin,
    _$key__hidden___$AriaPropsMixin,
    _$key__invalid___$AriaPropsMixin,
    _$key__label___$AriaPropsMixin,
    _$key__labelledby___$AriaPropsMixin,
    _$key__level___$AriaPropsMixin,
    _$key__live___$AriaPropsMixin,
    _$key__multiline___$AriaPropsMixin,
    _$key__multiselectable___$AriaPropsMixin,
    _$key__orientation___$AriaPropsMixin,
    _$key__owns___$AriaPropsMixin,
    _$key__posinset___$AriaPropsMixin,
    _$key__pressed___$AriaPropsMixin,
    _$key__readonly___$AriaPropsMixin,
    _$key__relevant___$AriaPropsMixin,
    _$key__required___$AriaPropsMixin,
    _$key__role___$AriaPropsMixin,
    _$key__selected___$AriaPropsMixin,
    _$key__setsize___$AriaPropsMixin,
    _$key__sort___$AriaPropsMixin,
    _$key__valuemax___$AriaPropsMixin,
    _$key__valuemin___$AriaPropsMixin,
    _$key__valuenow___$AriaPropsMixin,
    _$key__valuetext___$AriaPropsMixin
  ];
}

const PropsMeta _$metaForAriaPropsMixin = PropsMeta(
  fields: AriaPropsMixin.$props,
  keys: AriaPropsMixin.$propKeys,
);
