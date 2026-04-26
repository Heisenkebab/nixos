_: {
  services.yabai = {
    enable = true;
    config = {
      extraConfig = builtins.readFile ./yabairc;
    };
  };
}
