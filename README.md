# 林北松工作室 · Conradtech 首个作品

# Wine Runtime Wine11 CJKV

**Docker 化 Wine 11 + CJKV Windows 应用运行时环境**

**当前版本：** `0.1.0-rc1.20260825`
**发布阶段：** `Release Candidate / RC1`

Docker Image：

```bash
docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-rc1.20260825
```

---

## 项目简介

**Wine Runtime Wine11 CJKV** 是一个面向 Linux Desktop 的容器化 Wine 11 Windows 应用运行时环境。

本项目并不是针对某一个 Windows 软件制作的专用容器，而是希望提供一个：

* 可重复部署
* 可持久化
* 可迁移
* 可扩展
* 与宿主机环境相对隔离

的通用 Windows 应用兼容运行环境。

项目的核心思路是：

> **把 Wine 从安装在 Linux 宿主机上的软件，变成一个可以独立部署、复制、迁移和维护的 Runtime 环境。**

Wine Runtime 本身通过 Docker Image 提供，而用户自己的 Wine Prefix、字体、安装程序以及共享数据则与 Docker Image 分离保存。

---

# Current Release

当前公开 Release Candidate：

```text
0.1.0-rc1.20260825
```

发布阶段：

> **Release Candidate / RC1**

该版本是在此前：

```text
0.1.0-preview.20260808
```

公开 Preview 基础上的进一步 Runtime 固化版本。

RC1 主要用于：

* Runtime 基础环境验收
* Wine 11 Runtime 验证
* CJKV 字体环境验证
* Mono / Gecko Runtime 验证
* X11 GUI 应用验证
* Windows 应用安装兼容性测试
* 后续软件兼容性测试
* Release Candidate 阶段问题收集

Docker Image：

```bash
docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-rc1.20260825
```

---

# Project Status

当前项目已经完成：

* GitHub 公开发布
* Docker Hub 公开发布
* Wine 11 Runtime 基础环境
* Ubuntu 22.04 Runtime 基础环境
* 32-bit / 64-bit Windows 应用运行环境
* X11 GUI Runtime
* CJKV 字体环境
* Wine 字体注册与替换机制
* Fcitx5 输入法集成
* 外部字体注入机制
* Persistent Wine Prefix
* Runtime Workspace
* Runtime Launcher
* Wine Mono
* Wine Gecko

当前仍在持续进行：

* 更多 Windows 软件安装测试
* Windows 软件兼容性测试
* 软件安装韧性测试
* Adobe 等生产力软件兼容性测试
* Bluetooth / winebth 兼容性测试
* Windows 应用桌面集成
* `.exe` 文件关联
* Runtime 升级与回滚机制
* 更完整的故障排查文档
* 更多 CJKV 应用兼容性验证

因此：

> **RC1 是可实际测试和使用的 Release Candidate，但并不代表所有 Windows 软件或硬件相关功能均已完成兼容性验收。**

---

# Overview

Wine Runtime Wine11 CJKV 基于：

* Ubuntu 22.04.5 LTS
* WineHQ Stable 11
* 32-bit / 64-bit Windows 应用运行环境
* X11 GUI 应用支持
* Fcitx5 输入法集成
* 中文 Locale 配置
* CJKV 字体环境
* 外部字体注入机制
* 持久化 Wine Prefix
* Wine Mono
* Wine Gecko

其中 **CJKV** 指：

* 中文（Chinese）
* 日文（Japanese）
* 韩文（Korean）
* 越南文（Vietnamese）

项目重点解决 Linux + Wine 环境下 Windows 应用运行过程中常见的：

* CJKV 字体
* 中文环境
* 输入法
* Wine Prefix 持久化
* Docker Runtime 隔离
* Runtime 与用户数据分离

等问题。

---

# Features

当前 Runtime 主要提供：

* WineHQ Stable 11 Runtime
* Docker 化运行
* 32-bit / 64-bit Windows 应用支持
* X11 GUI 应用支持
* Wine Mono
* Wine Gecko
* 持久化 Wine Prefix
* Fcitx5 输入法集成
* 中文 Locale 环境
* CJKV 字体支持
* Wine 字体注册与替换
* 外部字体注入
* 持久化应用数据
* 可重复的 Runtime 配置
* 宿主机 Runtime Workspace
* Runtime Launcher
* Docker Image 部署
* Runtime 与用户数据分离

项目并不以“兼容所有 Windows 软件”为目标，也不会对任何第三方 Windows 应用做无条件兼容保证。

---

# Quick Start

## 方式一：使用 Docker Image

获取当前 Release Candidate：

```bash
docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-rc1.20260825
```

