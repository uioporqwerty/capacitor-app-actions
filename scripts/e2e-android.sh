#!/usr/bin/env bash
#
# End-to-end test for the Android app-actions flow, driven through the demo app
# (uioporqwerty/app-actions-demo). Assumes:
#   - an Android emulator/device is connected via adb
#   - a DEBUG build of the demo is already installed (debug builds emit the
#     Capacitor/Console logs this script asserts on)
#
# It verifies:
#   1. set() registers the dynamic shortcuts on load
#   2. launching from a shortcut on a COLD start fires the JS listener
#
set -euo pipefail

PKG="com.getcapacitor.community.appactionsdemo"
TIMEOUT=40

log() { echo "[e2e] $*"; }

wait_for_log() {
  local needle="$1" i
  for ((i = 0; i < TIMEOUT; i++)); do
    if adb logcat -d 2>/dev/null | grep -qF "$needle"; then return 0; fi
    sleep 1
  done
  return 1
}

log "waiting for device to finish booting"
adb wait-for-device
adb shell 'while [[ "$(getprop sys.boot_completed)" != "1" ]]; do sleep 2; done'

# ---------------------------------------------------------------------------
log "1/3 launching the app so set() registers the actions"
adb logcat -c
adb shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1
if wait_for_log "APPACTIONS_SET_OK"; then
  log "    ✓ set() resolved"
else
  log "    ✗ set() never completed"; adb logcat -d | tail -60; exit 1
fi

# ---------------------------------------------------------------------------
log "2/3 checking the dynamic shortcuts were registered"
if adb shell dumpsys shortcut 2>/dev/null | grep -q "id=order"; then
  log "    ✓ shortcut 'order' is registered"
else
  log "    ✗ shortcut 'order' missing"; adb shell dumpsys shortcut | grep -A5 "$PKG" || true; exit 1
fi

# ---------------------------------------------------------------------------
log "3/3 cold-launch: fully kill the app, then fire the shortcut intent"
adb shell am force-stop "$PKG"
adb logcat -c
adb shell am start -a android.intent.action.MAIN -n "$PKG/.MainActivity" \
  -f 0x10000000 --es ACTION_ID order >/dev/null 2>&1
if wait_for_log "action fired: order"; then
  log "    ✓ cold-launch fired the 'order' listener"
else
  log "    ✗ cold-launch listener did not fire"; adb logcat -d | tail -60; exit 1
fi

log "PASS: app actions register and cold-launch delivery works"
