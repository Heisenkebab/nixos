{pkgs, ...}: {
  # Disable coredump that could be exploited later
  # and also slow down the system when something crash
  # If disabled, core dumps appear in the current directory of the crashing process
  systemd.coredump.enable = true;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
  systemd.services.onedriveResync = {
    serviceConfig.Type = "oneshot";
    script = ''
      onedrive --sync
    '';
    # Specify required packages in the path
    path = [pkgs.bash];
  };
  systemd.timers.onedriveResyncTimer = {
    wantedBy = ["timers.target"];
    timerConfig.OnCalendar = "hourly";
    partOf = ["onedriveResync.service"];
  };
}
