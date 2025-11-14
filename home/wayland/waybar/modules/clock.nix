_: {
  programs.waybar = { 
    settings = [
        {
          "clock" = {
            tooltip = true;
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%a, %d %b, %I:%M %p}";
          };
        }
    ]; 
  };
}
