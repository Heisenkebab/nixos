# <https://wiki.nixos.org/wiki/Fonts>
_: {
  fonts = {
    enableDefaultPackages = true;
    # Issue: <https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can.27t_find_system_fonts>
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      antialias = true;
      includeUserConf = true;
      allowBitmaps = false;
      allowType1 = false; # Poor rendering

      defaultFonts = {
        monospace = ["Hack Nerd Font"];
        sansSerif = ["Hack Nerd Font"];
        serif = ["Hack Nerd Font"];
      };

      subpixel = {
        # rgba = "rgb";
        lcdfilter = "default";
      };

      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
    };
  };
}
