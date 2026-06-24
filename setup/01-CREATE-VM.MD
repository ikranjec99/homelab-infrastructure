## Create the VM

Create a minimal Debian VM from the Proxmox host.

```bash
# Run this on the Proxmox host
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/debian-13-vm.sh)"
```

After the script completes, review the VM settings in Proxmox before starting the guest.
