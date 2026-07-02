#' Package constants
#'
#' @name constants
#' @rdname constants
#'
#' @keywords constants
#'
#' @examples
#'
#' FILE_HOSP_OVERFLOW_RISK
#'
#' FILE_DEATHS_BY_AGE
#'
#' FILE_COST_BY_RESPONSE
#'
#' FILE_ECON_COST_BREAKDOWN
#'
#' @export
FILE_HOSP_OVERFLOW_RISK <- "table_hcap_breaches.csv"

#' @name constants
#'
#' @keywords constants
#'
#' @export
FILE_DEATHS_BY_AGE <- "table_deaths_by_age.csv"

#' @name constants
#'
#' @keywords constants
#'
#' @export
FILE_COST_BY_RESPONSE <- "table_cost_by_response.csv"

#' @name constants
#'
#' @keywords constants
#'
#' @export
FILE_ECON_COST_BREAKDOWN <- "table_econ_cost_breakdown.csv"

#' @ name constants
#'
#' @keywords constants
#'
#' @export
NAMES_PRECANNED_NPIS <- c(
  unmitigated = "No closures (unmitigated)",
  school_closures = "School closures (severe) + business closures (light)",
  business_closures = "Business closures (light)",
  `S+B closures` = "School and business closures (severe)"
)

#' @export
get_table <- function(x, tables_out) {
  df <- read.csv(
    file.path(tables_out, x)
  )

  df
}
