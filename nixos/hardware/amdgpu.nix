{
  pkgs,
  lib,
  meta,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
    ];
  };

  environment.systemPackages = with pkgs;
    []
    ++ lib.optionals meta.isLaptop [
      brightnessctl
      ocl-icd
      lact
      supergfxctl
    ];
  services.supergfxd.enable =
    meta.system.iGpu == "AMD" && meta.system.dGpu == "AMD" && meta.isLaptop;

  boot.kernelModules = lib.optional (meta.system.dGpu == "AMD") "amdgpu";
  boot.kernelParams = lib.optional (meta.system.dGpu == "AMD") "amdgpu.dc=1";
}
