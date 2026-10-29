{pkgs, ...}: let
  # rendered by noctalia's gtk3/gtk4 templates (home/linux/wayland/noctalia)
  noctaliaCss = ''@import url("noctalia.css");'';
in {
  gtk = {
    enable = true;
    # adw-gtk3 uses libadwaita's named colors, which noctalia.css overrides
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk4.theme = null;
    gtk3.extraCss = noctaliaCss;
    gtk4.extraCss = noctaliaCss;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # Apps (Brave, libadwaita) pick light/dark from this via the settings portal
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
