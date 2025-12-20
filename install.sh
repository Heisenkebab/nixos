#!/bin/sh
set -e
printf "Did you change the disk in disko.nix? (y/N): "
read -r disk_changed
if [ "${disk_changed:-n}" != "y" ] && [ "${disk_changed:-n}" != "Y" ]; then
    echo "Go to ~/nixos/nixos/hardware/disko.nix and change the disk if needed."
    exit 0
fi

printf "Default user is 'heisenkebab'. Proceed? (y/N): "
read -r user_ok
if [ "${user_ok:-n}" != "y" ] && [ "${user_ok:-n}" != "Y" ]; then
    echo "Go to ~/nixos/flake.nix and change the user.name."
    exit 0
fi

while true; do
    echo "-----------------------------------------------------------"
    echo "WARNING: THIS WILL ERASE ALL DATA ON THE SELECTED DISK."
    printf "Are you sure you want to proceed? (y/N): "
    read -r response
    response=${response:-n}
    case "$response" in
        [Yy]*) break ;;
        [Nn]*) echo "Installation aborted."; exit 0 ;;
        *) echo "Invalid input." ;;
    esac
done

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ~/nixos/nixos/hardware/disko.nix && \
sudo nixos-generate-config --no-filesystems --root /mnt && \
sudo cp /mnt/etc/nixos/hardware-configuration.nix ~/nixos/hosts/ && \
sudo rm -rf /mnt/etc/nixos/configuration.nix && \
sudo mv ~/nixos/* /mnt/etc/nixos && \
sudo nixos-install --flake /mnt/etc/nixos#nixos

echo "-----------------------------------------------------------"
echo "INSTALLATION COMPLETE"
echo "BEFORE REBOOTING: sudo nixos-enter --root /mnt -c 'passwd username'"
echo "-----------------------------------------------------------"
