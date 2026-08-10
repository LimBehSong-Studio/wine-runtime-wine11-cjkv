# 林北松工作室·Conradtech首個作品

# Wine Runtime Wine11 CJKV Public Edition

**Release:** 2026-08 Preview

Docker Image:

```bash
docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-preview.20260808
```

---
由于时间仓促，还没来得及完善详细手册、做软件安装韧性测试、蓝牙模块兼容性测试、远期的Wine底包一键升级、双击关连安装等有机会实现的功能，但目前exe的正常使用应该是不成问题的，欢迎各位用户测试反馈！
## Overview

Wine Runtime Wine11 CJKV Public Edition is a containerized Wine 11 runtime environment designed for running Windows applications on Linux systems.

The project provides a reproducible Windows compatibility environment based on:

- Ubuntu 22.04.5 LTS
- WineHQ Stable 11
- 32-bit and 64-bit Windows application support
- X11 application forwarding
- Fcitx5 input method integration
- Chinese locale configuration
- CJKV font rendering support
- External font injection system
- Persistent Wine prefix storage

The goal of this project is to provide a reusable and portable Wine runtime environment that can be deployed consistently across Linux systems.

---

## Features

- WineHQ Stable 11 runtime
- Linux container-based isolation
- 32-bit / 64-bit Windows application compatibility
- X11 GUI application support
- Host-side persistent Wine prefix
- Fcitx5 input method integration
- Chinese locale support
- CJK font rendering framework
- External font injection system
- Reproducible runtime configuration

---

# Quick Start

## Recommended: Using Runtime Launcher

The project provides a helper launcher script (`start.sh`) to simplify runtime deployment.

Instead of manually configuring Docker parameters, users can start the Wine Runtime environment with:

```bash
chmod +x start.sh
./start.sh
```

The launcher automatically prepares:

- Docker container startup
- X11 display forwarding
- Persistent Wine prefix
- External font directory
- Windows installer directory
- Shared data directory
- Runtime log directory

---

## Runtime Workspace

The launcher creates the following workspace:

```text
~/wine-runtime-data/
```

Directory structure:

```text
~/wine-runtime-data/

├── fonts/
│   └── External font files

├── wineprefix/
│   └── Persistent Wine environment

├── installers/
│   └── Windows application installers (.exe / .msi)

├── backups/
│   └── Runtime backup files

├── shared/
│   └── Shared files between Linux host and Wine container

└── logs/
    └── Runtime logs
```

---

## Installing Windows Applications

Windows installers can be placed into:

```text
~/wine-runtime-data/installers/
```

Supported installer formats:

- `.exe`
- `.msi`

Installer files remain outside the container and can be reused after runtime updates.

---

## Font Policy

Wine Runtime Wine11 CJKV Public Edition **does not include proprietary Microsoft fonts**.

Examples of proprietary fonts:

- Microsoft YaHei
- SimSun
- Microsoft JhengHei
- Malgun Gothic
- Other licensed Windows fonts

Users are responsible for obtaining and using fonts according to their own licensing requirements.

---

## Built-in Fonts

The default image may include open-source fonts for basic CJK rendering.

These fonts are provided under their respective open-source licenses.

Included font families may include:

- Noto CJK
- WenQuanYi fonts
- Other open-source CJK font families

For detailed license information, please refer to the corresponding font licenses.

---

## CJK Font Configuration

Many Windows applications depend on installed fonts for correct text rendering.

Without suitable CJK fonts:

- Chinese characters may appear as missing glyph boxes (`口口`)
- Font fallback may occur
- Application appearance may differ from native Windows environments

This runtime provides a font loading framework but does not provide licensed proprietary Microsoft fonts.

---

## External Font Injection

Users can provide additional fonts through an external directory mounted into the container.

### Host Directory

Recommended directory:

```text
~/wine-runtime-data/fonts/
```

Place additional font files inside this directory:

```text
~/wine-runtime-data/fonts/

├── example.ttf
├── example.otf
└── custom-fonts/
```

### Container Directory

The directory is mounted into the runtime as:

```text
/opt/extra_fonts/
```

Example volume mapping:

```bash
-v ~/wine-runtime-data/fonts:/opt/extra_fonts
```

The runtime initialization process will detect and configure available fonts during startup.

Supported font sources may include:

- Noto CJK
- HanaMin
- Jigmo
- User-provided fonts

---

## Persistent Wine Prefix

The Wine prefix is intentionally stored outside the Docker image.

Host directory:

```text
~/wine-runtime-data/wineprefix/
```

Container directory:

```text
/opt/wineprefix
```

Example volume mapping:

```bash
-v ~/wine-runtime-data/wineprefix:/opt/wineprefix
```

Benefits:

- Persistent Windows application settings
- Persistent Wine configuration
- Image upgrades without losing runtime data
- Easier backup and migration
- Multiple runtime versions can share or test different prefixes

---

## Current Documentation Status

> This README is currently being improved.

The runtime is functional, but documentation is still being expanded.

Future documentation improvements include:

- Complete architecture documentation
- Detailed Docker runtime configuration
- X11 setup guide
- Fcitx5 + Rime input method configuration
- Advanced font management
- Troubleshooting guide
- Recovery and migration documentation

The project is currently released as a preview version (`0.1.0-preview`).
