{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    ghostty
    alacritty
    nautilus

    # Util
    blueman
  ];
}
