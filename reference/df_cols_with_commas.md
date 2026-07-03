# Add commas to numeric columns

Add commas to numeric columns

## Usage

``` r
df_cols_with_commas(df)
```

## Arguments

- df:

  A data.frame with columns matching `"pctl"`.

## Value

A data.frame with columns matching `"pctl"` converted to type character
and with commas added to make reading large numbers easier. Numbers are
rounded to the nearest ones-place, or to the nearest 10th if less than
1.
