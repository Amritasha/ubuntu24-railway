![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu)
![Docker](https://img.shields.io/badge/Docker-Supported-blue?logo=docker)

# Ubuntu 24.04 Railway

A browser-accessible Ubuntu 24.04 terminal deployed on Railway using [ttyd](https://github.com/tsl0922/ttyd).

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/new/template)

## Description

Deploys an Ubuntu 24.04 LTS container accessible from any browser. No local installation required. Comes pre-installed with commonly used CLI tools and a persistent volume mounted at `/root`.

## Environment Variables

| Variable | Description |
|----------|-------------|
| `PORT` | Port for ttyd to listen on (default: 7681) |
| `USERNAME` | Login username for the web terminal |
| `PASSWORD` | Login password for the web terminal |

> **Note:** Always set USERNAME and PASSWORD before deploying.

## Features

- 🐧 Ubuntu 24.04 LTS (Noble Numbat)
- 🔒 Password-protected web terminal
- 💻 Neofetch on login
- 💾 Persistent volume mounted at `/root` — files and installs survive restarts
- 🛠️ Pre-installed tools:

| Category | Tools |
|---|---|
| Editors | vim, nano |
| System | htop, tree, lsof, strace, less, man |
| Files | unzip, zip |
| Build | gcc, g++, make, build-essential |
| Network | ifconfig, ip, ping, dig, openssh-client, telnet, netcat |
| Data | jq |
| General | sudo, python3, pip, git, curl, wget, neofetch |

## Installing More Tools

Since the container runs as root, no sudo needed:

```bash
apt-get install -y <package-name>
```

> **Note:** Files saved inside `/root` persist across restarts. Packages installed via `apt-get` are stored outside `/root` and will not survive a full redeploy.

## Use Cases

- Test shell scripts from anywhere
- Learn Linux commands in a browser
- Lightweight persistent remote dev environment
- Package and tool testing on the latest Ubuntu LTS
