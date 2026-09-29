_: {
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        terminal = "ghostty";
        layer = "overlay";
        width = 40;
        lines = 12;
        horizontal-pad = 20;
        vertical-pad = 12;
        inner-pad = 8;
        prompt = "\"> \"";
        icon-theme = "hicolor";
        icons-enabled = true;
      };

      border = {
        width = 2;
        radius = 6;
      };

      colors = {
        background = "000000e6";
        text = "c8c8c8ff";
        match = "ffffffff";
        selection = "000948ff";
        selection-text = "ffffffff";
        border = "000948ff";
      };
    };
  };
}
