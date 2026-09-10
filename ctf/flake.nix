{
  description = "CTF development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
      "aarch64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        python = pkgs.python3.withPackages (ps:
          with ps; [
            requests
            pwntools
            pycryptodome
            sympy
          ]);
      in {
        default = pkgs.mkShell {
          packages = [
            python
            pkgs.gdb
            pkgs.binutils
            pkgs.file
            pkgs.xxd
            pkgs.curl
            pkgs.netcat-gnu
          ];

          shellHook = ''
            echo "CTF environment"
            echo "Python: $(python --version)"
            echo "pwntools: $(python -c 'import pwn; print(pwn.version)')"
          '';
        };
      }
    );
  };
}
