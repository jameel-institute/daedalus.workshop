test_that("theme_eppi() returns a ggplot2 theme", {
  result <- theme_eppi()
  expect_s3_class(result, "theme")
})

test_that("make_sector_table() returns a knitr kable", {
  result <- make_sector_table("GBR")
  expect_s3_class(result, "knitr_kable")
})

test_that("df_cols_with_commas() returns a data.frame", {
  df <- data.frame(
    pctl_25 = c(0.5, 10, 100),
    pctl_50 = c(0.5, 20, 200),
    pctl_75 = c(0.5, 30, 300)
  )

  result <- df_cols_with_commas(df)
  expect_s3_class(result, "data.frame")
  expect_true(
    all(vapply(result, is.character, logical(1)))
  )
})
