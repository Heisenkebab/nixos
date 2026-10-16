{
  lib,
  user,
  desktop,
  ...
}: let
  primaryMon = lib.findFirst (m: m.primary) (builtins.head desktop.monitors) desktop.monitors;
  # logical size: what the lockscreen actually lays out against
  rotated = builtins.elem primaryMon.rotation [90 270];
  # assumes 1 when the compositor auto-scales; set `scale` if that's wrong
  scale =
    if primaryMon.scale == null
    then 1.0
    else primaryMon.scale;
  bounds = {
    width =
      (
        if rotated
        then primaryMon.height
        else primaryMon.width
      )
      / scale;
    height =
      (
        if rotated
        then primaryMon.width
        else primaryMon.height
      )
      / scale;
  };
in {
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = lib.mkForce "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        default.path = "${../../../../wallpapers/wallhaven-black.png}";
      };

      location = {
        auto_locate = false;
        address = "Vienna, Austria";
      };

      weather = {
        enabled = true;
        refresh_minutes = 30;
        unit = "metric";
        effects = true;
      };

      # Replaces swayidle: same 1 min lock / 2 min screen off / 5 min suspend.
      idle.behavior = {
        lock = {
          enabled = true;
          timeout = 60;
          action = "lock";
        };
        screen-off = {
          enabled = true;
          timeout = 120;
          action = "screen_off";
        };
        suspend = {
          enabled = true;
          timeout = 300;
          action = "suspend";
        };
      };
      # swayidle's before-sleep: also lock on lid close / `systemctl suspend`
      lockscreen.lock_before_suspend = true;

      shell.launcher = import ./components/launcher.nix {};

      bar = import ./components/bar.nix {};
      lockscreen_widgets = import ./components/lockscreen-widgets.nix {inherit user bounds primaryMon;};
    };
  };
}
