_: {
  imports = [
    ./modules
  ];

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
          "custom/left_div"
          "hyprland/workspaces"
          "custom/right_div#1"
        ];

        modules-center = [
          "custom/left_div#2"
          "temperature"
          "custom/left_div#3"
          "memory"
          "custom/left_div#4"
          "cpu"
          "custom/left_inv#1"
          "custom/left_div#5"
          "custom/distro"
          "custom/right_div#2"
          "custom/right_inv#1"
          "clock#time"
          "custom/right_div#3"
          "clock#date"
          "custom/right_div#4"
          "network"
          "bluetooth"
          "custom/right_div#5"
        ];

        modules-right = [
          "pulseaudio"
          "custom/left_div#6"
          "backlight"
          "custom/left_div#8"
          "battery"
          "custom/left_inv#2"
          "custom/power"
        ];

        # module settings
        "custom/distro" = {
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

        "battery" = {
          format = "{icon} {capacity}%";
          states = {
            high = 80;
            medium = 50;
            low = 20;
            critical = 10;
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

        "cpu" = {
          format = " {usage}%";
          tooltip = false;
        };

        "temperature" = {
          format = " {temperatureC}°C";
          critical-threshold = 80;
          tooltip = false;
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
        "clock" = {
          tooltip = true;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%a, %d %b, %I:%M %p}";
        };
        "memory" = {
          format = "  {used}GB";
          on-click = "kitty -e btop";
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

        "custom/power" = {
          format = "󰐥";
          on-click = "sleep 0.1 && loginctl lock-session && hyprlock";
          tooltip = false;
        };
        /*
        --------------------
          left dividers
        --------------------
        */
        "custom/left_div#1" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#2" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#3" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#4" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#5" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#6" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#7" = {
          format = "";
          tooltip = false;
        };
        "custom/left_div#8" = {
          format = "";
          tooltip = false;
        };

        /*
        inverse
        */
        "custom/left_inv#1" = {
          format = "";
          tooltip = false;
        };
        "custom/left_inv#2" = {
          format = "";
          tooltip = false;
        };

        /*
        --------------------
          right dividers
        --------------------
        */
        "custom/right_div" = {
          "format" = "";
          "tooltip" = false;
        };

        "custom/left_div" = {
          "format" = "";
          "tooltip" = false;
        };

        # Inverse Dividers
        "custom/right_inv" = {
          "format" = "";
          "tooltip" = false;
        };

        "custom/left_inv" = {
          "format" = "";
          "tooltip" = false;
        };

        "custom/right_div#1" = {
          format = "";
          tooltip = false;
        };
        "custom/right_div#2" = {
          format = "";
          tooltip = false;
        };
        "custom/right_div#3" = {
          format = "";
          tooltip = false;
        };
        "custom/right_div#4" = {
          format = "";
          tooltip = false;
        };
        "custom/right_div#5" = {
          format = "";
          tooltip = false;
        };

        /*
        inverse
        */
        "custom/right_inv#1" = {
          format = "";
          tooltip = false;
        };
      }
    ];
  };
}
