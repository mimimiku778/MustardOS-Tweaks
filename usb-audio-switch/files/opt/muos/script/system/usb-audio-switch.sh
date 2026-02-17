#!/bin/sh
export PIPEWIRE_RUNTIME_DIR=/run
export XDG_RUNTIME_DIR=/run
export PATH=/usr/bin:/usr/sbin:/bin:/sbin

INTERNAL_SINK="alsa_output._sys_devices_platform_soc_soc_03000000_codec_mach_sound_card0.stereo-fallback"
LOG="/tmp/usb-audio.log"

log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") $1" >> "$LOG"
}

find_sink_id() {
    pw-cli list-objects Node 2>/dev/null | awk -v pat="$1" \
        "/^[[:space:]]*id [0-9]/ { id = \$2; gsub(\",\",\"\",id) }
         /node.name/ && \$0 ~ pat { print id; exit }"
}

case "$1" in
    connect)
        # When called from udev, detach via setsid and re-exec
        if [ -z "$_USB_AUDIO_DETACHED" ]; then
            _USB_AUDIO_DETACHED=1 setsid "$0" connect </dev/null >>"$LOG" 2>&1 &
            exit 0
        fi
        log "Connect started (PID $$)"
        for i in $(seq 1 40); do
            USB_ID=$(find_sink_id "alsa_output[.]usb")
            if [ -n "$USB_ID" ]; then
                log "Found USB sink at attempt $i (node $USB_ID)"
                wpctl set-default "$USB_ID"
                log "Switched to USB audio (node $USB_ID)"
                exit 0
            fi
            sleep 0.5
        done
        log "USB audio sink not found after 20s"
        log "DEBUG: $(pw-cli list-objects Node 2>&1 | grep node.name)"
        ;;
    disconnect)
        INT_ID=$(find_sink_id "$INTERNAL_SINK")
        if [ -n "$INT_ID" ]; then
            wpctl set-default "$INT_ID"
            log "Switched to internal speaker (node $INT_ID)"
        else
            log "Internal sink not found"
        fi
        ;;
esac
