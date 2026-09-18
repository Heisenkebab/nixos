{
  pkgs,
  config,
  ...
}: {
  programs.niri.package = pkgs.niri;
  programs.niri.settings = {
    prefer-no-csd = true;

    input = {
      keyboard.xkb = {
        layout = "us";
        options = "grp:alt_shift_toggle,caps:escape";
      };
      touchpad = {
        natural-scroll = true;
        tap = true;
      };
      focus-follows-mouse.enable = false;
    };

    cursor = {
      theme = "default";
      size = 24;
    };

    layout = {
      gaps = 8;
      border = {
        enable = true;
        width = 2;
        active.color = "#e2e2e3";
        inactive.color = "#414550";
      };
      # Fill in preset-column-widths / default-column-width to taste, e.g.:
      # preset-column-widths = [
      #   { proportion = 1.0 / 3.0; }
      #   { proportion = 1.0 / 2.0; }
      #   { proportion = 2.0 / 3.0; }
      # ];
    };

    outputs = {
      "DP-1" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 239.970;
        };
        variable-refresh-rate = "on-demand";
        focus-at-startup = true;
        position = {
          x = 1080;
          y = 0;
        };
      };

      "DP-2" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        transform = {
          rotation = 90;
        };
        position = {
          x = 0;
          y = 0;
        };
      };

      "HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        position = {
          x = 1080 + 2560;
          y = 0;
        };
      };
    };
    spawn-at-startup = [
      {argv = ["waybar"];}
      {argv = ["swaybg" "--image" "${../../../../wallpapers/wallhaven-blonde.png}" "--mode" "fill"];}
    ];
    binds = with config.lib.niri.actions; {
      # Custom binds

      "Mod+Q".action.spawn = "ghostty";
      "Mod+Space".action.spawn = [
        "wofi"
        "--show"
        "drun"
        "-I"
        "-m"
        "-i"
      ];
      "Mod+F".action = maximize-column;
      #"Mod+M".action = maximize-window-to-edges;
      "Mod+C".action = close-window;
      "Mod+Shift+E".action = quit;

      # Scroll binds

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;

      # Workspace binds

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;

      # --- The rest below are niri's stock default hotkeys, kept as
      # --- placeholders for the keys not already bound above. Tweak
      # --- freely (e.g. Mod+T/Mod+D still point at alacritty/fuzzel).

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+T".action.spawn = "alacritty";
      "Mod+D".action.spawn = "fuzzel";
      "Super+Alt+L".action.spawn = "swaylock";

      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];

      # Focus / move windows and columns

      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      # Focus / move monitors

      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      # Focus / move workspaces

      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;

      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Column / window sizing

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+F".action = fullscreen-window;

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Screenshots

      "Print".action.spawn-sh = "mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | satty --filename - -o ~/Pictures/Screenshots/satty-$(date +%Y%m%d-%H%M%S).png";

      # Misc

      "Mod+Shift+P".action = power-off-monitors;
    };
  };
}
