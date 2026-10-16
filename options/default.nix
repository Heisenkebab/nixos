# Option declarations only (no config): host-level switches set from the
# `hosts` list in flake.nix and read by both NixOS and home-manager modules.
_: {
  imports = [
    ./desktop.nix
  ];
}
