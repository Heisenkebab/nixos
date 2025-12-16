{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      # Optional: Vulkan components specific to AMD
      amdvlk
      vulkan-tools
    ];
  };
  boot.kernelModules = ["amdgpu"];
  boot.kernelParams = ["amdgpu.dc=1"];
}
