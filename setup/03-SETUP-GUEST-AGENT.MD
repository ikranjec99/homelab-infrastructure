## Install the Proxmox guest agent

The qemu-guest-agent allows Proxmox to query the VM for network information and execute commands.

```bash
# Install the guest agent
apt install -y qemu-guest-agent
```

Enable the guest agent for the VM in the Proxmox UI, then restart the VM if Proxmox does not report the guest IP address immediately.
