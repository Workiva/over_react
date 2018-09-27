// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library over_react.aria_mixin;

import 'dart:collection';

// Must import these consts because they are used in the transformed code.
// ignore: unused_import
import 'package:over_react/over_react.dart' show PropDescriptor, ConsumedProps;
import 'package:over_react/src/component_declaration/annotations.dart';

part 'aria_mixin.overReactBuilder.g.dart';

/// Typed getters/setters for accessibility props.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class AriaPropsMixin {
  Map get props;

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
  @Accessor(key: 'aria-activedescendant')
  String activedescendant;

  /// Indicates whether assistive technologies will present all, or only parts of, the changed region
  /// based on the change notifications defined by the aria-relevant attribute. See related aria-relevant.
  ///
  /// Both accessibility APIs and the Document Object Model [DOM] provide events to allow the assistive
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
  @Accessor(key: 'aria-atomic')
  bool atomic;

  /// Indicates whether user input completion suggestions are provided.
  ///
  /// For a textbox with the aria-autocomplete attribute set to either inline or both, authors SHOULD
  /// ensure that any auto-completed text is selected, so the user can type over it.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-autocomplete>
  @Accessor(key: 'aria-autocomplete')
  dynamic autocomplete;

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
  @Accessor(key: 'aria-busy')
  bool busy;

  /// Indicates the current "checked" state of checkboxes, radio buttons, and other widgets. See
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
  @Accessor(key: 'aria-checked')
  dynamic checked;

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
  @Accessor(key: 'aria-controls')
  dynamic controls;

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
  @Accessor(key: 'aria-describedby')
  dynamic describedby;

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
  @Accessor(key: 'aria-disabled')
  bool disabled;

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
  @Accessor(key: 'aria-dropeffect')
  dynamic dropeffect;

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
  @Accessor(key: 'aria-expanded')
  dynamic expanded;

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
  @Accessor(key: 'aria-flowto')
  dynamic flowto;

  /// Indicates an element's "grabbed" state in a drag-and-drop operation.
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
  @Accessor(key: 'aria-grabbed')
  dynamic grabbed;

  /// Indicates that the element has a popup context menu or sub-level menu.
  ///
  /// This means that activation renders conditional content. Note that ordinary tooltips are not
  /// considered popups in this context.
  ///
  /// A popup is generally presented visually as a group of items that appears to be on top of the
  /// main page content.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-haspopup>
  @Accessor(key: 'aria-haspopup')
  bool haspopup;

  /// Indicates that the element and all of its descendants are not visible or perceivable to any
  /// user as implemented by the author. See related aria-disabled.
  ///
  /// If an element is only visible after some user action, authors MUST set the aria-hidden attribute
  /// to true. When the element is presented, authors MUST set the aria-hidden attribute to false
  /// or remove the attribute, indicating that the element is visible. Some assistive technologies
  /// access WAI-ARIA information directly through the DOM and not through platform accessibility
  /// supported by the browser. Authors MUST set aria-hidden="true" on content that is not displayed,
  /// regardless of the mechanism used to hide it. This allows assistive technologies or user agents
  /// to properly skip hidden elements in the document.
  ///
  /// It is recommended that authors key visibility of elements off this attribute, rather than
  /// change visibility and separately have to remember to update this property. CSS 2 provides
  /// a way to select on attribute values ([CSS]). The following CSS declaration makes content visible
  /// unless the aria-hidden attribute is true; scripts need only update the value of this attribute
  /// to change visibility:
  ///
  /// [aria-hidden="true"] { visibility: hidden; }
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
  @Accessor(key: 'aria-hidden')
  bool hidden;

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
  @Accessor(key: 'aria-invalid')
  dynamic invalid;

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
  /// name the element (e.g., the title attribute in HTML [HTML]), yet this could present a browser
  /// tooltip. In the cases where a visible label or visible tooltip is undesirable, authors MAY
  /// set the accessible name of the element using aria-label. As required by the text alternative
  /// computation, user agents give precedence to aria-labelledby over aria-label when computing
  /// the accessible name property.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-label>
  @Accessor(key: 'aria-label')
  String label;

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
  /// accessibility API features to which this property is mapped have established the "labelledby"
  /// spelling. This property is spelled that way to match the convention and minimize the difficulty
  /// for developers.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-labelledby>
  @Accessor(key: 'aria-labelledby')
  dynamic labelledby;

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
  @Accessor(key: 'aria-level')
  int level;

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
  @Accessor(key: 'aria-live')
  dynamic live;

  /// Indicates whether a text box accepts multiple lines of input or only a single line.
  ///
  /// Note: In most user agent implementations, the default behavior of the ENTER or RETURN key
  /// is different between the single-line and multi-line text fields in HTML. When user has focus
  /// in a single-line &lt;input type="text"&gt; element, the keystroke usually submits the form.
  /// When user has focus in a multi-line &lt;textarea&gt; element, the keystroke inserts a line
  /// break. The WAI-ARIA textbox role differentiates these types of boxes with the aria-multiline
  /// attribute, so authors are advised to be aware of this distinction when designing the field.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiline>
  @Accessor(key: 'aria-multiline')
  bool multiline;

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
  @Accessor(key: 'aria-multiselectable')
  bool multiselectable;

  /// Indicates whether the element and orientation is horizontal or vertical.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-orientation>
  @Accessor(key: 'aria-orientation')
  dynamic orientation;

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
  @Accessor(key: 'aria-owns')
  dynamic owns;

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
  @Accessor(key: 'aria-posinset')
  int posinset;

  /// Indicates the current "pressed" state of toggle buttons. See related aria-checked and aria-selected.
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
  @Accessor(key: 'aria-pressed')
  dynamic pressed;

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
  @Accessor(key: 'aria-readonly')
  bool readonly;

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
  /// Both accessibility APIs and Document Object Model Level 2 Events [DOM] provides events to
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
  @Accessor(key: 'aria-relevant')
  dynamic relevant;

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
  @Accessor(key: 'aria-required')
  bool required;

  /// Specifies the the type defining a user interface element. Enriches the semantics of markup and
  /// gives assistive technologies information about how to handle each element.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/usage#usage_intro>
  String role;

  /// Indicates the current "selected" state of various widgets. See related aria-checked and aria-pressed.
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
  @Accessor(key: 'aria-selected')
  dynamic selected;

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
  @Accessor(key: 'aria-setsize')
  int setsize;

  /// Indicates if items in a table or grid are sorted in ascending or descending order.
  ///
  /// Authors SHOULD only apply this property to table headers or grid headers. If the property
  /// is not provided, there is no defined sort order. For each table or grid, authors SHOULD apply
  /// aria-sort to only one header at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-sort>
  @Accessor(key: 'aria-sort')
  dynamic sort;

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
  @Accessor(key: 'aria-valuemax')
  num valuemax;

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
  @Accessor(key: 'aria-valuemin')
  num valuemin;

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
  @Accessor(key: 'aria-valuenow')
  num valuenow;

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
  @Accessor(key: 'aria-valuetext')
  String valuetext;
}

