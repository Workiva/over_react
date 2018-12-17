## Available Dart 2 Builder-Compatible Code Snippets

Below is a list of all available Dart 2 builder-compatible over_react snippets and their<br>
triggers for Webstorm/IntelliJ and VS Code. 

| Trigger  | Content |
| -------: | ------- |
| `or_stateless`   | dart 2 stateless component skeleton |
| `or_stateless_commented`   | dart 2 commented stateless component skeleton |
| `or_abstract_stateless`  | dart 2 abstract stateless component skeleton |
| `or_abstract_stateless_commented`  | dart 2 commented abstract stateless component skeleton |
| `or_stateful`   | dart 2 stateful component skeleton |
| `or_stateful_commented`   | dart 2 commneted stateful component skeleton |
| `or_abstract_stateful`  | dart 2 abstract stateful component skeleton |
| `or_abstract_stateful_commented`  | dart 2 commented abstract stateful component skeleton |
| `or_props_mixin`  | dart 2 prop mixin skeleton |
| `or_state_mixin`  | dart 2 state mixin skeleton |

## WebStorm and IntelliJ Snippets

### Installation Instructions

1. Click "WebStrom" or "IntelliJ" and select "Preferences" 
2. Click on the Editor drop down and select Live Templates
3. Click the "+" button in the upper right corner and select "Template Group..."
    1. Provide a meaningful name for your template group like "OverReactDart2"
    2. Alternatively, you can select an existing group, click on the "+" button and<br>
       select "Live Template" to add a new template to that group
4. Click the "+" again once you've created or selected the template group to which you'd<br> 
   like to add a new template and select "Live Template"
5. Enter the suggested abbreviation and description for the snippet you're adding
6. Copy the snippet code block you'd like to add from the available code blocks below and<br>
   paste it into the "Template text:" section 
7. Click "Define" next to "No applicable context." at the bottom and toggle the "Dart" check box
8. Click "Apply" and add another snippet or click OK to exit
9. Use the abbreviation in any ".dart" file to call invoke the snippet


### Stateless Component

**Suggested Abbreviation:** or_stateless<br>
**Suggested Description:** Creates a stateless over_react component

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<$MyComponent$Props> $MyComponent$ = $$$MyComponent$;

@Props()
class _$$$MyComponent$Props extends UiProps {}

// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@Component()
class $MyComponent$Component extends UiComponent<$MyComponent$Props> {
  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {}
}
```

### Stateless Component With Comments 

**Suggested Abbreviation:** or_stateless_commented<br>
**Suggested Description:** Creates a stateless over_react component with comments

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<$MyComponent$Props> $MyComponent$ = $$$MyComponent$;

@Props()
class _$$$MyComponent$Props extends UiProps {}

// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@Component()
class $MyComponent$Component extends UiComponent<$MyComponent$Props> {
// --------------------------------------------------------------------------
// React Component Specifications and Lifecycle Methods
// --------------------------------------------------------------------------

  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {}
  
// --------------------------------------------------------------------------
// Private Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Api Methods
// --------------------------------------------------------------------------
}
```

### Stateful Component

**Suggested Abbreviation:** or_stateful<br>
**Suggested Description:** Creates a stateful over_react component

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<$MyComponent$Props> Foo = $$$MyComponent$;

@Props()
class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@State()
class _$$$MyComponent$State extends UiState {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $$metaFor$MyComponent$State;
}

@Component()
class $MyComponent$Component extends UiStatefulComponent<$MyComponent$Props, $MyComponent$State> {
  @override
  Map getDefaultProps() => (newProps());

  @override
  Map getInitialState() => (newState());

  @override
  render() {}
}
```

### Stateful Component with Comments

**Suggested Abbreviation:** or_stateful_commented<br>
**Suggested Description:** Creates a stateful over_react component with comments

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<$MyComponent$Props> Foo = $$$MyComponent$;

@Props()
class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@State()
class _$$$MyComponent$State extends UiState {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $$metaFor$MyComponent$State;
}

@Component()
class $MyComponent$Component extends UiStatefulComponent<$MyComponent$Props, $MyComponent$State> {
// --------------------------------------------------------------------------
// React Component Specifications and Lifecycle Methods
// --------------------------------------------------------------------------

  @override
  Map getDefaultProps() => (newProps());

  @override
  Map getInitialState() => (newState());

  @override
  render() {}
  
// --------------------------------------------------------------------------
// Private Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Api Methods
// --------------------------------------------------------------------------
}
```

