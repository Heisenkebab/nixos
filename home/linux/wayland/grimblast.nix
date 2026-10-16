{
  config,
  lib,
  pkgs,
  ...
}: {
  # grimblast is a screenshot grabber and swappy is a screenshot editor
  # This config provide comprehensive screenshot functionality for hyprland
  home = {
    file = {
      "${config.xdg.configHome}/swappy/config".text = ''
        [Default]
        save_dir=${config.home.homeDirectory}/Pictures/Screenshots
        save_filename_format=screenshot-%Y%m%d-%H%M%S.png
        text_size=50
        text_font=Work Sans Bold
        early_exit=true
      '';
    };
  };
  # Lua config: each entry renders as hl.bind("<keys>", hl.dsp.exec_cmd("<cmd>")).
  wayland.windowManager.hyprland.settings.bind = let
    shot = mode: "${lib.getExe pkgs.grimblast} save ${mode} - | ${lib.getExe pkgs.swappy} -f -";
    bind = keys: mode: {
      _args = [keys (lib.generators.mkLuaInline "hl.dsp.exec_cmd(${lib.generators.toLua {} (shot mode)})")];
    };
  in [
    (bind "Print" "screen")
    (bind "SHIFT + Print" "area")
    (bind "CTRL + ALT + Print" "active")
    (bind "CTRL + Print" "output")
  ];
}