/// Options for WAI-ARIA role values.
///
/// See <http://www.w3.org/TR/wai-aria/roles>
class Role {
  /// A message with important, and usually time-sensitive, information. See related alertdialog
  /// and status.
  ///
  /// Alerts are used to convey messages to alert the user. In the case of audio warnings this is
  /// an accessible alternative for a hearing-impaired user. The alert role goes on the node containing
  /// the alert message. Alerts are specialized forms of the status role, which will be processed
  /// as an atomic live region.
  ///
  /// Alerts are assertive live regions and will be processed as such by assistive technologies.
  /// Neither authors nor user agents are required to set or manage focus to them in order for them
  /// to be processed. Since alerts are not required to receive focus, content authors SHOULD NOT
  /// require users to close an alert. If the operating system allows, the user agent SHOULD fire
  /// a system alert event through the accessibility API when the WAI-ARIA alert is created. If an
  /// alert requires focus to close the alert, then content authors SHOULD use alertdialog instead.
  ///
  /// Note: Elements with the role alert have an implicit aria-live value of assertive, and an implicit
  /// aria-atomic value of true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#alert>
  static const String alert = "alert";

  /// A type of dialog that contains an alert message, where initial focus goes to an element within
  /// the dialog. See related alert and dialog.
  ///
  /// Alert dialogs are used to convey messages to alert the user. The alertdialog role goes on the
  /// node containing both the alert message and the rest of the dialog. Content authors SHOULD make
  /// alert dialogs modal by ensuring that, while the alertdialog is shown, keyboard and mouse interactions
  /// only operate within the dialog.
  ///
  /// Unlike alert, alertdialog can receive a response from the user. For example, to confirm that
  /// the user understands the alert being generated. When the alert dialog is displayed, authors
  /// SHOULD set focus to an active element within the alert dialog, such as a form edit field or
  /// an OK button. The user agent SHOULD fire a system alert event through the accessibility API
  /// when the alert is created, provided one is specified by the intended accessibility API.
  ///
  /// Authors SHOULD use aria-describedby on an alertdialog to point to the alert message element
  /// in the dialog. If they do not, assistive technologies will resort to their internal recovery
  /// mechanism to determine the contents of an alert message.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#alertdialog>
  static const String alertdialog = "alertdialog";

  /// A region declared as a web application, as opposed to a web document.
  ///
  /// When the user navigates an element assigned the role of application, assistive technologies
  /// that typically intercept standard keyboard events SHOULD switch to an application browsing
  /// mode, and pass keyboard events through to the web application. The intent is to hint to certain
  /// assistive technologies to switch from normal browsing mode into a mode more appropriate for
  /// interacting with a web application; some user agents have a browse navigation mode where keys,
  /// such as up and down arrows, are used to browse the document, and this native behavior prevents
  /// the use of these keys by a web application.
  ///
  /// Note: Where appropriate, assistive technologies that typically intercept other standard device
  /// input events, such as touch screen input, could switch to an application browsing mode that
  /// passes some or all of those events through to the web application.
  ///
  /// Authors SHOULD set the role of application on the element that encompasses the entire application.
  /// If the application role applies to the entire web page, authors SHOULD set the role of application
  /// on the root node for content, such as the body element in HTML or svg element in SVG.
  ///
  /// For example, an email application has a document and an application in it. The author would
  /// want to use typical application navigation mode to cycle through the list of emails, and much
  /// of this navigation would be defined by the application author. However, when reading an email
  /// message the content will appear in a region with a document role in order to use browsing navigation.
  ///
  /// For all instances of non-decorative static text or image content inside an application, authors
  /// SHOULD either associate the text with a form widget or group (via aria-label, aria-labelledby,
  /// or aria-describedby) or separate the text into an element with role of document or article.
  ///
  /// Authors SHOULD provide a title or label for applications. Authors SHOULD use label text that
  /// is suitable for use as a navigation preview or table-of-contents entry for the page section.
  /// Content authors SHOULD provide the label through one of the following methods:
  ///
  /// If the application includes the entire contents of the web page, use the host language feature
  /// for title or label, such as the title element in both HTML and SVG. This has the effect of
  /// labeling the entire application.Otherwise, provide a visible label referenced by the application
  /// using aria-labelledby.
  /// User agents SHOULD treat elements with the role of application as navigational landmarks.
  ///
  /// Authors MAY use the application role on the primary content element of the host language (such
  /// as the body element in HTML) to define an entire page as an application. However, if the primary
  /// content element is defined as having a role of application, user agents MUST NOT use the element
  /// as a navigational landmark. If assistive technologies use an interaction mode that intercepts
  /// standard keyboard events, when encountering the application role, those assistive technologies
  /// SHOULD switch to an interaction mode that passes keyboard events through to the web application.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#application>
  static const String application = "application";

  /// A section of a page that consists of a composition that forms an independent part of a document,
  /// page, or site.
  ///
  /// An article is not a navigational landmark, but may be nested to form a discussion where assistive
  /// technologies could pay attention to article nesting to assist the user in following the discussion.
  /// An article could be a forum post, a magazine or newspaper article, a web log entry, a user-submitted
  /// comment, or any other independent item of content. It is independent in that its contents could
  /// stand alone, for example in syndication. However, the element is still associated with its
  /// ancestors; for instance, contact information that applies to a parent body element still covers
  /// the article as well. When nesting articles, the child articles represent content that is related to
  /// the content of the parent article. For instance, a web log entry on a site that accepts user-submitted
  /// comments could represent the comments as articles nested within the article for the web log entry.
  /// Author, heading, date, or other information associated with an article does not apply to nested articles.
  ///
  /// When the user navigates an element assigned the role of article, assistive technologies that
  /// typically intercept standard keyboard events SHOULD switch to document browsing mode, as opposed
  /// to passing keyboard events through to the web application. Assistive technologies MAY provide
  /// a feature allowing the user to navigate the hierarchy of any nested article elements.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#article>
  static const String article = "article";

  /// A region that contains mostly site-oriented content, rather than page-specific content.
  ///
  /// Site-oriented content typically includes things such as the logo or identity of the site sponsor,
  /// and site-specific search tool. A banner usually appears at the top of the page and typically
  /// spans the full width.
  ///
  /// User agents SHOULD treat elements with the role of banner as navigational landmarks.
  ///
  /// Within any document or application, the author SHOULD mark no more than one element with the
  /// banner role.
  ///
  /// Note: Because document and application elements can be nested in the DOM, they may have multiple
  /// banner elements as DOM descendants, assuming each of those is associated with different document
  /// nodes, either by a DOM nesting (e.g., document within document) or by use of the aria-owns
  /// attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#banner>
  static const String banner = "banner";

