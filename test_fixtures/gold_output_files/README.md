## Updating golds

To re-generate the gold files in this directory using the over_react builder, run:
```sh
dart tool/update_gold_output_files.dart
```

If that deletes other generated files throughout over_react (which usually only happens after it prompts you about conflicting outputs), you can restore them by running a build: 
```sh
dart run build_runner build
```
