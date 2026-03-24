#!/usr/bin/env blarg

LOCAL_CONFIG="${REPO_CONFIG_DIR}/git"

satisfied_if() {
  test -f "${LOCAL_CONFIG}/gitconfig" \
    && template_was_rendered "${LOCAL_CONFIG}/gitconfig.template" \
    && files_are_same "${LOCAL_CONFIG}/gitconfig" "${HOME}/.gitconfig" \
    && test_symlink "${LOCAL_CONFIG}/gitignore_global" "${HOME}/.gitignore"
}

apply() {
  if [ ! -f "${HOME}/.gitconfig" ]; then
    render_gitconfig
  elif ! files_are_same "${LOCAL_CONFIG}/gitconfig" "${HOME}/gitconfig"; then
    panic "${HOME}/.gitconfig has changed. Sync it up with ${LOCAL_CONFIG}/gitconfig.template"
  else
    # we updated the template here in this repo
    render_gitconfig
  fi

  rm -f "${HOME}/.gitignore"
  ln --symbolic "${LOCAL_CONFIG}/gitignore_global" "${HOME}/.gitignore"
}

render_gitconfig() {
  PUBLIC_NAME="${PUBLIC_NAME}" \
    PUBLIC_EMAIL="${PUBLIC_EMAIL}" \
    template_render "${LOCAL_CONFIG}/gitconfig.template"

  cp "${LOCAL_CONFIG}/gitconfig" "${HOME}/.gitconfig"
}
