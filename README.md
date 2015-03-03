# objcheck - an ObjC port of the QuickCheck unit test framework

# HOMEPAGE

http://www.yellosoft.us/quickcheck

# EXAMPLE

```
$ make
$ ./example
*** Failed!
-1243731847
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
```

See [example.m](https://github.com/mcandre/objcheck/blob/master/example.m) for more information.

# REQUIREMENTS

* `clang`, such as from [Xcode](https://developer.apple.com/xcode/)

## Optional

* [Ruby](https://www.ruby-lang.org/) 2+
* [Bundler](http://bundler.io/)
* [Cucumber](http://cukes.info/)
* [Guard](http://guardgem.org/)
* [aspelllint](https://github.com/mcandre/aspelllint)

# DEVELOPMENT

## Test

Ensure the example script works as expected:

```
$ bundle
$ cucumber
Feature: Run example tests

  Scenario: Running example tests            # features/run_example_tests.feature:3
    Given the program has finished           # features/step_definitions/steps.rb:1
    Then the output is correct for each test # features/step_definitions/steps.rb:7

1 scenario (1 passed)
2 steps (2 passed)
0m0.612s
```

## Spell Check

```
$ aspelllint
...
```

## Local CI

Guard can automatically run testing when the code changes:

```
$ bundle
$ guard -G Guardfile-cucumber
...
```
