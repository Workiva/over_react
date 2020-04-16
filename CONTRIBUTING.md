# Contributing to over_react

- [__Support, Opening Issues__](#support-opening-issues)
- [__Contributing Changes__](#contributing-changes)
    - [Coding Standards](#coding-standards)
    - [Git Commit Message Standards](#git-commit-message-standards)
- [__Code Review Process and Merging Requirements__](#code-review-process-and-merging-requirements)
    - [Minimum Required Review](#minimum-required-review)
    - [Review Types](#review-types)
    - [Manual Testing Criteria](#manual-testing-criteria)

---

## Support, Opening Issues
Have a bug to report or an improvement/feature to request? Please
[open an issue](https://github.com/Workiva/over_react/issues/new) and fill out
the issue template with as much detail as necessary.

###### Workiva Employees
> __Contact us on Slack:__ [\#support-ui-platform](https://workiva.slack.com/app_redirect?channel=support-ui-platform)

Have a bug to report or an improvement/feature to request?
Please contact us on Slack or [create a JIRA ticket](https://jira.atl.workiva.net/secure/CreateIssue!default.jspa?pid=CPLAT&component=over_react)
and fill out the description with as much detail as necessary.

## Contributing Changes
If you're contributing a change to over_react, please follow this process: (and
thank you!)

1. Before you start working on a larger contribution (e.g. implementing features, 
    refactoring code, etc.), you should get in touch with us first so that
    we can help out and possibly guide you. 

    Coordinating up front makes it much easier to avoid frustration later on.

1. Commit your changes in logical chunks. Please adhere to these
   [coding standards](#coding-standards) and
   [Git commit message guidelines](#git-commit-message-standards).

1. Write tests for your changes.
   - There are very few exceptions.
   - If you're having trouble, please reach out for testing advice. We'll be
  	 happy to help!
1. Open a PR against the `master` branch and fill out the template with as much
   detail as necessary.
1. See instructions in PR template for getting review on your changes.


### Coding Standards
A lot can be gained by writing code in a consistent way. Moreover, always
remember that code is written and maintained by _people_. Ensure your code is
descriptive, well commented, and approachable by others.

- Dart
    - Adhere to the official [Dart Style Guide][dart-style-guide]. _Please take the time to read it if you have never done so._
    - Format your code using `pub run dart_dev format` (this is enforced by a CI check)


### Git Commit Message Standards

Read [this short post][git-commit-messages] for commit message guidelines (and more information on why standardized commit message format is important).

[dart-style-guide]: https://www.dartlang.org/articles/style-guide/
[git-commit-messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

## Code Review Process and Merging Requirements
For a PR to merge, it must:
1. Receive the minimum required review
    - High-risk PRs (e.g., large number of lines changed, touching areas at high risk of regression, complex changes)
        - __Two__ +1s
        - QA +1 by someone other than the commit author
    - All other PRs (including trivial changes)
        - +1
        - QA +1 by someone other than the commit author

    ___NOTE: It does not matter whether the "+1" and "QA +1" come from the same reviewer (e.g., via a "+10").___
2. Pass the merge checklist outlined in the PR template


### Review Types

- __+1__
    - Reviewing code for correctness, robustness, maintainability, performance, etc.
    - Reviewing tests for coverage, thoroughness, and clarity
        - _This responsibility is shared with QA reviewers_
- __QA +1__
    - Verifying that adequate tests have been has been added, and reviewing them
      for coverage, thoroughness, and clarity
        - _This responsibility is shared with code reviewers_
    - Verifying automated tests pass in CI (this is often done automatically by Rosie).
    - Performing manual testing instructions, if they exist. (see criteria in the next section)
    - __Must be done by someone other than the commit author.__
- __+10__
    - Exactly equivalent to performing both a "+1" and a "QA +1", just combined into one step.

## Manual Testing Criteria
Manual testing instructions (done as part of a "QA +1") should be included for the following scenarios.

__If none of these apply, then manual testing instructions may be omitted.__

- When manual testing can help uncover areas of missed test coverage (in terms of certain scenarios and states, not just lines covered). 

    _Examples:_
    - Running CLIs on several different projects to help catch edge-cases.
    - Hammering on UI elements to ensure they react gracefully to different sequences of user input.
    
- When tests run in CI do not fully exercise the desired behavior. 

    _Examples:_
    - Changes were made in areas of the code that shouldn't be tested, like examples.
    - Changes were made in areas of the code that are very difficult to fully test, and are more efficient to test manually.
    - Changes need to be consumed in a certain library, harness, or deploy to be fully tested.
    
- When CI tests do not fully protect against regressions to existing behavior. 

    _Examples:_
    - Test coverage around code impacted by changes is sparse.
    - Changes need to be integrated with another library to ensure nothing broke.
    
- When changes are made to CI itself, and need to be manually verified. 

    _Examples:_
    - Test runner was updated.
    - New test suites were added.
