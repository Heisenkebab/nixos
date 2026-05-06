{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mkalias
    sketchybar
    skhd
  ];
}
