_: {
  # nix-darwin generates /etc/nix/nix.conf and leaves experimental features
  # off, so plain `nix` commands fail with "experimental Nix feature
  # 'nix-command' is disabled". darwin-rebuild and nix-direnv pass the flags
  # themselves, which is why only bare `nix ...` calls (e.g. .githooks/pre-push)
  # broke. Mirrors systems/linux/system/nix/tweaks.nix.
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
