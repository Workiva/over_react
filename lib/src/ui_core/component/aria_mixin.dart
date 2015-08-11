part of w_ui_platform.ui_core;

/// Typed getters/setters for accessibility props.
/// To be used as a mixin for React components and builders.
@GenerateProps(#AriaProps,
  keyType: TypedMapKeyType.STRING
)
abstract class _$template_AriaProps {
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
  @Prop('aria-activedescendant') String get activedescendant;

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
  @Prop('aria-atomic') bool get atomic;

  /// Indicates whether user input completion suggestions are provided.
  ///
  /// For a textbox with the aria-autocomplete attribute set to either inline or both, authors SHOULD
  /// ensure that any auto-completed text is selected, so the user can type over it.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-autocomplete>
  @Prop('aria-autocomplete') dynamic get autocomplete;

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
  @Prop('aria-busy') bool get busy;

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
  @Prop('aria-checked') dynamic get checked;

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
  @Prop('aria-controls') List get controls;

  /// Identifies the element (or elements) that describes the object. See related aria-labelledby.

  ///  ///
  /// The aria-labelledby attribute is similar to aria-describedby in that both reference other
  /// elements to calculate a text alternative, but a label should be concise, where a description
  /// is intended to provide more verbose information.
  ///
  /// The element or elements referenced by the aria-describedby comprise the entire description.
  /// Include ID references to multiple elements if necessary, or enclose a set of elements (e.g.,
  /// paragraphs) with the element referenced by the ID.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-describedby>
  @Prop('aria-describedby') List get describedby;

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
  @Prop('aria-disabled') bool get disabled;

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
  @Prop('aria-dropeffect') List get dropeffect;

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
  @Prop('aria-expanded') dynamic get expanded;

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
  @Prop('aria-flowto') List get flowto;

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
  @Prop('aria-grabbed') dynamic get grabbed;

  /// Indicates that the element has a popup context menu or sub-level menu.
  ///
  /// This means that activation renders conditional content. Note that ordinary tooltips are not
  /// considered popups in this context.
  ///
  /// A popup is generally presented visually as a group of items that appears to be on top of the
  /// main page content.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-haspopup>
  @Prop('aria-haspopup') bool get haspopup;

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
  @Prop('aria-hidden') bool get hidden;

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
  @Prop('aria-invalid') dynamic get invalid;

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
  @Prop('aria-label') String get label;

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
  @Prop('aria-labelledby') List get labelledby;

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
  @Prop('aria-level') int get level;

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
  @Prop('aria-live') dynamic get live;

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
  @Prop('aria-multiline') bool get multiline;

  /// Indicates that the user may select more than one item from the current selectable descendants.

  ///  ///
  /// Authors SHOULD ensure that selected descendants have the aria-selected attribute set to true,
  /// and selectable descendant have the aria-selected attribute set to false. Authors SHOULD NOT
  /// use the aria-selected attribute on descendants that are not selectable.
  ///
  /// Note: Lists and trees are examples of roles that might allow users to select more than one
  /// item at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-multiselectable>
  @Prop('aria-multiselectable') bool get multiselectable;

  /// Indicates whether the element and orientation is horizontal or vertical.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-orientation>
  @Prop('aria-orientation') dynamic get orientation;

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
  @Prop('aria-owns') List get owns;

  /// Defines an element's number or position in the current set of listitems or treeitems. Not
  /// required if all elements in the set are present in the DOM. See related aria-setsize.
  ///
  /// If all items in a set are present in the document structure, it is not necessary to set this
  /// attribute, as the user agent can automatically calculate the set size and position for each
  /// item. However, if only a portion of the set is present in the document structure at a given
  /// moment, this property is needed to provide an explicit indication of an element's position.
  ///
  /// The following example shows items 5 through 8 in a set of 16.
  ///
  /// &lt;h2 id="label_fruit"&gt; Available Fruit &lt;/h2&gt;
  ///
  /// &lt;ul role="listbox" aria-labelledby="label_fruit"&gt;
  ///
  /// &lt;li role="option" aria-setsize="16" aria-posinset="5"&gt; apples &lt;/li&gt;
  ///
  /// &lt;li role="option" aria-setsize="16" aria-posinset="6"&gt; bananas &lt;/li&gt;
  ///
  /// &lt;li role="option" aria-setsize="16" aria-posinset="7"&gt; cantaloupes &lt;/li&gt;
  ///
  /// &lt;li role="option" aria-setsize="16" aria-posinset="8"&gt; dates &lt;/li&gt;
  ///
  /// &lt;/ul&gt;
  ///
  /// Authors MUST set the value for aria-posinset to an integer greater than or equal to 1, and
  /// less than or equal to the size of the set. Authors SHOULD use aria-posinset in conjunction
  /// with aria-setsize.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-posinset>
  @Prop('aria-posinset') int get posinset;

  /// Indicates the current "pressed" state of toggle buttons. See related aria-checked and aria-selected.

  ///  ///
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
  @Prop('aria-pressed') dynamic get pressed;

  ///  Indicates that the element is not editable, but is otherwise operable. See related aria-disabled.

  ///  ///
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
  @Prop('aria-readonly') bool get readonly;

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
  /// aria-relevant value, the text addition ('bar') would be spoken, but the text removal ('foo')
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
  @Prop('aria-relevant') List get relevant;

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
  @Prop('aria-required') bool get required;

  /// Indicates the current "selected" state of various widgets. See related aria-checked and aria-pressed.

  ///  ///
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
  @Prop('aria-selected') dynamic get selected;

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
  @Prop('aria-setsize') int get setsize;

  /// Indicates if items in a table or grid are sorted in ascending or descending order.
  ///
  /// Authors SHOULD only apply this property to table headers or grid headers. If the property
  /// is not provided, there is no defined sort order. For each table or grid, authors SHOULD apply
  /// aria-sort to only one header at a time.
  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-sort>
  @Prop('aria-sort') dynamic get sort;

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
  @Prop('aria-valuemax') num get valuemax;

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

  ///  ///
  /// See: <http://www.w3.org/TR/wai-aria/states_and_properties#aria-valuemin>
  @Prop('aria-valuemin') num get valuemin;

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
  @Prop('aria-valuenow') num get valuenow;

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
  @Prop('aria-valuetext') String get valuetext;
}