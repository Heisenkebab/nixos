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
    description = "Onedrive Sync Service";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "heisenkebab";
    };
    script = ''
      ${pkgs.onedrive}/bin/onedrive --sync
    '';
    # Ensure the binary is available to the service
    path = [pkgs.onedrive];
  };

  systemd.timers.onedriveResyncTimer = {
    description = "Run onedrive sync every hour";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true; # Runs the job immediately if the computer was off during the last scheduled time
      Unit = "onedriveResync.service";
    };
  };
}
