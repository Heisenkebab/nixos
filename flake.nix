{
  description = "NixOS basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stablepkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-ld.url = "github:Mic92/nix-ld";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    stablepkgs,
    home-manager,
    disko,
    spicetify-nix,
    nix-darwin,
    nix-homebrew,
    niri,
    lanzaboote,
    ...
  }: let
    # ------------------------------------
    # Global user
    # ------------------------------------
    username = "heisenkebab";
    # homeDir depends on the target platform, not on the evaluating machine:
    # builtins.currentSystem is unavailable in pure eval (e.g. nix flake check).
    mkUser = os: {
      name = username;
      homeDir =
        if os == "darwin"
        then "/Users/${username}"
        else "/home/${username}";
    };
    # ------------------------------------
    # Systems
    # ------------------------------------
    systems = {
      x86-linux = "x86_64-linux";
      arm-darwin = "aarch64-darwin";
    };

    forAllSystems = f:
      nixpkgs.lib.genAttrs (builtins.attrValues systems) (
        system:
          f (import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          })
      );

    # ------------------------------------
    # Hosts
    # ------------------------------------
    hosts = [
      {
        name = "laptop";
        isLaptop = true;
        system = {
          os = "linux";
          desktop = "wayland";
          dGpu = "AMD";
          iGpu = "AMD";
        };
        wm = {
          niri = {
            enable = true;
            bar = "niribar";
            additionalSettings = [
              {
                outputs = {
                  "eDP-1" = {
                    mode = {
                      width = 1920;
                      height = 1200;
                      refresh = 165.0;
                    };
                    focus-at-startup = true;
                    position = {
                      x = 0;
                      y = 0;
                    };
                  };

                  "HDMI-A-1" = {
                    mode = {
                      width = 1920;
                      height = 1080;
                      refresh = 60.0;
                    };
                    position = {
                      x = 1920;
                      y = 0;
                    };
                  };
                };
              }
            ];
          };
        };
      }
      {
        name = "pc";
        isLaptop = false;
        system = {
          os = "linux";
          desktop = "wayland";
          dGpu = "AMD";
          iGpu = "AMD";
        };
        wm = {
          niri = {
            enable = true;
            bar = "niribar";
            additionalSettings = [
              {
                outputs = {
                  "DP-1" = {
                    mode = {
                      width = 2560;
                      height = 1440;
                      refresh = 239.970;
                    };
                    variable-refresh-rate = "on-demand";
                    focus-at-startup = true;
                    position = {
                      x = 1080;
                      y = 0;
                    };
                  };

                  "DP-2" = {
                    mode = {
                      width = 1920;
                      height = 1080;
                      refresh = 60.0;
                    };
                    transform = {
                      rotation = 90;
                    };
                    position = {
                      x = 0;
                      y = 0;
                    };
                  };

                  "HDMI-A-1" = {
                    mode = {
                      width = 1920;
                      height = 1080;
                      refresh = 60.0;
                    };
                    position = {
                      x = 1080 + 2560;
                      y = 0;
                    };
                  };
                };

                # Named workspaces are pinned to an output and sorted by key,
                # so "browser" is workspace 1 and "chat" workspace 2 on HDMI-A-1.
                workspaces = {
                  "01-browser" = {
                    name = "browser";
                    open-on-output = "HDMI-A-1";
                  };
                  "02-chat" = {
                    name = "chat";
                    open-on-output = "HDMI-A-1";
                  };
                  "03-music" = {
                    name = "music";
                    open-on-output = "DP-2";
                  };
                  "04-term" = {
                    name = "term";
                    open-on-output = "DP-1";
                  };
                };
                window-rules = [
                  {
                    matches = [{app-id = "^brave-browser$";}];
                    open-on-workspace = "browser";
                  }
                  {
                    matches = [{app-id = "^vesktop$";}];
                    open-on-workspace = "chat";
                  }
                  {
                    matches = [{app-id = "^[Ss]potify$";}];
                    open-on-workspace = "music";
                  }
                  {
                    matches = [{app-id = "^com\\.mitchellh\\.ghostty$";}];
                    open-on-workspace = "term";
                  }
                ];
              }
            ];
          };
        };
      }
      {
        name = "macBook";
        isLaptop = true;
        system = {
          os = "darwin";
          desktop = "wayland";
          dGpu = "NONE";
          iGpu = "APPLE";
        };
      }
    ];

    # ------------------------------------
    # build each host
    # ------------------------------------
    forLinuxHosts = host: let
      system = systems.x86-linux;
      stable = import stablepkgs {inherit system;};
      user = mkUser "linux";
    in {
      name = host.name;
      value = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs;
          inherit stable;

          meta = {
            hostname = host.name;
            system = host.system;
            isLaptop = host.isLaptop;
          };
          user = user;
        };

        modules = [
          ./hosts/linux/configuration.nix
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager
          {
            desktop.wm = host.wm or {};
          }
          ({config, ...}: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} = {
                imports = [
                  niri.homeModules.niri
                  ./hosts/linux/home.nix
                ];
              };
              extraSpecialArgs = {
                inherit inputs;
                inherit spicetify-nix;
                inherit import stable;
                meta = host;
                desktop = config.desktop;
                user = user;
              };
            };
          })
        ];
      };
    };

    forDarwinHosts = host: let
      system = systems.arm-darwin;
      stable = import stablepkgs {inherit system;};
      user = mkUser "darwin";
    in {
      name = host.name;
      value = nix-darwin.lib.darwinSystem {
        system = system;
        specialArgs = {
          inherit inputs;
          inherit stable;

          meta = {
            hostname = host.name;
            system = host.system;
            isLaptop = host.isLaptop;
          };
          user = user;
        };

        modules = [
          ./hosts/darwin/configuration.nix

          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} = import ./hosts/darwin/home.nix;
              extraSpecialArgs = {
                inherit inputs;
                inherit spicetify-nix;
                inherit import stable;
                meta = host;
                user = user;
              };
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = user.name;
              autoMigrate = true;
            };
          }
        ];
      };
    };

    linuxHosts = builtins.filter (h: h.system.os == "linux") hosts;
    darwinHosts = builtins.filter (h: h.system.os == "darwin") hosts;
  in {
    nixosConfigurations = builtins.listToAttrs (map forLinuxHosts linuxHosts);

    darwinConfigurations =
      builtins.listToAttrs (map forDarwinHosts darwinHosts);

    # use flake ~/nixos#ctf
    devShells = forAllSystems (pkgs: {
      ctf = import ./templates/ctf/shell.nix {inherit pkgs;};
    });

    # nix flake init -t ~/nixos#ctf
    templates = {
      ctf = {
        path = ./templates/ctf;
        description = "CTF challenge environment (pwn / rev / crypto / web / forensics)";
        welcomeText = ''
          # CTF challenge

          You usually do not need this copy -- an `.envrc` containing
          `use flake ~/nixos#ctf` gets the same shell without pinning a
          second nixpkgs. Keep this one only if the challenge needs to
          diverge.

          - `direnv allow` (or `nix develop`) to enter the shell
          - edit `shell.nix` to add tools for this challenge
          - drop the binary in as `./chal`, then `python solve.py`

          See `README.md`, including the macOS notes on `gdb`.
        '';
      };
    };
  };
}
