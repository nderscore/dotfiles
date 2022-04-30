#!/bin/bash
#
# build i3 and sway configs from directory of shared and unshared configs
# ~/tiling/config.d/

shopt -s extglob

# default config directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# conf.d path
CONFIG_D="${XDG_CONFIG_HOME}/tiling/config.d"

# i3 config file
I3_CONFIG="${XDG_CONFIG_HOME}/i3/config"

# sway config file
SWAY_CONFIG="${XDG_CONFIG_HOME}/sway/config"

if [ ! -d "${CONFIG_D}" ]; then
  >&2 echo "Config directory does not exist"
  exit 1
fi

# add warning message to top
echo "# DO NOT EDIT. This file is generated. Changes will be lost." > "${I3_CONFIG}"
echo "# Edit configs in ~/tiling/config.d/*.conf instead." >> "${I3_CONFIG}"
echo "" >> "${I3_CONFIG}"
cat "${I3_CONFIG}" > "${SWAY_CONFIG}"

# concatenate shared + non-shared configs in order
cat "${CONFIG_D}"/*@(.shared.conf|.i3.conf) >> "${I3_CONFIG}"
cat "${CONFIG_D}"/*@(.shared.conf|.sway.conf) >> "${SWAY_CONFIG}"
