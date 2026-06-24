## Resize the boot disk

The VM creation script may create a small default partition. Resize the partition and filesystem before installing services.

```bash
# Install cloud-guest-utils (for growpart)
apt update
apt install -y cloud-guest-utils e2fsprogs

# Grow the partition
growpart /dev/sda 1

# Grow the filesystem
resize2fs /dev/sda1
```
