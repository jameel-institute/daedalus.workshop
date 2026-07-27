# Changelog

## daedalus.workshop 0.0.2

This patch version:

- Allows users to pass a currency name or symbol from
  [`make_materials()`](../reference/make_materials.md);

- Edits the formatting to use the KOMA Script report class, adds page
  numbers, right aligns numbers in tables, and fixes tables overflowing
  the page.

- Adds test coverage for
  [`make_hcap_breaches_table()`](../reference/make_hcap_breaches_table.md),
  [`make_deaths_by_age_table()`](../reference/make_deaths_by_age_table.md),
  [`make_domain_costs_table()`](../reference/make_domain_costs_table.md),
  [`make_econ_cost_table()`](../reference/make_econ_cost_table.md), and
  for argument validation, currency propagation, error cleanup, and real
  PDF/HTML rendering in
  [`make_materials()`](../reference/make_materials.md). CI workflows now
  install TinyTeX to support the rendering test. The `testthat` version
  requirement in `Suggests` is bumped to `>= 3.2.0`, as the new tests
  use `local_mocked_bindings()`.

## daedalus.workshop 0.0.1

- This project now includes a
  [`NEWS.md`](https://r-pkgs.org/other-markdown.html#sec-news) file to
  inform users about changes and new features.

- Initial package function
  [`make_materials()`](../reference/make_materials.md) with templates
  for handout and phase 2 presentation, along with basic tests.
