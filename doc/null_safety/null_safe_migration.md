# Dart Null Safety Migration Guide

> [!NOTE]
> For Workiva employees, also refer to this more detailed Workiva-specific [migration guide](https://github.com/Workiva/dart_null_tools/blob/master/workiva_migration_guide.md).

Steps to migrate a repo to null safety:

1. [View resources](#step-1-view-resources)
1. [Run the preparation codemod](#step-2-run-the-preparation-codemod-coming-soon)
1. [Run the migration tool](#step-3-run-the-migration-tool)

## Step 1: View resources

If you haven't already, familiarize yourself with the concepts of Dart null safety with the following resources:

- [Understanding null safety](https://dart.dev/null-safety/understanding-null-safety) article 

<!-- TODO - add links to over_react null safety documentation once it exists -->

## Step 2: Run the preparation codemod (coming soon!)

<!-- TODO - update this section once we release the `null_safety_prep` codemod. -->

> [!WARNING]
> This codemod does not exist yet, but is coming soon!

Start out by running the `null_safety_prep` [codemod][orcm] on your repo:

```
dart pub global activate over_react_codemod
dart pub global run over_react_codemod:null_safety_prep
```

This codemod will:
- Migrate as many over_react specific use cases as possible.
- Get the repo into a state where the migration tool can be run with less manual intervention.

## Step 3: Run the migration tool

Run the null safety migrator tool:

- For Workiva employees, use the [Workiva version of the migrator tool](https://github.com/Workiva/wnnbd?tab=readme-ov-file#migrating-a-package).
- Otherwise, either:
  - use [Dart's migrator tool](https://dart.dev/null-safety/migration-guide#migration-tool)
  - use [a fork of the migrator tool](#migrator-tool-bug) that fixes a bug with how over_react usages are migrated

### Common migration cases

Below are some common cases that might come up while running the migrator tool on a repo using over_react.

#### Prop nullability

First, check out our documentation around [null safety and required props](../null_safety_and_required_props.md).

To determine if a prop should be nullable or not, first consider if the prop is required.

> [!WARNING]
> Making a prop required with the `late` keyword can be a breaking change if consumers are not always setting the prop.

Below is a table of the possible options for prop nullability:

|                | Required (`late`)    | Optional        |
|----------------|----------------------|-----------------|
| Nullable (`?`) | `late String? prop;` | `String? prop;` |
| Non-nullable   | `late String prop;`  | n/a             |

- (_most common_) All **optional** props should be made **nullable**.
- **Required** props can be nullable or non-nullable:
  - **Nullable**: If the prop is required, but can be explicitly set to `null`.
  - **Non-nullable**: If the prop is required and should never be set to `null`.

#### Migrator tool bug

The migrator tool [incorrectly treats the result of emulated function calls as nullable](https://github.com/dart-lang/sdk/issues/46263).

The most common way this affects over_react is in cases like this:
```dart
// The over_react code:
var content = Dom.div()();

// gets incorrectly migrated to:
ReactElement? content = Dom.div()();
```

To work around this issue, you can either:
- manually fix these after running the migrator
- use a fork of the migrator tool that contains a bugfix - see the following section for instructions on how to run that locally

#### Using the forked migrator tool

The `dart migrate` tool comes bundled with the Dart SDK, so we'll need a local copy of the SDK to pull in [a fix](https://github.com/dart-lang/sdk/issues/46263#issuecomment-967647710) for it.

First, clone the Dart SDK using the instructions from the Dart SDK wiki (just cloning the repo normally won't work). The only steps on this wiki you need to follow are:
1. [Dependencies](https://github.com/dart-lang/sdk/wiki/Building#dependencies)
2. [Getting the source](https://github.com/dart-lang/sdk/wiki/Building#source)

After that's done, we'll check out the branch containing the bugfix, and get the migrator tool ready to run:
```sh
# Enter the dart-sdk/sdk directory we set up above
cd sdk

# Check out the forked Dart SDK branch with the fix from:
# https://github.com/dart-lang/sdk/issues/46263#issuecomment-967647710
git remote add sdk-fork https://github.com/greglittlefield-wf/sdk.git
git fetch sdk-fork
git checkout fix-emulated-function-migration-2.19

# After changing branches, update files needed for generate_package_config  
gclient sync -D --nohooks

# Generate a package config in place of doing `pub get` (the Dart SDK's package setup is special),
# allowing us to run the migrator tool.
dart tools/generate_package_config.dart
```

Now, we're all set!

In place of running `dart migrate`, we can run our local copy of the migrator tool. Start in the package you want to migrate, then run the tool located at `pkg/nnbd_migration/bin/migrate.dart` within the Dart SDK clone.
```sh
cd your_package
# This can be an absolute or relative path
dart /full/path/to/dart-sdk/sdk/pkg/nnbd_migration/bin/migrate.dart
```

This command behaves the same as `dart migrate`, and accepts the same arguments it does. 


[orcm]: https://github.com/Workiva/over_react_codemod
