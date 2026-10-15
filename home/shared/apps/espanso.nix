{pkgs, ...}: {
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
    ];
  };
}
