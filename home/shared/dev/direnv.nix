_: {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;

      # Drop the "loading .envrc / using flake / export +AR +AS ..." chatter.
      # Errors (e.g. ".envrc is blocked") are still printed.
      silent = true;
    };
  };
}
