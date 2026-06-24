# Opengist

Opengist provides a self-hosted service for sharing Git-backed snippets.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `OPENGIST_HTTP_PORT` | `6157` | Host port mapped to the Opengist UI. |
| `OPENGIST_DATA_DIR` | `./data` | Local directory for Opengist data. |
| `OPENGIST_LOG_LEVEL` | `error` | Application log level. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `6157` | `6157` | Web UI |

## Persistence

Back up `OPENGIST_DATA_DIR`.

## Exposure

Run this service behind HTTPS if exposing it outside the LAN.
