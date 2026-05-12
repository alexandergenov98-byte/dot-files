#!/bin/bash

TARGET_PATH="$HOME"

deploy() {
    local rsync_flags="-av"
    local mode=""

    case "$1" in
        --force)
            mode="force"
            ;;
        --dry-run)
            rsync_flags="$rsync_flags --dry-run"
            mode="dry-run"
            ;;
        *)
            echo "Usage: deploy [--force | --dry-run]"
            echo
            echo "Options:"
            echo "  --force    Deploy files to $TARGET_PATH"
            echo "  --dry-run  Preview changes without copying"
            return 1
            ;;
    esac

    echo "Running deploy ($mode)..."

    rsync $rsync_flags \
        --exclude-from=.syncignore \
        ./ "$TARGET_PATH/"
}

deploy "$@"
