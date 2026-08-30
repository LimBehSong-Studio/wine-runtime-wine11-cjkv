#!/bin/bash

set -e

BUILTIN_FONT_SRC=/usr/share/fonts/custom
EXTRA_FONT_SRC=/opt/extra_fonts

FONT_DST="$WINEPREFIX/drive_c/windows/Fonts"

font_count=0

mkdir -p "$FONT_DST"

echo "=== Font Setup ==="
echo "WINEPREFIX=$WINEPREFIX"
echo "HOME=$HOME"
echo "USER=$(id -un)"
echo "FONT_DST=$FONT_DST"


#######################################
# Install and register a font
#######################################

register_font()
{
    local font_file="$1"
    local filename
    filename=$(basename "$font_file")

    case "$filename" in
        *.ttf|*.TTF|*.ttc|*.TTC|*.otf|*.OTF)
            ;;
        *)
            return 0
            ;;
    esac

    echo "Installing: $filename"

    # Put the font into the Wine Windows Fonts directory.
    # Use a symlink so the Docker image does not need another
    # copy of the font data.
    ln -sf "$font_file" "$FONT_DST/$filename"

    echo "Registering font: $filename"

    # Register the actual Windows font file name.
    wine reg add \
        "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Fonts" \
        /v "$filename" \
        /d "$filename" \
        /f || true

    font_count=$((font_count + 1))
}


#######################################
# Scan a font directory
#######################################

install_fonts()
{
    local SRC="$1"

    if [ ! -d "$SRC" ]; then
        return 0
    fi

    echo "Scanning: $SRC"

    while IFS= read -r -d '' font
    do
        register_font "$font"
    done < <(
        find "$SRC" -type f \
            \( \
                -iname "*.ttf" \
                -o -iname "*.ttc" \
                -o -iname "*.otf" \
            \) \
            -print0
    )
}


#######################################
# Built-in fonts
#######################################

install_fonts "$BUILTIN_FONT_SRC"


#######################################
# Optional extra fonts
#######################################

install_fonts "$EXTRA_FONT_SRC"


#######################################
# Rebuild Linux font cache
#######################################

echo "Rebuilding font cache..."

fc-cache -f >/dev/null 2>&1 || true

echo "Installed fonts: $font_count"


if [ "$font_count" -eq 0 ]; then
    echo ""
    echo "WARNING:"
    echo "No fonts installed."
    echo "Chinese applications may display missing glyph boxes."
    echo ""
fi

#######################################
# Verify installed fonts
#######################################

echo "Verifying Wine Fonts directory..."

find "$FONT_DST" \
    -maxdepth 1 \
    -type f,l \
    -printf '%f -> %l\n' \
    2>/dev/null | sort || true


#######################################
# Windows Font Substitution
#######################################

echo "Configuring Windows font substitutions..."


FONT_MAP="
SimSun=Noto Serif CJK SC
NSimSun=Noto Serif CJK SC
SimHei=Noto Sans CJK SC
Microsoft YaHei=Noto Sans CJK SC
Microsoft JhengHei=Noto Sans CJK TC
MS Gothic=Noto Sans CJK JP
MS PGothic=Noto Sans CJK JP
微软雅黑=Noto Sans CJK SC
宋体=Noto Serif CJK SC
黑体=Noto Sans CJK SC
Noto Sans CJK SC=Noto Sans CJK SC Regular
Noto Sans CJK JP=Noto Sans CJK JP Regular
Noto Sans CJK KR=Noto Sans CJK KR Regular
Noto Sans CJK TC=Noto Sans CJK TC Regular
"


while IFS="=" read -r winfont linuxfont
do

    [ -z "$winfont" ] && continue


    wine reg add \
    "HKCU\Software\Wine\Fonts\Replacements" \
    /v "$winfont" \
    /d "$linuxfont" \
    /f || true


done <<< "$FONT_MAP"



echo "Font substitution complete."


echo "Font setup complete."
