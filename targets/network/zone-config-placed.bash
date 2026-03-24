#!/usr/bin/env blarg

REPO_PATH="${REPO_CONFIG_DIR}/firewalld/secure-lappy.xml"
INSTALL_PATH=/etc/firewalld/zones/secure-lappy.xml

satisfied_if() {
  # we would use `files_are_same`, however `/etc/firewalld` is only readable by root and
  # that would cause a `sudo` prompt
  checkpoint_is_current "${REPO_PATH}"
}

apply() {
  as_root cp "${REPO_PATH}" "${INSTALL_PATH}"
  as_root firewall-cmd --reload
  checkpoint_success
}
