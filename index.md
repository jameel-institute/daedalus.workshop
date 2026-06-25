# daedalus.workshop: TAGLINE

*daedalus.workshop* is a template package and repository on which future
Jameel Institute packages are based.

To use this template, select *daedalus.workshop* from the drop-down menu
under **Repository template** when creating a new repository in the
Jameel Institute organisation. Replace all instances of
“daedalus.workshop” with your package name. Make sure to also:

1.  Edit the `DESCRIPTION` as appropriate with the correct package
    information;

2.  Edit the files in `R/`, `tests/`, and `vignettes/` to suit your
    package;

3.  Add spell check by running usethis::use_spell_check(lang = “en-GB”)

4.  Remove these instructions from `README.Rmd`, and re-render the `.md`
    file using `devtools::render_readme()`.

## Development tooling included

**Remove this section from your repo.**

Includes the general package structure, along with testing,
documentation, and CI infrastructure described in [R Packages
2e](https://r-pkgs.org/).

1.  Modern R formatting and linting using
    [air](https://posit-dev.github.io/air/formatter.html) and
    [jarl](https://jarl.etiennebacher.com/); much faster than *styler*
    and *lintr*, but may not have some functionality (such as replacing
    assignment operators, or catching some lints). We still use *lintr*
    in the CI workflow, so it is worth using that once in a while.

2.  Includes C++ formatting, linting, and static code analysis using
    [clang-format](https://clang.llvm.org/docs/ClangFormat.html),
    [cpplint](https://github.com/cpplint/cpplint), and
    [cppcheck](https://cppcheck.sourceforge.io/). Remember to replace
    the template package name with the names of files to be processed in
    the C++ linting shell script under `scripts/format-lnt-cpp.sh`. Or
    remove this script and associated command from the Makefile (see
    next).

3.  All formatting and linting workflows are nicely bundled into a
    Makefile. Install `make` on your system, and run `make <command>` to
    format-lint R, C++, or both.

``` sh
# both R and C++, using fast tools for R (air, jarl)
make format-lint

# only R or C++
make format-lint-r

make format-lint-cpp
```

4.  Includes LLM-associated directories in Rbuildignore.

## Installation

**NOTE:** Remove or comment out installation sources as appropriate.

You can install the development version of daedalus.workshop from the
Jameel Institute R-universe with:

``` r

# installation from R-universe
# install.packages(
#   "daedalus.workshop", 
#   repos = c(
#     "https://jameel-institute.r-universe.dev", "https://cloud.r-project.org"
#   )
# )
```

or from GitHub [GitHub](https://github.com/) with:

``` r

# install.packages("pak")
# pak::pak("jameel-institute/daedalus.workshop")
```

## Quick start

Add a simple example of using the package’s main feature(s) here, with a
minimum amount of code. If preparatory or plotting steps are needed,
prefer to hide them to keep focus on the package functionality.

## Related projects

Add information and links to related projects, such as research papers
or packages, here.

## References

Space for references: REMOVE this text.
