{pkgs ? (import ./nixpkgs.nix) {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    gnupg
    act
  ];
}
