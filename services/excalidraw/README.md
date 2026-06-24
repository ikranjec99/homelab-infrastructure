# Excalidraw

Excalidraw provides a lightweight collaborative whiteboard.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `EXCALIDRAW_HTTP_PORT` | `3030` | Host port mapped to the Excalidraw web UI. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `3030` | `80` | Web UI |

## Persistence

This stack does not currently define persistent volumes.

## Exposure

Run this service on the LAN or behind a reverse proxy. Confirm whether your deployment needs authentication before exposing it publicly.
