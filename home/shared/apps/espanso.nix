{
  pkgs,
  lib,
  ...
}: {
  services.espanso = {
    enable = true;
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
      then pkgs.espanso
      else pkgs.espanso-wayland;
    configs.default = {
      show_notifications = false;
    };

    matches.default.matches = [
      {
        trigger = ";ae";
        replace = "ä";
      }
      {
        trigger = ";oe";
        replace = "ö";
      }
      {
        trigger = ";ue";
        replace = "ü";
      }
      {
        trigger = ";ss";
        replace = "ß";
      }
    ];
  };
  # run through the cap_dac_override wrapper from hosts/linux/configuration.nix;
  # the store binary has no access to /dev/input or /dev/uinput
  systemd.user.services.espanso.Service.ExecStart =
    lib.mkIf pkgs.stdenv.hostPlatform.isLinux (lib.mkForce "/run/wrappers/bin/espanso launcher");
}
