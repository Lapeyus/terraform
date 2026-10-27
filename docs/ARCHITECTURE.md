# Architecture

This document explains the design choices behind the modules and the release pipeline. See the
[README](../README.md) for usage.

## Module design

### One resource type per module, many instances per call

Every module wraps a single Google Cloud resource type and accepts a collection of objects (`list(object)` or
`map(object)`), iterated with `for_each`. The intent is that an environment layout is described as data (in
`.tfvars` or locals) and the same few module calls create all of it. Optional attributes use Terraform's `optional()`
and are passed to the provider with `try(..., null)` or a module-level default, so only the fields a caller sets are
sent.

`for_each` keys:

| Module | Key | Consequence |
|---|---|---|
| `google_folder` | map key | renaming a key recreates the folder |
| `google_project` | `environments[].name` | one folder + project per environment |
| `google_compute_network` | `networks[].name` | network names must be unique across environments in one call |
| `google_compute_subnetwork` | `sub_networks[].name` | same, for subnet names |
| `google_compute_firewall` | list index | reordering the list recreates rules |
| `google_project_service` | `count` index | reordering the list disables/re-enables APIs |

### Implicit project wiring by naming convention

`google_project` builds the project ID as `<project_name>-<env>-<random_id>`. The network, subnetwork and firewall
modules rebuild the same string from their own `project_name`, `random_id` and each item's `env`. There is no output
from `google_project` that feeds them, so:

- the caller must pass identical `project_name` and `random_id` values to all of them;
- Terraform cannot infer the dependency; callers need `depends_on = [module.<projects>]` (or must already have the
  projects) for the first apply to succeed.

### Layered folders

Terraform cannot express a recursive resource, so `google_folder` unrolls the hierarchy into ten resources,
`layer1_folders` to `layer10_folders`. An entry with `external_parent_id` lands in layer 1; an entry whose
`parent_entry_key` points at a layer-N key lands in layer N+1. Entries deeper than ten levels, or whose parent key does
not exist, are silently ignored. `display_name` defaults to the map key.

### Per-environment folders in `google_project`

`google_project` creates a folder named after each environment directly under `attach_point` and places that
environment's project inside it, then flattens `environments[].services` into one `google_project_service` per
(environment, API) pair. APIs are left enabled on destroy by default.

## Release pipeline

Two workflows in `.github/workflows/`, both triggered only by changes under `modules/`:

**`terraform-ci.yml`** (every branch except `main`): computes the modules changed in the last commit, then runs
`terraform validate`, `terraform fmt -check`, `tflint`, `checkov` and any `modules/<m>/tests/*.sh` on each.

**`publish-terraform-module.yml`** (`main`, or manual dispatch):

1. Lists modules changed between `HEAD~1` and `HEAD`.
2. Creates `<module>.tar.gz` from each module directory.
3. Picks the version: the first `X.Y.Z` in the last commit message; otherwise the newest `<module>-v*` tag with the
   patch number incremented; otherwise `0.0.1`.
4. Runs `gh release create <module>-v<version> <module>.tar.gz --generate-notes`, authenticated with the `PAT`
   repository secret.

Consumers can pin either the Git tag (`?ref=<module>-vX.Y.Z` with a `//modules/<module>` subdirectory) or download the
release tarball.

Caveats of this design:

- Only the last commit of a push is inspected, so a multi-commit push can skip modules.
- A semver in the commit message applies to every module changed in that commit.
- The "exit if no changes" step only exits its own step; the job continues, and later steps simply loop over an empty
  list.
- See the README's Tests and Status sections for the validate failures in CI and in two modules.
