# Creates a `tables_out` directory populated with the CSV files expected by
# make_hcap_breaches_table(), make_deaths_by_age_table(),
# make_domain_costs_table(), and make_econ_cost_table(), mirroring the
# columns and response/domain labels written by
# inst/rmarkdown/templates/handout/skeleton/rmdchunks/projections.Rmd.
local_tables_out <- function() {
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
    file.path(FILE_HOSP_OVERFLOW_RISK),
    row.names = FALSE
  )

  write.csv(
    data.frame(
      response = rep(responses, each = length(responses)),
      age_group = rep(
        c("0-4", "5-19", "20-64", "65+"),
        times = length(responses)
      ),
      pctl_50 = 100,
      pctl_25 = 50,
      pctl_75 = 150
    ),
    file.path(FILE_DEATHS_BY_AGE),
    row.names = FALSE
  )

  cost_domains <- c("economic", "education", "life_value")

  write.csv(
    data.frame(
      response = rep(responses, each = 3),
      domain = rep(cost_domains, times = length(responses)),
      pctl_50 = 1000,
      pctl_25 = 500,
      pctl_75 = 1500
    ),
    file.path(FILE_COST_BY_RESPONSE),
    row.names = FALSE
  )

  econ_cost_cats <- c("economic_cost_closures", "economic_cost_absences")

  write.csv(
    data.frame(
      response = rep(responses, each = 2),
      cost_type = rep(
        econ_cost_cats,
        times = length(responses)
      ),
      pctl_50 = 100,
      pctl_25 = 50,
      pctl_75 = 150
    ),
    file.path(FILE_ECON_COST_BREAKDOWN),
    row.names = FALSE
  )
}
