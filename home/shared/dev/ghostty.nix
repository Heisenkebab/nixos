{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    # nixpkgs' ghostty is Linux-only; on darwin the app comes from homebrew
    # (modules/darwin/homebrew/apps.nix) and home-manager only writes the config.
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
      then null
      else pkgs.ghostty;
    enableZshIntegration = true;
    # installVimSyntax = true;

    settings = {
      theme = "Catppuccin Mocha";
      font-size = 12;
      font-family = ["Monaco" "Jetbrains Mono"];
      font-thicken = true;
      font-thicken-strength = 150;

      cursor-style = "block";
      cursor-style-blink = false;
      cursor-invert-fg-bg = false;
      cursor-color = "lightgrey";
      cursor-text = "black";
      shell-integration-features = ["no-cursor"];
      scrollback-limit = 100000;

      custom-shader-animation = true;
      mouse-hide-while-typing = true;
      working-directory = "inherit";
      window-inherit-working-directory = true;
      copy-on-select = true;
      quit-after-last-window-closed = true;
      confirm-close-surface = false;
      app-notifications = false;
      desktop-notifications = false;
      window-decoration = false;
    };
  };
}
