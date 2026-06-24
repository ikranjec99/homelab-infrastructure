# Vaultwarden

Vaultwarden provides a lightweight, self-hosted password manager compatible with Bitwarden clients.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

Update `VAULTWARDEN_DOMAIN` before using this service behind a reverse proxy.

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `VAULTWARDEN_HTTP_PORT` | `9445` | Host port mapped to the Vaultwarden web UI. |
| `VAULTWARDEN_DATA_DIR` | `./bitwarden` | Local data directory. |
| `VAULTWARDEN_WEBSOCKET_ENABLED` | `false` | Enables websocket support when required. |
| `VAULTWARDEN_SIGNUPS_ALLOWED` | `false` | Controls public account registration. |
| `VAULTWARDEN_DOMAIN` | `https://vault.example.com` | Public URL used by Vaultwarden. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `9445` | `80` | Web UI |

## Persistence

Back up `VAULTWARDEN_DATA_DIR`. Test restores before relying on this service for important credentials.

## Security

Keep signups disabled unless you explicitly need open registration. Serve Vaultwarden over HTTPS and restrict administrative access.
