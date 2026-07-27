# Make economic costs breakdown table

Make economic costs breakdown table

## Usage

``` r
make_econ_cost_table(tables_out, currency = "$")
```

## Arguments

- tables_out:

  Location to table outputs.

- currency:

  A string for the currency or currency symbol to include in the column
  header. Default to the US dollar symbol "\$".

## Value

A [`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) table.
