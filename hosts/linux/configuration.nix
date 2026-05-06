{
  inputs,
  pkgs,
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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = ["kvm" "kvm_intel" "kvm_amd"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

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
}
