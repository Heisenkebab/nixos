{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    ghostty
    alacritty
    nautilus
    claude-code
    # Util
    blueman
  ];
}
