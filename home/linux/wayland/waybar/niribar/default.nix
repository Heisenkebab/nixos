{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./styles/style.css;
    settings = [
      {
        layer = "top";
        position = "top";
        mode = "dock";
        reload_style_on_change = true;

        modules-left = ["niri/workspaces"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "battery" "group/group-power"];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 5;
          tooltip-format = "Volume: {volume}%";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip-format = "{time} remaining";
        };

        "group/group-power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/lock" = {
          format = "󰌾";
          on-click = "swaylock";
          tooltip = true;
          tooltip-format = "Lock screen";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          on-click = "reboot";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "shutdown now";
        };
      }
    ];
  };
}
