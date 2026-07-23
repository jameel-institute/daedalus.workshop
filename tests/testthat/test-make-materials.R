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

test_that("make_materials() passes the requested currency to the handout only", {
  withr::with_tempdir({
    make_materials(country = "GBR", currency = "£", render = FALSE)

    handout_lines <- readLines(file.path("handout", "handout.Rmd"))
    expect_true(any(grepl('"£"', handout_lines, fixed = TRUE)))

    pres_lines <- readLines(file.path("pres_phase_02", "pres_phase_02.Rmd"))
    expect_false(any(grepl('"£"', pres_lines, fixed = TRUE)))
  })
})

test_that("make_materials() errors on invalid arguments", {
  withr::with_tempdir({
    expect_snapshot(error = TRUE, make_materials(t0 = -1, render = FALSE))
    expect_snapshot(
      error = TRUE,
      make_materials(t0 = 30, horizon = 10, render = FALSE)
    )
    expect_snapshot(error = TRUE, make_materials(n_samples = 1, render = FALSE))
    expect_snapshot(
      error = TRUE,
      make_materials(workshop_name = 123, render = FALSE)
    )
    expect_snapshot(error = TRUE, make_materials(date = 2024, render = FALSE))
    expect_snapshot(error = TRUE, make_materials(currency = 1, render = FALSE))
  })
})

test_that("make_materials() errors on an unrecognised country or disease", {
  withr::with_tempdir({
    expect_snapshot(
      error = TRUE,
      make_materials(country = "ZZZ", render = FALSE)
    )
    expect_snapshot(
      error = TRUE,
      make_materials(disease = "not_a_disease", render = FALSE)
    )
  })
})

test_that("make_materials() cleans up output directories on error", {
  withr::with_tempdir({
    local_mocked_bindings(
      render = function(...) stop("boom"),
      .package = "rmarkdown"
    )

    expect_snapshot(
      error = TRUE,
      make_materials(country = "GBR", render = TRUE)
    )

    expect_false(dir.exists("handout"))
    expect_false(dir.exists("pres_phase_02"))
  })
})

test_that("make_materials() produces rendered pdf and html output", {
  skip_if_not(tinytex::is_tinytex())

  withr::with_tempdir({
    make_materials(
      country = "GBR",
      t0 = 1,
      horizon = 5,
      n_samples = 10,
      render = TRUE
    )

    handout_pdf <- file.path("handout", "handout.pdf")
    pres_html <- file.path("pres_phase_02", "pres_phase_02.html")

    expect_true(file.exists(handout_pdf))
    expect_gt(file.size(handout_pdf), 0)
    expect_true(file.exists(pres_html))
    expect_gt(file.size(pres_html), 0)
  })
})
