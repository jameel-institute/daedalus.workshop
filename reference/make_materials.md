# Generate all workshop materials

Generates all workshop materials in the current working directory.

## Usage

``` r
make_materials(
  country = "GBR",
  disease = "sars_cov_1",
  t0 = 30,
  horizon = 100,
  final_horizon = horizon * 2,
  n_samples = 10,
  workshop_name = "Pandemic Response Workshop",
  date = as.character(Sys.Date()),
  currency = "$",
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

- final_horizon:

  The time horizon for the final phase of the exercise, when
  participants are shown projections under their chosen mitigation
  strategy. This should be a value \> `horizon`, and defaults to 2x
  horizon.

- n_samples:

  The number of samples for parameter uncertainty. Default 10.

- workshop_name:

  The workshop name. Intended to be used as a sub-title.

- date:

  The workshop date as a string. Defaults to the current date.

- currency:

  A string for the currency name or symbol to be used. A symbol is
  preferred as the final use is in the form `"<symbol>M"` to indicate
  millions in `currency`.

- render:

  Whether the drafted Rmarkdown document should be rendered.

## Value

Nothing; called only for side-effects of drafting and rendering
Rmarkdown documents for real-time pandemic response workshop materials.