建议固定使用明确版本号，而不是依赖不断变化的 `latest` 标签。

这样可以保证：

> **测试环境、部署环境和后续回滚环境使用的是同一个 Runtime 版本。**

---

## 方式二：使用 Runtime Launcher

项目提供：

```text
start.sh
```

用于简化 Runtime 的启动过程。

进入项目目录：

```bash
cd ~/wine-runtime-wine11-cjkv
```

赋予执行权限：

```bash
chmod +x start.sh
```

启动：

```bash
./start.sh
```

Runtime Launcher 负责处理 Runtime 启动过程中需要的相关 Docker、X11 以及数据目录配置。

当前 Runtime Workspace 包括：

* Wine Prefix
* 外部字体目录
* Windows 安装程序目录
* Shared 数据目录
* Runtime 日志目录

> **注意：`start.sh` 主要针对项目当前 Runtime 配置以及本地环境设计。使用 Docker Hub 公共镜像时，请根据当前版本的 Runtime 配置进行调整。**

---

# Runtime Workspace

Runtime 默认使用：

```text
~/wine-runtime-data/
```

推荐目录结构：

```text
~/wine-runtime-data/

├── fonts/
│   └── 外部字体
│
├── wineprefix/
│   └── 持久化 Wine Prefix
│
├── installers/
│   └── Windows 应用安装程序
│
├── backups/
│   └── 备份数据
│
├── shared/
│   └── 宿主机与 Runtime 共享文件
│
└── logs/
    └── Runtime 日志
```

Runtime 数据与 Docker Image 分离。

因此，在正常的 Volume 持久化配置下：

> **重新创建 Container 并不等于删除用户自己的 Wine Prefix。**

这也是本项目 Runtime 设计的重要组成部分。

---

# Windows 应用安装

Windows 应用安装程序推荐放置在：

```text
~/wine-runtime-data/installers/
```

常见安装格式包括：

```text
.exe
.msi
```

例如：

```text
~/wine-runtime-data/installers/

├── setup.exe
├── application.exe
└── application.msi
```

安装程序本身保存在 Linux 宿主机中，而不是 Docker Image 内。

因此，在 Runtime 重新创建、升级或迁移时，原有安装程序仍然可以继续使用。

---

# Wine Prefix 持久化

Wine Prefix 默认存储在宿主机：

```text
~/wine-runtime-data/wineprefix/
```

Container 内对应：

```text
/opt/wineprefix
```

典型 Volume Mapping：

```bash
-v ~/wine-runtime-data/wineprefix:/opt/wineprefix
```

Wine Prefix 保存 Windows 应用运行过程中产生的大量持久化状态，例如：

* Windows 应用设置
* Wine 配置
* Windows Registry
* 已安装应用数据
* 应用兼容性配置
* Wine 环境状态

因此，Runtime Image 与 Wine Prefix 可以相互独立。

这使得后续可以进一步实现：

* Runtime Image 升级
* Wine Prefix 持久化
* Runtime 迁移
* Prefix 备份
* 不同 Runtime 版本测试

而不需要每次重新建立整个 Windows 应用环境。

> **建议在进行重大 Runtime 升级、实验性修改或兼容性测试前，对 Wine Prefix 进行备份。**

---

# Wine Mono

Runtime 包含 Wine Mono，用于支持依赖 .NET / Mono Runtime 的 Windows 应用。

Mono Runtime 已经过基础运行环境以及 Windows GUI 应用相关测试。

其中包括：

* C# 程序运行
* WinForms
* `System.Windows.Forms`
* `System.Drawing`
* Windows GUI / MessageBox

但是：

> **Mono Runtime 可用并不代表所有基于 .NET 的 Windows 软件均可正常运行。**

不同软件可能依赖不同版本的 .NET Framework、Windows API、第三方组件或特定运行库。

因此，具体软件仍需要单独进行兼容性测试。

---

# Wine Gecko

Runtime 包含 Wine Gecko。

Wine Gecko 主要用于支持 Wine 环境中依赖 HTML / Web rendering 的 Windows 应用组件。

与 Mono 一样：

> **Gecko Runtime 存在并正常初始化，不等于所有依赖 WebView / HTML rendering 的 Windows 软件均经过完整兼容性验收。**

具体软件仍需要进行实际测试。

---

# 字体支持

## Font Policy

Wine Runtime Wine11 CJKV **不主动分发微软专有 Windows 系统字体。**

例如：

* Microsoft YaHei / 微软雅黑
* SimSun / 宋体
* SimHei / 黑体
* Microsoft JhengHei
* Malgun Gothic
* MS Gothic
* 其他具有相应商业授权限制的 Windows 字体

