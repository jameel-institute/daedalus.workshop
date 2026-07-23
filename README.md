
<!-- README.md is generated from README.Rmd. Please edit that file -->

# daedalus.workshop: Generate materials for pandemic response workshops using *daedalus*

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R build
status](https://github.com/jameel-institute/daedalus.workshop/workflows/R-CMD-check/badge.svg)](https://github.com/jameel-institute/daedalus.workshop/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jameel-institute/daedalus.workshop/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jameel-institute/daedalus.workshop?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/daedalus.workshop)](https://CRAN.R-project.org/package=daedalus.workshop)
<!-- badges: end -->

*daedalus.workshop* is a package that helps to prepare materials for
pandemic response workshops that use the *daedalus* family of packages.

## Installation

<!-- You can install the development version of daedalus.workshop from the Jameel Institute R-universe with:
&#10;```r
# installation from R-universe
# install.packages(
#   "daedalus.workshop", 
#   repos = c(
#     "https://jameel-institute.r-universe.dev", "https://cloud.r-project.org"
#   )
# )
``` -->

You can install this package from [GitHub](https://github.com/) with:

``` r
install.packages("pak")
pak::pak("jameel-institute/daedalus.workshop")
```

## Quick start

*daedalus.workshop* can be used with the main function,
`make_materials()`, which prepares directories and workshop-relevant
outputs in the current working directory.

``` r
# code not run
# supports some country parameters
make_materials(
  country = "GBR", disease = "influenza_2009",
  t0 = 30, horizon = 100,
  n_samples = 25,
  render = TRUE
)
```

See the [“Get started” page in the package
documentation](articles/daedalus.workshop.html) for more on modifying
outputs.

## Related projects

- [*daedalus*](https://github.com/jameel-institute/daedalus.git) and
  family of packages for integrated epidemiological-economic modelling.

- The organisation of *daedalus.workshop* draws from the [Epiverse-TRACE
  package *episoap*](https://epiverse-trace.github.io/episoap/), but the
  core aim is quickly generating literate programming material from a
  template rather than a fully reproducible report.
