[private]
_default:
    @just --list --list-submodules

# Apply configuration to local machine
apply:
    #!/usr/bin/env bash
    set -euo pipefail
    export PATH="${PWD}/bin:${PATH}"
    blarg --verbose targets/main.bash

# Run pre-commit on all files
lint:
    pre-commit run --all --show-diff-on-failure --color always
