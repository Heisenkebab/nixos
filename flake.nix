{
  description = "NixOS basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    disko,
    spicetify-nix,
    nix-darwin,
    nix-homebrew,
    ...
  }: let
    # ------------------------------------
    # Global user
    # ------------------------------------
    user = {
      name = "heisenkebab";
      homeDir =
        if nixpkgs.legacyPackages.${builtins.currentSystem}.stdenv.isLinux
        then "/home/heisenkebab"
        else "/Users/heisenkebab";
    };

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
        monitors = [
          {
            name = "eDP-1";
            dimensions = "1920x1200";
            scale = 1;
            primary = true;
            framerate = 165;
            position = "0x0";
            transform = 0;
          }
          {
            name = "HDMI-A-1";
            dimensions = "1920x1080";
            scale = 1;
            primary = false;
            framerate = 60;
            position = "1920x0";
            transform = 0;
          }
        ];
        workspaceRules = [];
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
        monitors = [
          {
            name = "HDMI-A-1";
            dimensions = "1920x1080";
            scale = 1;
            primary = false;
            framerate = 144;
            position = "1920x0";
            transform = 0;
          }
          {
            name = "DP-1";
            dimensions = "1920x1080";
            scale = 1;
            primary = true;
            framerate = 144;
            position = "0x0";
            transform = 0;
          }
        ];
        workspaceRules = [
          "1, monitor:DP-1"
          "2, monitor:HDMI-A-1"
          "3, monitor:DP-1"
          "4, monitor:HDMI-A-1"
          "5, monitor:DP-1"
          "6, monitor:DP-1"
          "7, monitor:DP-1"
          "8, monitor:DP-1"
          "9, monitor:DP-1"
        ];
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
        monitors = [
          {
            name = "eDP-1";
            dimensions = "1920x1200";
            scale = 1;
            primary = true;
            framerate = 165;
            position = "0x0";
            transform = 0;
          }
          {
            name = "HDMI-A-1";
            dimensions = "1920x1080";
            scale = 1;
            primary = false;
            framerate = 60;
            position = "1920x0";
            transform = 0;
          }
        ];
        workspaceRules = [];
      }
    ];

    # ------------------------------------
    # build each host
    # ------------------------------------
    forLinuxHosts = host: {
      name = host.name;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;

          meta = {
            hostname = host.name;
            system = host.system;
            isLaptop = host.isLaptop;
            monitors = host.monitors;
            workspaceRules = host.workspaceRules;
          };
          user = user;
        };

        modules = [
          ./hosts/linux/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} = import ./hosts/linux/home.nix;
              extraSpecialArgs = {
                inherit inputs;
                inherit spicetify-nix;
                meta = host;
                user = user;
              };
            };
          }
        ];
      };
    };

    forDarwinHosts = host: {
      name = host.name;
      value = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;

          meta = {
            hostname = host.name;
            system = host.system;
            isLaptop = host.isLaptop;
            monitors = host.monitors;
            workspaceRules = host.workspaceRules;
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
  };
}