  /// An input that allows for user-triggered actions when clicked or pressed. See related link.
  ///
  /// Buttons are mostly used for discrete actions. Standardizing the appearance of buttons enhances
  /// the user's recognition of the widgets as buttons and allows for a more compact display in toolbars.
  ///
  /// Buttons support the optional attribute aria-pressed. Buttons with a non-empty aria-pressed
  /// attribute are toggle buttons. When aria-pressed is true the button is in a "pressed" state,
  /// when aria-pressed is false it is not pressed. If the attribute is not present, the button is
  /// a simple command button.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#button>
  static const String button = "button";

  /// A checkable input that has three possible values: true, false, or mixed.
  ///
  /// The aria-checked attribute of a checkbox indicates whether the input is checked (true), unchecked
  /// (false), or represents a group of elements that have a mixture of checked and unchecked values
  /// (mixed). Many checkboxes do not use the mixed value, and thus are effectively boolean checkboxes.
  ///
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#checkbox>
  static const String checkbox = "checkbox";

  /// A cell containing header information for a column.
  ///
  /// columnheader can be used as a column header in a table or grid. It could also be used in a
  /// pie chart to show a similar relationship in the data.
  ///
  /// The columnheader establishes a relationship between it and all cells in the corresponding column.
  /// It is the structural equivalent to an HTML th element with a column scope.
  ///
  /// Authors MUST ensure elements with role columnheader are contained in, or owned by, an element
  /// with the role row.
  ///
  /// Note: Because cells are organized into rows, there is not a single container element for the
  /// column. The column is the set of gridcell elements in a particular position within their respective
  /// row containers.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#columnheader>
  static const String columnheader = "columnheader";

  /// A presentation of a select; usually similar to a textbox where users can type ahead to select
  /// an option, or type to enter arbitrary text as a new item in the list. See related listbox.
  ///
  /// combobox is the combined presentation of a single line textfield with a listbox popup. The
  /// combobox may be editable. Typically editable combo boxes are used for autocomplete behavior,
  /// and authors SHOULD set aria-autocomplete attribute on the textfield.
  ///
  /// If an author sets a combobox's value of aria-autocomplete to 'none' (default), authors MUST
  /// manage and set focus on the associated listbox, so assistive technologies can follow the currently
  /// selected value.If an author sets a combobox's value of aria-autocomplete to 'inline' or 'both',
  /// authors MUST update the value of the focused textfield, so assistive technologies can announce
  /// the currently selected value.If an author sets a combobox's value of aria-autocomplete to 'list',
  /// user agents MUST expose changes to the aria-activedescendant attribute on the combobox while
  /// the combobox remains focused. If a change to the aria-activedescendant attribute occurs while
  /// the combobox is focused, assistive technologies SHOULD alert the user of that change, for example,
  ///  by speaking the text alternative of the new active descendant element. Authors SHOULD associate
  ///  the combobox textfield with its listbox using aria-owns.
  ///
  /// Note: In XForms [XFORMS] the same select can have one of 3 appearances: combo-box, drop-down
  /// box, or group of radio-buttons. Many browsers allow users to type ahead to existing choices
  /// in a drop-down select widget. This specification does not constrain the presentation of the
  /// combo box.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// Note: Elements with the role combobox have an implicit aria-haspopup value of true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#combobox>
  static const String combobox = "combobox";

  /// A supporting section of the document, designed to be complementary to the main content at a
  /// similar level in the DOM hierarchy, but remains meaningful when separated from the main content.
  ///
  /// There are various types of content that would appropriately have this role. For example, in
  /// the case of a portal, this may include but not be limited to show times, current weather, related
  /// articles, or stocks to watch. The complementary role indicates that contained content is relevant
  /// to the main content. If the complementary content is completely separable main content, it
  /// may be appropriate to use a more general role.
  ///
  /// User agents SHOULD treat elements with the role of complementary as navigational landmarks.
  ///
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#complementary>
  static const String complementary = "complementary";

  /// A large perceivable region that contains information about the parent document.
  ///
  /// Examples of information included in this region of the page are copyrights and links to privacy
  /// statements.
  ///
  /// User agents SHOULD treat elements with the role of contentinfo as navigational landmarks.
  ///
  /// Within any document or application, the author SHOULD mark no more than one element with the
  /// contentinfo role.
  ///
  /// Note: Because document and application elements can be nested in the DOM, they may have multiple
  /// contentinfo elements as DOM descendants, assuming each of those is associated with different
  /// document nodes, either by a DOM nesting (e.g., document within document) or by use of the aria-owns
  /// attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#contentinfo>
  static const String contentinfo = "contentinfo";

  /// A definition of a term or concept.
  ///
  /// The WAI-ARIA specification does not provide a role to specify the definition term, but host
  /// languages may provide such an element. If a host language has an appropriate element for the
  /// term (e.g., dfn or dt in HTML), authors SHOULD include the term in that element. Authors SHOULD
  /// identify the definition term by using an aria-labelledby attribute on each element with a role
  /// of definition.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#definition>
  static const String definition = "definition";

  /// A dialog is an application window that is designed to interrupt the current processing of an
  /// application in order to prompt the user to enter information or require a response. See related
  /// alertdialog.
  ///
  /// Authors SHOULD provide a dialog label. Labels may be provided with the aria-label or aria-labelledby
  /// attribute if other mechanisms are not available. Authors SHOULD ensure each active dialog has
  /// a focused descendant element that has keyboard focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#dialog>
  static const String dialog = "dialog";

  /// A list of references to members of a group, such as a static table of contents.
  ///
  /// Authors SHOULD use this role for a static table of contents, whether linked or unlinked. This
  /// includes tables of contents built with lists, including nested lists. Dynamic tables of contents,
  /// however, might use a tree role instead.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#directory>
  static const String directory = "directory";

