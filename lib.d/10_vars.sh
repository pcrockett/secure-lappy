# shellcheck shell=bash

# TODO: use these for git config
# if [ "${PUBLIC_EMAIL:-}" == "" ]; then
#   panic "Missing \$PUBLIC_EMAIL"
# fi

# if [ "${PUBLIC_NAME:-}" == "" ]; then
#   panic "Missing \$PUBLIC_NAME"
# fi

export STATE_DIR="${HOME}/.local/state/lappy"
export REPO_CONFIG_DIR="${BLARG_MODULE_DIR}/config"
