# Nextcloud AIO

Nextcloud All-in-One provides file sync, collaboration, and related services managed through the official AIO master container.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

Open the AIO interface and complete the official setup flow.

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `NEXTCLOUD_AIO_PORT` | `8090` | Host port for the AIO management interface. |
| `NEXTCLOUD_APACHE_PORT` | `11000` | Apache port used behind a reverse proxy. |
| `NEXTCLOUD_APACHE_IP_BINDING` | `0.0.0.0` | Interface binding for the Apache container. |
| `NEXTCLOUD_DATADIR` | `/mnt/ncdata` | Host data directory for Nextcloud files. Do not change after first install. |
| `NEXTCLOUD_MOUNT` | `/mnt/` | Host path exposed to Nextcloud. |
| `NEXTCLOUD_UPLOAD_LIMIT` | `16G` | Upload size limit. |
| `NEXTCLOUD_MAX_TIME` | `3600` | PHP max execution time. |
| `NEXTCLOUD_MEMORY_LIMIT` | `2048M` | PHP memory limit. |
| `NEXTCLOUD_SKIP_DOMAIN_VALIDATION` | `true` | Skips AIO domain validation when reverse proxying is already configured. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `8090` | `8080` | AIO management interface |
| `11000` | Managed by AIO | Reverse proxy backend |

## Persistence

Back up the `nextcloud_aio_mastercontainer` volume and the configured `NEXTCLOUD_DATADIR`. Also use the backup tooling provided by Nextcloud AIO.

## Security

Review the official AIO reverse proxy documentation before exposing this service. Nextcloud should be served over HTTPS.
