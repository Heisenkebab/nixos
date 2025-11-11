{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop
    discord
    onlyoffice-desktopeditors
    brave
    ghostty
    nautilus

    # waybar
    waybar

    # hypr
    wofi
    hypridle
    hyprlock
    hyprpaper
    hyprutils
    hyprcursor
  ];
}
