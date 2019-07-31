## Available Code Snippets

Below is a list of all available over_react snippets and their Triggers for Webstorm/IntelliJ and VS Code. 

| Trigger | Content |
| -------: | ------- |
| `orStless`   | Stateless component skeleton |
| `orCStless`   | Commented stateless component skeleton |
| `orAbsStless`  |  Abstract stateless component skeleton |
| `orCAbsStless`  | Commented abstract stateless component skeleton |
| `orStful`   | Stateful component skeleton |
| `orCStful`   | Commented stateful component skeleton |
| `orAbsStful`  | Abstract stateful component skeleton |
| `orCAbsStful`  | Commented abstract stateful component skeleton |

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
    curl https://raw.githubusercontent.com/Workiva/over_react/master/snippets/snippets.xml | pbcopy
    ```

2. Click on "Code", select "Preferences" and select "User Snippets"
3. Select "New Global Snippet file..."
4. Name the file something meaningful like "OverReact Snippets"
5. Select all of the boiler plate in the snippet file just created and replace it by pasting the<br>
   VS Code snippets json copied after running the command in step 1
6. Use any "prefix" or "trigger" from the table above in any ".dart" file to invoke a snippet
7. Press "tab" to move to and set the next variable.
