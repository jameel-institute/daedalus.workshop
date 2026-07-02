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

#' @name constants
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

#' Read a local CSV file
#'
#' @param file Filename.
#'
#' @param tables_out Directory.
#'
#' @export
get_table <- function(file, tables_out) {
  df <- utils::read.csv(
    file.path(tables_out, file)
  )

  df
}
