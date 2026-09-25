{pkgs, ...}: {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    # skhd has no include directive, so the fragments are concatenated here.
    config =
      builtins.readFile ./skhdrc-common.txt
      + "\n"
      + builtins.readFile ./skhdrc-spaces.txt;
  };
}
