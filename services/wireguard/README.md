# WireGuard Dashboard

WireGuard Dashboard provides a web UI for managing WireGuard configuration.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `TZ` | `Europe/Zagreb` | Container timezone. |
| `WGDASHBOARD_HTTP_PORT` | `10086` | Host port mapped to the dashboard UI. |
| `WIREGUARD_UDP_PORT` | `51820` | WireGuard UDP port. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `10086` | `10086/tcp` | Dashboard UI |
| `51820` | `51820/udp` | WireGuard tunnel |

## Persistence

Back up the `conf` and `data` Docker volumes.

## Security

Keep the dashboard restricted to LAN or VPN access. Only the WireGuard UDP port should be exposed where remote clients require it.
