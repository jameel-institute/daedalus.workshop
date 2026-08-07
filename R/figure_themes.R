#' Theme for handout figures
#'
#' @name figure_themes
#' @rdname figure_themes
#'
#' @return A `ggplot2` theme function that can be appended to a ggplot object.
#'
#' @export
theme_eppi <- function() {
  ggplot2::theme_bw(base_size = 24) +
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

#' @name figure_themes
#'
#' @export
theme_explainer <- function() {
  ggplot2::theme_classic(base_size = 16) +
    ggplot2::theme(
      axis.line.x = ggplot2::element_line(
        arrow = grid::arrow(
          length = ggplot2::unit(0.3, "cm"),
          ends = "last",
          type = "closed"
        )
      ),
      axis.line.y = ggplot2::element_line(
        arrow = grid::arrow(
          length = ggplot2::unit(0.3, "cm"),
          ends = "last",
          type = "closed"
        )
      ),
      axis.title.x = ggplot2::element_text(
        hjust = 1,
        vjust = 1
      ),
      axis.title.y = ggplot2::element_text(
        hjust = 1,
        vjust = 0
      ),
      axis.text.x = ggplot2::element_text(hjust = 0),
      axis.ticks.x = ggplot2::element_line(),
      axis.ticks.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      legend.position = "top"
    )
}