  /// A region containing related information that is declared as document content, as opposed to
  /// a web application.
  ///
  /// When the user navigates an element assigned the role of document, assistive technologies that
  /// typically intercept standard keyboard events SHOULD switch to document browsing mode, as opposed
  /// to passing keyboard events through to the web application. The document role informs user agents
  /// of the need to augment browser keyboard support in order to allow users to visit and read any
  /// content within the document region. In contrast, additional commands are not necessary for
  /// screen reader users to read text within a region with the application role, where if coded
  /// in an accessible manner, all text will be semantically associated with focusable elements.
  /// An important trait of documents is that they have text which is not associated with widgets
  /// or groups thereof.
  ///
  /// Authors SHOULD set the role of document on the element that encompasses the entire document.
  /// If the document role applies to the entire web page, authors SHOULD set the role of document
  /// on the root node for content, such as the body element in HTML or svg element in SVG.
  ///
  /// For example, an email application has a document and an application in it. The author would
  /// want to use typical application navigation mode to cycle through the list of emails, and much
  /// of this navigation would be defined by the application author. However, when reading an email
  /// message, the content will appear in a region with a document role in order to use browsing
  /// navigation.
  ///
  /// Authors SHOULD provide a title or label for documents. Authors SHOULD use label text that suitable
  /// for use as a navigation preview or table-of-contents entry for the page section. Content authors
  /// SHOULD provide the label through one of the following methods:
  ///
  /// If the document includes the entire contents of the web page, use the host language feature
  /// for title or label, such as the title element in both HTML and SVG. This has the effect of
  /// labeling the entire document.Otherwise, provide a visible label referenced by the document
  /// using aria-labelledby.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#document>
  static const String document = "document";

  /// A landmark region that contains a collection of items and objects that, as a whole, combine
  /// to create a form. See related search.
  ///
  /// A form may be a mix of host language form controls, scripted controls, and hyperlinks. Authors
  /// are reminded to use native host language semantics to create form controls, whenever possible.
  /// For search facilities, authors SHOULD use the search role and not the generic form role. Authors
  /// SHOULD provide a visible label for the form referenced with aria-labelledby. If an author uses
  /// a script to submit a form based on a user action that would otherwise not trigger an onsubmit
  /// event (for example, a form submission triggered by the user changing a form element's value),
  /// the author SHOULD provide the user with advance notification of the behavior. Authors are
  /// reminded to use native host language semantics to create form controls, whenever possible.
  ///
  /// User agents SHOULD treat elements with the role of form as navigational landmarks.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#form>
  static const String form = "form";

  /// A grid is an interactive control which contains cells of tabular data arranged in rows and
  /// columns, like a table.
  ///
  /// Grids do not necessarily imply presentation. The grid construct describes relationships between
  /// data such that it may be used for different presentations. Grids allow the user to move focus
  /// between cells using two dimensional navigation. For example, grid might be used as the invisible
  /// data model (hidden with CSS but still operable by assistive technologies) for a presentational
  /// chart.
  ///
  /// Authors MUST ensure that elements with role gridcell are owned by elements with role row, which
  /// in turn are owned by an element with role rowgroup, grid or treegrid. If the author applies
  /// any non-global WAI-ARIA states or properties to a native markup element that is acting as a
  /// row (such as the tr element in HTML), the author MUST also apply the role of row, as stated
  /// in the section on Implementation in Host Languages. Authors MAY make cells focusable. Authors
  /// MAY provide row and column headers for grids, by using rowheader and columnheader roles.
  ///
  /// Since WAI-ARIA can augment an element in the host language, grids can reuse existing functionality
  /// of native table grids. When WAI-ARIA grid or gridcell roles overlay host language table elements
  /// they reuse the host language semantics for that table. For instance, WAI-ARIA does not specify
  /// general attributes for gridcell elements that span multiple rows or columns. When the author
  /// needs a gridcell to span multiple rows or columns, use the host language markup, such as the
  /// colspan and rowspan attributes in HTML.
  ///
  /// Authors MAY determine the contents of a gridcell through calculation of a mathematical formula.
  /// Authors MAY make a cell's formula editable by the user. In a spreadsheet application for example,
  /// the text alternative of a cell may be the calculated value of a formula. However, when the
  /// cell is being edited, the text alternative may be the formula itself.
  ///
  /// gridcell elements with the aria-selected attribute set can be selected for user interaction,
  /// and if the aria-multiselectable attribute of the grid is set to true, multiple cells in the
  /// grid may be selected. Grids may be used for spreadsheets like those in desktop spreadsheet
  /// applications.
  ///
  /// A grid is considered editable unless otherwise specified. To make a grid read-only, set the
  /// aria-readonly attribute of the grid to true. The value of the grid element's aria-readonly
  /// attribute is implicitly propagated to all of its owned gridcell elements, and will be exposed
  /// through the accessibility API. An author may override an individual gridcell element's propagated
  /// aria-readonly value by setting the aria-readonly attribute on the gridcell.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#grid>
  static const String grid = "grid";

  /// A cell in a grid or treegrid.
  ///
  /// Cells may be active, editable, and selectable. Cells may have relationships such as aria-controls
  /// to address the application of functional relationships.
  ///
  /// If relevant headers cannot be determined from the DOM structure, authors SHOULD explicitly
  /// indicate which header cells are relevant to the cell by referencing elements with role rowheader
  /// or columnheader using the aria-describedby attribute.
  ///
  /// In a treegrid, authors MAY define cells as expandable by using the aria-expanded attribute.
  /// If the aria-expanded attribute is provided, it applies only to the individual cell. It is not
  /// a proxy for the container row, which also can be expanded. The main use case for providing
  /// this attribute on a cell is pivot table behavior.
  ///
  /// Authors MUST ensure elements with role gridcell are contained in, or owned by, an element with
  /// the role row.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#gridcell>
  static const String gridcell = "gridcell";

  /// A set of user interface objects which are not intended to be included in a page summary or
  /// table of contents by assistive technologies.
  ///
  /// Contrast with region which is a grouping of user interface objects that will be included in
  /// a page summary or table of contents.
  ///
  /// Authors SHOULD use a group to form logical collection of items in a widget such as children
  /// in a tree widget forming a collection of siblings in a hierarchy, or a collection of items
  /// having the same container in a directory. However, when a group is used in the context of list,
  /// authors MUST limit its children to listitem elements. Therefore, proper handling of group by
  /// authors and assistive technologies is determined by the context in which it is provided.
  ///
  /// Authors MAY nest group elements. If a section is significant enough to warrant inclusion in
  /// the web page's table of contents, the author SHOULD assign the section a role of region or
  /// a standard landmark role.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#group>
  static const String group = "group";

  /// A heading for a section of the page.
  ///
  /// Often, heading elements will be referenced with the aria-labelledby attribute of the section
  /// for which they serve as a heading. If headings are organized into a logical outline, the aria-level
  /// attribute can be used to indicate the nesting level.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#heading>
  static const String heading = "heading";

  /// A container for a collection of elements that form an image.
  ///
  /// An img can contain captions and descriptive text, as well as multiple image files that when
  /// viewed together give the impression of a single image. An img represents a single graphic within
  /// a document, whether or not it is formed by a collection of drawing objects. In order for elements
  /// with a role of img be perceivable, authors MUST provide alternative text or a label determined
  /// by the accessible name calculation.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#img>
  static const String img = "img";

