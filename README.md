# 林北松工作室 · Conradtech 首个作品

# Wine Runtime Wine11 CJKV Public Edition

**Release:** 2026-08 Preview

Docker Image:

    docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-preview.20260808

---

由于时间仓促，还没来得及完善详细手册、做软件安装韧性测试、蓝牙模块兼容性测试、远期的 Wine 底包一键升级、双击关联安装等有机会实现的功能，但目前 `.exe` / `.msi` 应用的正常使用应该是不成问题的。

目前项目已经完成公开发布，欢迎各位用户测试反馈！

---

## Overview

Wine Runtime Wine11 CJKV Public Edition 是一个面向 Linux 的容器化 Wine 11 Runtime 环境。

项目提供一个可重复部署、可持久化、可迁移的 Windows 应用兼容运行环境。

项目基于：

- Ubuntu 22.04.5 LTS
- WineHQ Stable 11
- 32-bit / 64-bit Windows application support
- X11 application forwarding
- Fcitx5 input method integration
- Chinese locale configuration
- CJKV font rendering support
- External font injection system
- Persistent Wine prefix storage

项目的核心目标是：

> 把 Wine 从安装在宿主机上的软件，变成一个可复制、可迁移、可维护的 Runtime 环境。

---

## Features

- WineHQ Stable 11 Runtime
- Linux Docker container isolation
- 32-bit / 64-bit Windows application compatibility
- X11 GUI application support
- Persistent Wine prefix
- Fcitx5 input method integration
- Chinese locale support
- CJKV font rendering framework
- External font injection system
- Persistent application data
- Reproducible runtime configuration
- Host-side runtime workspace
- Runtime launcher script
- Docker-based deployment
- Runtime data separated from the Docker image

---

# Quick Start

## Recommended: Using Runtime Launcher

项目提供了 `start.sh` Runtime Launcher，用于简化 Docker Runtime 的启动过程。

进入项目目录：

    cd ~/wine-runtime-wine11-cjkv

赋予执行权限：

    chmod +x start.sh

启动：

    ./start.sh

Launcher 会自动准备 Runtime 所需的基础环境，包括：

- Docker container startup
- X11 display forwarding
- Persistent Wine prefix
- External font directory
- Windows installer directory
- Shared data directory
- Runtime log directory

---

# Runtime Workspace

Launcher 默认使用：

    ~/wine-runtime-data/

目录结构：

    ~/wine-runtime-data/

    ├── fonts/
    │   └── External font files
    │
    ├── wineprefix/
    │   └── Persistent Wine environment
    │
    ├── installers/
    │   └── Windows application installers (.exe / .msi)
    │
    ├── backups/
    │   └── Runtime backup files
    │
    ├── shared/
    │   └── Shared files between Linux host and Wine container
    │
    └── logs/
        └── Runtime logs

Runtime 数据与 Docker Image 分离。

因此，即使后续升级 Wine Runtime Image，用户自己的 Wine Prefix、字体、安装包以及其他 Runtime 数据也可以继续保留。

---

# Installing Windows Applications

Windows 应用安装包可以放入：

    ~/wine-runtime-data/installers/

支持的常见安装格式：

- `.exe`
- `.msi`

例如：

    ~/wine-runtime-data/installers/

    ├── setup.exe
    ├── application.exe
    └── application.msi

安装包保存在宿主机中，不依赖 Docker Image。

这样在 Runtime 更新、重新创建 Container 或迁移环境时，安装包仍然可以继续使用。

---

# Persistent Wine Prefix

Wine Prefix 默认存储在宿主机：

    ~/wine-runtime-data/wineprefix/

Container 内对应：

    /opt/wineprefix

典型 Volume Mapping：

    -v ~/wine-runtime-data/wineprefix:/opt/wineprefix

Wine Prefix 与 Docker Image 分离，可以保留：

- Windows application settings
- Wine configuration
- Installed application data
- Registry configuration
- Application compatibility settings

这样可以实现：

- Runtime Image 升级而不直接删除用户数据
- Wine Prefix 持久化
- Runtime 迁移
- Prefix 备份
- 不同 Runtime 版本进行测试

