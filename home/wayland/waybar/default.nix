_: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./styles/style.css;

    # nerd fonts symbols-only is required for some icons to show
    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;
        margin = "6 8 4 8";

        modules-left = [
          "custom/menu"
          "hyprland/workspaces"
          "hyprland/language"
          "keyboard-state"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "battery"
          "network"
          "custom/bitrate"
          "memory"
          "backlight"
          "custom/power"
        ];

        # module settings
        "custom/menu" = {
          format = "";
          on-click = "wofi --show drun -I -m -i";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          active-only = false;
          on-click = "hyprctl dispatch workspace {name}";
          on-scroll-up = "hyprctl dispatch workspace e+1 1>/dev/null";
          on-scroll-down = "hyprctl dispatch workspace e-1 1>/dev/null";
          presistent-workspaces = {
            "*" = 3;
          };
        };

        "hyprland/language" = {
          format = "{shortDescription} ";
          on-click = "hyprctl switchxkblayout current next";
        };

        "keyboard-state" = {
          capslock = true;
          format = "caps {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "clock" = {
          tooltip = true;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%a, %d %b, %I:%M %p}";
        };

        "pulseaudio" = {
          scroll-step = 3;
          format = "{icon}  {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon}󰂯 {format_source}";
          format-bluetooth-muted = "󰍭 {icon}󰂯 {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "󰍬";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋋";
            phone = "󰏳";
            car = "󰄍";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
          on-click-right = "amixer sset Master toggle";
          tooltip = false;
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-alt = "{icon}";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          states = {
            high = 80;
            medium = 50;
            low = 20;
            critical = 4;
          };
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "network" = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          format-disabled = "";
          tooltip-format-wifi = " {essid} {frequency}MHz\nStrength: {signaldBm}dBm ({signalStrength}%)\nIP: {ipaddr}/{cidr}\n {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = " {bandwidthUpBits}  {bandwidthDownBits}\n{ifname}\n{ipaddr}/{cidr}\n";
          on-click = "sleep 0.1 && nm-connection-editor";
        };

        "custom/bitrate" = {
          exec = builtins.readFile ./modules/bitrate.sh;
          interval = 15;
          tooltip = false;
          format = "<span size='x-small'>{}</span>";
        };

        "memory" = {
          format = "  {used}GB";
          on-click = "kitty -e btop";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          tooltip = false;
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "sleep 0.1 && loginctl lock-session && hyprlock";
          tooltip = false;
        };
      }
    ];
  };
}
