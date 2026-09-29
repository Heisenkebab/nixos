{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty
    alacritty

    nautilus

    # Util
    blueman
    onlyoffice-desktopeditors
    playerctl
  ];
}
