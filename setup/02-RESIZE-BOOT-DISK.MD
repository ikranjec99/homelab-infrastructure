## Resize the boot disk

### The script creates a small default partition that can be too small for your workloads.


```bash
# Install cloud-guest-utils (for growpart)
apt update
apt install -y cloud-guest-utils e2fsprogs

# Grow the partition
growpart /dev/sda 1

# Grow the filesystem
resize2fs /dev/sda1
```