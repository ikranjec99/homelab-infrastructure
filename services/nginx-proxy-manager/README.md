# Nginx Proxy Manager

Nginx Proxy Manager provides reverse proxy and certificate management for homelab services.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `TZ` | `Europe/Zagreb` | Container timezone. |
| `NPM_HTTP_PORT` | `80` | Public HTTP port. |
| `NPM_HTTPS_PORT` | `443` | Public HTTPS port. |
| `NPM_ADMIN_PORT` | `81` | Admin UI port. |
| `NPM_DISABLE_IPV6` | `true` | Disables IPv6 inside the container. |
| `NPM_DATA_DIR` | `./data` | Application data directory. |
| `NPM_LETSENCRYPT_DIR` | `./letsencrypt` | Certificate storage directory. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `80` | `80` | HTTP |
| `443` | `443` | HTTPS |
| `81` | `81` | Admin UI |

## Persistence

Back up `NPM_DATA_DIR` and `NPM_LETSENCRYPT_DIR`.

## Security

Only ports `80` and `443` should be exposed publicly. Keep the admin UI restricted to LAN or VPN access.
