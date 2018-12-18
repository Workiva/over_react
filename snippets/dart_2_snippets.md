## Available Dart 2 Builder-Compatible Code Snippets

Below is a list of all available Dart 2 builder-compatible over_react snippets and their<br>
triggers for Webstorm/IntelliJ and VS Code. 

| Trigger  | Content |
| -------: | ------- |
| `orStless`   | Dart 2 stateless component skeleton |
| `orCStless`   | Dart 2 commented stateless component skeleton |
| `orAbsStless`  | Dart 2 abstract stateless component skeleton |
| `orCAbsStless`  | Dart 2 commented abstract stateless component skeleton |
| `orStful`   | Dart 2 stateful component skeleton |
| `orCStful`   | Dart 2 commented stateful component skeleton |
| `orAbsStful`  | Dart 2 abstract stateful component skeleton |
| `orCAbsStful`  | Dart 2 commented abstract stateful component skeleton |
| `orPropsMixin`  | Dart 2 prop mixin skeleton |
| `orStateMixin`  | Dart 2 state mixin skeleton |

## WebStorm and IntelliJ Snippets

### Installation Instructions

1. Copy the snippet XML below.
2. Open preferences and select "Editor" > "Live Templates"
3. (Optional) Create a new "OverReact Dart 2" group by clicking the "+" button in the<br> 
   upper right corner and selecting "Template Group..."
4. Right click on your new (or an existing) template group and select Paste.
5. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet

### Snippet XML

```
<template name="orStateMixin" value="@StateMixin()&#10;abstract class $MyComponent$StateMixin {&#10;  // To ensure the codemod regression checking works properly, please keep this&#10;  // field at the top of the class!&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const StateMeta meta = $$metaFor$MyComponent$StateMixin;&#10;&#10;  Map get state;&#10;}" description="Creates an over_react state mixin" toReformat="false" toShortenFQNames="true">
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orAbsStful" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@AbstractProps()&#10;abstract class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@AbstractState()&#10;abstract class _$$$MyComponent$State extends UiState {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;abstract class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const StateMeta meta = $$metaFor$MyComponent$State;&#10;}&#10;&#10;@AbstractComponent()&#10;abstract class $MyComponent$Component&lt;T extends $MyComponent$Props, S extends $MyComponent$State&gt; extends UiStatefulComponent&lt;T, S&gt; {&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  Map getInitialState() =&gt; (newState());&#10;&#10;  @override&#10;  render() {}&#10;}" description="Creates an abstract stateful over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orAbsStless" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@AbstractProps()&#10;abstract class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@AbstractComponent()&#10;abstract class $MyComponent$Component&lt;T extends $MyComponent$Props&gt; extends UiComponent&lt;T&gt; {&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  render() {}&#10;}" description="Creates an abstract stateless over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orCAbsStless" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@AbstractProps()&#10;abstract class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@AbstractComponent()&#10;abstract class $MyComponent$Component&lt;T extends $MyComponent$Props&gt; extends UiComponent&lt;T&gt; {&#10;// --------------------------------------------------------------------------&#10;// React Component Specifications and Lifecycle Methods&#10;// --------------------------------------------------------------------------&#10;&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  render() {}&#10;&#10;// --------------------------------------------------------------------------&#10;// Private Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public API Methods&#10;// --------------------------------------------------------------------------&#10;}" description="Creates a commented abstract stateless over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orCStful" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@Factory()&#10;// ignore: undefined_identifier&#10;UiFactory&lt;$MyComponent$Props&gt; Foo = $$$MyComponent$;&#10;&#10;@Props()&#10;class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@State()&#10;class _$$$MyComponent$State extends UiState {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const StateMeta meta = $$metaFor$MyComponent$State;&#10;}&#10;&#10;@Component()&#10;class $MyComponent$Component extends UiStatefulComponent&lt;$MyComponent$Props, $MyComponent$State&gt; {&#10;// --------------------------------------------------------------------------&#10;// React Component Specifications and Lifecycle Methods&#10;// --------------------------------------------------------------------------&#10;&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  Map getInitialState() =&gt; (newState());&#10;&#10;  @override&#10;  render() {}&#10;  &#10;// --------------------------------------------------------------------------&#10;// Private Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public API Methods&#10;// --------------------------------------------------------------------------&#10;}" description="Creates a commented stateful over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orCStless" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@Factory()&#10;// ignore: undefined_identifier&#10;UiFactory&lt;$MyComponent$Props&gt; $MyComponent$ = $$$MyComponent$;&#10;&#10;@Props()&#10;class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// ignore: mixin_of_non_class, undefined_class&#10;class FooProps extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@Component()&#10;class $MyComponent$Component extends UiComponent&lt;$MyComponent$Props&gt; {&#10;// --------------------------------------------------------------------------&#10;// React Component Specifications and Lifecycle Methods&#10;// --------------------------------------------------------------------------&#10;&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  render() {}&#10;  &#10;// --------------------------------------------------------------------------&#10;// Private Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public Utility Methods&#10;// --------------------------------------------------------------------------&#10;&#10;// --------------------------------------------------------------------------&#10;// Public A Methods&#10;// --------------------------------------------------------------------------&#10;}" description="Creates a commented stateless over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orPropsMixin" value="@PropsMixin()&#10;abstract class $MyComponent$PropsMixin {&#10;  // To ensure the codemod regression checking works properly, please keep this&#10;  // field at the top of the class!&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$PropsMixin;&#10;&#10;  Map get props;&#10;}" description="Creates an over_react props mixin" toReformat="false" toShortenFQNames="true">
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orStful" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@Factory()&#10;// ignore: undefined_identifier&#10;UiFactory&lt;$MyComponent$Props&gt; Foo = $$$MyComponent$;&#10;&#10;@Props()&#10;class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@State()&#10;class _$$$MyComponent$State extends UiState {}&#10;&#10;// AF-3369 This will be removed once the transition to Dart 2 is complete.&#10;// ignore: mixin_of_non_class, undefined_class&#10;class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const StateMeta meta = $$metaFor$MyComponent$State;&#10;}&#10;&#10;@Component()&#10;class $MyComponent$Component extends UiStatefulComponent&lt;$MyComponent$Props, $MyComponent$State&gt; {&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  Map getInitialState() =&gt; (newState());&#10;&#10;  @override&#10;  render() {}&#10;}" description="Creates a stateful over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
<template name="orStless" value="// ignore: uri_has_not_been_generated&#10;part '$FileName$.over_react.g.dart';&#10;&#10;@Factory()&#10;// ignore: undefined_identifier&#10;UiFactory&lt;$MyComponent$Props&gt; $MyComponent$ = $$$MyComponent$;&#10;&#10;@Props()&#10;class _$$$MyComponent$Props extends UiProps {}&#10;&#10;// ignore: mixin_of_non_class, undefined_class&#10;class FooProps extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {&#10;  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value&#10;  static const PropsMeta meta = $$metaFor$MyComponent$Props;&#10;}&#10;&#10;@Component()&#10;class $MyComponent$Component extends UiComponent&lt;$MyComponent$Props&gt; {&#10;  @override&#10;  Map getDefaultProps() =&gt; (newProps());&#10;&#10;  @override&#10;  render() {}&#10;}" description="Creates a stateless over_react component" toReformat="false" toShortenFQNames="true">
  <variable name="FileName" expression="" defaultValue="" alwaysStopAt="true" />
  <variable name="MyComponent" expression="" defaultValue="" alwaysStopAt="true" />
  <context>
    <option name="DART" value="true" />
  </context>
</template>
```


