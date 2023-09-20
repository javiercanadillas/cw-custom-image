#!/usr/bin/env bash
## Prevent this script from being sourced
#shellcheck disable=SC2317
return 0  2>/dev/null || :

set -uo pipefail

bash_config_dir_base="/home/user/.config"
bash_config_dir="$bash_config_dir_base/bash"
bash_main_config="$bash_config_dir/main_config.bash"

make_bash_conf_dir() {
  echo "Creating Bash configuration directory..."
  mkdir -p "$bash_config_dir"
  chmod -R user:user "$bash_config_dir_base"
}

download_bash_prompt() {
  echo "Downloading Bash prompt..."
  curl -sSL https://raw.githubusercontent.com/javiercm/qwiklabs-cloudshell-setup/master/.prompt -o "$bash_config_dir/.prompt"
  chmod -R user:user "$bash_config_dir/.prompt"
}

enhance_bashrc() {
  echo "Enhancing Bash configuration..."
  cat <<EOF >> "$bash_main_config"
# Aliases
alias tf='terraform'
alias k='kubectl'
alias gauth='gcloud auth login'
alias gproj='gcloud config set project'
alias gconf='gcloud config configurations'

# Custom Bash prompt
source "$bash_config_dir/.prompt"
# Enable kubeclt autocompletion
[[ hash kubectl ]] && source <(kubectl completion bash) >> ~/.bashrc
EOF
}

customize_bashrc() {
  echo "Customizing Bash configuration..."
  grep -qxF "source \"$bash_main_config\"" "/home/user/.bashrc" || echo "source \"$bash_main_config\"" >> "/home/user/.bashrc"
}

set_user_permissions() {
  echo "Setting user permissions..."
}

main() {
  echo "Customizing Bash..."
  make_bash_conf_dir
  download_bash_prompt
  enhance_bashrc
  customize_bashrc
  set_user_permissions
}

main "$@"
