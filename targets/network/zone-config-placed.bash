#!/usr/bin/env blarg

REPO_PATH="${REPO_CONFIG_DIR}/firewalld/secure-lappy.xml"
INSTALL_PATH=/etc/firewalld/zones/secure-lappy.xml

satisfied_if() {
  files_are_same "${INSTALL_PATH}" "${REPO_PATH}"
}

apply() {
  as_root cp "${REPO_PATH}" "${INSTALL_PATH}"
  as_root firewall-cmd --reload
}