### Abstract Stateless Component

**Suggested Abbreviation:** or_abstract_stateless<br>
**Suggested Description:** Creates an abstract stateless over_react component

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@AbstractProps()
abstract class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@AbstractComponent()
abstract class $MyComponent$Component<T extends $MyComponent$Props> extends UiComponent<T> {
  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {}
}
```

### Abstract Stateless Component with Comments

**Suggested Abbreviation:** or_abstract_stateless_commented<br>
**Suggested Description:** Creates an abstract stateless over_react component with comments

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@AbstractProps()
abstract class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@AbstractComponent()
abstract class $MyComponent$Component<T extends $MyComponent$Props> extends UiComponent<T> {
// --------------------------------------------------------------------------
// React Component Specifications and Lifecycle Methods
// --------------------------------------------------------------------------

  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {}

// --------------------------------------------------------------------------
// Private Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Api Methods
// --------------------------------------------------------------------------
}
```

### Abstract Stateful Component

**Suggested Abbreviation:** or_abstract_stateful<br>
**Suggested Description:** Creates an abstract stateful over_react component

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@AbstractProps()
abstract class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@AbstractState()
abstract class _$$$MyComponent$State extends UiState {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $$metaFor$MyComponent$State;
}

@AbstractComponent()
abstract class $MyComponent$Component<T extends $MyComponent$Props, S extends $MyComponent$State> extends UiStatefulComponent<T, S> {
  @override
  Map getDefaultProps() => (newProps());

  @override
  Map getInitialState() => (newState());

  @override
  render() {}
}
```

### Abstract Stateful Component with Comments

**Suggested Abbreviation:** or_abstract_stateful_commented<br>
**Suggested Description:** Creates an abstract stateful over_react component with comments

```
// ignore: uri_has_not_been_generated
part '$FileName$.over_react.g.dart';

@AbstractProps()
abstract class _$$$MyComponent$Props extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$Props extends _$$$MyComponent$Props with _$$$MyComponent$PropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$Props;
}

@AbstractState()
abstract class _$$$MyComponent$State extends UiState {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class $MyComponent$State extends _$$$MyComponent$State with _$$$MyComponent$StateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $$metaFor$MyComponent$State;
}

@AbstractComponent()
abstract class $MyComponent$Component<T extends $MyComponent$Props, S extends $MyComponent$State> extends UiStatefulComponent<T, S> {
// --------------------------------------------------------------------------
// React Component Specifications and Lifecycle Methods
// --------------------------------------------------------------------------

  @override
  Map getDefaultProps() => (newProps());

  @override
  Map getInitialState() => (newState());

  @override
  render() {}
  
// --------------------------------------------------------------------------
// Private Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Utility Methods
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Api Methods
// --------------------------------------------------------------------------
}
```

### Props Mixin

**Suggested Abbreviation:** or_props_mixin<br>
**Suggested Description:** Creates an over_react props mixin

```
@PropsMixin()
abstract class $MyComponent$PropsMixin {
  // To ensure the codemod regression checking works properly, please keep this
  // field at the top of the class!
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $$metaFor$MyComponent$PropsMixin;

  Map get props;
}
```

### State Mixin

**Suggested Abbreviation:** or_state_mixin<br>
**Suggested Description:** Creates an over_react state mixin

```
@StateMixin()
abstract class $MyComponent$StateMixin {
  // To ensure the codemod regression checking works properly, please keep this
  // field at the top of the class!
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $$metaFor$MyComponent$StateMixin;

  Map get state;
}
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
    "prefix": "or_stateless",
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
    "prefix": "or_stateless_commented",
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
    "prefix": "or_abstract_stateless",
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
    "prefix": "or_abstract_stateless_commented",
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
    "prefix": "or_stateful",
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
    "prefix": "or_stateful_commented",
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
    "prefix": "or_abstract_stateful",
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
    "prefix": "or_abstract_stateful_commented",
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
    "prefix": "or_props_mixin",
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
    "prefix": "or_state_mixin",
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
