{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop
    discord
    onlyoffice-desktopeditors
    ghostty
    nautilus
    vscode-with-extensions
    # waybar
    waybar

    # hypr
    wofi
    hypridle
    hyprlock
    hyprpaper
    hyprutils
    hyprcursor

    # Util
    blueman
    neofetch
    google-chrome
    prismlauncher
  ];
}
