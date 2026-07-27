#' Check for LaTeX
#'
#' @return Warning side-effects informing users about missing LaTeX
#' and specifically PdfLaTeX.
#'
#' @keywords internal
check_pdflatex <- function() {
  latex_typesetters <- c("pdflatex", "xelatex", "lualatex")

  ltx_avail <- Sys.which(latex_typesetters)
  any_avail <- any(nzchar(ltx_avail))

  if (any_avail) {
    has_pdflatex <- nzchar(ltx_avail["pdflatex"])
    if (!has_pdflatex) {
      which_available <- latex_typesetters[nzchar(ltx_avail)] # nolint used cli

      cli::cli_warn(
        "pdflatex was not found on this system --- there may be errors in PDF \
        output rendering. Other LaTeX typsetters are available on this system: \
        {.str {which_available}}.
        Set the LaTeX engine to the typesetter available.
        See the {.pkg rmarkdown} documentation on LaTeX options: \
        https://pkg.yihui.org/rmarkdown-book/pdf-document#latex-options"
      )
    }
  } else {
    cli::cli_warn(
      "No LaTeX installation detected on this system; PDF output probably \
      cannot be rendered. Try setting the argument `render = FALSE`, and \
      render documents manually.
      Consider installing the package {.pkg tinytex}."
    )
  }
}
