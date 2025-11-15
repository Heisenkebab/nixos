_: let
  g = import ../globals.nix;
in {
  imports = [
    ../home
  ];
  home.username = g.username;
  home.homeDirectory = "/home/${g.username}";
  home.stateVersion = "25.05";

  programs.git.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      san = "echo sanity check o.O";
    };
  };
}
