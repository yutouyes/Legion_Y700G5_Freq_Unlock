#!/system/bin/sh

GPU_DIR="/sys/class/kgsl/kgsl-3d0"
MAX_FILE="$GPU_DIR/max_pwrlevel"
DEF_FILE="$GPU_DIR/default_pwrlevel"
MIN_FILE="$GPU_DIR/min_pwrlevel"

TARGET_MAX="0"
TARGET_DEF="17"
TARGET_MIN="17"

CHECK_INTERVAL=300  


apply_settings() {
    chmod 777 "$MAX_FILE" "$DEF_FILE" "$MIN_FILE" 2>/dev/null
    echo "$TARGET_MAX" > "$MAX_FILE"
    echo "$TARGET_DEF" > "$DEF_FILE"
    echo "$TARGET_MIN" > "$MIN_FILE"
    chmod 444 "$MAX_FILE" "$DEF_FILE" "$MIN_FILE" 2>/dev/null
}


sleep 30


apply_settings


while true; do
    sleep "$CHECK_INTERVAL"

    cur_max=$(<"$MAX_FILE" 2>/dev/null)
    cur_def=$(<"$DEF_FILE" 2>/dev/null)
    cur_min=$(<"$MIN_FILE" 2>/dev/null)

    if [ "$cur_max" != "$TARGET_MAX" ] || \
       [ "$cur_def" != "$TARGET_DEF" ] || \
       [ "$cur_min" != "$TARGET_MIN" ]; then
        apply_settings
    fi
done