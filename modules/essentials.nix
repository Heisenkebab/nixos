{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    grimblast
    swappy
    wl-clipboard-rs
    bibata-cursors
    openssl_3
    imv
  ];
}
