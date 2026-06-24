## Configure a static IP

Edit the Netplan config so the VM stops using DHCP and gets a fixed address.

```bash
# Edit the Netplan file
nano /etc/netplan/90-default.yaml
```

Replace the entire file with:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
      dhcp4: no
      addresses:
        - 192.168.0.120/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses:
          - 1.1.1.1
          - 8.8.8.8
        search: []
```

Before applying the configuration:

- Confirm that `ens18` is the correct interface name for the VM.
- Update `addresses`, `via`, and `nameservers` to match your network.

Apply the new configuration:

```bash
netplan apply
```

If the network does not come up, reboot the VM:

```bash
reboot
```

The VM should now have a stable LAN IP for SSH and service access.
