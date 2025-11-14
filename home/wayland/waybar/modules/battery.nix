_: {
  programs.waybar = { 
    settings = [
     {
        "battery" = {
          format = "{icon} {capacity}%";
          format-alt = "{icon}";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          states = {
            high = 80;
            medium = 50;
            low = 20;
            critical = 4;
          };
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
     }
    ]; 
  };
}
