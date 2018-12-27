## Available Dart 1 and Dart 2 Backwards Compatible Code Snippets

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

<img src="webstorm_intelliJ.gif" alt="How to install and use snippets in WebStorm and IntelliJ"/><br>

1. Copy the command below and run it in your terminal.

   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/snippets.xml | pbcopy
   ``` 
   
2. Open preferences and select "Editor" > "Live Templates"
3. (Optional) Create a new "OverReact Snippets" group by clicking the "+" button in the<br> 
   upper right corner and selecting "Template Group..."
4. Right click on your new (or an existing) template group and select Paste.
5. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet
6. Press "tab" to move to and set the next variable.

## VS Code Snippets

### Installation Instructions

<img src="vs_code.gif" alt="How to install and use snippets in VS Code"/><br>

1. Copy the command below and run it in your terminal.

   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/snippets.json | pbcopy
   ```

2. Click on "Code", select "Preferences" and select "User Snippets"
3. Select "New Global Snippet file..."
4. Name the file something meaningful like "OverReact Snippets"
5. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet
6. Press "tab" to move to and set the next variable.
