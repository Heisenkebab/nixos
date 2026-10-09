{pkgs ? (import ./nixpkgs.nix) {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    gnupg
    act
  ];

  # Enable .githooks/pre-commit (the CI checks, run locally before a commit).
  shellHook = ''
    git config core.hooksPath .githooks
  '';
}
