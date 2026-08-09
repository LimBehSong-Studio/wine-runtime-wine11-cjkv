# Restore Guide / 恢复指南

## Wine Runtime Release

**Release Name:**

wine-runtime-wine11-cjkv-fcitx5-20260712

**Release Date:**

2026-07-12

---

# 1. Overview / 概述

This package contains a verified Docker Wine runtime environment.

本归档包含一个已经验证通过的 Docker Wine 运行环境。

Included components:

包含组件：

- Docker image archive / Docker 镜像归档
- Dockerfile / 镜像构建文件
- Runtime scripts / 运行脚本
- Documentation / 文档说明
- Integrity checksum / 完整性校验文件


The Docker image has been tested and validated before release.

该 Docker 镜像已经经过测试，并在发布前完成验证。

---

# 2. Restore Docker Image / 恢复 Docker 镜像

## Step 1: Extract Release Package

## 第一步：解压发布包


Copy the release archive to the target machine.

将 release 压缩包复制到目标机器。


Run:

执行：

```bash
tar -xzvf wine-runtime-wine11-cjkv-fcitx5-20260712-release.tar.gz
