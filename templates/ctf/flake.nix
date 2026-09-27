{
  description = "CTF challenge environment (pwn / rev / crypto / web / forensics)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # Only needed when a challenge wants its own pinned nixpkgs or extra tools.
  # For the usual case, skip this file entirely and point .envrc at the shared
  # shell instead: echo 'use flake ~/nixos#ctf' > .envrc
  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f (import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          })
      );
  in {
    # The tool list lives in ./shell.nix -- edit that to add anything this
    # challenge needs.
    devShells = forAllSystems (pkgs: {
      default = import ./shell.nix {inherit pkgs;};
    });
  };
}
