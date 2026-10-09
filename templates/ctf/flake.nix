{
  description = "CTF challenge environment (pwn / rev / crypto / web / forensics)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stablepkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  # Only needed when a challenge wants its own pinned nixpkgs or extra tools.
  # For the usual case, skip this file entirely and point .envrc at the shared
  # shell instead: echo 'use flake ~/nixos#ctf' > .envrc
  outputs = {
    nixpkgs,
    stablepkgs,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            stable = import stablepkgs {
              inherit system;
              config.allowUnfree = true;
            };
          }
      );
  in {
    # The tool list lives in ./shell.nix -- edit that to add anything this
    # challenge needs.
    devShells = forAllSystems ({
      pkgs,
      stable,
    }: {
      default = import ./shell.nix {inherit pkgs stable;};
    });
  };
}
