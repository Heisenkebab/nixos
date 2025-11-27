{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop
    discord
    onlyoffice-desktopeditors
    brave
    ghostty
    nautilus
    vscode-with-extensions

    #Spotify
    spotify
    spicetify-cli

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

    google-chrome
  ];
}
