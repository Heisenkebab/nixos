# Prerequisites
1. USB stick with [NixOS Minimal ISO](https://nixos.org/download/)
2. An active internet connection
3. Secure Boot disabled

# Installation Steps
## 1. Clone the Configuration
Clone the repository:
```bash
git clone https://github.com/Heisenkebab/nixos.git 
cd nixos

```
## 2. Customize Your Configuration
Before running the script, you must verify your hardware settings.

### A. Target the Correct Disk
Check your drive names using lsblk. Then, edit the disko.nix file to match your target drive (e.g., /dev/sda or /dev/nvme0n1):
```bash
vim /root/nixos/nixos/hardware/disko.nix
```

### B. Set Your Username
If you want to use a name other than heisenkebab, you must update it in your flake.nix:
```bash
vim /root/nixos/flake.nix
```

### C. Run the Install Script
Ensure the script is executable and run it. The script will prompt you for confirmation before making any changes.
```bash
chmod +x install.sh
./install.sh
```

# Post Installation
## Set Your Password
After installation you are prompted from the installation script that you change your password.
Otherwise you can not login to the user.
```bash
sudo nixos-enter --root /mnt -c 'passwd username'
```
## Reboot
Unmount and restart your system:
```bash
reboot
```
