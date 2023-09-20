#!/usr/bin/env bash
## Prevent this script from being sourced
#shellcheck disable=SC2317
return 0  2>/dev/null || :

set -eo pipefail

update_settings() {
  echo "Updating user settings..."
  local -r codeoss_path="/home/user/.codeoss-cloudworkstations"
  local -r settings_path="$codeoss_path/data/Machine"
  local -r settings_file="$settings_path/settings.json"

  mkdir -p "$settings_path"


  [[ -f "$settings_file" ]] && cat <<EOF > "$settings_file"
{
  "editor.inlineSuggest.enabled": true,
  "workbench.colorTheme": "One Dark Pro",
  "editor.fontSize": 14,
  "terminal.integrated.fontSize": 14,
  "editor.rulers": [80, 120],
  "editor.tabSize": 2,
  #"editor.defaultFormatter": "charliermarsh.ruff",
  "editor.accessibilitySupport": "off",
  "github.copilot.enable": {
    "*": true
  },
  "workbench.startupEditor": "none",
  "[terraform-vars]": {
    "editor.defaultFormatter": "hashicorp.terraform"
  },
  "[terraform]": {
    "editor.defaultFormatter": "hashicorp.terraform"
  },
  "[python]": {
    "editor.insertSpaces": true,
    "editor.tabSize": 2,
    "editor.detectIndentation": false,
    "editor.defaultFormatter": "ms-python.python"
  },
  "[jsonc]": {
    "editor.defaultFormatter": "vscode.json-language-features"
  },
  "go.toolsManagement.autoUpdate": true,
  "window.zoomLevel": 1,
  "cloudcode.project": "javiercm-main-dev",
  "cloudcode.duetAI.project": "javiercm-main-dev",
  "[shellscript]": {
    "editor.defaultFormatter": "foxundermoon.shell-format"
  },
  "files.trimFinalNewlines": true,
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "files.autoSave": "off",
  "editor.minimap.enabled": false,
}
EOF

  chown -R user:user "$codeoss_path"
  chmod -R 755 "$codeoss_path"
}

main() {
  update_settings
}

main "$@"