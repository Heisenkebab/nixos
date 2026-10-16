{
  lib,
  desktop,
  ...
}: let
  # Lua modules under ~/.config/hypr/user/, sources in ./lua; user/init.lua
  # requires the rest in order.
  luaModules = ["init" "monitors" "settings" "binds" "rules" "autostart"];
in {
  imports = [
    # wallpaper is handled by noctalia; kept for fallback
    # ./hyprpaper.nix
    # idle is handled by noctalia (home/linux/wayland/noctalia); kept for fallback
    # ./hypridle.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # Hyprland itself comes from the NixOS module (programs.hyprland, pinned to
    # the flake's hyprland input); a second copy from nixpkgs would shadow it in
    # PATH with an older Lua API.
    package = null;
    portalPackage = null;
    systemd.enable = true;
    configType = "lua";

    extraLuaFiles =
      lib.genAttrs' luaModules (name:
        lib.nameValuePair "user.${name}" {
          content = ./lua/${name}.lua;
          autoLoad = name == "init";
        })
      // {
        # Host data for user/monitors.lua: the flake's `monitors` list.
        "nix.monitors" = {
          content = "return ${lib.generators.toLua {} desktop.monitors}\n";
          autoLoad = false;
        };
      };

    # Host-specific overrides (desktop.wm.hyprland.additionalSettings), rendered
    # as hl.<name>(...) calls after the Lua modules above.
    settings = lib.mkMerge desktop.wm.hyprland.additionalSettings;
  };
}
