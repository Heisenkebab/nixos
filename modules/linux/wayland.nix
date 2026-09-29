{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wofi
    hypridle
    hyprlock
    hyprpaper
    hyprutils
    hyprcursor

    # niri
    grim
    xwayland-satellite
    slurp
    swappy
    satty
    swaybg

    # shared
    grimblast
    wl-clipboard-rs
    imv
    waybar
  ];
}
