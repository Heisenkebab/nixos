{user, ...}: {
  imports = [
    ../../home/darwin
    ../../home/shared
  ];
  home = {
    username = user.name;
    homeDirectory = user.homeDir;
    stateVersion = "26.05";
  };

  programs.git.enable = true;
}
