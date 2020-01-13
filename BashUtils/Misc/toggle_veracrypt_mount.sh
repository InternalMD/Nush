function toggle_veracrypt_mount() (
    VERACRYPT_PATH="E:\Programs\VeraCrypt\VeraCrypt-x64.exe"

    # Process args
    volume_path="$1"
    drive_letter="$2"
    if [ -z "$1" -o -z "$2" ]; then
        echo "toggle_veracrypt_mount <veracrypt_volume_path> <drive_letter>"
        return 1
    fi

    # Check if drive is mounted
    pushd /$drive_letter/ >/dev/null 2>&1
    not_mounted=$?
    popd >/dev/null 2>&1

    # Toogle mount state
    if [[ $not_mounted != 0 ]] ; then
        echo "Mounting $volume_path as $drive_letter: drive..."
        powershell -Command "$VERACRYPT_PATH /volume $volume_path /letter $drive_letter /nowaitdlg /explore /quit"
    else
        echo "Dismounting $drive_letter: drive..."
        powershell -Command "$VERACRYPT_PATH /dismount $drive_letter /quit"
    fi
)
