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
      rocm-opencl-runtime
      ocl-icd
      lact
      supergfxctl
    ];
  services.supergfxd.enable = meta.isLaptop;

  boot.kernelModules = ["amdgpu"];
  boot.kernelParams = ["amdgpu.dc=1"];
}
