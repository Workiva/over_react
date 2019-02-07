# Contributing

> We are working on a more thorough version of these contributing guidlines. For
> the time being, we've documented our temporary dual-release setup that is
> necessary for supporting Dart 1 and Dart 2 concurrently.

## Dart 1 & Dart 2 Dual-Releases

Long story short, we are unable to maintain a single codebase of over_react that
is compatible with both Dart 1 and Dart 2. Transformers only work on Dart 1 and
builders only work on Dart 2, and we can't maintain the transformer and builder
together due to dependency conflicts.

> For more information on our Dart 2 migration, [see this guide](/doc/dart2_migration.md).

Fortunately, this problem can be shouldered entirely by the maintainers via a
dual-release strategy (credit to the [dart2_constant](https://pub.dartlang.org/packages/dart2_constant)
for the idea). The result is that consumers will depend on a version range of
this library like they normally do and everything will _just work_.

For every _version_ we want to release, we will actually release two releases -
a Dart 1 (transformer) version and a Dart 2 (builder) version. These two
releases will have the same semantic version, but will have unique build
suffixes. The `pub` client will then decide which one to install based on their
`environment.sdk` constraints and the active Dart SDK version.

### Branches

- `master`
  - Dart2-only
  - Provides a builder
  - Environment constraint: `>=2.1.0 <3.0.0`

- `master_dart1`
  - Dart1-only
  - Provides a transformer
  - Environment constraint: `>=1.24.3 <2.0.0`

### Release Process

> Note that these steps are intended to be followed by Workiva employees, and as
> such have some references to internal tooling.

For every release, do the following:

1. Ensure the next release versions exist in MARV:

    Name | Branch
    ---- | ------
    over_react 2.x.x-dart1 | master_dart1
    over_react 2.x.x-dart2 | master

1. Trigger the `over_react 2.x.x-dart1` release first and review the PR:

   - Ensure the updated `pubspec.yaml` version is correct, including the
     `-dart1` suffix.

   - Ensure the build passes.

1. Trigger the `over_react 2.x.x-dart2` release second and review the PR:

   - Ensure the updated `pubspec.yaml` version is correct, including the
     `-dart2` suffix.

   - Ensure the build passes.

   - **Add any necessary changelog updates to the Dart 2 version.**

1. **Merge the Dart 1 release first and publish it to pub.**

1. Merge the Dart 2 release second and publish it to pub.

1. Re-recreate the Dart 1 release in MARV (it does not get recreated
   automatically like the default release does).

  