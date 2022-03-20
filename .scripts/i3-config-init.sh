#!/bin/bash
#
# i3-config.d

# Default config directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# i3 configuration
I3="${XDG_CONFIG_HOME}/i3"
# The i3 config file (output of this script)
I3_CONFIG="${I3}/config"
# The i3 config.d directory (contains input files for this script)
I3_CONFIG_D="${I3_CONFIG}.d"

# If the directory does not exist, don't run the script.
if [ ! -d "${I3_CONFIG_D}" ]; then
  >&2 echo "Config directory does not exist, will not run i3-config-init"
  exit 1
fi

echo "# DO NOT EDIT. This file is generated. Changes will be lost." > "${I3_CONFIG}"
echo "# Edit configs in ./config.d/*.conf instead." >> "${I3_CONFIG}"
echo "" >> "${I3_CONFIG}"

# Concattenate the inputs in lexilogical order and output
cat "${I3_CONFIG_D}"/*.conf >> "${I3_CONFIG}"