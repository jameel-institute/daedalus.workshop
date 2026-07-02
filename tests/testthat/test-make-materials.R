test_that("make_materials() drafts an expanded handout Rmd file", {
  withr::with_tempdir(
    {
      make_materials(country = "GBR", render = FALSE)

      handout_file <- file.path("handout", "handout.Rmd")
      expect_true(file.exists(handout_file))

      # knit_expand() placeholders should be fully substituted, none left over
      handout_lines <- readLines(handout_file)
      expect_false(any(grepl("{{", handout_lines, fixed = TRUE)))

      rendered_files <- list.files(
        ".",
        pattern = "\\.(pdf|html)$",
        recursive = TRUE
      )
      expect_length(rendered_files, 0)
    }
  )
})

test_that("make_materials() drafts an expanded phase 2 presentation Rmd file", {
  withr::with_tempdir(
    {
      make_materials(country = "GBR", render = FALSE)

      pres_file <- file.path("pres_phase_02", "pres_phase_02.Rmd")
      expect_true(file.exists(pres_file))

      pres_lines <- readLines(pres_file)
      expect_false(any(grepl("{{", pres_lines, fixed = TRUE)))
    }
  )
})
