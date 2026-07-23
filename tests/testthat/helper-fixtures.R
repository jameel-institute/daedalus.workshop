# Creates a `tables_out` directory populated with the CSV files expected by
# make_hcap_breaches_table(), make_deaths_by_age_table(),
# make_domain_costs_table(), and make_econ_cost_table(), mirroring the
# columns and response/domain labels written by
# inst/rmarkdown/templates/handout/skeleton/rmdchunks/projections.Rmd.
local_tables_out <- function(env = parent.frame()) {
  dir <- withr::local_tempdir(.local_envir = env)

  responses <- c(
    "unmitigated",
    "school_closures",
    "business_closures",
    "S+B closures"
  )

  write.csv(
    data.frame(
      response = c(
        "none",
        "school_closures",
        "economic_closures",
        "elimination"
      ),
      hcap_exceeded_pct = c(0, 0.25, 0.5, 1)
    ),
    file.path(dir, FILE_HOSP_OVERFLOW_RISK),
    row.names = FALSE
  )

  write.csv(
    data.frame(
      response = rep(responses, each = 4),
      age_group = rep(c("0-4", "5-19", "20-64", "65+"), times = 4),
      pctl_50 = 100,
      pctl_25 = 50,
      pctl_75 = 150
    ),
    file.path(dir, FILE_DEATHS_BY_AGE),
    row.names = FALSE
  )

  write.csv(
    data.frame(
      response = rep(responses, each = 3),
      domain = rep(c("economic", "education", "life_value"), times = 4),
      pctl_50 = 1000,
      pctl_25 = 500,
      pctl_75 = 1500
    ),
    file.path(dir, FILE_COST_BY_RESPONSE),
    row.names = FALSE
  )

  write.csv(
    data.frame(
      response = rep(responses, each = 2),
      cost_type = rep(
        c("economic_cost_closures", "economic_cost_absences"),
        times = 4
      ),
      pctl_50 = 100,
      pctl_25 = 50,
      pctl_75 = 150
    ),
    file.path(dir, FILE_ECON_COST_BREAKDOWN),
    row.names = FALSE
  )

  dir
}
