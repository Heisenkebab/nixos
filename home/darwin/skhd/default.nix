{
  config,
  lib,
  pkgs,
  ...
}: {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    # skhd has no include directive, so the fragments are concatenated here.
    config =
      builtins.readFile ./skhdrc-common.txt
      + "\n"
      + builtins.readFile ./skhdrc-spaces.txt;
  };

  # home-manager reloads a launchd agent only when the plist itself differs
  # byte for byte, and upstream's skhd plist names nothing but the package --
  # so editing a keybinding left the running daemon on its old config. skhd
  # cannot notice on its own either: the file it watches is an immutable store
  # path, and a rebuild repoints the symlink rather than changing that file.
  # Naming the config in the plist ties the two together.
  launchd.agents.skhd.config.ProgramArguments = lib.mkForce [
    (lib.getExe pkgs.skhd)
    "-c"
    "${config.xdg.configFile."skhd/skhdrc".source}"
  ];
}
