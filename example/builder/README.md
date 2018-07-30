Most of our code generation plays nicely with the restrictions of the `build` package, and there are some new things we can take advantage of.

---

_(I won't include these in my comment, but for the team's sake, I'll include them here)_

Methodology: take transformer output and rearrange it into a `.g.dart` file that's feasible for the `build` package to produce, then turn off the transformer and run it.
- Things I've verified in Dartium/dart2js/DDC:
  - standard component declaration
    - Requires *very* minimal boilerplate changes
      ```diff
       @Factory()
      -UiFactory<FooProps> Foo;
      +UiFactory<FooProps> Foo = $Foo;
      ```
  - component class inheritance
  - component class inheritance w/ non-abstract superclass w/ generic prop params
- Things that will still work but may look a little different
  - instantiating component classes directly 
- Things that still need solutions
  - prop mixins (see below)
  - prop class inheritance (see below)
