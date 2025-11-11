{pkgs, ...}: {
  programs.brave = {
    enable = true;
    package = pkgs.brave; # for beta: brave-beta

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];

    extensions = [
      # wappalyzer
      {id = "gppongmhjkpfnbhagpmjfkannfbllamg";}
      {id = "nngceckbapebfimnlniiiahkandclblb";}
    ];

    # pinnedExtensions = [
    #   "gppongmhjkpfnbhagpmjfkannfbllamg"
    # ];
  };
}
