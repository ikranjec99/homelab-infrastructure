#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: sudo ./scripts/bootstrap-vm.sh [options]

Bootstrap a Debian VM for homelab Docker Compose workloads.

Options:
  --user USER             User to add to the docker group. Defaults to $SUDO_USER.
  --timezone TIMEZONE     System timezone. Defaults to Europe/Zagreb.
  --stacks-dir PATH       Directory for Compose stacks. Defaults to /opt/stacks.
  --dockge-dir PATH       Directory for Dockge files. Defaults to /opt/dockge.
  --install-dockge        Install and start Dockge.
  -h, --help              Show this help text.

Examples:
  sudo ./scripts/bootstrap-vm.sh --user ikranjec
  sudo ./scripts/bootstrap-vm.sh --user ikranjec --install-dockge
EOF
}

TARGET_USER="${SUDO_USER:-}"
TIMEZONE="Europe/Zagreb"
STACKS_DIR="/opt/stacks"
DOCKGE_DIR="/opt/dockge"
INSTALL_DOCKGE="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)
      TARGET_USER="${2:-}"
      shift 2
      ;;
    --timezone)
      TIMEZONE="${2:-}"
      shift 2
      ;;
    --stacks-dir)
      STACKS_DIR="${2:-}"
      shift 2
      ;;
    --dockge-dir)
      DOCKGE_DIR="${2:-}"
      shift 2
      ;;
    --install-dockge)
      INSTALL_DOCKGE="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ "${EUID}" -ne 0 ]]; then
  echo "This script must be run as root. Use sudo." >&2
  exit 1
fi

if [[ -z "${TARGET_USER}" ]]; then
  echo "Could not determine the target user. Pass --user USER." >&2
  exit 1
fi

if ! id "${TARGET_USER}" >/dev/null 2>&1; then
  echo "User '${TARGET_USER}' does not exist." >&2
  exit 1
fi

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot read /etc/os-release." >&2
  exit 1
fi

. /etc/os-release

if [[ "${ID:-}" != "debian" ]]; then
  echo "This bootstrap script is intended for Debian VMs. Detected: ${PRETTY_NAME:-unknown}" >&2
  exit 1
fi

install_base_packages() {
  apt-get update
  apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    qemu-guest-agent \
    unattended-upgrades
}

configure_timezone() {
  timedatectl set-timezone "${TIMEZONE}"
}

install_docker() {
  if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed."
    return
  fi

  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL "https://download.docker.com/linux/debian/gpg" -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  cat >/etc/apt/sources.list.d/docker.list <<EOF
deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${VERSION_CODENAME} stable
EOF

  apt-get update
  apt-get install -y \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin
}

configure_services() {
  systemctl enable --now qemu-guest-agent
  systemctl enable --now docker
  usermod -aG docker "${TARGET_USER}"
}

create_directories() {
  install -d -m 0755 "${STACKS_DIR}"
  chown "${TARGET_USER}:${TARGET_USER}" "${STACKS_DIR}"

  if [[ "${INSTALL_DOCKGE}" == "true" ]]; then
    install -d -m 0755 "${DOCKGE_DIR}"
  fi
}

install_dockge() {
  if [[ "${INSTALL_DOCKGE}" != "true" ]]; then
    return
  fi

  cat >"${DOCKGE_DIR}/compose.yaml" <<EOF
services:
  dockge:
    image: louislam/dockge:1
    restart: unless-stopped
    ports:
      - "5001:5001"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./data:/app/data
      - ${STACKS_DIR}:${STACKS_DIR}
    environment:
      - DOCKGE_STACKS_DIR=${STACKS_DIR}
EOF

  docker compose -f "${DOCKGE_DIR}/compose.yaml" up -d
}

main() {
  install_base_packages
  configure_timezone
  install_docker
  configure_services
  create_directories
  install_dockge

  cat <<EOF

Bootstrap complete.

User '${TARGET_USER}' was added to the docker group.
Log out and back in before running Docker without sudo.

Stacks directory: ${STACKS_DIR}
Dockge installed: ${INSTALL_DOCKGE}
EOF
}

main
