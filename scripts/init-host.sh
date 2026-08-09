#!/bin/bash

set -e


DATA_DIR="$HOME/wine-runtime-data"


echo "====================================="
echo " Wine Runtime Host Initialization "
echo "====================================="


echo

echo "Creating workspace..."


mkdir -p "$DATA_DIR/fonts"
mkdir -p "$DATA_DIR/wineprefix"
mkdir -p "$DATA_DIR/installers"
mkdir -p "$DATA_DIR/backups"
mkdir -p "$DATA_DIR/shared"
mkdir -p "$DATA_DIR/logs"


echo

echo "Workspace:"
echo "  $DATA_DIR"


echo

echo "Folders:"
echo "  fonts"
echo "  wineprefix"
echo "  installers"
echo "  backups"
echo "  shared"
echo "  logs"



#######################################
# Desktop shortcut
#######################################

DESKTOP_DIR=$(xdg-user-dir DESKTOP 2>/dev/null || true)


if [ -n "$DESKTOP_DIR" ] && [ -d "$DESKTOP_DIR" ]; then

    LINK_PATH="$DESKTOP_DIR/Wine Runtime Data"


    if [ ! -e "$LINK_PATH" ]; then

        ln -s "$DATA_DIR" "$LINK_PATH"


        echo
        echo "Desktop shortcut created:"
        echo "  $LINK_PATH"


    else

        echo
        echo "Desktop shortcut already exists."


    fi


else

    echo
    echo "Desktop directory not detected."
    echo "Skipping shortcut creation."

fi



echo

echo "Next Steps:"
echo

echo "1. Add fonts:"
echo "   $DATA_DIR/fonts"

echo

echo "2. Add Windows installers:"
echo "   $DATA_DIR/installers"

echo

echo "3. Wine prefix location:"
echo "   $DATA_DIR/wineprefix"



echo

echo "====================================="
echo " Initialization Complete "
echo "====================================="