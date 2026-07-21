#' Generate all workshop materials
#'
#' Generates all workshop materials in the current working directory.
#'
#' @return Nothing; called only for side-effects of drafting and rendering
#' Rmarkdown documents for real-time pandemic response workshop materials.
#'
#' @param country The country name or three-letter ISO code.
#'
#' @param disease The disease name. Must be one of
#' [daedalus.data::epidemic_names].
#'
#' @param t0 The current time-point. Defaults to 30 days.
#'
#' @param horizon The time horizon for projections. Defaults to 100 days.
#'
#' @param n_samples The number of samples for parameter uncertainty. Default 10.
#'
#' @param workshop_name The workshop name. Intended to be used as a sub-title.
#'
#' @param date The workshop date as a string. Defaults to the current date.
#' 
#' @param currency A string for the currency name or symbol to be used. A symbol
#' is preferred as the final use is in the form `"<symbol>M"` to indicate
#' millions in `currency`.
#'
#' @param render Whether the drafted Rmarkdown document should be rendered.
#'
#' @export
make_materials <- function(
  country = "GBR",
  disease = "sars_cov_1",
  t0 = 30,
  horizon = 100,
  n_samples = 10,
  workshop_name = "Pandemic Response Workshop",
  date = as.character(Sys.Date()),
  currency = "$",
  render = TRUE
) {
  # makes handout
  rmarkdown::draft(
    "handout",
    "handout",
    "daedalus.workshop",
    TRUE,
    edit = FALSE
  )

  handout_dir <- "handout"
  pres_dir <- "pres_phase_02"

  handout_path <- file.path(handout_dir, "handout.Rmd")
  pres_path <- file.path(pres_dir, "pres_phase_02.Rmd")

  country_name <- daedalus::daedalus_country(country)$name
  disease_name <- daedalus::daedalus_infection(disease)$name

  checkmate::assert_number(t0, lower = 0, finite = TRUE)
  checkmate::assert_number(horizon, lower = 10, finite = TRUE)
  checkmate::assert_number(n_samples, lower = 10, finite = TRUE)
  checkmate::assert_string(workshop_name)
  checkmate::assert_string(date)

  tryCatch(
    {
      # makes drafted Rmd independent of params
      writeLines(
        knitr::knit_expand(
          handout_path,
          country = country_name,
          disease = disease,
          n_samples = n_samples,
          t0 = t0,
          horizon = horizon,
          t_diff = horizon - t0,
          workshop_name = workshop_name,
          currency = currency
        ),
        handout_path
      )

      rmarkdown::draft(
        "pres_phase_02",
        "pres_phase_02",
        "daedalus.workshop",
        TRUE,
        edit = FALSE
      )

      writeLines(
        knitr::knit_expand(
          pres_path,
          country = country_name,
          disease = disease_name,
          n_samples = n_samples,
          t0 = t0,
          horizon = horizon + 100,
          t_diff = horizon - t0,
          workshop_name = workshop_name
        ),
        pres_path
      )

      if (render) {
        rmarkdown::render(handout_path)
        rmarkdown::render(pres_path)
      }
    },
    error = function(e) {
      # clean up dirs
      fs::dir_delete(handout_dir)
      fs::dir_delete(pres_dir)

      cli::cli_abort(
        "`make_materials()` errored with the following error, quitting while \
        removing output directories and contents:
        {e}"
      )
    }
  )
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
#' @param country A country name, or a type that can be coerced to a
#' `<daedalus_country>`.
#'
#' @param currency A string for the currency or currency symbol to include in
#' the column header. Default to the US dollar symbol "$".
#'
#' @return A `knitr::kable()` table.
#'
#' @export
make_sector_table <- function(country, currency = "$") {
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
    glue::glue("Daily GVA ({currency}M)"),
    "Workplace contacts"
  )

  kableExtra::row_spec(
    knitr::kable(df, col.names = col_names, align = c("l", "r", "r")),
    0,
    bold = TRUE
  )
}

#' Make hospital capacity breaches table
#'
#' @param tables_out Location to table outputs.
#'
#' @return A `knitr::kable()` table.
#'
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

  kableExtra::row_spec(
    knitr::kable(df, col.names = col_names),
    0,
    bold = TRUE
  )
}

#' Make deaths by age table
#'
#' @param tables_out Location to table outputs.
#'
#' @return A `knitr::kable()` table.
#'
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
    "Median",
    "25th percentile",
    "75th percentile"
  )

  kableExtra::row_spec(
    kableExtra::column_spec(
      knitr::kable(
        df,
        col.names = col_names,
        align = c("l", "l", "r", "r", "r")
      ),
      1,
      width = "10em"
    ),
    0,
    bold = TRUE
  )
}

#' Make domain costs table
#'
#' @param tables_out Location to table outputs.
#'
#' @param currency A string for the currency or currency symbol to include in
#' the column header. Default to the US dollar symbol "$".
#'
#' @return A `knitr::kable()` table.
#'
#' @export
make_domain_costs_table <- function(tables_out, currency = "$") {
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
      domain == "life_value" ~ "Life years"
    )
  )

  df <- df_cols_with_commas(df)

  col_names <- c(
    "Mitigation response strategy",
    "Cost domain",
    glue::glue("Median ({currency}M)"),
    glue::glue("25th percentile ({currency}M)"),
    glue::glue("75th percentile ({currency}M)")
  )

  kableExtra::row_spec(
    kableExtra::column_spec(
      knitr::kable(
        df,
        col.names = col_names,
        align = c("l", "l", "r", "r", "r")
      ),
      1,
      width = "10em"
    ),
    0,
    bold = TRUE
  )
}

#' Make economic costs breakdown table
#'
#' @param tables_out Location to table outputs.
#'
#' @param currency A string for the currency or currency symbol to include in
#' the column header. Default to the US dollar symbol "$".
#'
#' @return A `knitr::kable()` table.
#'
#' @export
make_econ_cost_table <- function(tables_out, currency = "$") {
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
    glue::glue("Median ({currency}M)"),
    glue::glue("25th percentile ({currency}M)"),
    glue::glue("75th percentile ({currency}M)")
  )
  kableExtra::row_spec(
    kableExtra::column_spec(
      knitr::kable(
        df,
        col.names = col_names,
        align = c("l", "l", "r", "r", "r")
      ),
      1,
      width = "10em"
    ),
    0,
    bold = TRUE
  )
}

#' Add commas to numeric columns
#'
#' @param df A data.frame with columns matching `"pctl"`.
#'
#' @return A data.frame with columns matching `"pctl"` converted to type
#' character and with commas added to make reading large numbers easier.
#' Numbers are rounded to the nearest ones-place, or to the nearest 10th if
#' less than 1.
#'
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
