# Scripts

Operational helper scripts live here.

## `bootstrap-vm.sh`

Bootstraps a Debian VM for Docker Compose based homelab workloads.

It installs:

- Base packages required for Docker setup.
- `qemu-guest-agent` for Proxmox integration.
- Docker Engine and the Docker Compose plugin.
- Optional Dockge stack management.

Run from the repository root on a fresh Debian VM:

```bash
sudo ./scripts/bootstrap-vm.sh --user <user>
```

To install Dockge during bootstrap:

```bash
sudo ./scripts/bootstrap-vm.sh --user <user> --install-dockge
```

The script is intended for Debian guests. Review it before running on an existing server.