  /// A generic type of widget that allows user input.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#input>
  static const String input = "input";

  /// An interactive reference to an internal or external resource that, when activated, causes the
  /// user agent to navigate to that resource. See related button.
  ///
  /// If this is a native link in the host language (such as an HTML anchor with an href value),
  /// activating the link causes the user agent to navigate to that resource. If this is a simulated
  /// link, the web application author is responsible for managing navigation.
  ///
  /// Note: If pressing the link triggers an action but does not change browser focus or page location,
  /// authors are advised to consider using the button role instead of the link role.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#link>
  static const String link = "link";

  /// A group of non-interactive list items. See related listbox.
  ///
  /// Lists contain children whose role is listitem, or elements whose role is group which in turn
  /// contains children whose role is listitem.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#list>
  static const String list = "list";

  /// A widget that allows the user to select one or more items from a list of choices. See related
  /// combobox and list.
  ///
  /// Items within the list are static and, unlike standard HTML select elements, may contain images.
  /// List boxes contain children whose role is option.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#listbox>
  static const String listbox = "listbox";

  /// A single item in a list or directory.
  ///
  /// Authors MUST ensure elements with role listitem are contained in, or owned by, an element with
  /// the role list or group.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#listitem>
  static const String listitem = "listitem";

  /// A type of live region where new information is added in meaningful order and old information
  /// may disappear. See related marquee.
  ///
  /// Examples include chat logs, messaging history, game log, or an error log. In contrast to other
  /// live regions, in this role there is a relationship between the arrival of new items in the
  /// log and the reading order. The log contains a meaningful sequence and new information is added
  /// only to the end of the log, not at arbitrary points.
  ///
  /// Note: Elements with the role log have an implicit aria-live value of polite.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#log>
  static const String log = "log";

  /// The main content of a document.
  ///
  /// This marks the content that is directly related to or expands upon the central topic of the
  /// document. The main role is a non-obtrusive alternative for "skip to main content" links, where
  /// the navigation option to go to the main content (or other landmarks) is provided by the user
  /// agent through a dialog or by assistive technologies.
  ///
  /// User agents SHOULD treat elements with the role of main as navigational landmarks.
  ///
  /// Within any document or application, the author SHOULD mark no more than one element with the
  /// main role.
  ///
  /// Note: Because document and application elements can be nested in the DOM, they may have multiple
  /// main elements as DOM descendants, assuming each of those is associated with different document
  /// nodes, either by a DOM nesting (e.g., document within document) or by use of the aria-owns
  /// attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#main>
  static const String main = "main";

  /// A type of live region where non-essential information changes frequently. See related log.
  ///
  /// Common usages of marquee include stock tickers and ad banners. The primary difference between
  /// a marquee and a log is that logs usually have a meaningful order or sequence of important content
  /// changes.
  ///
  /// Note: Elements with the role marquee maintain the default aria-live value of off.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#marquee>
  static const String marquee = "marquee";

  /// Content that represents a mathematical expression.
  ///
  /// Content with the role math is intended to be marked up in an accessible format such as MathML
  /// [MATHML], or with another type of textual representation such as TeX or LaTeX, which can be
  /// readily converted to an accessible format by assistive technologies.
  ///
  /// This role provides a hook whereby a plug-in mechanism can provide multi-modal access to compliant
  /// MathML, as well as enabling support for MathML in "mainstream" user agents.
  ///
  /// While it is inappropriate to use an image of a mathematical expression in the math role, there
  /// exists a significant amount of legacy content where images are used to represent mathematical
  /// expressions. For purposes of repair, if an image has been used to represent a mathematical
  /// expression, the text equivalent defined for that image SHOULD be valid MathML or TeX. Such
  /// images SHOULD also be labeled by text that describes the mathematical expression as it might
  /// be spoken, using the  aria-describedby attribute.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#math>
  static const String math = "math";

  /// A type of widget that offers a list of choices to the user.
  ///
  /// A menu is often a list of common actions or functions that the user can invoke. The menu role
  /// is appropriate when a list of menu items is presented in a manner similar to a menu on a desktop
  /// application.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#menu>
  static const String menu = "menu";

  /// A presentation of menu that usually remains visible and is usually presented horizontally.
  ///
  /// The menubar role is used to create a menu bar similar to those found in Windows, Mac, and Gnome
  /// desktop applications. A menu bar is used to create a consistent set of frequently used commands.
  /// Authors SHOULD ensure that menubar interaction is similar to the typical menu bar interaction
  /// in a desktop graphical user interface.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#menubar>
  static const String menubar = "menubar";

  /// An option in a set of choices contained by a menu or menubar.
  ///
  /// Authors MAY disable a menu item with the aria-disabled attribute. If the menu item has its
  /// aria-haspopup attribute set to true, it indicates that the menu item may be used to launch
  /// a sub-level menu, and authors SHOULD display a new sub-level menu when the menu item is activated.
  ///
  /// Authors MUST ensure that menu items are owned by an element with role menu or menubar in order
  /// to identify that they are related widgets. Authors MAY separate menu items into sets by use
  /// of a separator or an element with an equivalent role from the native markup language.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#menuitem>
  static const String menuitem = "menuitem";

  /// A menuitem with a checkable state whose possible values are true, false, or mixed.
  ///
  /// The aria-checked attribute of a menuitemcheckbox indicates whether the menu item is checked
  /// (true), unchecked (false), or represents a sub-level menu of other menu items that have a mixture
  /// of checked and unchecked values (mixed).
  ///
  /// Authors MUST ensure that menu item checkboxes are owned by an element with role menu or menubar
  /// in order to identify that they are related widgets. Authors MAY separate menu items into sets
  /// by use of a separator or an element with an equivalent role from the native markup language.
  ///
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#menuitemcheckbox>
  static const String menuitemcheckbox = "menuitemcheckbox";

  /// A checkable menuitem in a set of elements with role menuitemradio, only one of which can be
  /// checked at a time.
  ///
  /// Authors SHOULD enforce that only one menuitemradio in a group can be checked at the same time.
  /// When one item in the group is checked, the previously checked item becomes unchecked (its
  /// aria-checked attribute becomes false).
  ///
  /// Authors MUST ensure that menu item radios are owned by an element with role group, menu, or
  /// menubar in order to identify that they are related widgets. Authors MAY separate menu items
  /// into sets by use of a separator or an element with an equivalent role from the native markup
  /// language.
  ///
  /// If a menu or menubar contains more than one group of menuitemradio elements, or if the menu
  /// contains one group and other, unrelated menu items, authors SHOULD nest each set of related
  /// menuitemradio elements in an element using the group role, and authors SHOULD delimit the group
  /// from other menu items with an element using the separator role.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#menuitemradio>
  static const String menuitemradio = "menuitemradio";

