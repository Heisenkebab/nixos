{pkgs, ...}: {
  gtk = {
    enable = true;
    gtk4.theme = null;
    theme = {
      name = "catppuccin-mocha-blue-standard+black";
      package = pkgs.catppuccin-gtk.override {
        size = "standard";
        tweaks = ["black"];
        variant = "mocha";
      };
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # Apps (Brave, libadwaita) pick light/dark from this via the settings portal
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
