# Operations

These conventions keep the homelab predictable during routine changes.

## Service Changes

- Change one service stack at a time.
- Review `docker-compose.yaml`, `.env.example`, and service `README.md` together.
- Keep host ports explicit.
- Keep persistent paths documented.
- Do not commit real `.env` files.

## Deployment

Deploy from a service directory:

```bash
cd services/<service>
cp .env.example .env
docker compose up -d
```

Check status:

```bash
docker compose ps
docker compose logs --tail=100
```

## Recovery Notes

The `setup/` directory keeps the manual VM preparation steps available even when automation exists. This makes it easier to recover when a script cannot be used or when a fresh VM needs to be prepared by hand.
