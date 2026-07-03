# NA

The goal of this repository, called daedalus.workshop, is to hold an R
package to create documents from existing templates using literate
programming. Users should be able to use this package to generate
materials in an existing or new directory. The documents will represent
workshop materials such as handouts and presentations.

## Prior art

Refer to the following packages and repositories. If they cannot be
found locally, read the source from GitHub.

- episoap (<https://github.com/epiverse-trace/episoap/>) : this is an
  existing R package that provides similar functionality. This should be
  taken as a reference point for the implementation side of this
  package.
- Daedalus (<https://github.com/jameel-institute/daedalus>) or at
  @../daedalus : this is the Daedalus epidemiological-economic model.
  The key aim of daedalus.workshop is to create reports using the
  functionality. Examples of use cases are shown in the directory
  ‘vignettes’ within the daedalus repo.
- daedalus.compare
  (<https://github.com/jameel-institute/daedalus.compare>) or at
  @../daedalus.compare : this is an extension to the daedalus package
  which allows running multiple scenarios of infection parameters, as
  well as multiple intervention scenarios.

## Package structure

Refer to this package structure and aim to maintain this outline. This
package provides R markdown templates in @inst/rmarkdown/templates/ and
the templates available are ‘handout’, ‘pres_phase_01’, and
‘pres_phase_02’. Each template consists of a ‘skeleton.Rmd’ file in the
directory ‘skeleton’, and R markdown chunks that are inserted into the
skeleton from ‘rmdchunks’.

## Implementation rules

For any task, refer to the following rules. If any skills are not found,
query the user to install them.

- Use the skills r-package-development and testing-r-packages, from
  provider posit-dev/skills or r-lib/skills
- Always query the user for adding a new plan when new functionality is
  requested.
- New plans should be added under @plans/ query the user to create this
  directory if it does not exist. Plans should never be tracked by
  version control.
- Never run tests locally.
- Do not commit any files unless requested.
- Always credit Claude with the model version when a commit is
  requested.
- Always add a summary to the changelog in @NEWS.md when making edits.
  Scan @NEWS.md and update the contents if a new change would overwrite
  a previous change in the same version.
