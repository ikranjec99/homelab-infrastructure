# BentoPDF

BentoPDF provides browser-accessible PDF tooling for a homelab environment.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `BENTOPDF_HTTP_PORT` | `3000` | Host port mapped to the BentoPDF web UI. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `3000` | `8080` | Web UI |

## Persistence

This stack does not currently define persistent volumes.

## Exposure

Run this service on the LAN or behind a reverse proxy. Review authentication and upstream project guidance before exposing it publicly.
