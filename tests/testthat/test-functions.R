test_that("theme_eppi() returns a ggplot2 theme", {
  result <- theme_eppi()
  expect_s3_class(result, "theme")
})

test_that("make_sector_table() returns a knitr kable", {
  result <- make_sector_table("GBR")
  expect_s3_class(result, "knitr_kable")
})

test_that("make_hcap_breaches_table() returns a knitr kable", {
  tables_out <- local_tables_out()
  result <- make_hcap_breaches_table(tables_out)

  expect_s3_class(result, "knitr_kable")
  expect_match(
    paste(result, collapse = "\n"),
    NAMES_PRECANNED_NPIS[["business_closures"]],
    fixed = TRUE
  )
})

test_that("make_deaths_by_age_table() returns a knitr kable", {
  tables_out <- local_tables_out()
  result <- make_deaths_by_age_table(tables_out)

  expect_s3_class(result, "knitr_kable")
  expect_match(paste(result, collapse = "\n"), "65+", fixed = TRUE)
})

test_that("make_domain_costs_table() returns a knitr kable", {
  tables_out <- local_tables_out()
  result <- make_domain_costs_table(tables_out)

  expect_s3_class(result, "knitr_kable")
  expect_match(paste(result, collapse = "\n"), "1,000", fixed = TRUE)
})

test_that("make_econ_cost_table() returns a knitr kable", {
  tables_out <- local_tables_out()
  result <- make_econ_cost_table(tables_out)

  expect_s3_class(result, "knitr_kable")
  expect_match(paste(result, collapse = "\n"), "Closures", fixed = TRUE)
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
