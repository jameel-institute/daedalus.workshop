# daedalus.workshop: Generate materials for pandemic response workshops using *daedalus*

*daedalus.workshop* is a package that helps to prepare materials for
pandemic response workshops that use the *daedalus* family of packages.

## Installation

You can install this package from [GitHub](https://github.com/) with:

``` r

install.packages("pak")
pak::pak("jameel-institute/daedalus.workshop")
```

## Quick start

*daedalus.workshop* can be used with the main function,
[`make_materials()`](reference/make_materials.md), which prepares
directories and workshop-relevant outputs in the current working
directory.

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
documentation](articles/daedalus.workshop.md) for more on modifying
outputs.

## Related projects

- [*daedalus*](https://github.com/jameel-institute/daedalus.git) and
  family of packages for integrated epidemiological-economic modelling.

- The organisation of *daedalus.workshop* draws from the [Epiverse-TRACE
  package *episoap*](https://epiverse-trace.github.io/episoap/), but the
  core aim is quickly generating literate programming material from a
  template rather than a fully reproducible report.
