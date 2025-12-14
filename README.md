# homelab‑infrastructure

> A **single‑source‑of‑truth** for all the services that live inside containers on top of Proxmox.  
> Every VM is a minimal Debian box with Docker & Dockge; every service is a `docker‑compose.yml` that lives in this repo.

## Table of Contents
- [🧠 Hardware](#hardware)
- [🏗 Architecture](#architecture)
- [🖥️ VM Standardisation](#vm-standardisation)
- [Bootstrapping a New VM](#bootstrapping-a-new-vm)
- [🖥️ VM Naming Convention](#vm-naming-convention)
- [📁 Repository Structure](#repository-structure)
- [🐳 Docker Conventions](#docker-conventions)
- [🚀 Deployment](#deployment)
- [📌 Notes](#notes)
- [📜 License](#license)

---

## Hardware
> This homelab runs on a compact but capable machine:

| Component | Specification |
|-----------|---------------|
| **Box** | Lenovo M710q Tiny |
| **CPU** | Intel i7‑6700 (4 core / 8 thread) |
| **Memory** | 32 GB DDR4 |
| **Boot Drive** | 240 GB SSD (Proxmox OS) |
| **Data Drive** | 1 TB SSD/HDD (VMs) |
| **Hypervisor** | Proxmox VE 9.x (latest stable) |

> *A small, silent system with enough headroom for 10‑15 services.*


---

## Architecture
- **Proxmox** → bare‑metal hypervisor  
- **Each service** gets its own Debian VM  
- **Inside the VM**: Docker + Docker‑Compose + Dockge (web UI)  
- **No “shared” VMs** – isolation = peace of mind  
- **Networking**: bridge `vmbr0` (NAT to the internet), optional internal networks per service

---

## VM Standardisation

| Item | Value |
|------|-------|
| OS | Debian 12 (netinst, minimal) |
| Boot disk | 20 GB |
| RAM | 4 GB |
| CPU | 2 cores (shareable via Proxmox scheduler) |
| Docker | latest stable |
| Dockge | latest stable (web UI on `:5000`) |

> Keep the VM image identical; this makes cloning, patching, and scaling a breeze.

### Bootstrapping a New VM

Check [Setup][./setup/VM-SETUP.md]

---

### VM Naming Convention

All VMs follow the same pattern so that tools like pvecli and Docker can discover them by hostname.


```text
p4-<user>-deb-<N>
```
- p4 – Proxmox node (or environment tag)
- <user> – your short name (e.g., ikranjec)
- deb – Debian OS identifier
- <N> – sequential integer starting at 1

Examples:

```text
p4-ikranjec-deb-1
p4-ikranjec-deb-2
p4-ikranjec-deb-3
```

> Important – The hostname inside the VM must equal the Proxmox VM name.
This guarantees that Docker Compose can refer to services by ${HOSTNAME} without surprises.

---

## Repository Structure

```text
homelab-infrastructure/
├── README.md
├── vm-setup/
│   ├── SETUP.md
│   └── bootstrap.sh            # optional Cloud‑Init script
├── services/
│   ├── <service-name>/
│   │   ├── docker-compose.yml
│   │   ├── .env.example
│   │   └── README.md           # per‑service docs
│   └── another-service/
│       ├── docker-compose.yml
│       └── .env.example
```

- Each folder represents a separate docker service.
- Keep README.md inside each service folder if you need service‑specific notes.

---

## Docker Conventions

| Rule | Description |
|------|-------------|
| **One compose file per service** | Keeps the stack atomic and reusable. |
| **`env_file`** | Load environment variables from a `.env` file. |
| **No hard‑coded secrets** | Secrets are injected via `docker secret` or environment files that are **never** committed. |
| **Named volumes** | For data persistence; declared in the compose file. |
| **`restart: unless-stopped`** | Containers stay alive across reboots unless you explicitly stop them. |


---

## Deployment

1. Clone the repo

```bash
git clone https://github.com/ikranjec99/homelab-infrastructure.git
cd homelab-infrastructure
```

2. Copy and adjust environment files

```bash
cp .env.example .env
```

3. Start services

```bash
docker compose up -d
```

4. Enjoy a calm dashboard and quiet fans

---

## Notes

This is a **personal homelab**, not a production cluster.

Mistakes are expected.
Fixes are documented.

---

## License

MIT – feel free to use, fork, adapt, and improve.
If this repo saves you time, consider starring it or sending a note.

Happy self‑hosting! 🐳🚀