---

# Font Policy

Wine Runtime Wine11 CJKV Public Edition **不包含微软专有字体**。

例如：

- Microsoft YaHei
- SimSun
- Microsoft JhengHei
- Malgun Gothic
- 其他 Windows 专有字体

用户应根据相关字体的授权条款自行获取和使用字体。

本项目不会在 Docker Image 中主动分发未经授权的微软专有字体。

---

# Built-in Fonts

Runtime 可以提供用于基础 CJK 字符显示的开源字体。

这些字体分别遵循其对应的开源许可证。

可能使用的字体包括：

- Noto CJK
- WenQuanYi
- 其他开源 CJK 字体

具体字体及其许可证信息，请以项目实际文件和对应字体项目的 License 为准。

---

# CJKV Font Configuration

很多 Windows 应用依赖系统字体进行正确的文字渲染。

如果系统没有合适的 CJK 字体，可能出现：

- 中文显示为缺字方框
- 字体 Fallback
- 中日韩文字显示异常
- 软件界面与 Windows 原生环境存在差异

本项目提供 CJKV 字体加载和配置框架，但不提供未经授权的微软专有字体。

---

# External Font Injection

用户可以通过宿主机目录向 Runtime 注入额外字体。

推荐目录：

    ~/wine-runtime-data/fonts/

例如：

    ~/wine-runtime-data/fonts/

    ├── example.ttf
    ├── example.otf
    └── custom-fonts/

Container 内对应：

    /opt/extra_fonts/

典型 Volume Mapping：

    -v ~/wine-runtime-data/fonts:/opt/extra_fonts

Runtime 初始化过程会检测并处理可用字体。

可以根据个人需求加入合法获取的字体，例如：

- Noto CJK
- HanaMin
- Jigmo
- 用户自行获取并授权使用的字体

---

# X11 GUI

本项目主要面向 Linux Desktop + X11 环境。

Windows GUI application 通过 X11 forwarding 显示到 Linux Desktop。

因此，在使用 Runtime 前，需要确保 Linux 宿主机已经正常运行 X11 图形环境。

目前项目主要针对实际 Linux Desktop 环境进行开发和测试。

---

# Fcitx5 Input Method

Runtime 集成了 Fcitx5 相关支持，用于改善 Windows 应用中的中文输入体验。

项目目前重点面向：

- Fcitx5
- Chinese input method
- CJKV language environment

不同 Windows 应用对输入法的支持方式可能存在差异。

因此，部分特殊软件仍可能需要额外兼容性调整。

---

# Project Structure

当前项目根目录主要包含：

    wine-runtime-wine11-cjkv/

    ├── Dockerfile
    ├── README.md
    ├── RESTORE.md
    ├── start.sh
    │
    ├── scripts/
    │   └── Runtime initialization scripts
    │
    ├── fonts/
    │   └── Built-in font resources
    │
    ├── extra_fonts/
    │   └── Additional font resources
    │
    ├── gecko/
    │   └── Wine Gecko resources
    │
    ├── mono/
    │   └── Wine Mono resources
    │
    ├── assets/
    │   └── Project assets
    │
    └── archive/
        └── dockerfiles/
            └── Historical Dockerfiles

历史开发阶段使用过的 Dockerfile 已经移动到：

    archive/dockerfiles/

这些文件主要用于保留项目开发过程中的历史版本和技术演进记录。

当前正式 Runtime 使用：

    Dockerfile

---

# Recovery

项目提供：

    RESTORE.md

以及：

    一键恢复流程.txt

用于记录 Runtime 的恢复、重新部署以及相关操作流程。

由于 Docker Image、项目源码以及 Runtime 数据采用分离设计，即使本地环境出现问题，也可以通过重新获取项目源码和 Docker Image 的方式恢复 Runtime。

---

# Current Release

当前公开版本：

    0.1.0-preview.20260808

Docker Image：

    docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-preview.20260808

当前版本属于：

> Preview / Public Preview

主要用于公开测试、实际应用验证以及收集用户反馈。

