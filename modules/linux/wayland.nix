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

    grim
    slurp

    swappy
    satty
    wl-clipboard-rs
    imv
    swaybg
  ];
}
