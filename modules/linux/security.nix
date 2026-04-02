{pkgs, ...}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    openssl
    glibc
  ];
  environment.systemPackages = with pkgs; [
    burpsuite
  ];
}
