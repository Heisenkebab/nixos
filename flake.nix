{
  description = "NixOS basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nix-ld.url = "github:Mic92/nix-ld";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    disko,
    spicetify-nix,
    ...
  }: let
    # ------------------------------------
    # Global user
    # ------------------------------------
    user = {
      name = "heisenkebab";
      homeDir = "/home/heisenkebab";
    };

    # ------------------------------------
    # Hosts
    # ------------------------------------
    hosts = [
      {
        name = "nixos";
        system = {
          os = "linux";
          desktop = "wayland";
        };
        monitors = [
          {
            name = "HDMI-A-1";
            dimensions = "1920x1080";
            scale = 1;
            primary = true;
            internal = true;
            framerate = 60;
            transform = 0;
          }
        ];
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
            monitors = host.monitors;
          };
          user = user;
        };

        modules = [
          ./hosts/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} = import ./hosts/home.nix;
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
  in {
    nixosConfigurations = builtins.listToAttrs (map forLinuxHosts hosts);
  };
}
