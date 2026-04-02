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

  system.primaryUser = user.name;

  homebrew = {
    enable = true;
    # Deletes packages not defined in the nix-config
    onActivation.cleanup = "zap";
  };

  time.timeZone = "Europe/Vienna";

  system.stateVersion = 6;
}
