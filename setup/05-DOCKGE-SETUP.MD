## Install Dockge

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
Access the GUI at https://<VM_IP>:5001.
First login uses the default admin / admin credentials – change them immediately.