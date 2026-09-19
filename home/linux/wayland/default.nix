{
  lib,
  desktop,
  ...
}: {
  imports =
    [
      ./wofi
      ./grimblast.nix
    ]
    ++ lib.optional (desktop.wm == "hyprland") ./hypr
    ++ lib.optional (desktop.wm == "niri") ./niri
    ++ lib.optional (desktop.bar == "mechabar") ./waybar/mechabar
    ++ lib.optional (desktop.bar == "niribar") ./waybar/niribar;
}
