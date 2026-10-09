{pkgs ? (import ./nixpkgs.nix) {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    gnupg
    act
  ];

  # Enable .githooks/pre-push (the CI checks, run locally before a push).
  shellHook = ''
    git config core.hooksPath .githooks
  '';
}
