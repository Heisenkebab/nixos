{
  lib,
  config,
  ...
}: let
  mkWm = name: defaultBar: {
    enable = lib.mkEnableOption "the ${name} Wayland compositor on this host";

    bar = lib.mkOption {
      type = lib.types.enum ["mechabar" "niribar" "none"];
      default = defaultBar;
      description = "Status bar flavor to enable when ${name} is the window manager.";
    };

    additionalSettings = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "Host-specific attrsets merged on top of the shared ${name} settings.";
    };
  };

  monitor = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        example = "DP-1";
        description = "Connector name, as shown by `niri msg outputs` / `hyprctl monitors`.";
      };
      width = lib.mkOption {type = lib.types.ints.positive;};
      height = lib.mkOption {type = lib.types.ints.positive;};
      refresh = lib.mkOption {
        type = lib.types.float;
        description = "Refresh rate in Hz; must match an advertised mode exactly (e.g. 179.960).";
      };
      x = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Position in logical pixels (after scale and rotation of the outputs to the left/above).";
      };
      y = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };
      scale = lib.mkOption {
        type = lib.types.nullOr lib.types.float;
        default = null;
        description = "null lets the compositor pick a scale from the panel's DPI.";
      };
      rotation = lib.mkOption {
        type = lib.types.enum [0 90 180 270];
        default = 0;
        description = "Counter-clockwise rotation in degrees.";
      };
      vrr = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      primary = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Focused at startup; noctalia's lockscreen is drawn here.";
      };
    };
  };
in {
  options.desktop.wm = {
    niri = mkWm "niri" "niribar";
    hyprland = mkWm "hyprland" "mechabar";
  };

  options.desktop.monitors = lib.mkOption {
    type = lib.types.listOf monitor;
    default = [];
    description = ''
      Every monitor of this host. Translated into niri `outputs` and hyprland
      `monitor` rules, and read by noctalia; compositor-specific extras still
      go in desktop.wm.<name>.additionalSettings.
    '';
  };

  config.assertions = [
    {
      assertion = lib.count (wm: wm.enable) (builtins.attrValues config.desktop.wm) == 1;
      message = "Exactly one of desktop.wm.<name>.enable must be set per host.";
    }
    {
      assertion = lib.count (m: m.primary) config.desktop.monitors <= 1;
      message = "At most one of desktop.monitors may set primary = true.";
    }
    {
      assertion = lib.allUnique (map (m: m.name) config.desktop.monitors);
      message = "desktop.monitors has the same connector name twice.";
    }
  ];
}
