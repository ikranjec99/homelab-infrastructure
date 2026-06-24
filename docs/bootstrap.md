# Bootstrap

The bootstrap flow prepares a Debian VM for Docker Compose workloads.

## Recommended Flow

1. Create a Debian VM in Proxmox.
2. Resize the boot disk if required.
3. Configure a static LAN IP.
4. Clone this repository.
5. Run the bootstrap script.
6. Copy service stacks into place or deploy from the repository.

The manual setup notes remain available under `setup/` for recovery and troubleshooting.

## Bootstrap Script

Run from the repository root:

```bash
sudo ./scripts/bootstrap-vm.sh --user <user>
```

Install Dockge during bootstrap:

```bash
sudo ./scripts/bootstrap-vm.sh --user <user> --install-dockge
```

Useful options:

| Option | Default | Purpose |
| --- | --- | --- |
| `--user` | `$SUDO_USER` | User added to the `docker` group. |
| `--timezone` | `Europe/Zagreb` | System timezone. |
| `--stacks-dir` | `/opt/stacks` | Directory used for Compose stacks. |
| `--dockge-dir` | `/opt/dockge` | Directory used for Dockge files. |
| `--install-dockge` | disabled | Installs and starts Dockge. |

## After Bootstrap

Log out and back in so group membership changes apply.

Verify Docker:

```bash
docker version
docker compose version
```

If Dockge was installed, open:

```text
https://<VM_IP>:5001
```
