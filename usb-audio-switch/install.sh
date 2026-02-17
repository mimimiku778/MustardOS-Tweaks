#!/bin/sh
# Install USB audio auto-switch for MustardOS (RG40XX V)
#
# Usage:
#   Run on-device:  sh install.sh
#   Run via SSH:    ssh rg40xxv 'sh -s' < install.sh
#   Or with scp:    scp -r usb-audio-switch rg40xxv:/tmp/ && ssh rg40xxv 'sh /tmp/usb-audio-switch/install.sh'

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FILES_DIR="$SCRIPT_DIR/files"

if [ ! -d "$FILES_DIR" ]; then
    echo "Error: files/ directory not found at $FILES_DIR" >&2
    exit 1
fi

echo "Installing USB audio auto-switch..."

cp "$FILES_DIR/opt/muos/script/system/usb-audio-switch.sh" \
   /opt/muos/script/system/usb-audio-switch.sh
chmod +x /opt/muos/script/system/usb-audio-switch.sh

cp "$FILES_DIR/etc/udev/rules.d/99-usb-audio.rules" \
   /etc/udev/rules.d/99-usb-audio.rules

udevadm control --reload-rules

echo "Done. Plug in a USB audio device to test."
