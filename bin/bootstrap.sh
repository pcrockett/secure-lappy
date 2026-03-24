#!/usr/bin/env bash
set -euo pipefail

# as of this writing, a base Fedora Silverblue install has at least:
#
# - curl
# - git
# - GNU coreutils
#

init() {
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
  GIT_REMOTE="${GIT_REMOTE:-ssh://git@github.com/pcrockett/secure-lappy}"
  INSTALL_DIR="${INSTALL_DIR:-${XDG_CONFIG_HOME}/secure-lappy}"
  NEEDS_REBOOT="false"
  mkdir --parent "${XDG_CONFIG_HOME}"
  cd "${XDG_CONFIG_HOME}"
}

step() {
  echo "--> $*"
}

gen_ssh_key() {
  local key_file=~/.ssh/id_ed25519
  test -f "${key_file}" || {
    step "Generating SSH key..."
    ssh-keygen -t ed25519 -f "${key_file}" -a 300
    step "SSH key generated. Add the following to your GitHub account keys:"
    echo
    cat "${key_file}.pub"
    echo
  }
}

install_packages() {
  {
    command -v just && command -v direnv
  } &>/dev/null || {
    step "Installing packages..."
    rpm-ostree install --idempotent just direnv
    step "Packages installed (reboot required)."
    NEEDS_REBOOT="true"
  }
}

clone_repo() {
  if [ -d "${INSTALL_DIR}/.git" ]; then
    git -C "${INSTALL_DIR}" pull --ff-only
  else
    step "Cloning repo..."
    git clone "${GIT_REMOTE}" "${INSTALL_DIR}"
    step "Repo cloned to ${INSTALL_DIR}"
  fi
}

populate_envrc() {
  test -f "${INSTALL_DIR}/.envrc" || {
    cp "${INSTALL_DIR}/.envrc.example" "${INSTALL_DIR}/.envrc"
  }
}

source_envrc() {
  # define some dummy functions to prevent errors
  # shellcheck disable=SC2329
  strict_env() {
    true
  }
  # shellcheck disable=SC2329
  PATH_add() {
    true
  }
  # shellcheck source=/dev/null
  source "${INSTALL_DIR}/.envrc"
}

first_apply() {
  cd "${INSTALL_DIR}"
  just apply
}

main() {
  init
  install_packages
  gen_ssh_key
  if [ "${NEEDS_REBOOT}" == "true" ]; then
    step "Reboot and run this script to continue."
    exit 0
  fi
  clone_repo
  populate_envrc
  nano "${INSTALL_DIR}/.envrc"
  source_envrc
  first_apply
  exit $?
}

main
