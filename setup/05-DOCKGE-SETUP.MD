## Install Dockge

Dockge provides a web interface for managing Docker Compose stacks.

```bash
# Create required directories
mkdir -p /opt/{dockge,stacks}

# Download the default compose file
curl -sSL https://raw.githubusercontent.com/louislam/dockge/master/compose.yaml \
     --output /opt/dockge/compose.yaml

# Start Dockge service
cd /opt/dockge
docker compose up -d
```

Access the UI at:

```text
https://<VM_IP>:5001
```

Change the default credentials immediately after the first login.