本项目不会为了提高兼容性而直接在 Docker Image 中打包未经授权的商业 Windows 字体。

如果某个 Windows 应用依赖特定商业字体，用户可以根据自身拥有的授权情况自行提供字体文件。

> **字体文件的版权、授权及合法使用责任由用户自行承担。**

请勿通过本项目获取、传播或重新分发没有相应授权的商业字体。

---

# 内置 CJK 字体

Runtime 提供用于基础 CJK 字符显示的开源字体资源。

当前项目使用的字体资源包括：

* Noto CJK
* Jigmo
* HanaMin
* 其他项目实际包含的开源字体资源

这些字体分别遵循各自的开源许可证。

具体字体文件及其授权信息，请以项目实际 `fonts/` 文件和对应字体项目的 License 为准。

本项目不会因为使用开源 CJK 字体，就对所有 Windows 应用的字体兼容性作出保证。

---

# CJKV 字体兼容

很多 Windows 应用会依赖特定系统字体进行文字渲染。

如果 Runtime 中缺少应用所需要的字体，可能出现：

```text
□□□□
```

或者：

* 中文显示为缺字方框
* 日文显示异常
* 韩文显示异常
* 字体 Fallback 不符合预期
* 应用界面字体与 Windows 原生环境存在差异
* 特定字符无法正确显示

本项目已经提供 CJKV 字体加载、Wine 字体注册以及字体替换机制。

但是：

> **CJKV Runtime 并不意味着所有 Windows 软件都可以在任何情况下正确显示所有 CJK 字符。**

不同 Windows 应用可能使用不同的字体 API、字体名称、Fallback 机制或私有字体。

因此，字体兼容性仍然属于应用级问题。

---

# 外部字体注入

用户可以通过宿主机目录向 Runtime 注入额外字体。

推荐目录：

```text
~/wine-runtime-data/fonts/
```

Container 内对应：

```text
/opt/extra_fonts/
```

典型 Volume Mapping：

```bash
-v ~/wine-runtime-data/fonts:/opt/extra_fonts
```

Runtime 支持处理常见字体格式：

```text
.ttf
.ttc
.otf
```

例如：

```text
~/wine-runtime-data/fonts/

├── example.ttf
├── example.otf
├── example.ttc
└── custom-fonts/
```

用户可以根据自己的实际需求加入合法获得并拥有使用权的字体。

例如：

* Noto CJK
* HanaMin
* Jigmo
* 用户自行获得授权的商业字体

---

# 遇到 `□□□□` 怎么办？

如果 Windows 应用出现：

```text
□□□□
```

或者部分 CJK 字符无法正常显示，可以按照以下顺序排查：

### 1. 确认 Runtime 本身能够识别 CJK 字体

首先确认问题不是整个 Runtime 的 CJK 字体环境失效。

### 2. 确认应用是否依赖特定字体

部分 Windows 应用并不是简单寻找“任意中文字体”，而是直接请求某个特定字体名称。

例如某些应用可能明确依赖：

```text
SimSun
SimHei
Microsoft YaHei
MS Gothic
```

等字体。

### 3. 使用合法获得的字体进行外挂

将拥有合法使用权的字体放入：

```text
~/wine-runtime-data/fonts/
```

然后重新启动 Runtime，使字体初始化过程重新处理字体。

### 4. 重新测试应用

不同 Windows 软件的字体机制差异很大。

因此：

> **Runtime 提供字体基础设施，但最终显示效果仍取决于具体 Windows 应用。**

---

# X11 GUI

本项目目前主要面向：

```text
Linux Desktop + X11
```

Windows GUI 应用通过 Docker Container 的 X11 forwarding 显示到 Linux Desktop。

因此使用 Runtime 前，需要确保：

* Linux Desktop 正常运行
* X11 环境正常
* Docker Container 可以访问宿主机 X11 Display

项目当前主要针对实际 Linux Desktop + X11 环境进行开发和测试。

Wayland-only、特殊远程桌面环境以及其他非标准图形环境可能需要额外配置。

---

# Fcitx5 输入法

Runtime 已完成 Fcitx5 输入法集成以及相关兼容性配置。

目前主要针对：

* Fcitx5
* Fcitx5 中文输入环境
* CJKV 语言环境

进行开发和测试。

当前重点验证的是：

```text
Fcitx5
    ↓
Linux Desktop
    ↓
Wine Runtime
    ↓
Windows Application
```

输入法相关环境。

> **注意：目前项目主要针对 Fcitx5 进行实际测试和兼容性修复。其他 Linux 输入法暂未进行完整测试，因此暂不做兼容性保证。**

