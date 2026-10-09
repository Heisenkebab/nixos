{
  config,
  pkgs,
  ...
}: let
  # swayidle's systemd unit runs with a PATH that only contains bash, so every
  # command here has to be an absolute store path.
  niri = "${config.programs.niri.package}/bin/niri";
  lock = "${pkgs.procps}/bin/pidof swaylock || ${config.programs.swaylock.package}/bin/swaylock -f";
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
        command = "${niri} msg action power-off-monitors";
        resumeCommand = "${niri} msg action power-on-monitors";
      }
      {
        timeout = 300; # 5min
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = {
      before-sleep = lock;
    };
  };
}
