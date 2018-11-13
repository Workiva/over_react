# Contributing to Dart Transformer Utilities

Looking to contribute something? __Here's how you can help.__

+ __[Coding Standards](#coding-standards)__
  + [Formatting](#formatting)
+ __[Key Branches](#key-branches)__
+ __[Using the Issue Tracker](#using-the-issue-tracker)__
  + [Reporting Bugs](#bug-reports)
  + [Feature Requests](#feature-requests)
  + [Submitting Pull Requests](#pull-requests)
+ __[Commit Message Standards](#git-commit-message-standards)__

---


## Coding standards

A lot can be gained by writing code in a consistent way.  Moreover, always remember that code is written and maintained by _people_. Ensure your code is descriptive, well commented, and approachable by others.

Adhere to the [Dart Style Guide][dart-style-guide].  __PLEASE READ IT IF YOU HAVE NEVER DONE SO__

### Formatting

All Dart code is to be formatted by [dart_style](https://github.com/dart-lang/dart_style) via [the dart_dev package](https://pub.dartlang.org/packages/dart_dev).


## Key branches

+ `master` is the latest, deployed version.
+ `*-wip` branches are the official work in progress branches for the next patch/minor/major releases.
    + __The appropriate *-wip branch should always be the base branch of any PR you create.__
        + All PRs using `master` as the base branch will be closed without merge.
        + If you are making a change that will break backwards compatibility, stop - and __reach out to us by opening an issue first__.
        + If there is more than one `*-wip` branch open when you are creating your feature branch, consider the scope of the changes you plan on making.
            + If you are making a change that will add some new functionality, the base branch should be the next minor release version.
                + For example, if the current version is `2.0.0`, changes that add functionality should be based off of `2.1.0-wip`.
            + If you are making a change that will not add any new functionality, merely fix a bug, etc, the base branch should be the next patch release version.
                + For example, if the current version is `2.0.0`, fixes that don't add anything should be based off of `2.0.1-wip`.


## Using the issue tracker

The issue tracker is the preferred channel for [bug reports](#bug-reports), [feature requests](#feature-requests) and [submitting pull requests](#pull-requests), but __please follow the guidelines:__

  + __Help Us Help You__
    + Please include context relating to the urgency / timeframe for the request, and tag any key folks that need to keep track of the request as it moves through the process.

  + __Be Professional__
    + Please __do not__ derail or troll issues. Keep the discussion on topic and respect the opinions of others.

  + __Not that Professional__
    + Feel free to include _relevant_ animated gifs to drive home your message / request.


### Bug reports

A bug is a _demonstrable problem_ that is caused by the code in the repository.
Good bug reports are extremely helpful - thank you!

__Guidelines for bug reports:__

1. __Search for existing issues.__ Duplicate issues can become cumbersome, and you'd help us out a lot by first checking if someone else has reported the same issue. Moreover, the issue may have already been resolved with a fix available.

2. __Share as much information as possible.__ Include Dart SDK version, version of dart_transformer_utils, etc. where appropriate. Also include steps to reproduce the bug.

__Example Bug Report:__

> Short and descriptive example bug report title
>
> A summary of the issue and the environment in which it occurs. If
> suitable, include the steps required to reproduce the bug.
>
> 1. This is the first step
> 2. This is the second step
> 3. Further steps, etc.
>
> Any other information you want to share that is relevant to the issue being
> reported. This might include the lines of code that you have identified as
> causing the bug, and potential solutions (and your opinions on their
> merits).


### Feature requests

Feature requests are welcome. But take a moment to find out whether your idea fits with the scope and aims of the project. It's up to *you* to make a strong case to convince us of the merits of this feature. Please provide as much detail and context as possible.


### Pull requests

Good pull requests - patches, improvements, new features - are a fantastic help. They should remain focused in scope and avoid containing unrelated commits.

__Please ask first__ before embarking on any significant pull request (e.g. implementing features, refactoring code, porting to a different language), otherwise you risk spending a lot of time working on something that the project's lead developers might not want to merge into the project.

Please adhere to the [Dart Style Guide][dart-style-guide] for all changes contained in your pull requests.

Adhering to the following process is the best way to get your work included in the project:

1. [Fork](http://help.github.com/fork-a-repo/) the project, clone your fork,
   and configure the remotes:

   ```bash
   # Navigate to your workspaces location
   cd ~/workspaces
   # Clone your fork of the repo into the current directory
   git clone https://github.com/<your-username>/dart_transformer_utils
   # Navigate to the newly cloned directory
   cd ~/workspaces/dart_transformer_utils
   # Assign the repo you forked from to a remote called "upstream"
   git remote add upstream https://github.com/Workiva/dart_transformer_utils
   ```

2. If you cloned a while ago, get the latest changes from upstream:

   ```bash
   git checkout *.*.*-wip
   git pull upstream *.*.*-wip
   ```

3. Create a new topic branch (off the -wip development branch you plan to submit your pull request for consideration of release inclusion) to, containing your feature, change, or fix:

   ```bash
   git checkout -b <topic-branch-name>
   ```

4. Commit your changes in logical chunks. Please adhere to these [git commit message guidelines](#git-commit-message-standards) or your code is unlikely be merged into the main project. Optionally, you can use Git's [interactive rebase](https://help.github.com/articles/interactive-rebase) feature to tidy up your commits before making them public.

5. Locally merge the upstream development branch into your topic branch:

   ```bash
   git pull upstream *.*.*-wip
   ```

6. Push your topic branch up to your fork:

   ```bash
   git push origin <topic-branch-name>
   ```

7. [Open a Pull Request](https://help.github.com/articles/using-pull-requests/)
    with a clear title and description - using the current `Workiva/dart_transformer_utils` __`*-wip`__ branch, following all the [issue guidelines](#using-the-issue-tracker) listed above.



## Git Commit Message Standards

Below you will find an example commit message that follows the guidelines we would like all contributors to follow.

```
Capitalized, short (50 chars or less) summary

+ More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: "Fix bug" and not "Fixed bug" or "Fixes bug."  This convention matches up with commit messages generated by commands like git merge and git revert.

Further paragraphs come after blank lines.

+ Bullet points are okay, too

+ Typically a hyphen, asterisk or plus-symbol is used for the bullet, followed by a
  single space, with blank lines in between, but conventions vary here

+ Use a hanging indent
```

> [Read this](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) for more information on why standardized commit message format is important.


[dart-style-guide]: https://www.dartlang.org/articles/style-guide/
