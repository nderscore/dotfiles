#!/bin/bash
#
# Get GPU utilization stats for status bar

GIGABYTE=1073741824

if [ -z "$STATS_GPU_TOTAL_MEM" ]; then
    STATS_GPU_TOTAL_MEM="$(cat /sys/class/drm/card1/device/mem_info_vram_total)"
    export STATS_GPU_TOTAL_MEM="$(echo "scale=2; ${STATS_GPU_TOTAL_MEM}/${GIGABYTE}" | bc -l)"
fi

STATS_GPU_UTILIZATION="$(cat /sys/class/drm/card1/device/gpu_busy_percent)"
STATS_GPU_MEM="$(cat /sys/class/drm/card1/device/mem_info_vram_used)"
STATS_GPU_MEM="$(echo "scale=2; ${STATS_GPU_MEM}/${GIGABYTE}" | bc -l)"

echo "🎨 ${STATS_GPU_UTILIZATION}% (${STATS_GPU_MEM}GiB)"
