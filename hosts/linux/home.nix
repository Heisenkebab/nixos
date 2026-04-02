{
  pkgs,
  user,
  ...
}: {
  imports = [
    ../../home/linux
    ../../home/shared
  ];
  home.username = user.name;
  home.homeDirectory = user.homeDir;
  home.stateVersion = "25.05";

  programs.git.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      san = "echo sanity check o.O";
    };
  };
}
