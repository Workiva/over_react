# Dart Null Safety Migration Guide

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

> ⚠️ This codemod does not exist yet, but is coming soon!

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
- Otherwise, use [Dart's migrator tool](https://dart.dev/null-safety/migration-guide#migration-tool).

### Common migration cases

Below are some common cases that might come up while running the migrator tool on a repo using over_react.

#### Whether a prop should be non-nullable




[orcm]: https://github.com/Workiva/over_react_codemod
