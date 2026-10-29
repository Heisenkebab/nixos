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
    configs.default =
      {
        show_notifications = false;
      }
      # must match niri's xkb layout; altgr-intl has ä/ö/ü/ß so the evdev injector can type them
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        # the default "Auto" backend always pastes non-ASCII text via the clipboard on Linux,
        # and the Wayland clipboard backend doesn't work (pastes the old clipboard)
        backend = "Inject";
        keyboard_layout = {
          layout = "us";
          variant = "altgr-intl";
        };
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
