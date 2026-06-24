## Docker setup

```bash
# Install Docker CE from the official convenience script
curl -fsSL https://get.docker.com | sh

# Add user to docker group
usermod -aG docker <user>
```

Log out and back in after adding the user to the `docker` group.

Verify the installation:

```bash
docker version
docker compose version
```
