#' Generate all workshop materials
#'
#' Generates all workshop materials in the current working directory.
make_materials <- function(
  country = "GBR",
  disease = "sars_cov_1",
  r0 = 3.0,
  t0 = 30,
  horizon = 100,
  n_samples = 10
) {
  cli::cli_inform(
    "Generating workshop materials at dir {.file {here::here()}}"
  )

  # makes figures - unsure if wanted
  # make_projections(country, disease, r0, t0, t_end)

  # makes handout
  rmarkdown::draft(
    "handout",
    "handout",
    "daedalus.workshop",
    TRUE
  )
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
