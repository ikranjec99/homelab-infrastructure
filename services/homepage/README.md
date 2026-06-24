# Homepage

Homepage provides a dashboard for homelab services and links.

## Deployment

```bash
cp .env.example .env
mkdir -p config
docker compose up -d
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `HOMEPAGE_HTTP_PORT` | `3000` | Host port mapped to the Homepage UI. |
| `HOMEPAGE_CONFIG_DIR` | `./config` | Local directory for Homepage configuration files. |
| `HOMEPAGE_ALLOWED_HOSTS` | `localhost:3000` | Allowed hostnames for incoming requests. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `3000` | `3000` | Web UI |

## Persistence

Back up `HOMEPAGE_CONFIG_DIR`.

## Security

This stack mounts the Docker socket as read-only for integrations. Treat the dashboard as internal infrastructure and avoid exposing it publicly without access controls.
