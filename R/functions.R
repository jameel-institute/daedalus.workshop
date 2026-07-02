#' Generate all workshop materials
#'
#' Generates all workshop materials in the current working directory.
#'
#' @return Nothing; called only for side-effects of drafting and rendering
#' Rmarkdown documents for real-time pandemic response workshop materials.
#'
#' @param country description
#'
#' @param disease
#'
#' @param r0
#'
#' @param t0
#'
#' @param horizon
#'
#' @param n_samples
#'
#' @param render
#'
#' @export
make_materials <- function(
  country = "GBR",
  disease = "sars_cov_1",
  r0 = 3.0,
  t0 = 30,
  horizon = 100,
  n_samples = 10,
  render = TRUE
) {
  cli::cli_inform(
    "Generating workshop materials at dir {.file {here::here()}}"
  )

  # makes handout
  rmarkdown::draft(
    "handout",
    "handout",
    "daedalus.workshop",
    TRUE,
    edit = FALSE
  )

  if (render) {
    rmarkdown::render(
      file.path("handout", "handout.Rmd"),
      params = list(
        country = country,
        base_disease = disease,
        t0 = t0,
        horizon = horizon,
        n_samples = n_samples
      )
    )
  }

  # makes phase 1 presentation (may not be used)
  # rmarkdown::draft(
  #   "pres_phase_01", "pres_phase_01", "daedalus.workshop", TRUE
  # )
  # rmarkdown::render(
  #   file.path("pres_phase_01", "pres_phase_01.Rmd"),
  #   params = list(
  #     country = country
  #   )
  # )

  # # makes phase 2 presentation script only
  # rmarkdown::draft(
  #   "pres_phase_02", "pres_phase_02", "daedalus.workshop", TRUE
  # )
}

#' Theme for handout figures
#'
#' @return A `ggplot2` theme function that can be appended to a ggplot object.
#'
#' @export
theme_eppi <- function() {
  ggplot2::theme_bw(base_size = 24, base_family = "Arial") +
    ggplot2::theme(
      legend.position = "top",
      panel.grid.major = ggplot2::element_line(
        colour = "grey"
      ),
      panel.grid.minor = ggplot2::element_line(
        colour = "grey",
        linetype = "dashed"
      )
    )
}

#' Make table of sector GVA and contacts
#'
#' @param country
#'
#' @return A `knitr::kable` table.
#'
#' @export
make_sector_table <- function(country) {
  country <- daedalus::daedalus_country(country)

  gva <- daedalus::get_data(country, "gva")
  gva_display <- scales::comma(gva, 1)

  gva_display[gva < 1] <- scales::comma(gva[gva < 1], 0.1)

  contacts <- round(daedalus::get_data(country, "contacts_workplace"), 1L)

  sector_names <- daedalus.data::econ_sector_names
  sector_names[45L] <- "Activities of households as employers"

  df <- tibble::tibble(
    economic_sector = sector_names,
    gva = gva_display,
    contacts = contacts
  )

  col_names <- c(
    "Economic sector",
    "Daily GVA ($M)",
    "Workplace contacts"
  )

  knitr::kable(df, col.names = col_names)
}

#' @export
make_hcap_breaches_table <- function(tables_out) {
  df <- get_table(FILE_HOSP_OVERFLOW_RISK, tables_out)
  df$hcap_exceeded_pct <- scales::percent(df$hcap_exceeded_pct)

  df <- dplyr::mutate(
    df,
    response = dplyr::case_when(
      response == "none" ~ NAMES_PRECANNED_NPIS["unmitigated"],
      response == "school_closures" ~ NAMES_PRECANNED_NPIS["school_closures"],
      response == "economic_closures" ~
        NAMES_PRECANNED_NPIS["business_closures"],
      response == "elimination" ~ NAMES_PRECANNED_NPIS["S+B closures"]
    )
  )

  col_names <- c(
    "Mitigation response strategy",
    "Hospital capacity exceeded (%)"
  )

  knitr::kable(df, col.names = col_names)
}

#' @export
make_deaths_by_age_table <- function(tables_out) {
  df <- get_table(FILE_DEATHS_BY_AGE, tables_out)

  df <- dplyr::mutate(
    df,
    response = dplyr::case_when(
      response == "unmitigated" ~ NAMES_PRECANNED_NPIS["unmitigated"],
      response == "school_closures" ~ NAMES_PRECANNED_NPIS["school_closures"],
      response == "business_closures" ~
        NAMES_PRECANNED_NPIS["business_closures"],
      response == "S+B closures" ~ NAMES_PRECANNED_NPIS["S+B closures"]
    )
  )

  df <- df_cols_with_commas(df)

  col_names <- c(
    "Mitigation response strategy",
    "Age group",
    "Median (50th percentile)",
    "25th percentile",
    "75th percentile"
  )

  knitr::kable(df, col.names = col_names)
}

#' @export
make_domain_costs_table <- function(tables_out) {
  df <- get_table(FILE_COST_BY_RESPONSE, tables_out)

  df <- dplyr::mutate(
    df,
    response = dplyr::case_when(
      response == "unmitigated" ~ NAMES_PRECANNED_NPIS["unmitigated"],
      response == "school_closures" ~ NAMES_PRECANNED_NPIS["school_closures"],
      response == "business_closures" ~
        NAMES_PRECANNED_NPIS["business_closures"],
      response == "S+B closures" ~ NAMES_PRECANNED_NPIS["S+B closures"]
    ),
    domain = dplyr::case_when(
      domain == "economic" ~ "Economic",
      domain == "education" ~ "Education",
      domain == "lfie_value" ~ "Life years"
    )
  )

  df <- df_cols_with_commas(df)

  col_names <- c(
    "Mitigation response strategy",
    "Cost domain",
    "Median (50th percentile)",
    "25th percentile",
    "75th percentile"
  )

  knitr::kable(df, col.names = col_names)
}

#' @export
make_econ_cost_table <- function(tables_out) {
  df <- get_table(FILE_ECON_COST_BREAKDOWN, tables_out)

  df <- dplyr::mutate(
    df,
    response = dplyr::case_when(
      response == "unmitigated" ~ NAMES_PRECANNED_NPIS["unmitigated"],
      response == "school_closures" ~ NAMES_PRECANNED_NPIS["school_closures"],
      response == "business_closures" ~
        NAMES_PRECANNED_NPIS["business_closures"],
      response == "S+B closures" ~ NAMES_PRECANNED_NPIS["S+B closures"]
    ),
    cost_type = dplyr::case_when(
      cost_type == "economic_cost_closures" ~ "Closures",
      cost_type == "economic_cost_absences" ~ "Absences"
    )
  )

  df <- df_cols_with_commas(df)

  col_names <- c(
    "Mitigation response strategy",
    "Cost type",
    "Median (50th percentile)",
    "25th percentile",
    "75th percentile"
  )

  knitr::kable(df, col.names = col_names)
}

#' @export
df_cols_with_commas <- function(df) {
  # assumes data frame has cols "pctl_50" etc

  df <- dplyr::mutate(
    df,
    dplyr::across(
      dplyr::matches("pctl"),
      function(x) {
        x_disp <- scales::comma(x, 1)
        x_disp[x < 1] <- scales::comma(x[x < 1], 0.1)

        x_disp
      }
    )
  )

  df
}
