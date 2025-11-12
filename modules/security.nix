{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools
    burpsuite
  ];
}