  /// A collection of navigational elements (usually links) for navigating the document or related
  /// documents.
  ///
  /// User agents SHOULD treat elements with the role of navigation as navigational landmarks.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#navigation>
  static const String navigation = "navigation";

  /// A section whose content is parenthetic or ancillary to the main content of the resource.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#note>
  static const String note = "note";

  /// A selectable item in a select list.
  ///
  /// Authors MUST ensure elements with role option are contained in, or owned by, an element with
  /// the role listbox. Options not associated with a listbox might not be correctly mapped to an
  /// accessibility API.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#option>
  static const String option = "option";

  /// An element whose implicit native role semantics will not be mapped to the accessibility API.
  ///
  /// The intended use is when an element is used to change the look of the page but does not have
  /// all the functional, interactive, or structural relevance implied by the element type, or may
  /// be used to provide for an accessible fallback in older browsers that do not support WAI-ARIA.
  ///
  /// Example use cases:
  ///
  /// An element whose content is completely presentational (like a spacer image, decorative graphic,
  /// or clearing element); An image that is in a container with the img role and where the full
  /// text
  /// alternative is available and is marked up with aria-labelledby and (if needed) aria-describedby;An
  /// element used as an additional markup "hook" for CSS; orA layout table and/or any of its associated
  /// rows, cells, etc.
  /// For any element with a role of presentation and which is not focusable, the user agent MUST
  /// NOT expose the implicit native semantics of the element (the role and its states and properties)
  /// to accessibility APIs. However, the user agent MUST expose content and descendant elements
  /// that do not have an explicit or inherited role of presentation. Thus, the presentation role
  /// causes a given element to be treated as having no role or to be removed from the accessibility
  /// tree, but does not cause the content contained within the element to be removed from the accessibility tree.
  ///
  /// The presentation role is used on an element that has implicit native semantics, meaning that
  /// there is a default accessibility API role for the element. Some elements are only complete
  /// when additional descendant elements are provided. For example, in HTML, table elements (matching
  /// the grid role) require tr descendants (the row role), which in turn require th or td children
  /// (the gridcell, columnheader, rowheader roles). Similarly, lists require list item children.
  /// The descendant elements that complete the semantics of an element are described in WAI-ARIA as
  /// required owned elements.
  ///
  /// When an explicit or inherited role of presentation is applied to an element with the implicit
  /// semantic of a WAI-ARIA role that has required owned elements, in addition to the element with
  /// the explicit role of presentation, the user agent MUST apply an inherited role of presentation
  /// to any owned elements that do not have an explicit role defined. Also, when an explicit or
  /// inherited role of presentation is applied to a host language element which has required children
  /// as defined by the host language specification, in addition to the element with the explicit role
  /// of presentation, the user agent MUST apply an inherited role of presentation to any required
  /// children that do not have an explicit role defined. For any element with an explicit or inherited
  /// role of presentation and which is not focusable, user agents MUST ignore role-specific WAI-ARIA states
  /// and properties for that element. For example, in HTML, a ul or ol element with a role of presentation
  /// will have the implicit native semantics of its li elements removed because the list role to which
  /// the ul or ol corresponds has a required owned element of listitem. Likewise, although an HTML table
  /// element does not have an implicit native semantic role corresponding directly to a WAI-ARIA role,
  /// the implicit native semantics of its thead/tbody/tfoot/tr/th/td descendants will also be removed,
  /// because the HTML specification indicates that these are required structural descendants of the
  /// table element. Explicit roles on a descendant or owned element override the inherited role of
  /// presentation, and cause the owned element to behave as any other element with an explicit role.
  /// If the action of exposing the implicit role causes the accessibility tree to be malformed, the
  /// expected results are undefined and the user agent MAY resort to an internal recovery mechanism
  /// to repair the accessibility tree.
  ///
  /// Note: Only the implicit native semantics of elements that correspond to WAI-ARIA required owned
  /// elements are removed. All other content remains intact, including nested tables or lists, unless
  /// those elements also have a explicit role of presentation applied.
  ///
  /// For any element with an explicit or inherited role of presentation, user agents MUST apply
  /// an inherited role of presentation to all host-language-specific labeling elements for the presentational
  /// element. For example, a table element with a role of presentation will have the implicit native
  /// semantics of its caption element removed, because the caption is merely a label for the presentational
  /// table.
  ///
  /// For any element with an explicit or inherited role of presentation, user agents MUST ignore
  /// any non-global, role-specific WAI-ARIA states and properties. However, the user agent MUST
  /// always expose global WAI-ARIA states and properties to accessibility APIs, even if an element
  /// has an explicit or inherited role of presentation.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#presentation>
  static const String presentation = "presentation";

  /// An element that displays the progress status for tasks that take a long time.
  ///
  /// A progressbar indicates that the user's request has been received and the application is making
  /// progress toward completing the requested action. The author SHOULD supply values for aria-valuenow,
  /// aria-valuemin, and aria-valuemax, unless the value is indeterminate, in which case the author
  /// SHOULD omit the aria-valuenow attribute. Authors SHOULD update these values when the visual
  /// progress indicator is updated. If the progressbar is describing the loading progress of a particular
  /// region of a page, the author SHOULD use aria-describedby to point to the status, and set the aria-busy
  /// attribute to true on the region until it is finished loading. It is not possible for the user to alter
  /// the value of a progressbar because it is always readonly.
  ///
  /// Note: Assistive technologies generally will render the value of aria-valuenow as a percent
  /// of the range between the value of aria-valuemin and aria-valuemax, unless aria-valuetext is
  /// specified. It is best to set the values for aria-valuemin, aria-valuemax, and aria-valuenow
  /// in a manner that is appropriate for this calculation.
  ///
  /// Note: Elements with the role progressbar have an implicit aria-readonly value of true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#progressbar>
  static const String progressbar = "progressbar";

  /// A checkable input in a group of radio roles, only one of which can be checked at a time.
  ///
  /// Authors SHOULD ensure that elements with role radio are explicitly grouped in order to indicate
  /// which ones affect the same value. This is achieved by enclosing the radio elements in an element
  /// with role radiogroup. If it is not possible to make the radio buttons DOM children of the radiogroup,
  /// authors SHOULD use the aria-owns attribute on the radiogroup element to indicate the relationship
  /// to its children.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#radio>
  static const String radio = "radio";

  /// A group of radio buttons.
  ///
  /// A radiogroup is a type of select list that can only have a single entry checked at any one
  /// time. Authors SHOULD enforce that only one radio button in a group can be checked at the same
  /// time. When one item in the group is checked, the previously checked item becomes unchecked
  /// (its aria-checked attribute becomes false).
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#radiogroup>
  static const String radiogroup = "radiogroup";

