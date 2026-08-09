# Wine Runtime Wine11 CJKV Public Edition

Release: 2026-08 Preview

Docker Pull：docker pull conradtech/wine-runtime-wine11-cjkv:0.1.0-preview.20260808

# Overview

Wine Runtime CJKV Public Edition is a portable Wine 11 runtime environment
designed for running Windows applications on Linux systems.

The runtime provides a reproducible Windows compatibility environment based on:

- Ubuntu 22.04.5 LTS
- WineHQ Stable 11
- 32-bit and 64-bit Windows application support
- Fcitx5 input method integration
- Chinese locale configuration
- CJKV rendering support


# Features

- WineHQ Stable 11 runtime
- Linux container isolation
- Host-side persistent Wine prefix
- X11 application support
- Fcitx5 IME integration
- Chinese locale support
- CJK font loading framework
- External font injection system


# Font Policy

Wine Runtime CJKV Public Edition does not include proprietary Microsoft fonts.

Examples of proprietary fonts:

- Microsoft YaHei
- SimSun
- Microsoft JhengHei
- Malgun Gothic
- Other licensed Windows fonts


Users are responsible for obtaining and using fonts according to
their own licensing requirements.


# Built-in Fonts

The default image may include open-source fonts for basic CJK rendering.

These fonts are provided under their respective open-source licenses.

Included fonts may include:

- Noto CJK
- WenQuanYi fonts
- Other open-source CJK font families


For detailed font licenses, please refer to the corresponding font licenses.


# CJK Font Configuration

Windows applications rely on installed fonts for correct text rendering.

Without suitable CJK fonts:

- Chinese characters may appear as missing glyph boxes (口口)
- Font fallback may use Linux system fonts
- Application appearance may differ from Windows environments


This runtime provides font loading support but cannot provide
licensed proprietary fonts.


# External Font Injection

Users may provide additional fonts through:
