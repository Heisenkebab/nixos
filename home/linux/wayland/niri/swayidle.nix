{config, ...}: let
  lock = "${config.programs.swaylock.package}/bin/swaylock -f";
in {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 60; # 1min
        command = "niri msg action power-off-monitors";
        resumeCommand = "niri msg action power-on-monitors";
      }
      {
        timeout = 300; # 5min
        command = lock;
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
