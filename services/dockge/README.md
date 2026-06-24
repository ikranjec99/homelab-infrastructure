# Dockge

Dockge provides a web UI for managing Docker Compose stacks.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `DOCKGE_HTTP_PORT` | `5001` | Host port mapped to the Dockge UI. |
| `DOCKGE_DATA_DIR` | `./data` | Local directory for Dockge application data. |
| `DOCKGE_STACKS_DIR` | `/opt/stacks` | Absolute host path where Compose stacks are stored. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `5001` | `5001` | Dockge UI |

## Persistence

Back up `DOCKGE_DATA_DIR` and `DOCKGE_STACKS_DIR`.

## Security

Dockge mounts `/var/run/docker.sock`, which effectively grants host-level Docker control. Keep this service LAN-only or behind VPN.
