{
  pkgs,
  stable,
  ...
}: let
  binaries = import ./c-binaries.nix {inherit pkgs;};
in {
  # SOURCE: https://github.com/h4ckd0tm3/schNixOS
  programs.sketchybar = {
    enable = true;
    configType = "lua";
    package = pkgs.sketchybar;

    sbarLuaPackage = stable.sbarlua;
    luaPackage = pkgs.lua5_4;

    config = {
      source = ./config;
      recursive = true;
    };
  };

  home.file.".local/share/sketchybar_lua/sketchybar.so" = {
    source = "${stable.sbarlua}/lib/lua/5.5/sketchybar.so";
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/sketchybarrc" = {
    text = ''
      #!/usr/bin/env ${pkgs.lua5_4}/bin/lua
      package.path = "./?.lua;./?/init.lua;" .. package.path
      -- Load the sketchybar-package and prepare the helper binaries
      require("helpers")
      require("init")
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/helpers/event_providers/cpu_load/bin/cpu_load".source = "${binaries.cpuLoadBinary}/bin/cpu_load";
  home.file.".config/sketchybar/helpers/event_providers/network_load/bin/network_load".source = "${binaries.networkLoadBinary}/bin/network_load";
  home.file.".config/sketchybar/helpers/menus/bin/menus".source = "${binaries.menusBinary}/bin/menus";

  #home.file."Library/Fonts/sketchybar-app-font.ttf".source = "${pkgs.sketchybar-app-font}/share/fonts/truetype/sketchybar-app-font.ttf";
}
