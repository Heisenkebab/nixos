{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    hypridle
    hyprlock
    hyprpaper
    hyprutils
    hyprcursor

    grimblast
    swappy
    wl-clipboard-rs
    imv
    bibta-cursors
  ];
}