同时，不同 Windows 应用对输入法的实现方式存在差异。

因此，即使宿主机使用 Fcitx5，部分特殊 Windows 软件仍然可能需要进一步的兼容性调整。

---

# Bluetooth / Hardware Compatibility

Bluetooth、USB 以及其他硬件相关 Windows 应用属于独立兼容性领域。

当前项目正在持续测试：

* Wine Bluetooth / `winebth`
* Bluetooth 设备相关应用
* USB 设备相关应用
* Windows 硬件管理软件
* 依赖 Windows Driver / Device API 的应用

因此当前阶段：

> **不要将 Bluetooth / 硬件兼容性视为 RC1 的全面完成项目。**

实际兼容性需要根据具体硬件、Linux Host、Wine API 以及 Windows 应用分别验证。

---

# Project Structure

当前项目根目录主要包含：

```text
wine-runtime-wine11-cjkv/

├── Dockerfile
├── README.md
├── RESTORE.md
├── start.sh
│
├── scripts/
│   ├── entrypoint.sh
│   ├── init-fonts.sh
│   ├── init-host.sh
│   └── launcher.sh
│
├── fonts/
│   └── 内置字体资源
│
├── extra_fonts/
│   └── 额外字体资源
│
├── gecko/
│   └── Wine Gecko 资源
│
├── mono/
│   └── Wine Mono 资源
│
├── assets/
│   └── 项目资源
│
└── archive/
    └── 历史开发文件
```

历史开发阶段使用过的 Dockerfile 已移动至 `archive/`。

当前 Runtime 构建使用：

```text
Dockerfile
```

---

# Runtime 恢复

项目提供：

```text
RESTORE.md
```

以及：

```text
一键恢复流程.txt
```

用于记录 Runtime 的恢复、重新部署以及相关操作流程。

由于项目采用：

> **Docker Image + GitHub 源码 + Host Runtime Data 分离**

的设计，即使本地 Container 出现问题，也可以重新获取项目源码与 Docker Image，再结合持久化 Runtime 数据重新建立运行环境。

---

# Version History

## 0.1.0-rc1.20260825

**Release Candidate / RC1**

当前最新公开 Release Candidate。

主要目标：

* 固化 Wine 11 Runtime 基础环境
* 完善 Runtime 初始化流程
* CJKV 字体 Runtime 初始化
* Mono / Gecko Runtime
* X11 GUI 环境
* 为 Windows 应用兼容性测试提供稳定基线

Docker Image：

```bash
docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-rc1.20260825
```

---

## 0.1.0-preview.20260808

**Public Preview**

项目首次公开发布版本。

主要用于：

* Docker Runtime 公开测试
* CJKV 环境测试
* Wine Prefix 持久化测试
* Fcitx5 测试
* Windows 应用兼容性测试

该版本现作为历史 Preview 保留。

---

# 当前完成情况

## 已完成

目前已经完成：

* Wine 11 Runtime 基础环境
* Docker 化运行
* 32-bit / 64-bit Windows 应用环境
* X11 GUI Runtime
* Wine Mono
* Wine Gecko
* CJKV 字体环境
* CJK 字体注册与替换机制
* Fcitx5 输入法集成
* 外部字体注入
* Persistent Wine Prefix
* Runtime Launcher
* Runtime Workspace
* GitHub 开源项目发布
* Docker Hub 镜像公开发布
* Release Candidate 基础版本发布

---

## 持续完善

目前仍在持续完善：

* 更多 Windows 应用兼容性测试
* Adobe 等生产力软件兼容性测试
* 软件安装韧性测试
* Bluetooth 兼容性
* USB 设备兼容性
* Wine 底层 Runtime 一键升级
* Windows 应用双击关联安装
* 更完善的 Fcitx5 / Rime 配置
* 更完整的故障排查文档
* 更完整的迁移与恢复文档
* 更多自动化部署功能
* 更多 CJKV 应用兼容性测试

---

# Roadmap

后续版本将根据实际测试结果以及社区反馈继续完善。

## Runtime

* Wine Runtime 更新机制
* 更完善的 Runtime 升级流程
* Runtime Rollback
* Runtime Backup / Restore
* 更完善的 Docker 部署自动化

## Windows 应用兼容性

* 更多 Windows 应用兼容性测试
* Adobe Acrobat 等生产力软件测试
* 软件安装韧性测试
* Bluetooth 兼容性
* USB 设备兼容性
* 硬件相关应用兼容性
* Windows 应用安装流程优化

## Desktop Integration

* Windows 应用桌面集成
* `.exe` 文件关联
* 双击安装
* Windows 应用 Launcher 集成

