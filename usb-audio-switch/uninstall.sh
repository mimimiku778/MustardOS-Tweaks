#!/bin/sh
# Uninstall USB audio auto-switch

set -e

echo "Removing USB audio auto-switch..."

rm -f /opt/muos/script/system/usb-audio-switch.sh
rm -f /etc/udev/rules.d/99-usb-audio.rules
rm -f /tmp/usb-audio.log

udevadm control --reload-rules

echo "Done."
