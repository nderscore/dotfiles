#!/bin/bash
#
# Apex Legends Vulkan Shader Cache Updater

GIT_PATH="${HOME}/nondev/apex-legends-cache"

CACHE_PATH="${HOME}/.local/share/Steam/steamapps/shadercache/1172470/DXVK_state_cache"

cd $GIT_PATH
UP_TO_DATE="$(git pull | grep -c 'Already up to date')"

if [ $UP_TO_DATE == "0" ] || [[ $1 == "--force" ]]; then
    TIMESTAMP="$(git log -n 1 --format=%cd)"
    cp "${GIT_PATH}/r5apex.dxvk-cache" "${CACHE_PATH}/r5apex.dxvk-cache"
    echo "Updated apex cache file with latest from ${TIMESTAMP}"
else
    echo "Already up-to-date. Exiting."
fi
