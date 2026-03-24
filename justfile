[private]
_default:
    @just --list --list-submodules

# Apply configuration to local machine
apply:
    #!/usr/bin/env bash
    set -euo pipefail

    source_envrc() {
      # define some dummy functions to prevent errors
      strict_env() {
        true
      }
      PATH_add() {
        true
      }
      source .envrc
    }

    export PATH="${PWD}/bin:${PATH}"
    if [ "${PUBLIC_EMAIL:-}" = "" ]; then
        # this is running on a machine that doesn't have direnv configured
        source_envrc
    fi
    blarg --verbose targets/main.bash

# Run pre-commit on all files
lint:
    pre-commit run --all --show-diff-on-failure --color always
