# make_materials() errors on invalid arguments

    Code
      make_materials(t0 = -1, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 't0' failed: Element 1 is not >= 0.

---

    Code
      make_materials(t0 = 30, horizon = 10, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 'horizon' failed: Element 1 is not >= 30.

---

    Code
      make_materials(n_samples = 1, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 'n_samples' failed: Element 1 is not >= 10.

---

    Code
      make_materials(workshop_name = 123, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 'workshop_name' failed: Must be of type 'string', not 'double'.

---

    Code
      make_materials(date = 2024, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 'date' failed: Must be of type 'string', not 'double'.

---

    Code
      make_materials(currency = 1, render = FALSE)
    Condition
      Error in `make_materials()`:
      ! Assertion on 'currency' failed: Must be of type 'string', not 'double'.

# make_materials() errors on an unrecognised country or disease

    Code
      make_materials(country = "ZZZ", render = FALSE)
    Condition
      Error in `lookup_country_name_from_code()`:
      ! `code` must be one of "ARG", "AUS", "AUT", "BEL", "BRA", "BRN", "BGR", "KHM", "CAN", "CHL", "CHN", "COL", "CRI", "HRV", "CYP", "CZE", "DNK", "EGY", "EST", "ETH", "FIN", "FRA", "DEU", "GRC", "HUN", "ISL", "IND", "IDN", "IRL", "ISR", "ITA", "JPN", "KAZ", "LAO", "LVA", "LTU", "LUX", "MYS", "MLT", "MEX", "MAR", "MMR", "NLD", "NZL", "NOR", "PER", "PHL", "POL", "PRT", "ROU", "RUS", "RWA", "SAU", "SGP", "SVK", "SVN", "ZAF", "KOR", "ESP", "SWE", "CHE", "THA", "TUN", "TUR", "GBR", "USA", or "VNM", not "ZZZ".

---

    Code
      make_materials(disease = "not_a_disease", render = FALSE)
    Condition
      Error in `daedalus::daedalus_infection()`:
      ! `name` must be one of "sars_cov_1", "influenza_2009", "influenza_1957", "influenza_1918", "sars_cov_2_pre_alpha", "sars_cov_2_omicron", or "sars_cov_2_delta", not "not_a_disease".

# make_materials() cleans up output directories on error

    Code
      make_materials(country = "GBR", render = TRUE)
    Condition
      Error in `value[[3L]]()`:
      ! `make_materials()` errored with the following error, quitting while removing output directories and contents: Error in rmarkdown::render(handout_path): boom

