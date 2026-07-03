# Generate all workshop materials

Generates all workshop materials in the current working directory.

## Usage

``` r
make_materials(
  country = "GBR",
  disease = "sars_cov_1",
  t0 = 30,
  horizon = 100,
  n_samples = 10,
  workshop_name = "Pandemic Response Workshop",
  render = TRUE
)
```

## Arguments

- country:

  The country name or three-letter ISO code.

- disease:

  The disease name. Must be one of
  [daedalus.data::epidemic_names](https://jameel-institute.github.io/daedalus.data/reference/epidemic_data.html).

- t0:

  The current time-point. Defaults to 30 days.

- horizon:

  The time horizon for projections. Defaults to 100 days.

- n_samples:

  The number of samples for parameter uncertainty. Default 10.

- workshop_name:

  The workshop name. Intended to be used as a sub-title.

- render:

  Whether the drafted Rmarkdown document should be rendered.

## Value

Nothing; called only for side-effects of drafting and rendering
Rmarkdown documents for real-time pandemic response workshop materials.
