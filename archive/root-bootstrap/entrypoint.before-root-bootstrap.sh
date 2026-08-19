#!/bin/bash

set -e

echo "=== Wine Runtime Starting ==="


#######################################
# Wine Environment
#######################################

export HOME=/home/wineuser

export WINEPREFIX=/opt/wineprefix

export WINEARCH=win64

export PATH=/usr/bin:/bin:$PATH

export TERM=xterm


#######################################
# XDG / DBus Runtime Environment
#######################################

# IMPORTANT:
# Do not overwrite XDG_RUNTIME_DIR when it is provided
# by the host session.
#
# Fcitx5 uses the host user's DBus session bus.
# Overwriting XDG_RUNTIME_DIR with a container-local
# directory breaks the DBus connection and therefore
# breaks Wine + Fcitx5 input method integration.

if [ -z "${XDG_RUNTIME_DIR:-}" ]; then

    export XDG_RUNTIME_DIR="/tmp/runtime-$(id -u)"

    mkdir -p "$XDG_RUNTIME_DIR"

    chmod 700 "$XDG_RUNTIME_DIR"

    echo "XDG_RUNTIME_DIR was not provided by host."
    echo "Using fallback: $XDG_RUNTIME_DIR"

else

    echo "Using host XDG_RUNTIME_DIR: $XDG_RUNTIME_DIR"

fi


# Preserve the host DBus session bus when provided.
if [ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then

    echo "Using DBUS_SESSION_BUS_ADDRESS: $DBUS_SESSION_BUS_ADDRESS"

else

    echo "DBUS_SESSION_BUS_ADDRESS is not set."

fi


#######################################
# Input Method Environment
#######################################

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx


#######################################
# Wine Prefix Initialization
#######################################

if [ ! -f "$WINEPREFIX/system.reg" ]; then

    echo "Initializing Wine prefix..."

    wineboot -u

else

    echo "Existing Wine prefix detected."

fi


#######################################
# Font Initialization
#######################################

if [ ! -f "$WINEPREFIX/.font_init_done" ]; then

    bash /usr/local/bin/init-fonts.sh

    touch "$WINEPREFIX/.font_init_done"

else

    echo "Fonts already initialized."

fi


#######################################
# Wine XIM Configuration
#######################################

echo "Configuring Wine XIM..."

wine reg add \
    "HKCU\Software\Wine\X11 Driver" \
    /v UseXIM \
    /d Y \
    /f || true


#######################################
# Runtime Status
#######################################

echo "Wine Ready."

echo "HOME=$HOME"
echo "WINEPREFIX=$WINEPREFIX"
echo "WINEARCH=$WINEARCH"
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"

if [ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
    echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"
fi


#######################################
# Launch
#######################################

if [ $# -eq 0 ]; then

    exec /usr/local/bin/launcher.sh

fi


exec "$@"
