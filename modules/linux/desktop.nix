{lib, ...}: {
  options.desktop = {
    wm = lib.mkOption {
      type = lib.types.enum ["hyprland" "niri"];
      default = "niri";
      description = "Wayland compositor / window manager to use on this host.";
    };

    bar = lib.mkOption {
      type = lib.types.enum ["mechabar" "none"];
      default = "mechabar";
      description = "Status bar flavor to enable for the chosen window manager.";
    };
  };
}
