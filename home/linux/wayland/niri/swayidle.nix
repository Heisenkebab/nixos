{config, ...}: let
  lock = "pidof swaylock || ${config.programs.swaylock.package}/bin/swaylock -f";
in {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 60; # 1min
        command = lock;
      }
      {
        timeout = 120; # 2min
        command = "niri msg action power-off-monitors";
        resumeCommand = "niri msg action power-on-monitors";
      }
      {
        timeout = 900; # 15min
        command = "systemctl suspend";
      }
    ];
    events = {
      before-sleep = lock;
    };
  };
}
