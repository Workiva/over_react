## Available Code Snippets

Below is a list of all available Dart 2 builder-compatible over_react snippets and their<br>
triggers for Webstorm/IntelliJ and VS Code. 

| Trigger - Dart 1/2 Compatible  | Trigger - Dart 2 Only | Content |
| -------: | ------- | ------- |
| `orStless`   | `ord2Stless`   | Dart 2 stateless component skeleton |
| `orCStless`   | `ord2CStless`   | Dart 2 commented stateless component skeleton |
| `orAbsStless`  | `ord2AbsStless`   |  Dart 2 abstract stateless component skeleton |
| `orCAbsStless`  | `ord2CAbsStless`  | Dart 2 commented abstract stateless component skeleton |
| `orStful`   |  `ord2Stful`   | Dart 2 stateful component skeleton |
| `orCStful`   | `ord2CStful`   | Dart 2 commented stateful component skeleton |
| `orAbsStful`  | `ord2AbsStful`  | Dart 2 abstract stateful component skeleton |
| `orCAbsStful`  | `orCAbsStful`  | Dart 2 commented abstract stateful component skeleton |
| `orPropsMixin`  | N/A  | Dart 2 prop mixin skeleton (unnecessary in Dart 2 only) |
| `orStateMixin`  | N/A  | Dart 2 state mixin skeleton (unnecessary in Dart 2 only) |

## WebStorm and IntelliJ Snippets

### Installation Instructions

<img src="webstorm_intelliJ.gif" alt="How to install and use snippets in WebStorm and IntelliJ"/><br>

1. Copy the command below and run it in your terminal.

   For Dart 1/2 compatible snippets:                                  
   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/dart1-2/snippets.xml | pbcopy
   ``` 
   
   For Dart 2 only snippets:
   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/dart2-only/snippets.xml | pbcopy
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

    For Dart 1/2 compatible snippets: 
   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/dart1-2/snippets.json | pbcopy
   ```
   
   For Dart 2 only snippets:
   ```bash
   curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/dart2-only/snippets.json | pbcopy
   ```

2. Click on "Code", select "Preferences" and select "User Snippets"
3. Select "New Global Snippet file..."
4. Name the file something meaningful like "OverReact Snippets"
5. Select all of the boiler plate in the snippet file just created and replace it by pasting the<br>
   VS Code snippets json copied after running the command in step 1
6. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet
7. Press "tab" to move to and set the next variable.