  /// A large perceivable section of a web page or document, that is important enough to be included
  /// in a page summary or table of contents, for example, an area of the page containing live sporting
  /// event statistics.
  ///
  /// The 'page summary' referenced above is a structure created dynamically from the page after
  /// it is loaded as a means of quickly describing its overall organization. It may be created by
  /// the author using a script, or by assistive technologies.
  ///
  /// Authors SHOULD ensure that a region has a heading referenced by aria-labelledby. This heading
  /// is provided by an instance of the standard host language heading element or an instance of
  /// an element with role heading that contains the heading text.
  ///
  /// When defining regions of a web page, authors are advised to consider using standard document
  /// landmark roles. If the definitions of these regions are inadequate, authors can use the region
  /// role and provide the appropriate accessible name.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#region>
  static const String region = "region";

  /// A row of cells in a grid.
  ///
  /// Rows contain gridcell elements, and thus serve to organize the grid.
  ///
  /// In a treegrid, authors MAY mark rows as expandable, using the aria-expanded attribute to indicate
  /// the present status. This is not the case for an ordinary grid, in which the aria-expanded attribute
  /// is not present.
  ///
  /// Authors MUST ensure elements with role row are contained in, or owned by, an element with the
  /// role grid, rowgroup, treegrid.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#row>
  static const String row = "row";

  /// A group containing one or more row elements in a grid.
  ///
  /// The rowgroup role establishes a relationship between owned row elements. It is a structural
  /// equivalent to the thead, tfoot, and tbody elements in an HTML table element.
  ///
  /// Authors MUST ensure elements with role rowgroup are contained in, or owned by, an element with
  /// the role grid.
  ///
  /// Note: The rowgroup role exists, in part, to support role symmetry in HTML, and allows for the
  /// propagation of presentation inheritance on HTML table elements with an explicit presentation
  /// role applied.
  ///
  /// Note: This role does not differentiate between types of row groups (e.g., thead vs. tbody),
  /// but an issue has been raised for WAI-ARIA 2.0.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#rowgroup>
  static const String rowgroup = "rowgroup";

  /// A cell containing header information for a row in a grid.
  ///
  /// Rowheader can be used as a row header in a table or grid. The rowheader establishes a relationship
  /// between it and all cells in the corresponding row. It is a structural equivalent to setting
  /// scope="row" on an HTML th element.
  ///
  /// Authors MUST ensure elements with role rowheader are contained in, or owned by, an element
  /// with the role row.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#rowheader>
  static const String rowheader = "rowheader";

  /// A landmark region that contains a collection of items and objects that, as a whole, combine
  /// to create a search facility. See related form.
  ///
  /// A search region may be a mix of host language form controls, scripted controls, and hyperlinks.
  ///
  /// User agents SHOULD treat elements with the role of search as navigational landmarks.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#search>
  static const String search = "search";

  /// A divider that separates and distinguishes sections of content or groups of menuitems.
  ///
  /// This is a visual separator between sections of content. For example, separators are found between
  /// groups of menu items in a menu or as the moveable separator between two regions in a split
  /// pane.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#separator>
  static const String separator = "separator";

  /// A graphical object that controls the scrolling of content within a viewing area, regardless
  /// of whether the content is fully displayed within the viewing area.
  ///
  /// A scrollbar represents the current value and range of possible values via the size of the scrollbar
  /// and position of the thumb with respect to the visible range of the orientation (horizontal
  /// or vertical) it controls. Its orientation represents the orientation of the scrollbar and the
  /// scrolling effect on the viewing area controlled by the scrollbar. It is typically possible
  /// to add or subtract to the current value by using directional keys such as arrow keys.
  ///
  /// Authors MUST set the aria-controls attribute on the scrollbar element to reference the scrollable
  /// area it controls.
  ///
  /// Note: Elements with the role scrollbar have an implicit aria-orientation value of vertical.
  ///
  /// Note: Assistive technologies generally will render the value of aria-valuenow as a percent
  /// of the range between the value of aria-valuemin and aria-valuemax, unless aria-valuetext is
  /// specified. It is best to set the values for aria-valuemin, aria-valuemax, and aria-valuenow
  /// in a manner that is appropriate for this calculation.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#scrollbar>
  static const String scrollbar = "scrollbar";

  /// A user input where the user selects a value from within a given range.
  ///
  /// A slider represents the current value and range of possible values via the size of the slider
  /// and position of the thumb. It is typically possible to add or subtract to the value by using
  /// directional keys such as arrow keys.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#slider>
  static const String slider = "slider";

  /// A form of range that expects the user to select from among discrete choices.
  ///
  /// A spinbutton typically allows the user to select from the given range through the use of an
  /// up and down button on the keyboard. Visibly, the current value is incremented or decremented
  /// until a maximum or minimum value is reached. Authors SHOULD ensure this functionality is accomplished
  /// programmatically through the use of up and down arrows on the keyboard.
  ///
  /// Although a spinbutton is similar in appearance to many presentations of select, it is advisable
  /// to use spinbutton when working with known ranges (especially in the case of large ranges) as
  /// opposed to distinct options. For example, a spinbutton representing a range from 1 to 1,000,000
  /// would provide much better performance than a select widget representing the same values.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#spinbutton>
  static const String spinbutton = "spinbutton";

  /// A container whose content is advisory information for the user but is not important enough
  /// to justify an alert, often but not necessarily presented as a status bar. See related alert.
  ///
  /// Authors MUST provide status information content within an element with role status. Authors
  /// SHOULD ensure this object does not receive focus.
  ///
  /// Status is a form of live region. If another part of the page controls what appears in the status,
  /// authors SHOULD make the relationship explicit with the aria-controls attribute.
  ///
  /// Assistive technologies MAY reserve some cells of a Braille display to render the status.
  ///
  /// Note: Elements with the role status have an implicit aria-live value of polite, and an implicit
  /// aria-atomic value of true.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#status>
  static const String status = "status";

