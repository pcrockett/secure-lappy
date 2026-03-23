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

  if [ -d "${INSTALL_DIR}" ]; then
    cd "${INSTALL_DIR}"
  else
    cd "${XDG_CONFIG_HOME}"
  fi
}

step() {
  echo "--> $*"
}

gen_ssh_key() {
  local key_file=~/.ssh/id_ed25519
  test -f "${key_file}" || {
    step "Generating SSH key..."
    ssh-keygen -t ed25519 -f "${key_file}" -a 300
    step "SSH key generated. Add \`${key_file}.pub\` to your GitHub account settings."
    exit 0
  }
}

install_just() {
  command -v just &>/dev/null || {
    step "Installing just..."
    rpm-ostree install just
    step "Just installed (reboot required)."
    NEEDS_REBOOT="true"
  }
}

main() {
  init
  install_just
  gen_ssh_key
  git clone "${GIT_REMOTE}" "${INSTALL_DIR}"
  if [ "${NEEDS_REBOOT}" == "true" ]; then
    step "Reboot and run this script to continue."
    exit 0
  fi
  just apply
  exit $?
}

main
