{pkgs, ...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source =
          if pkgs.stdenv.hostPlatform.isDarwin
          then "macos_small"
          else "nixos_small";
        padding.right = 1;
      };
      display = {
        size.binaryPrefix = "si";
        color = "black";
        separator = "  ";
      };
      modules = [
        {
          type = "os";
        }
        {
          type = "cpu";
        }
        {
          type = "gpu";
        }
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
      ];
    };
  };
}
