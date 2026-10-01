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
in {
  options.desktop.wm = {
    niri = mkWm "niri" "niribar";
    hyprland = mkWm "hyprland" "mechabar";
  };

  config.assertions = [
    {
      assertion = lib.count (wm: wm.enable) (builtins.attrValues config.desktop.wm) == 1;
      message = "Exactly one of desktop.wm.<name>.enable must be set per host.";
    }
  ];
}
