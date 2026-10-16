# noctalia's launcher (replaces fuzzel). Opened by Mod+Space / Mod+D in niri.nix.
# Providers trigger on provider_prefix + prefix, e.g. "/emo"; `global = true`
# also mixes their results into a plain search.
# For scripts, `noctalia dmenu -p "prompt"` is the fuzzel --dmenu equivalent.
_: {
  categories = true;
  show_icons = true;
  show_app_origin_indicator = true;
  compact = false;
  app_grid = false;
  sort_by_usage = true;
  pinned = []; # desktop ids, e.g. ["brave-browser" "com.mitchellh.ghostty"]
  fetch_exchange_rates = true; # calculator currency conversion; queries a third-party API
  provider_prefix = "/";
  auto_paste = "auto"; # off | auto | ctrl_v | ctrl_shift_v | shift_insert

  providers = {
    calculator = {
      prefix = "calc";
      global = true;
    };
    emoji.prefix = "emo";
    session = {
      prefix = "session";
      global = false;
    };
    wallpaper.prefix = "wall";
    windows.prefix = "win";
  };
}
