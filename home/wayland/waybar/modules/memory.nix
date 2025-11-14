_: {
  programs.waybar = { 
    settings = [
        {
          "memory" = {
            format = "  {used}GB";
            on-click = "kitty -e btop";
          };
        }
    ]; 
  };
}
