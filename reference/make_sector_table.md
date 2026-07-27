# Make table of sector GVA and contacts

Make table of sector GVA and contacts

## Usage

``` r
make_sector_table(country, currency = "$")
```

## Arguments

- country:

  A country name, or a type that can be coerced to a
  `<daedalus_country>`.

- currency:

  A string for the currency or currency symbol to include in the column
  header. Defaults to the US dollar symbol "\$".

## Value

A [`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) table.
