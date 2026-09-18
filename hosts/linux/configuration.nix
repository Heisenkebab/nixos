{
  inputs,
  pkgs,
  lib,
  user,
  meta,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.default

      ./hardware-configuration.nix

      ../../systems/linux
      ../../systems/shared

      ../../modules/linux
      ../../modules/shared
    ]
    ++ (
      if meta.system.dGpu == "AMD" || meta.system.iGpu == "AMD"
      then [../../systems/linux/hardware/amdgpu.nix]
      else []
    );

  # systemd-boot itself can't be Secure Boot signed; lanzaboote replaces it
  # with signed Unified Kernel Images while reusing the systemd-boot menu.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = true;
    # sbctl 0.18's config.DefaultConfig() hardcodes "/var/lib/sbctl" as the
    # keydir (config/config.go), regardless of any --database-path flag or
    # linker default — keep this in sync with wherever `sbctl create-keys`
    # actually wrote its keys.
    pkiBundle = "/var/lib/sbctl";
  };
  boot.blacklistedKernelModules = ["kvm" "kvm_intel" "kvm_amd"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = [pkgs.sbctl];

  time.timeZone = "Europe/Vienna";

  users.users.${user.name} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "vboxusers"
      "docker"
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";

        user = "greeter";
      };
    };
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    # powerKeyLongPress = "ignore";
  };

  system.stateVersion = "25.11";
  programs.niri.enable = true;
}
