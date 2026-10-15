{pkgs, ...}: {
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
      # evdev backend can't detect the layout under wayland; match niri's primary xkb layout
      // pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        keyboard_layout.layout = "us";
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
    ];
  };
}
