{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mkalias
    sketchybar
    sketchybar-app-font
    skhd
  ];
}
