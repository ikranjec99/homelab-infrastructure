# Debian 13 VM on Proxmox VE  
*A quick‑start guide to create a ready‑to‑go Debian 13 virtual machine, enable SSH, install Docker and Dockge, and set a static IP.*

> **⚠️ NOTE** – All commands below are meant to be run on a **root shell** inside the Proxmox VE host.  
---

## Prerequisites

| Item | Why it matters | How to get it |
|------|----------------|---------------|
| **Proxmox VE 9.x+** | The script uses Proxmox's CLI (`pve`) and relies on the QEMU/KVM stack | Install from <https://www.proxmox.com/> |
| **Internet access on the host** | Needed to download the Debian image, Docker installer, Dockge compose file, and any updates | Configure your network, or use a bridge to the internet |
| **Root shell on the Proxmox host** | Most of the commands use `apt` and modify system files | `ssh root@<pve-host>` or physical console |
| **Optional – `curl` & `sed`** | The one‑liner script uses `curl` and the VM’s shell uses `sed` | Usually pre‑installed on Proxmox; install with `apt install curl sed` if missing |

---

## Step 1 – Create the VM

```bash
# Run this on the Proxmox host
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/debian-13-vm.sh)"
```

## Step 2 - Enable SSH

After the VM boots for the first time (or after the script finishes), SSH is already installed, but we still need to unlock root and enable password authentication.

```bash
# Install the SSH client and server
apt update
apt install -y openssh-client openssh-server

# Create a root password
passwd root

# Permit root login + password auth in sshd_config
sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
       -e 's/^PasswordAuthentication.*/PasswordAuthentication yes/' \
       /etc/ssh/sshd_config

# Generate host keys (if missing) and restart the service
ssh-keygen -A
systemctl restart sshd
```

Security note – Enabling password authentication is convenient for a quick start, but you should immediately set up key‑based auth or change the default credentials.

## Step 3 - Resize the boot disk

The script creates a small default partition that can be too small for your workloads.
Fix is here.

```bash
# Install cloud-guest-utils (for growpart)
apt update
apt install -y cloud-guest-utils e2fsprogs

# Grow the partition
growpart /dev/sda 1

# Grow the filesystem
resize2fs /dev/sda1
```

## Step 4 – Guest Agent

The qemu-guest-agent allows Proxmox to query the VM for network information and execute commands.

```bash
# Install the guest agent
apt install -y qemu-guest-agent
```

## Step 5 – Set a hostname

Pick a name (replace <user> with your login if you want non‑root Docker usage)

```bash
mkdir -p /opt/{dockge,stacks}
usermod -aG docker <user>
```

## Step 6 – Install Docker

```bash
# Install Docker CE from the official convenience script
curl -fsSL https://get.docker.com | sh
```

## Step 7 – Add Dockge

```bash
# Create the directories
mkdir -p /opt/{dockge,stacks}

# Download the default compose file
curl -sSL https://raw.githubusercontent.com/louislam/dockge/master/compose.yaml \
     --output /opt/dockge/compose.yaml

# Start Dockge
cd /opt/dockge
docker compose up -d
```

Access the GUI at https://<VM_IP>:5001.
First login uses the default admin / admin credentials – change them immediately.

## Step 8 – Set a static IP

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
      addresses: [192.168.1.42/24]
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [192.168.1.1,8.8.8.8]
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

Happy hacking!
If you have questions, improvements, or run into issues, feel free to open an issue or pull request on this repo.