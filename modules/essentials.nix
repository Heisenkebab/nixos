{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    grimblast
    swappy
    wl-clipboard-rs
    bibata-cursors
  ];
}