---

# Current Status

目前已经完成：

- Wine 11 Runtime 基础环境
- Docker 化运行
- 32-bit / 64-bit 支持
- X11 GUI Runtime
- CJKV 字体环境
- Fcitx5 输入法支持
- 外部字体注入
- Persistent Wine Prefix
- Runtime Launcher
- Runtime Workspace
- Docker Hub 发布
- GitHub 开源项目发布

目前仍在持续完善：

- 更完整的软件安装兼容性测试
- 软件安装韧性测试
- 蓝牙模块兼容性
- 更多 Windows 应用兼容性测试
- Wine 底层 Runtime 一键升级
- Windows 应用双击关联安装
- 更完善的 Fcitx5 / Rime 配置
- 更完整的故障排查文档
- 更完整的迁移与恢复文档
- 更多自动化部署功能

---

# Roadmap

后续版本将根据实际测试结果继续完善。

## Runtime

- Wine Runtime 更新机制
- 更完善的 Runtime upgrade workflow
- Runtime rollback
- Runtime backup / restore
- 更完善的 Docker deployment automation

## Compatibility

- 更多 Windows application compatibility testing
- Bluetooth compatibility
- USB device compatibility
- Hardware-related compatibility
- Windows application installation resilience

## Desktop Integration

- Windows application desktop integration
- `.exe` file association
- Double-click installation
- Application launcher integration

## Input & CJKV

- Fcitx5 / Rime optimization
- More CJKV font compatibility
- Better Japanese / Korean input support
- Better application-specific input compatibility

## Documentation

- Complete installation guide
- Troubleshooting guide
- Architecture documentation
- Advanced configuration guide
- Migration guide
- Recovery guide

---

# Project Philosophy

Wine Runtime Wine11 CJKV Public Edition 希望探索一种不同于传统 Wine 安装方式的思路。

传统方式：

    Linux Host
        │
        └── Wine
             ├── Windows Applications
             ├── Wine Prefix
             └── System Configuration

本项目：

    Linux Host
        │
        ├── Docker
        │
        └── Wine Runtime Container
              │
              ├── Wine 11
              ├── CJKV Environment
              ├── Fcitx5
              └── Windows Applications

    Host Persistent Data
              │
              └── ~/wine-runtime-data/
                    ├── wineprefix
                    ├── fonts
                    ├── installers
                    ├── shared
                    ├── backups
                    └── logs

核心思路是：

> **Runtime 与用户数据分离。**

这样可以让 Wine 环境更加容易：

- 部署
- 复制
- 迁移
- 备份
- 恢复
- 升级
- 测试

---

# Repository

GitHub:

https://github.com/LimBehSong-Studio/wine-runtime-wine11-cjkv

Docker Hub:

https://hub.docker.com/r/conradtech/wine-runtime-wine11-cjkv

欢迎提交：

- Issues
- Bug reports
- Compatibility reports
- Feature requests
- Pull Requests

如果你成功使用本 Runtime 运行某个 Windows 软件，也欢迎反馈软件名称、Wine 配置以及运行情况。

这些实际测试结果将帮助项目继续完善。

---

## Current Documentation Status

> This README is currently being improved.

The runtime is functional, but documentation is still being expanded.

The current release is intended for public preview and real-world compatibility testing.

---

## Support the Project

Wine Runtime Wine11 CJKV Public Edition is maintained as an independent open-source project.

If this project is useful to you, you are welcome to support its continued development, testing, documentation, and maintenance.

### 支持项目

如果这个项目对你有帮助，欢迎通过赞赏支持项目后续的开发、测试、文档完善与维护。

<div align="center">

<table>
<tr>
<td align="center">
<img src="assets/Alipay.jpg" width="220">

**Alipay / 支付宝**
</td>

<td align="center">
<img src="assets/Wechatpay.png" width="220">

**WeChat Pay / 微信支付**
</td>
</tr>
</table>

**Thank you for supporting open-source development!**

感谢你的支持 ❤️

</div>

> Donations are voluntary and do not provide any guaranteed support, service, or commercial license.
