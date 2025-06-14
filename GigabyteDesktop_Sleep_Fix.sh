#!/bin/bash

############################################################
# Sleep/Wakeup Fix For Gigabyte Motherboards
# Script forked from DAK404's repo
# Modified for Gigabyte A520i AC by PercyPanleo
#
# ----------------------------------------------------------
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/PercyPanleo/OpenSUSE-Setup-Scripts/main/GigabyteDesktop_Sleep_Fix.sh)"
#
# ----------------------------------------------------------
#
# --- CHANGELOG ---
#
# 1.0 (19-July-2024):
#    * Bump version to 1.0
# 1.0.1 (22-April-2025):
#    * Forked from DAK404
#    * Replaced GPP0 with GPP8 for certain Gigabyte motherboards
############################################################

sudo cat > /etc/systemd/system/biosWakeupWorkaround.service << EOL
[Unit]
Description=Workaround for Gigabyte BIOS sleep/wakeup bug

[Service]
Type=oneshot
ExecStart = /bin/sh -c 'if grep 'GPP8' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP8' > /proc/acpi/wakeup; fi'

[Install]
WantedBy = multi-user.target
EOL

sudo systemctl daemon-reload && sudo systemctl enable biosWakeupWorkaround.service
