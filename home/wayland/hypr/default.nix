{meta, ...}: {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$fileManager" = "nautilus";

      monitor =
        map (
          m: "${m.name}, ${m.dimensions}@${toString m.framerate}, ${m.position}, ${toString m.scale}"
        )
        meta.monitors;

      # ENVIRONMENT VARIABLES
      env = [
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_SIZE,24"
      ];

      # INPUT
      input = {
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };

        kb_layout = "de";
        kb_options = [
          "grp:alt_shift_toggle"
          "caps:escape"
        ];
      };

      # LOOK AND FEEL
      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 1;
        "col.active_border" = "0xaae2e2e3";
        "col.inactive_border" = "0xaa414550";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          brightness = 1.0;
          contrast = 1.0;
          popups = true; # blur popup menus
          noise = 0.03;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      gesture = [
        "3, horizontal, workspace"
      ];
      # AUTOSTART
      exec-once = [
        "systemctl --user start hyprland-session.target"
        "waybar &"
        "hyprpaper &"
        "hypridle &"
        "[workspace 2 silent] brave"
        "[workspace 1 silent] ghostty"
      ];

      # Keybindings
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, R, exec, hyprctl reload"
        # Launch Applications
        "$mainMod, SPACE, exec,  wofi --show drun -I -m -i"
        "$mainMod SHIFT, N, exec, swaync-client -rs"
        "$mainMod SHIFT, C, exec, exit"
        "$mainMod, Q, exec, ghostty"
        "$mainMod, C, killactive"

        # Window Management
        "$mainMod SHIFT, I, togglesplit"
        "$mainMod, M, fullscreen, 1"
        "$mainMod SHIFT, M, fullscreen, 0"

        # Move Focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod, Left, movefocus, l"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Down, movefocus, d"

        # Move Windows
        "$mainMod SHIFT, Left, movewindow, l"
        "$mainMod SHIFT, Right, movewindow, r"
        "$mainMod SHIFT, Up, movewindow, u"
        "$mainMod SHIFT, Down, movewindow, d"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Workspace Navigation with Mouse
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Other
        "$mainMod, ENTER, togglespecialworkspace"
        "$mainMod SHIFT, ENTER, movetoworkspace,special"

        #Mirror
        "$mainMod, P, exec, hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 1920x0, 1, mirror, eDP-1"
        # Extend
        "$mainMod SHIFT, P, exec, hyprctl keyword monitor HDMI-A-1, 1920x1080@60,1920x0,1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "opacity 0.9, class:code"

        "opacity 0.9, class:jetbrains-idea"
        "opacity 0.9, class:com.mitchellh.ghostty"
        "move, workspace 2, class:Brave-browser"
        "move, workspace 1, class:ghostty"
      ];
      workspace = meta.workspaceRules;
    };

    extraConfig = ''
      # additional non-Nix-configurable settings
    '';
  };
}
