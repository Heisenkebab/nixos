{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${../../../../wallpapers/wallhaven-black.png}";
      scaling = "fill";
      effect-blur = "9x4";
      effect-vignette = "0.5:0.4";
      fade-in = "0.2";
      grace = 0;

      clock = true;
      timestr = "%H:%M";
      datestr = "%A, %d %B";
      font = "JetBrains Mono Nerd Font Mono";
      text-color = "c8c8c8ff";

      indicator-radius = 100;
      indicator-thickness = 10;
      indicator-caps-lock = true;

      ring-color = "00000000";
      ring-clear-color = "00000000";
      ring-ver-color = "00000000";
      ring-wrong-color = "ff000080";
      inside-color = "00000080";
      inside-clear-color = "00000080";
      inside-ver-color = "00000080";
      inside-wrong-color = "aa000080";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      separator-color = "00000000";
      key-hl-color = "ffffff40";
      bs-hl-color = "ff000040";
      text-clear-color = "c8c8c8ff";
      text-ver-color = "c8c8c8ff";
      text-wrong-color = "ff5555ff";

      show-failed-attempts = true;
      ignore-empty-password = true;
    };
  };
}
