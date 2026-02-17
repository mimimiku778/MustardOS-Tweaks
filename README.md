# MustardOS Tweaks

Small quality-of-life modifications for [MustardOS](https://muos.dev/) on Anbernic devices.

---

## USB Audio Auto-Switch

Automatically routes audio to a USB audio device when plugged in, and back to the internal speaker when unplugged. No manual configuration needed in RetroArch or other apps.

**Tested on:** RG40XX V, MustardOS 2601.0 Jacaranda

### Quick Guide

#### You need

- A USB-C OTG adapter (or direct USB-C audio device)
- ADB enabled on your device: **Settings > Connection > USB Function > ADB**
- `adb` on your computer — [Minimal ADB and Fastboot](https://xdaforums.com/t/tool-minimal-adb-and-fastboot-2-9-18.2317790/) (~2 MB, Windows) / Mac: `brew install android-platform-tools`

#### Install

1. **Download** the latest `usb-audio-switch.zip` from the [Releases page](https://github.com/mimimiku778/MustardOS-Tweaks/releases) and extract it.

2. **Open a terminal** (Command Prompt or PowerShell on Windows, Terminal on Mac) and move to where you extracted the zip:

   Windows:
   ```
   cd %USERPROFILE%\Downloads
   ```
   Mac:
   ```
   cd ~/Downloads
   ```

3. **Connect your device** via USB and send the files:

   ```
   adb push usb-audio-switch /tmp/usb-audio-switch
   ```

4. **Run the installer:**

   ```
   adb shell sh /tmp/usb-audio-switch/install.sh
   ```

Done. Plug in a USB audio device to verify it works.

#### Uninstall

```
adb push usb-audio-switch /tmp/usb-audio-switch
adb shell sh /tmp/usb-audio-switch/uninstall.sh
```

#### Troubleshooting

Check the log on the device:

```
adb shell cat /tmp/usb-audio.log
```
