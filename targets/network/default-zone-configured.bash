#!/usr/bin/env blarg

ZONE="secure-lappy"

depends_on zone-config-placed

satisfied_if() {
  test "$(firewall-cmd --get-default-zone)" = "${ZONE}"
}

apply() {
  as_root firewall-cmd --set-default-zone="${ZONE}"
}
