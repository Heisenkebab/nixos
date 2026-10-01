{
  lib,
  desktop,
  ...
}: let
  bars = map (wm: wm.bar) (builtins.filter (wm: wm.enable) (builtins.attrValues desktop.wm));
in {
  imports =
    [
      ./wofi
      ./grimblast.nix
    ]
    ++ lib.optional desktop.wm.hyprland.enable ./hypr
    ++ lib.optional desktop.wm.niri.enable ./niri
    ++ lib.optional (builtins.elem "mechabar" bars) ./waybar/mechabar
    ++ lib.optional (builtins.elem "niribar" bars) ./waybar/niribar;
}
