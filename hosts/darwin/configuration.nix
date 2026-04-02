{
  inputs,
  user,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.default

    ../../systems/darwin
    ../../systems/shared

    ../../modules/darwin
    ../../modules/shared
  ];
  users.users.${user.name} = {
    name = user.name;
    home = user.homeDir;
  };

#  homebrew.enable = true;

  time.timeZone = "Europe/Vienna";

  system.stateVersion = 6;
}