## 输入法与 CJKV

* Fcitx5 / Rime 进一步优化
* 更多 CJKV 字体兼容性测试
* 更完善的日文输入支持
* 更完善的韩文输入支持
* 更完善的应用级输入法兼容性

## 文档

* 完整安装手册
* 故障排查指南
* Runtime 架构文档
* 高级配置指南
* Runtime 迁移指南
* Runtime 恢复指南

---

# 项目设计理念

传统 Wine 安装方式通常类似：

```text
Linux Host
    │
    └── Wine
         ├── Windows Applications
         ├── Wine Prefix
         └── System Configuration
```

Wine Runtime Wine11 CJKV 希望探索另一种方式：

```text
Linux Host
    │
    ├── Docker
    │
    └── Wine Runtime Container
          │
          ├── Wine 11
          ├── CJKV Environment
          ├── Fcitx5
          ├── Mono
          └── Gecko

Host Persistent Data
          │
          └── ~/wine-runtime-data/
                ├── wineprefix
                ├── fonts
                ├── installers
                ├── shared
                ├── backups
                └── logs
```

核心思路只有一句话：

> **Runtime 与用户数据分离。**

这样可以让 Wine 环境更加容易：

* 部署
* 复制
* 迁移
* 备份
* 恢复
* 升级
* 测试

最终希望形成的是一个真正意义上的：

> **Windows Application Runtime for Linux**

而不是一个只针对某一个软件的临时 Wine 容器。

---

# Repository

GitHub：

https://github.com/LimBehSong-Studio/wine-runtime-wine11-cjkv

Docker Hub：

https://hub.docker.com/r/conradtech/wine-runtime-wine11-cjkv

欢迎提交：

* Issue
* Bug Report
* Compatibility Report
* Feature Request
* Pull Request
* Documentation Improvement

如果你成功使用本 Runtime 运行某个 Windows 软件，也非常欢迎反馈：

```text
软件名称：
软件版本：
Runtime 版本：
Linux 发行版：
安装方式：
运行结果：
CJK / 字体表现：
输入法：
额外配置：
错误信息 / 日志：
```

实际的 Windows 应用兼容性反馈，对于后续 Runtime 的完善非常有价值。

---

# 支持项目

**Wine Runtime Wine11 CJKV** 是林北松工作室 / Conradtech 的独立开源项目。

如果这个项目帮助你节省了时间、解决了 Linux 下运行 Windows 应用的问题，欢迎通过赞赏支持项目后续的：

* Runtime 开发
* 兼容性测试
* 文档完善
* Bug 排查
* 社区维护
* 后续版本开发

## 支持方式

### 支付宝

![支付宝赞赏码](assets/Alipay.jpg)

### 微信支付

![微信支付赞赏码](assets/Wechatpay.png)

感谢每一位使用、测试、反馈以及支持这个项目的人 ❤️

> 赞赏属于自愿支持，不代表任何商业服务、技术支持承诺或软件授权。

---

# 免责声明

Wine Runtime Wine11 CJKV 是一个基于 Wine 的开源 Windows 应用兼容运行环境。

本项目：

* 不包含 Windows 操作系统
* 不提供 Windows 操作系统许可证
* 不提供第三方 Windows 软件许可证
* 不主动分发未经授权的微软专有字体
* 不保证任何第三方 Windows 软件兼容
* 不保证与原生 Windows 环境具有完全相同的行为或显示效果
* 不保证 Windows 驱动、蓝牙设备、USB 设备以及其他硬件相关软件兼容

用户自行负责获取并合法使用 Windows 软件、字体、运行库以及其他第三方组件。

第三方软件、字体及其他资源均受其各自适用的许可证约束。

---

# 最后

这是 **林北松工作室 · Conradtech 的第一个公开作品**。

Wine Runtime Wine11 CJKV 已经从最初的实验性 Docker Wine 环境进入 **Release Candidate** 阶段。

RC1 的目标不是宣称：

> “所有 Windows 软件都已经可以运行。”

而是建立一个更加稳定、可重复部署、可验证和可持续迭代的 Wine Runtime 基线。

如果你遇到问题，欢迎提交 Issue。

如果你发现某个 Windows 软件可以正常运行，也欢迎告诉我们。

如果你发现某个软件存在字体、输入法、安装或者兼容性问题，同样欢迎反馈。

这些真实环境中的测试结果，会成为后续 Runtime 继续完善的重要依据。

**Wine Runtime Wine11 CJKV**

> **让 Wine 成为 Runtime，而不仅仅是一套安装在宿主机上的软件。**
