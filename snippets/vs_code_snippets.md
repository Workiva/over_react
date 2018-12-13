## VS Code Dart 1 Transformer Compatible Code Snippets 

The following is attributed to [VS Code Snippet Extension](https://marketplace.visualstudio.com/items?itemName=JaceHensley.over-react-snippets)

Below is a list of all available VS Code snippets and their triggers. 

| Trigger  | Content |
| -------: | ------- |
| `orStless`   | stateless component skeleton |
| `orCStless`   | commented stateless component skeleton |
| `orAbsStless`  | abstract stateless component skeleton |
| `orCAbsStless`  | commented abstract stateless component skeleton |
| `orStful`   | stateful component skeleton |
| `orCStful`   | commneted stateful component skeleton |
| `orAbsStful`  | abstract stateful component skeleton |
| `orCAbsStful`  | commented abstract stateful component skeleton |
| `orMixin`  | prop mixin skeleton |
| `orWM`  | `componentWillMount` method |
| `orDM`  | `componentDidMount` method |
| `orWRP`  | `componentWillReceiveProps` method |
| `orSUp`  | `shouldComponentUpdate` method |
| `orWUp`  | `componentWillUpdate` method |
| `orDUp`  | `componentDidUpdate` method |
| `orWUn`  | `componentWillUnmount` method |
| `orSS`  | invoked `setState` with `newState()` |
| `orSST`  | invoked `setState` with function |
| `orBanner`  | comment banner |

### Installation Instructions

1. Click on "Code", select "Preferences" and select "User Snippets"
2. Select "New Global Snippet file..."
3. Name the file something meaningful like "OverReact"
4. Copy the snippet JSON below, paste it into create snippet file and save
5. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet

### Snippet JSON

```
{
  "statelessComponents": {
    "prefix": "orStless",
    "body": [
      "@Factory()",
      "UiFactory<${1:MyComponent}Props> ${1:MyComponent};",
      "",
      "@Props()",
      "class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@Component()",
      "class ${1:MyComponent}Component extends UiComponent<${1:MyComponent}Props> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates a stateless OverReact component"
  },
  "statelessCommentedComponents": {
    "prefix": "orCStless",
    "body": [
      "@Factory()",
      "UiFactory<${1:MyComponent}Props> ${1:MyComponent};",
      "",
      "@Props()",
      "class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@Component()",
      "class ${1:MyComponent}Component extends UiComponent<${1:MyComponent}Props> {",
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
    "description": "Creates a commented stateless OverReact component"
  },
  "abstractStatelessComponents": {
    "prefix": "orAbsStless",
    "body": [
      "@AbstractProps()",
      "abstract class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${1:MyComponent}Component<T extends ${1:MyComponent}Props> extends UiComponent<T> {",
      "\t@override",
      "\tMap getDefaultProps() => (newProps());",
      "",
      "\t@override",
      "\trender() { }",
      "}"
    ],
    "description": "Creates an abstract stateless OverReact component"
  },
  "abstractCommentedStatelessComponents": {
    "prefix": "orCAbsStless",
    "body": [
      "@AbstractProps()",
      "abstract class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${1:MyComponent}Component<T extends ${1:MyComponent}Props> extends UiComponent<T> {",
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
    "description": "Creates an commented abstract stateless OverReact component"
  },
  "statefulComponents": {
    "prefix": "orStful",
    "body": [
      "@Factory()",
      "UiFactory<${1:MyComponent}Props> ${1:MyComponent};",
      "",
      "@Props()",
      "class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@State()",
      "class ${1:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "@Component()",
      "class ${1:MyComponent}Component extends UiStatefulComponent<${1:MyComponent}Props, ${1:MyComponent}State> {",
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
    "description": "Creates a stateful OverReact component"
  },
  "statefulCommentedComponents": {
    "prefix": "orCStful",
    "body": [
      "@Factory()",
      "UiFactory<${1:MyComponent}Props> ${1:MyComponent};",
      "",
      "@Props()",
      "class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@State()",
      "class ${1:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "@Component()",
      "class ${1:MyComponent}Component extends UiStatefulComponent<${1:MyComponent}Props, ${1:MyComponent}State> {",
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
    "description": "Creates a commented stateful OverReact component"
  },
  "abstractStatefulComponents": {
    "prefix": "orAbsStful",
    "body": [
      "@AbstractProps()",
      "abstract class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@AbstractState()",
      "abstract class ${1:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${1:MyComponent}Component<T extends ${1:MyComponent}Props, S extends ${1:MyComponent}State> extends UiStatefulComponent<T, S> {",
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
    "description": "Creates an abstract stateful OverReact component"
  },
  "abstractCommentedStatefulComponents": {
    "prefix": "orCAbsStful",
    "body": [
      "@AbstractProps()",
      "abstract class ${1:MyComponent}Props extends UiProps {",
      "",
      "}",
      "",
      "@AbstractState()",
      "abstract class ${1:MyComponent}State extends UiState {",
      "",
      "}",
      "",
      "@AbstractComponent()",
      "abstract class ${1:MyComponent}Component<T extends ${1:MyComponent}Props, S extends ${1:MyComponent}State> extends UiStatefulComponent<T, S> {",
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
    "description": "Creates an commented abstract stateful OverReact component"
  },
  "propMixins": {
    "prefix": "orMixin",
    "body": [
      "@PropsMixin()",
      "abstract class ${1:MyComponent}PropsMixin {",
      "\tstatic final ${1:MyComponent}PropsMixinMapView defaultProps = new ${1:MyComponent}PropsMixinMapView({});",
      "",
      "\tMap get props;",
      "}",
      "",
      "class ${1:MyComponent}PropsMixinMapView extends UiPropsMixinMapView with ${1:MyComponent}PropsMixin {",
      "\t${1:MyComponent}PropsMixinMapView(Map map) : super(map);",
      "}"
    ],
    "description": "Creates an abstract stateful OverReact component"
  },
  "componentWillMount": {
    "prefix": "orWM",
    "body": [
      "@mustCallSuper",
      "@override",
      "void componentWillMount() {",
      "\tsuper.componentWillMount()",
      "",
      "}"
    ],
    "description": "componentWillMount method"
  },
  "componentDidMount": {
    "prefix": "orDM",
    "body": [
      "@override",
      "void componentDidMount() { }"
    ],
    "description": "componentDidMount method"
  },
  "componentWillReceiveProps": {
    "prefix": "orWRP",
    "body": [
      "@mustCallSuper",
      "@override",
      "void componentWillReceiveProps(Map nextProps) {",
      "\tsuper.componentWillReceiveProps(nextProps)",
      "",
      "}"
    ],
    "description": "componentWillReceiveProps method"
  },
  "shouldComponentUpdate": {
    "prefix": "orSUp",
    "body": [
      "@override",
      "bool shouldComponentUpdate(Map nextProps, Map nextState) { }"
    ],
    "description": "shouldComponentUpdate method"
  },
  "componentWillUpdate": {
    "prefix": "orWUp",
    "body": [
      "@override",
      "void componentWillUpdate(Map nextProps, Map nextState) { }"
    ],
    "description": "componentWillUpdate method"
  },
  "componentDidUpdate": {
    "prefix": "orDUp",
    "body": [
      "@override",
      "void componentDidUpdate(Map prevProps, Map prevState) { }"
    ],
    "description": "componentDidUpdate method"
  },
  "componentWillUnmount": {
    "prefix": "orWUn",
    "body": [
      "@mustCallSuper",
      "@override",
      "void componentWillUnmount() {",
      "\tsuper.componentWillUnmount()",
      "",
      "}"
    ],
    "description": "componentWillUnmount method"
  },
  "setState": {
    "prefix": "orSS",
    "body": [
      "setState(newState());"
    ],
    "description": "setState with new state"
  },
  "setStateTransactional": {
    "prefix": "orSST",
    "body": [
      "setState((Map prevState, Map props) {",
      "\tvar stateChanges = newState()",
      "",
      "\treturn stateChanges;",
      "});"
    ],
    "description": "setState with new state"
  },
  "banner": {
    "prefix": "orBanner",
    "body": [
      "// --------------------------------------------------------------------------",
      "// ${1:Message}",
      "// --------------------------------------------------------------------------"
    ],
    "description": "Creates a code comment banner"
  }
}
```
