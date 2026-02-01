## Static IP setup

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
        addresses: [x.x.x.x/24] # IP address we want for this VM should be set here, for example 192.168.0.120/24
        routes:
          - to: default
            via: x.x.x.x # 192.168.0.1
        nameservers:
          addresses:
            - 1.1.1.1
            - 8.8.8.8
          search: []
```

Remember
- ```ens18``` is the typical interface name on Debain 13 inside Proxmox
- update ```addresses```, ```via``` and ```nameservers``` to match your network.

Apply the new configuration

```bash
netplan apply
```

If the network doesn’t come up, a quick reboot will fix most issues:

```bash
reboot
```

Now your VM should have a stable IP and you can SSH or access Dockge from anywhere on the LAN.