  /// A grouping label providing a mechanism for selecting the tab content that is to be rendered
  /// to the user.
  ///
  /// If a tabpanel or item in a tabpanel has focus, the associated tab is the currently active tab
  /// in the tablist, as defined in Managing Focus. tablist elements, which contain a set of associated
  /// tab elements, are typically placed near a series of tabpanel elements, usually preceding it.
  /// See the WAI-ARIA Authoring Practices Guide [ARIA-PRACTICES] for details on implementing a tab
  /// set design pattern.
  ///
  /// Authors MUST ensure elements with role tab are contained in, or owned by, an element with the
  /// role tablist.
  ///
  /// Authors SHOULD ensure the tabpanel associated with the currently active tab is perceivable
  /// to the user.
  ///
  /// For a single-selectable tablist, authors SHOULD hide other tabpanel elements from the user
  /// until the user selects the tab associated with that tabpanel. For a multi-selectable tablist,
  /// authors SHOULD ensure each visible tabpanel has its aria-expanded attribute set to true, and
  /// that the remaining hidden tabpanel elements have their aria-expanded attributes set to false.
  ///
  /// In either case, authors SHOULD ensure that a selected tab has its aria-selected attribute set
  /// to true, that inactive tab elements have their aria-selected attribute set to false, and that
  /// the currently selected tab provides a visual indication that it is selected. In the absence
  /// of an aria-selected attribute on the current tab, user agents SHOULD indicate to assistive
  /// technologies through the platform accessibility API that the currently focused tab is selected.
  ///
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#tab>
  static const String tab = "tab";

  /// A list of tab elements, which are references to tabpanel elements.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// For a single-selectable tablist, authors SHOULD hide other tabpanel elements from the user
  /// until the user selects the tab associated with that tabpanel. For a multi-selectable tablist,
  /// authors SHOULD ensure each visible tabpanel has its aria-expanded attribute set to true, and
  /// that the remaining hidden tabpanel elements have their aria-expanded attributes set to false.
  ///
  /// tablist elements are typically placed near, usually preceding, a series of tabpanel elements.
  /// See the WAI-ARIA Authoring Practices Guide [ARIA-PRACTICES] for details on implementing a tab
  /// set design pattern.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#tablist>
  static const String tablist = "tablist";

  /// A container for the resources associated with a tab, where each tab is contained in a tablist.
  ///
  /// Authors SHOULD associate a tabpanel element with its tab, either by using the aria-controls
  /// attribute on the tab to reference the tab panel, or by using the aria-labelledby attribute
  /// on the tab panel to reference the tab.
  ///
  /// tablist elements are typically placed near, usually preceding, a series of tabpanel elements.
  /// See the WAI-ARIA Authoring Practices Guide [ARIA-PRACTICES] for details on implementing a tab
  /// set design pattern.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#tabpanel>
  static const String tabpanel = "tabpanel";

  /// Input that allows free-form text as its value.
  ///
  /// If the aria-multiline attribute is true, the widget accepts line breaks within the input, as
  /// in an HTML textarea. Otherwise, this is a simple text box. The intended use is for languages
  /// that do not have a text input element, or cases in which an element with different semantics
  /// is repurposed as a text field.
  ///
  /// Note: In most user agent implementations, the default behavior of the ENTER or RETURN key is
  /// different between the single-line and multi-line text fields in HTML. When user has focus in
  /// a single-line &lt;input type="text"&gt; element, the keystroke usually submits the form. When
  /// user has focus in a multi-line &lt;textarea&gt; element, the keystroke inserts a line break.
  /// The WAI-ARIA textbox role differentiates these types of boxes with the aria-multiline attribute,
  /// so authors are advised to be aware of this distinction when designing the field.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#textbox>
  static const String textbox = "textbox";

  /// A type of live region containing a numerical counter which indicates an amount of elapsed time
  /// from a start point, or the time remaining until an end point.
  ///
  /// The text contents of the timer object indicate the current time measurement, and are updated
  /// as that amount changes. The timer value is not necessarily machine parsable, but authors SHOULD
  /// update the text contents at fixed intervals, except when the timer is paused or reaches an
  /// end-point.
  ///
  /// Note: Elements with the role timer maintain the default aria-live value of off.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#timer>
  static const String timer = "timer";

  /// A collection of commonly used function buttons or controls represented in compact visual form.
  ///
  /// The toolbar is often a subset of functions found in a menubar, designed to reduce user effort
  /// in using these functions. Authors MUST supply an aria-label property on each toolbar when the
  /// application contains more than one toolbar.
  ///
  /// Authors MAY manage focus of descendants for all instances of this role, as described in Managing
  /// Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#toolbar>
  static const String toolbar = "toolbar";

  /// A contextual popup that displays a description for an element.
  ///
  /// The tooltip typically becomes visible in response to a mouse hover, or after the owning element
  /// receives keyboard focus. In each of these cases, authors SHOULD display the tooltip after a
  /// short delay. The use of a WAI-ARIA tooltip is a supplement to the normal tooltip behavior of
  /// the user agent.
  ///
  /// Note: Typical tooltip delays last from one to five seconds.
  ///
  /// Authors SHOULD ensure that elements with the role tooltip are referenced through the use of
  /// aria-describedby by the time the tooltip is displayed.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#tooltip>
  static const String tooltip = "tooltip";

  /// A type of list that may contain sub-level nested groups that can be collapsed and expanded.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#tree>
  static const String tree = "tree";

  /// A grid whose rows can be expanded and collapsed in the same manner as for a tree.
  ///
  /// A treegrid is considered editable unless otherwise specified. To make a treegrid read-only,
  /// set the aria-readonly attribute of the treegrid to true. The value of the treegrid element's
  /// aria-readonly attribute is implicitly propagated to all of its owned gridcell elements, and
  /// will be exposed through the accessibility API. An author may override an individual gridcell
  /// element's propagated aria-readonly value by setting the aria-readonly attribute on the gridcell.
  ///
  /// To be keyboard accessible, authors SHOULD manage focus of descendants for all instances of
  /// this role, as described in Managing Focus.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#treegrid>
  static const String treegrid = "treegrid";

  /// An option item of a tree. This is an element within a tree that may be expanded or collapsed
  /// if it contains a sub-level group of treeitem elements.
  ///
  /// A collection of treeitem elements to be expanded and collapsed are enclosed in an element with
  /// the group role.
  ///
  /// Authors MUST ensure elements with role treeitem are contained in, or owned by, an element with
  /// the role group or tree.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/roles#treeitem>
  static const String treeitem = "treeitem";
}

/// A MapView with the typed getters/setters for all aria props.
class AriaPropsMapView extends MapView with AriaPropsMixin {
  /// Create a new instance backed by the specified map.
  AriaPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}

/// Returns a new [AriaPropsMapView], optionally backed by a specified Map.
///
/// Convenient for adding aria props inline to DOM and non-DOM components:
/// <pre>
/// <!>  ..addProps(ariaProps()..disabled = true)
/// <!>  ..addProps(ariaProps()
/// <!>    ..expanded = false
/// <!>    ..labelledby = 'label-btn'
/// <!>  )
/// </pre>
/// <!-- use pre tags and HTML markup until WebStorm fully supports Dart doc comment markdown -->
AriaPropsMapView ariaProps([Map backingMap]) => new AriaPropsMapView(backingMap == null ? {} : backingMap);