## VS Code Snippets

### Installation Instructions

1. Click on "Code", select "Preferences" and select "User Snippets"
2. Select "New Global Snippet file..."
3. Name the file something meaningful like "OverReactDart2"
4. Copy the snippet JSON below, paste it into create snippet file and save
5. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet

### Snippet JSON
```
{
  "statelessComponentsDart2": {
    "prefix": "orStless",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@Factory()",
      "// ignore: undefined_identifier",
      "UiFactory<${2:MyComponent}Props> ${2:MyComponent} = $${2:MyComponent};",
      "",
      "@Props()",
      "class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@Component()",
      "class ${2:MyComponent}Component extends UiComponent<${2:MyComponent}Props> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates a stateless OverReact component compatible with Dart 1 and 2"
  },
  "statelessCommentedComponentsDart2": {
    "prefix": "orCStless",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@Factory()",
      "// ignore: undefined_identifier",
      "UiFactory<${2:MyComponent}Props> ${2:MyComponent} = $${2:MyComponent};",
      "",
      "@Props()",
      "class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@Component()",
      "class ${2:MyComponent}Component extends UiComponent<${2:MyComponent}Props> {",
      "\t// Refs",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// React Component Specifications and Lifecycle Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Private Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public API Methods",
      "\t// --------------------------------------------------------------------------",
      "}"
    ],
    "description": "Creates a commented stateless OverReact component compatible with Dart 1 and 2"
  },
  "abstractStatelessComponentsDart2": {
    "prefix": "orAbsStless",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@AbstractProps()",
      "abstract class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${2:MyComponent}Component<T extends ${2:MyComponent}Props> extends UiComponent<T> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates an abstract stateless OverReact component compatible with Dart 1 and 2"
  },
  "abstractCommentedStatelessComponentsDart2": {
    "prefix": "orCAbsStless",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@AbstractProps()",
      "abstract class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${2:MyComponent}Component<T extends ${2:MyComponent}Props> extends UiComponent<T> {",
      "\t// Refs",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// React Component Specifications and Lifecycle Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Private Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public API Methods",
      "\t// --------------------------------------------------------------------------",
      "}"
    ],
    "description": "Creates an commented abstract stateless OverReact component compatible with Dart 1 and 2"
  },
  "statefulComponentsDart2": {
    "prefix": "orStful",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@Factory()",
      "// ignore: undefined_identifier",
      "UiFactory<${2:MyComponent}Props> ${2:MyComponent} = $${2:MyComponent}",
      "",
      "@Props()",
      "class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "@State()",
      "class _$${2:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}State extends _$${2:MyComponent}State with _$${2:MyComponent}StateAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const StateMeta meta = $metaFor${2:MyComponent}State;",
      "}",
      "",
      "@Component()",
      "class ${2:MyComponent}Component extends UiStatefulComponent<${2:MyComponent}Props, ${2:MyComponent}State> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\tMap getInitialState() => (newState());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates a stateful OverReact component compatible with Dart 1 and 2"
  },
  "statefulCommentedComponentsDart2": {
    "prefix": "orCStful",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@Factory()",
      "// ignore: undefined_identifier",
      "UiFactory<${2:MyComponent}Props> ${2:MyComponent} = $${2:MyComponent}",
      "",
      "@Props()",
      "class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@State()",
      "class _$${2:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "class ${2:MyComponent}State extends _$${2:MyComponent}State with _$${2:MyComponent}StateAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const StateMeta meta = $metaFor${2:MyComponent}State;",
      "}",
      "",
      "@Component()",
      "class ${2:MyComponent}Component extends UiStatefulComponent<${2:MyComponent}Props, ${2:MyComponent}State> {",
      "\t// Refs",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// React Component Specifications and Lifecycle Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\tMap getInitialState() => (newState());",
      "",
      "\t@override",
      "\trender() { }",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Private Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public API Methods",
      "\t// --------------------------------------------------------------------------",
      "}"
    ],
    "description": "Creates a commented stateful OverReact component compatible with Dart 1 and 2"
  },
  "abstractStatefulComponentsDart2": {
    "prefix": "orAbsStful",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@AbstractProps()",
      "abstract class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@AbstractState()",
      "abstract class _$${2:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}State extends _$${2:MyComponent}State with _$${2:MyComponent}StateAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const StateMeta meta = $metaFor${2:MyComponent}State;",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${2:MyComponent}Component<T extends ${2:MyComponent}Props, S extends ${2:MyComponent}State> extends UiStatefulComponent<T, S> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\tMap getInitialState() => (newState());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates an abstract stateful OverReact component compatible with Dart 1 and 2"
  },
  "abstractCommentedStatefulComponentsDart2": {
    "prefix": "orCAbsStful",
    "body": [
      "// ignore: uri_has_not_been_generated",
      "part '${1:FileName}.over.react.g.dart';",
      "",
      "@AbstractProps()",
      "abstract class _$${2:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}Props extends _$${2:MyComponent}Props with _$${2:MyComponent}PropsAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const PropsMeta meta = $metaFor${2:MyComponent}Props;",
      "}",
      "",
      "@AbstractState()",
      "abstract class _$${2:MyComponent}State extends UiState {",
      "",
      "// AF-3369 This will be removed once the transition to Dart 2 is complete.",
      "// ignore: mixin_of_non_class, undefined_class",
      "abstract class ${2:MyComponent}State extends _$${2:MyComponent}State with _$${2:MyComponent}StateAccessorsMixin {",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\tstatic const StateMeta meta = $metaFor${2:MyComponent}State;",
      "}",
      "",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${2:MyComponent}Component<T extends ${2:MyComponent}Props, S extends ${2:MyComponent}State> extends UiStatefulComponent<T, S> {",
      "\t// Refs",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// React Component Specifications and Lifecycle Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\tMap getInitialState() => (newState());",
      "",
      "\t@override",
      "\trender() { }",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Private Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public Utility Methods",
      "\t// --------------------------------------------------------------------------",
      "",
      "\t// --------------------------------------------------------------------------",
      "\t// Public API Methods",
      "\t// --------------------------------------------------------------------------",
      "}"
    ],
    "description": "Creates an commented abstract stateful OverReact component compatible with Dart 1 and 2"
  },
  "propMixinsDart2": {
    "prefix": "orPropsMixin",
    "body": [
      "@PropsMixin()",
      "abstract class ${1:MyComponent}PropsMixin {",
      "\t// To ensure the codemod regression checking works properly, please keep this",
      "\t// field at the top of the class!",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\t static const PropsMeta meta = $metaFor${1:MyComponent}PropsMixin;",
      "",
      "\tMap get props;",
      "}"
    ],
    "description": "Creates an OverReact props mixin compatible with Dart 1 and 2"
  },
  "stateMixinsDart2": {
    "prefix": "orStateMixin",
    "body": [
      "@StateMixin()",
      "abstract class ${1:MyComponent}StateMixin {",
      "\t// To ensure the codemod regression checking works properly, please keep this",
      "\t// field at the top of the class!",
      "\t// ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value",
      "\t static const StateMeta meta = $metaFor${1:MyComponent}StateMixin;",
      "",
      "\tMap get state;",
      "}"
    ],
    "description": "Creates an OverReact state mixin compatible with Dart 1 and 2"
  },
}
```
