{
  inputs,
  pkgs,
  ...
}: let
  g = import ../globals.nix;
in {
  imports = [
    inputs.home-manager.nixosModules.default

    ./hardware-configuration.nix
    ../nixos
    ../modules
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = ["kvm" "kvm_intel"];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Europe/Vienna";

  users.users.${g.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "vboxusers"
      "docker"
      "kvm"
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  system.stateVersion = "25.05";
}
