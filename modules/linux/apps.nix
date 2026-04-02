{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditor
    ghostty
    nautilus

    # Util
    blueman
 ];
}
