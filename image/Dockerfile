FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
  && apt-get install -y \
  apt-transport-https \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  gnupg \
  jq \
  lsb-release \
  software-properties-common

# Install Bash completion
RUN apt-get -y install bash-completion

# Install Docker Compose
RUN apt-get -y install docker-compose-plugin

# Install bat
RUN apt-get -y install bat

# Install K8s tooling: Kubectx
RUN wget -O- https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubectx_v0.9.5_linux_x86_64.tar.gz | tar -xvz kubectx \
  && chmod +x kubectx \
  && mv kubectx /usr/bin

# Install K8s tooling: K9s
RUN wget -O- https://github.com/derailed/k9s/releases/download/v0.27.4/k9s_Linux_amd64.tar.gz | tar -xvz k9s \
  && chmod +x k9s \
  && mv k9s /usr/bin

# Install Skaffold
RUN wget -O- https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 | \
  install /dev/stdin /usr/local/bin/skaffold

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  && gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint \
  && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list \
  && apt-get -y update \
  && apt-get -y install terraform

# VS Code Extensions
# Gitgraph
RUN wget -O https://open-vsx.org/api/mhutchie/git-graph/1.30.0/file/mhutchie.git-graph-1.30.0.vsix \
  && unzip mhutchie.git-graph-1.30.0.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/git-graph

# Docker
RUN wget -O https://open-vsx.org/api/ms-azuretools/vscode-docker/1.26.1/file/ms-azuretools.vscode-docker-1.26.1.vsix \
  && unzip ms-azuretools.vscode-docker-1.26.1.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/docker

# Hashicorp Terraform
RUN wget -O https://open-vsx.org/api/hashicorp/terraform/linux-x64/2.25.2/file/hashicorp.terraform-2.25.2@linux-x64.vsix \
  && unzip hashicorp.terraform-2.25.2@linux-x64.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/terraform

# Hashicorp HCL
RUN wget -O https://open-vsx.org/api/hashicorp/hcl/0.3.2/file/hashicorp.hcl-0.3.2.vsix \
  && unzip hashicorp.hcl-0.3.2.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/hcl

# Shellcheck
RUN wget -O https://openvsxorg.blob.core.windows.net/resources/timonwong/shellcheck/linux-x64/0.34.0/timonwong.shellcheck-0.34.0@linux-x64.vsix \
  && unzip timonwong.shellcheck-0.34.0@linux-x64.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/shellcheck

# Shell formatter
RUN wget -O https://open-vsx.org/api/foxundermoon/shell-format/7.0.1/file/foxundermoon.shell-format-7.0.1.vsix \
  && unzip foxundermoon.shell-format-7.0.1.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/shell-format

# Go
RUN wget -O https://open-vsx.org/api/golang/Go/0.39.1/file/golang.Go-0.39.1.vsix \
  && unzip golang.Go-0.39.1.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/go

# Microsoft Python
RUN wget -O https://open-vsx.org/api/ms-python/python/2023.2.0/file/ms-python.python-2023.2.0.vsix \
  && unzip ms-python.python-2023.2.0.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/python

# Microsoft Python Linting
#RUN wget -O https://open-vsx.org/api/ms-python/pylint/2023.6.0/file/ms-python.pylint-2023.6.0.vsix \
#    && unzip ms-python.pylint-2023.6.0.vsix "extension/*" \
#    && mv extension /opt/code-oss/extensions/pylint

# Python Ruff Linting
RUN wget -O https://open-vsx.org/api/charliermarsh/ruff/linux-x64/2023.38.0/file/charliermarsh.ruff-2023.38.0@linux-x64.vsix \
  && unzip charliermarsh.ruff-2023.38.0@linux-x64.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/ruff

# One Dark Pro Theme
RUN wget -O https://open-vsx.org/api/zhuangtongfa/material-theme/3.16.0/file/zhuangtongfa.material-theme-3.16.0.vsix \
  && unzip zhuangtongfa.material-theme-3.16.0.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/material-theme

# Material Icon Theme
RUN wget -O https://open-vsx.org/api/PKief/material-icon-theme/4.30.1/file/PKief.material-icon-theme-4.30.1.vsix \
  && unzip PKief.material-icon-theme-4.30.1.vsix "extension/*" \
  && mv extension /opt/code-oss/extensions/material-icon-theme

# User scripts
COPY 200_set_code_oss_settings.sh /etc/workstation-startup.d/
COPY 210_customize_bash.sh /etc/workstation-startup.d/

RUN apt-get clean
