#!/bin/bash

set -e

#######################################
# Wine Runtime Launcher
#######################################

VERSION="0.1.0-preview.20260808"

IMAGE="wine-runtime-wine11-cjkv-public:${VERSION}"

DATA_DIR="$HOME/wine-runtime-data"

echo "====================================="
echo " Wine Runtime Launcher ${VERSION}"
echo "====================================="

echo


#######################################
# Host initialization
#######################################

if [ -f "./scripts/init-host.sh" ]; then

    ./scripts/init-host.sh

else

    echo "Warning:"
    echo "init-host.sh not found."

fi


#######################################
# Runtime Health Check
#######################################

echo

echo "====================================="
echo " Wine Runtime Health Check "
echo "====================================="

check_dir () {

    if [ -d "$1" ]; then
        echo "[✓] $2"
    else
        echo "[!] $2 missing"
    fi

}


check_dir "$DATA_DIR/wineprefix" "Wine Prefix"
check_dir "$DATA_DIR/fonts" "Fonts Directory"
check_dir "$DATA_DIR/installers" "Installers Directory"
check_dir "$DATA_DIR/shared" "Shared Directory"
check_dir "$DATA_DIR/logs" "Logs Directory"


if [ -n "$DISPLAY" ]; then

    echo "[✓] X11 Display: $DISPLAY"

else

    echo "[!] DISPLAY not detected"

fi


echo

echo "Docker Image:"
echo "$IMAGE"

echo


#######################################
# X11 permission
#######################################

if command -v xhost >/dev/null 2>&1; then

    xhost +local:docker >/dev/null 2>&1 || true

fi


#######################################
# Check Docker image
#######################################

if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then

    echo
    echo "Docker image not found:"
    echo "$IMAGE"

    echo
    echo "Please build or pull the image first."

    exit 1

fi


echo

echo "Starting Wine Runtime..."

echo


#######################################
# Start Container
#######################################

docker run --rm -it \
    --user 1000:1000 \
    --security-opt apparmor=unconfined \
    -e DISPLAY="$DISPLAY" \
    -e XDG_RUNTIME_DIR=/tmp/runtime-1000 \
    -e GTK_IM_MODULE=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e XMODIFIERS=@im=fcitx \
    -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/1000:/run/user/1000 \
    -v "$DATA_DIR/wineprefix":/opt/wineprefix \
    -v "$DATA_DIR/fonts":/opt/extra_fonts \
    -v "$DATA_DIR/installers":/opt/installers \
    -v "$DATA_DIR/shared":/opt/shared \
    -v "$DATA_DIR/logs":/opt/logs \
    "$IMAGE" \
    bash