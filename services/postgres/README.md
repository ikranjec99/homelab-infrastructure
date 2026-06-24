# PostgreSQL

PostgreSQL provides a relational database service for internal homelab workloads.

## Deployment

```bash
cp .env.example .env
docker compose up -d
```

Change `POSTGRES_PASSWORD` before starting the service.

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `POSTGRES_HOST_PORT` | `5400` | Host port mapped to PostgreSQL. |
| `POSTGRES_CONTAINER_PORT` | `5432` | PostgreSQL port inside the container. |
| `POSTGRES_DB` | `homelab` | Default database created on first initialization. |
| `POSTGRES_USER` | `homelab` | Default database user created on first initialization. |
| `POSTGRES_PASSWORD` | `change-me-before-deploying` | Default database password. Must be changed before use. |
| `POSTGRES_PGDATA` | `/var/lib/postgresql/18/docker` | PostgreSQL data directory inside `POSTGRES_DATA_DIR`. |
| `POSTGRES_DATA_DIR` | `/var/lib/postgresql` | Container path mounted to the `pgdata` Docker volume. |

## Ports

| Host | Container | Purpose |
| --- | --- | --- |
| `5400` | `5432` | PostgreSQL client connections |

## Persistence

PostgreSQL data is stored in the `pgdata` Docker volume.

Back up this service with database-native dumps, for example:

```bash
docker exec postgres pg_dumpall -U "$POSTGRES_USER" > postgres-dump.sql
```

Test restore procedures before relying on this database for important services.

## Security

Keep PostgreSQL internal-only. Do not expose this port publicly. Use strong credentials and restrict client access at the network level.
